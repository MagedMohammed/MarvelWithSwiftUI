//
//  APIClient.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import Foundation
import Alamofire
import Combine

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

protocol APIClientProtocol {
    func fetchData<T: Decodable>(
        requestConvertible: URLRequestConvertible
    ) -> AnyPublisher<T, Error>
}

class APIClient: APIClientProtocol {
    
    func fetchData<T: Decodable>(
        requestConvertible: URLRequestConvertible
    ) -> AnyPublisher<T, Error> {
        return Future { promise in
            AF.request(requestConvertible).validate()
                .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
