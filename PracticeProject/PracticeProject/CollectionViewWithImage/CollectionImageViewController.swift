//
//  CollectionImageViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-04.
//

import UIKit

class CollectionImageViewController: UIViewController {
    
    var collectionView: UICollectionView = {
        let gridLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let viewModel = CustomerServiceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        viewModel.fetchQuetion {
            [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.configureCollectionView()
            }
        }
    }
    
    func configureCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionImageViewCell.self, forCellWithReuseIdentifier: "CollectionImageViewCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.allowsMultipleSelection = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
}

extension CollectionImageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.question?.answer.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionImageViewCell.identifier, for: indexPath) as? CollectionImageViewCell ?? CollectionImageViewCell()
        
        if let url = viewModel.question?.answer[indexPath.row].image_url {
            viewModel.fetchImage(url: url){ image in
                cell.configCell(image: image)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.size.width - 30)/2
        return CGSize(width: itemSize, height: itemSize)
    }
    

}
