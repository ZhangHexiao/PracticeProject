//
//  RecipeViewModel.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation
import UIKit

protocol RecipeListViewModelDelegate: AnyObject {
    func viewReload()
}


class RecipeListViewModel {
    
    var recipeList:[Recipe] = []
    var currentPage: Int = 1
    var isLoading = false
    private var recipeService: RecipeServiceProtocol
    weak var delegate: RecipeListViewModelDelegate?
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    func fetchData() {
        if (isLoading == true) {
            return
        }
        isLoading = true
        currentPage += 1
        recipeService.getPaginateRecipe(page: currentPage){
            result in
            switch result{
            case .success(let result):
                self.recipeList += result
                self.delegate?.viewReload()
                self.isLoading = false
            case .failure(let error):
                DispatchQueue.main.async {
                    ErrorAlertController.presentErrorAlert(on: self.delegate as! UIViewController, message: error.errorDescription ?? "Some error happened", retryHandler: {self.fetchData()})
                    self.isLoading = false
                    self.delegate?.viewReload()
                }
            }
        }
    }
    
    func loadImageForCell(imageURL: String, cell: RecipeViewCell) {
        ImageCacheLoader.requestImage(imageUrl: imageURL){result in
            switch result {
            case .success(let image):
                if (cell.foodImageUrl == imageURL){
                    cell.setImage(image)
                }
            case .failure(_):
                cell.setRetryDownloadImage(retryAction: {self.loadImageForCell(imageURL: imageURL, cell: cell)})
            }
        }
    }
}
