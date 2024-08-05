//
//  CollectionImageViewModel.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-04.
//

import Foundation
import UIKit

class CustomerServiceViewModel {
    
    var question: CollectionImageQuetion?
    private let networkService = CollectionImageNetworkManager.shared
    
    func fetchQuetion(onCompletion: @escaping ()-> Void){
        networkService.mockNetworkGetQuestion(GetCollectionImageQuestionRequest()){
            [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.question = response
                onCompletion()
            case .failure(let error): print(error)
            }
        }
    }
    
    func fetchImage(url: String, onCompletion: @escaping (UIImage)->Void){
        networkService.downloadImage(urlString: url){
            [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let image):
                onCompletion(image)
            case .failure(let error): print(error)
            }
        }
    }
}
