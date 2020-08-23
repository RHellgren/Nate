//
//  InsomniaAPI.swift
//  Insomnia
//
//  Created by Robin Hellgren on 19/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed(Error)
    case noDataResponse
    case httpError(Error)
    case failedToMatchHTTPStatusCode
    case decodingError(Error)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public class InsomniaAPI {

    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }

    func createRequest(path: String, method: HTTPMethod, body: [String: Any]? = nil) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 3000
        components.path = path

        guard let url = components.url else {
            return nil
        }
        var request = URLRequest(url: url)

        if let body = body,
            let httpBody = try? JSONSerialization.data(withJSONObject: body) {
            request.httpBody = httpBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.httpMethod = method.rawValue

        return request
    }

    private func httpStatusError(response: URLResponse?) -> APIError? {
        if let httpResponse = response as? HTTPURLResponse,
            let status = httpResponse.status {
            switch status {
            case .ok:
                return nil

            default:
                return .httpError(status)
            }
        } else {
            return .failedToMatchHTTPStatusCode
        }
    }

    internal func perform<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, APIError>) -> ()) {

        let dataTask = session.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.noDataResponse))
                return
            }

            if let httpStatusError = self.httpStatusError(response: response) {
                completion(.failure(httpStatusError))
            }

            do {
                let responseObject = try self.decoder.decode(T.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }

            } catch let error {
                completion(.failure(.decodingError(error)))
            }

        }
        dataTask.resume()
    }
}
