//
//  Recipe.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation

struct Recipe: Decodable {
    let id: String
    let name: String
    let points: Int
    let preparationTime: Int
    let difficultyLevel: DifficultyLevel
    let images: [Image]
    
    //从返回的所有image中只要small的image
    var smallImage: Image? {
        return images.first { $0.imageType == ImageType.small }
       }
    
    //将json中的key转换为自己的key
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, points, preparationTime, difficultyLevel, images

    }
}

struct Image: Decodable {
    let url: String
    let width: Int
    let height: Int
    let imageType: ImageType
}

enum DifficultyLevel: String, Codable {
    case easy = "EASY"
    case moderate = "MODERATE"
}

enum ImageType: String, Codable {
    case small = "SMALL"
    case medium = "MEDIUM"
    case large = "LARGE"
    case extraLarge = "EXTRALARGE"
    case square600 = "SQUARE600"
    case square200 = "SQUARE200"
}
