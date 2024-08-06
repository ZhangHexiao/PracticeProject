//
//  ConcurrentImageAPIClient.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation
import UIKit

//public typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

enum ConcurrentImageError: Error {
    case invalidURL(String)
    case requestFailed(String)
    case decodingFailed(String)
    case otherError(String)
}

public protocol ConcurrentImageRequest: Encodable {
    
    associatedtype Response: Decodable
    var resourceName: String { get }
}

public class ConcurrentImageAPIClient: NSObject{
    
    static let shared = ConcurrentImageAPIClient()
    
    private let baseEndpoint = URL(string: "https://api.punkapi.com/v2/")
    private let session = URLSession(configuration: .default)

    
    func imageDownLoader(urlString: String, completionHandler: @escaping (Result<UIImage, ConcurrentImageError>) -> Void){
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ConcurrentImageError.invalidURL("FAILED")))
            return
        }
        Thread.sleep(forTimeInterval: TimeInterval(Double.random(in: 0..<0.9)))
        let task = session.dataTask(with: url){ data, reponse, error in
            if error != nil {
                completionHandler(.failure(ConcurrentImageError.invalidURL("FAILED")))
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completionHandler(.success(image))
            }else{
                completionHandler(.failure(ConcurrentImageError.invalidURL("FAILED")))
            }
        }
        task.resume()
    }
}
