//
//  shortURLNetworkManager.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-06.
//

import Foundation

public enum ShorURLNetworkError: String, LocalizedError {
    case invalidData = "Response from the server is not valid, data was nil or zero length."
    case errorFromResponse = "Your request could not be processed."
    case invalidStatusCode = "Your request could not be processed, invalid statusCode"
    case jsonSerializationError = "Data format is wrong"
    case urlParseError = "The provided URL is not valid"
    case imageDownloadingFailure = "Failed to download this image"
    
    public var errorDescription: String? {
        return self.rawValue
    }
}

class ShortURLNetworkManager: ShortURLNetworkServiceProtocol {
    static let shared = ShortURLNetworkManager()
    private let urlSession = URLSession(configuration: .default)
    
    public func performGetURLRequest(urlString: String, completion: @escaping (Result<Data, Error>)->Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url){data, response, error in
            if let data = data {
                completion(.success(data))
                return
            }else{
                completion(.failure(ShorURLNetworkError.invalidData))
            }
        }
        dataTask.resume()
    }
    
    func performPostCallForShortURL(inputString: String, completion: @escaping (Result<Data,Error>)-> Void) {
        
        guard let endpoint = URL(string: "https://cleanuri.com/api/v1/shorten") else {
            completion(.failure(ShorURLNetworkError.urlParseError))
            return
        }
        
        let jsonString = "{ \"url\" : \"\(inputString)\"}"
        guard let jsonData = jsonString.data(using: .utf8) else { return }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(ShorURLNetworkError.errorFromResponse))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(ShorURLNetworkError.invalidData))
            }
        }
        task.resume()
    }
}
