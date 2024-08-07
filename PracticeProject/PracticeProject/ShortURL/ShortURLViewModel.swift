//
//  ShortURLViewModel.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-06.
//

import Foundation

struct ShortURLAPIResponse: Decodable {
    let result_url: String
}

protocol ShortURLViewModelDelegate: AnyObject {
    func didLoadData()
}

protocol ShortURLNetworkServiceProtocol {
    
    func performPostCallForShortURL(inputString: String, completion: @escaping (Result<Data,Error>)-> Void)
    
}

class ShortURLViewModel {
    
    var urlInput:String = ""
    var networkService: ShortURLNetworkServiceProtocol
    weak var delegate: ShortURLViewModelDelegate?
    
    var shorenURL: String = ""
    
    init(networkService: ShortURLNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func shortenURL (input: String) {
        networkService.performPostCallForShortURL(inputString: input, completion: {
            [weak self]  result in
            guard self != nil else {return}
            switch result {
            case .success(let result):
                do {
                    let str = String(decoding: result, as: UTF8.self)
                    print(str)
                    let result = try JSONDecoder().decode(ShortURLAPIResponse.self, from: result)
                    self!.shorenURL = result.result_url
                    self!.delegate?.didLoadData()
                }catch {
                    print("Decode error")
                }

            case .failure(let error):
                print(error)
            }
        })
    }
}
