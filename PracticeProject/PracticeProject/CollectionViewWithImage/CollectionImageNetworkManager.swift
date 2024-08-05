//
//  CollectionImageNetworkManager.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-04.
//

import Foundation
import UIKit

//Only get the data from mocked API
public class CollectionImageNetworkManager {
    
    static let shared = CollectionImageNetworkManager()
    
    private let session = URLSession(configuration: .default)
    
    public func mockNetworkGetQuestion<T: CollectionImageApiCall>(_ request: T, completion: @escaping CollectionImageCompletion<T.Response>){
        guard let url = Bundle.main.url(forResource: "QuestionResponse", withExtension: "json") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failedd to find File.json in app bundle."])))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(T.Response.self, from: data)
            completion(.success(decodedData))
            
        } catch{
            completion(.failure(error))
        }
    }
    
    public func downloadImage(urlString: String, completion:@escaping CollectionImageCompletion<UIImage>){
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(CollectionImageServiceError.urlError))
            return
        }
        
        let task = session.dataTask(with: imageURL){ data, response, error in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else{
                completion(.failure(CollectionImageServiceError.httpError))
                return
            }
            
            if let data = data {
                completion(.success(UIImage(data: data)!))
            } else {
                completion(.failure(CollectionImageServiceError.noData))
            }
        }
        
        task.resume()
        
    }
}

