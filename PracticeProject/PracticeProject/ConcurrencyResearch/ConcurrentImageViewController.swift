//
//  ConcurrentImageViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import UIKit

class ConcurrentImageViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var viewModel:ImageMatrixViewModel = ImageMatrixViewModel()
    let counterLock = NSLock()
    let semaphore = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupCollectionView()
    }
    
    func setupCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        let size = (view.frame.size.width - 20) / 3
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        self.collectionView.register(ConcurrentImageCell.self, forCellWithReuseIdentifier: ConcurrentImageCell.identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // This method can gurantee the loop follow the order,
        // but some API call will come back quicker, so the image is not configured one by one
        // loadImageUsingBarrier()
        
        // This method can gurantee the loop follow the order,
        // but some API call will come back quicker
        // will configured one by one
        loadImageUsingSemaphore()
    }
    
    private func loadImageUsingBarrier(){
        for (i, _) in viewModel.imageURLsMatrix.enumerated() {
            for (j, _) in viewModel.imageURLsMatrix[i].enumerated(){
                print("1**start loop**(\(i) - \(j))")
                
                let queue = DispatchQueue(label: "Queue+", qos: .background, attributes: .concurrent)
                queue.async(flags: .barrier) {
                    print("2**insert queue**(\(i) - \(j))")
                    ConcurrentImageAPIClient.shared.imageDownLoader(urlString: self.viewModel.imageURLsMatrix[i][j]){ [weak self] result in
                        switch result {
                        case .success(let image):
                            self!.viewModel.imageList[i][j] = image
                            print("3**success call back**(\(i) - \(j))")
                            DispatchQueue.main.sync {
                                self?.collectionView.reloadItems(at: [IndexPath(item: j, section: i)])
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    private func loadImageUsingSemaphore(){
        for (i, _) in viewModel.imageURLsMatrix.enumerated() {
            for (j, _) in viewModel.imageURLsMatrix[i].enumerated(){
                print("1**start loop**(\(i) - \(j))")
                
                DispatchQueue.global(qos: .utility).async {
                    self.semaphore.wait()
                    defer {
                        // Ensure the semaphore is always signaled, regardless of success or failure
                        self.semaphore.signal()
                    }
                    ConcurrentImageAPIClient.shared.imageDownLoader(urlString: self.viewModel.imageURLsMatrix[i][j]){ [weak self] result in
                        switch result {
                        case .success(let image):
                            self!.viewModel.imageList[i][j] = image
                            print("3**success call back**(\(i) - \(j))")
                            DispatchQueue.main.async {
                                self?.collectionView.reloadItems(at: [IndexPath(item: j, section: i)])
                                //                                self?.semaphore.signal()
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
            }
        }
    }
}


extension ConcurrentImageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.imageURLsMatrix.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageURLsMatrix[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConcurrentImageCell.identifier, for: indexPath) as? ConcurrentImageCell ?? ConcurrentImageCell()
        
        if let image = viewModel.imageList[indexPath.section][indexPath.row] {
            cell.config(image: image)
        }
        
        return cell
    }
    
}

