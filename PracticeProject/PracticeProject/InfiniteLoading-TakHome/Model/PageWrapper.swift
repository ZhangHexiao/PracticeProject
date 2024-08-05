//
//  PageWrapper.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation

struct PageWrapper<T: Decodable>: Decodable {
    let count: Int
    let page: String
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case count, page
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        page = try container.decode(String.self, forKey: .page)
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        items = try dynamicContainer.decode([T].self, forKey: DynamicCodingKey(stringValue: "recipes")!)
    }
    
}

struct DynamicCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
}

struct DecoderContext {
    let itemsKey: String
}
