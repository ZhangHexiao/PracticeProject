//
//  CollectionImageDataModel.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-04.
//

import Foundation

public protocol CollectionImageApiCall: Encodable {
    associatedtype Response: Decodable
    var resourceName: String {get}
}

public typealias CollectionImageCompletion<Value> = (Result<Value, Error>) -> Void

enum CollectionImageServiceError: Error {
    case urlError
    case httpError
    case noData
}

struct CollectionImageQuetion: Decodable {
    let query: String
    let answer:[CollectionImageAnswer]
}

struct CollectionImageAnswer: Decodable {
    let image_url: String
    let correct: Bool
}

struct GetCollectionImageQuestionRequest: CollectionImageApiCall {
    typealias Response = CollectionImageQuetion
    
    var resourceName: String {
        get{
            return ""
        }
    }
}
