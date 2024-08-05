//
//  NetworkManager.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation

protocol NetworkManagerProtocol {
    func executeRequest(apiRequest: APIRequest,
                        completion: @escaping (Result<Data, NetworkError>) -> Void)
}

public class NetworkManager: NetworkManagerProtocol{
    
    static let shared = NetworkManager()
    private let session = URLSession(configuration: .default)
    
    public func executeRequest(apiRequest: APIRequest,
                               completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        var jsonData: Data?
        var urlString: String = apiRequest.url
        if let parameters = apiRequest.parameters {
            switch apiRequest.method {
            case .get where !parameters.isEmpty:
                urlString = urlString + "?" + query(parameters)
            case .post, .put, .patch, .delete:
                jsonData = try? JSONSerialization.data(withJSONObject: parameters as Any, options: [])
            default: break
            }
        }
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(NetworkError.urlParseError))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.rawValue
        
        if let httpHeaders = apiRequest.headers {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpBody = jsonData
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            self?.requestCompletionHandler(data, response, error, completion: completion)
        }
        task.resume()
    }
    
    private func requestCompletionHandler(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        if error != nil {
            completion(.failure(NetworkError.errorFromResponse))
            return
        }
        
        guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else{
            completion(.failure(NetworkError.invalidStatusCode))
            return
        }
        
        if let validData = data {
                completion(.success(validData))
        } else {
            completion(.failure(NetworkError.invalidData))
        }
        
    }
}

extension NetworkManager {
    public func query(_ parameters: [String: String]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components.append((key, value))
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
