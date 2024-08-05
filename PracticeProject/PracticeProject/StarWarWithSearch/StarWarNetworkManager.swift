//
//  SearchBeerNetworkManager.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation

public typealias StarWarCompletion<Value> = (Result<Value, Error>) -> Void

public protocol  StarWarApiCall {
    associatedtype Response: Decodable
    var resourceName: String {get}
}

enum StarWarError: Error {
    case urlError
    case noDataError
    case httpError
}

public protocol StarWarNetworkService {
    func performStarWarRequest<T: StarWarApiCall> (request: T, completion: @escaping StarWarCompletion<T.Response>)
}

public class StarWarNetworkManager: StarWarNetworkService {
    static let shared = StarWarNetworkManager()
    private let session = URLSession(configuration: .default)
    public func performStarWarRequest<T: StarWarApiCall> (request: T, completion: @escaping StarWarCompletion<T.Response>) {
        guard let url = URL(string: request.resourceName) else{
            completion(.failure(StarWarError.urlError))
            return
        }
        
        let dataTask = session.dataTask(with: url) {data, response, error in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                completion(.failure(StarWarError.urlError))
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(decodedData))
                }catch {
                    completion(.failure(StarWarError.httpError))
                }
            }else{
                completion(.failure(StarWarError.noDataError))
                return
            }
        }
        dataTask.resume()
    }
}


