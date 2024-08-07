//
//  TicTacToeViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-06.
//

import UIKit

class TicTacToeViewController: UIViewController {

    var collectionView: UICollectionView!
    
    var winnerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.setTitle("Start Game", for: .normal)
        button.backgroundColor  = UIColor.green
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        button.titleLabel?.textColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints  = false
        return button
    }()
    
    @objc func restart(_ sender: Any) {
        result = [[0,0,0],[0,0,0],[0,0,0]];
        collectionView.reloadData();
        DispatchQueue.main.async {
            self.winnerLabel.text = "Who is the Winner?"
        }
        collectionView.allowsSelection = true
    }
    
    private var step: Int?;
    private var result: [[Int]] = [[0,0,0],[0,0,0],[0,0,0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        self.step = 1
    }
    
    func setUpCollectionView(){
        view.backgroundColor = UIColor.white
        let layout = UICollectionViewFlowLayout()
        let size = (view.frame.size.width - 20) / 3
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(winnerLabel)
        view.addSubview(restartButton)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            winnerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winnerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: winnerLabel.bottomAnchor,constant: 50),
            restartButton.widthAnchor.constraint(equalToConstant: 150),
            restartButton.heightAnchor.constraint(equalToConstant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: winnerLabel.topAnchor, constant: -20),
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TicTacToeColletionViewCell.self, forCellWithReuseIdentifier: TicTacToeColletionViewCell.identifier)
        collectionView.allowsSelection = true
        
        restartButton.addTarget(self, action: #selector(restart), for: .touchUpInside)
    }
    
    func checkWinner(){
        var ingredients: Set<Int> = []
        
        for i in 0..<3 {
            ingredients.insert(result[i][0]*result[i][1]*result[i][2])
            ingredients.insert(result[0][i]*result[1][i]*result[2][i])
        }
       
        ingredients.insert(result[0][0]*result[1][1]*result[2][2])
        ingredients.insert(result[2][0]*result[1][1]*result[0][2])

        
        if ingredients.contains(8) || ingredients.contains(1){
            let winner = step! % 2 == 1 ? "Blue is the Winner" : "Yellow is the winner"
            DispatchQueue.main.async {
                self.winnerLabel.text = winner
            }
            collectionView.allowsSelection = false
            self.step = 1
        }
    }

}

extension TicTacToeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicTacToeColletionViewCell.identifier, for: indexPath) as? TicTacToeColletionViewCell ?? TicTacToeColletionViewCell()
        
        if (result[indexPath.section][indexPath.item] != 0) {
            if result[indexPath.section][indexPath.item] == 1{
                cell.backgroundColor = .blue
            }else{
                cell.backgroundColor = .yellow
            }
        }else{
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? TicTacToeColletionViewCell else {
            return
        }
        if (result[indexPath.section][indexPath.item] == 0) {
            result[indexPath.section][indexPath.item] = self.step! % 2 == 0 ? 2:1
            if result[indexPath.section][indexPath.item] == 1{ 
                cell.backgroundColor = .blue
            }else{
                cell.backgroundColor = .yellow
            }
            checkWinner()
            self.step = self.step!+1
            return
        }
        return
    }
    
    
}
