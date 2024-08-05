//
//  ApiRequest.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public protocol APIRequest {
    var baseURL: String { get }
    var urlPath: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

extension APIRequest {
    var baseURL: String  {
        return "https://api.qa.ww.com/v1/guidance/interview/recipe"
    }
    
    var url: String {
        return baseURL + urlPath
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
}


struct RecipeListRequest: APIRequest {
    let urlPath = "/list"
    let method = HTTPMethod.get
    let page: Int
    init(page: Int) {
        self.page = page
    }
    var parameters: [String: String]? {
        return ["page": String(page)]
    }
}

struct ImageDownLoadRequest: APIRequest {
    var baseURL: String = ""
    var urlPath: String
    let method = HTTPMethod.get
    let parameters: [String : String]? = nil
    init(url: String) {
        self.urlPath = url
    }
}
