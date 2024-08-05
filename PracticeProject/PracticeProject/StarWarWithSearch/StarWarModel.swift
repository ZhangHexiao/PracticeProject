//
//  StarWarModel.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation

struct Person: Decodable {
    let name: String
    let films:[String]
    let hairColor:String
    let url:String
    enum CodingKeys: String, CodingKey {
           case name
           case films
           case hairColor = "hair_color"
           case url
       }
}

struct People: Decodable {
    let results:[Person]
}

struct GetPeopleRequest: StarWarApiCall {
    typealias Response = People
    var resourceName: String {
        return "https://swapi.dev/api/people/"
    }
}


struct SearchPeopleRequest: StarWarApiCall{
    //https://swapi.dev/api/people/?search=r2
    var query: String
    typealias Response = People
    var resourceName:String {
        return "https://swapi.dev/api/people/?search=\(query)"
    }
    init(query: String) {
        self.query = query
    }
}
