//
//  StarWarViewModel.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation

protocol StarWarViewModelDelegate:AnyObject {
    func didLoadData()
}

class StarWarViewModel {
    
    var personList: [Person] = []
    weak var delegate: StarWarViewModelDelegate?
    private let networkService: StarWarNetworkService
    private var workItem: DispatchWorkItem?
    
    init(networkService: StarWarNetworkService){
        self.networkService = networkService
    }
    
    func fetchData() {
        networkService.performStarWarRequest(request: GetPeopleRequest()) {
            [weak self] result in
            guard let self = self else{ return }
            switch result {
            case .success(let result):
                self.personList = result.results
                self.delegate?.didLoadData()
            case .failure(let error):
                print(error)
            }}
    }
    
    func searchData(query:String) {
       workItem?.cancel()
        
        workItem = DispatchWorkItem(block: {[weak self] in
            guard let self = self else{ return }
            self.networkService.performStarWarRequest(request: SearchPeopleRequest(query: query)) {
                [weak self] result in
                guard let self = self else{ return }
                switch result {
                case .success(let result):
                    self.personList = result.results
                    self.delegate?.didLoadData()
                case .failure(let error):
                    print(error)
                }}
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem!)
    }
}
