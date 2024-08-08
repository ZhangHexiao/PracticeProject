//
//  BarChartViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-07.
//

import UIKit

struct Bar {
    let color: UIColor
    let nomlizedHeight: CGFloat
}

class BarChartViewController: UIViewController {
    
    var data = [(height:120, color: UIColor.red), (height:150, color: UIColor.blue), (height:70, color: UIColor.yellow)]
    
    var barData:[Bar] {
        let maxHeight = CGFloat(data.map{$0.height}.max() ?? 1)
        return data.map{Bar(color: $0.color, nomlizedHeight: CGFloat($0.height)/maxHeight)}
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpCollectionView()
        setUpButton()
    }
    
    var collectionView: UICollectionView!
    var buttonContianer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    func setUpCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:-200),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BarCell.self, forCellWithReuseIdentifier: BarCell.identifier)
    }
    
    func generateButton(title:String, tag:Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.tag = tag
        return button
    }
    
    @objc func switchData(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            data = [(height:120, color: UIColor.red),(height:150, color: UIColor.blue),(height:70, color: UIColor.yellow)]
        case 1:
            data = [(height:90, color: UIColor.green),(height:120, color: UIColor.blue)]
        case 2:
            data = [(height:190, color: UIColor.red),(height:40, color: UIColor.blue),(height:190, color: UIColor.lightGray ),(height:210, color: UIColor.lightGray ),(height:290, color: UIColor.orange )]
            
        default: return
        }
        
        collectionView.reloadData()
    }
    
    func setUpButton() {
        buttonContianer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonContianer)
        NSLayoutConstraint.activate([
            buttonContianer.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50),
            buttonContianer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            buttonContianer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            buttonContianer.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let buttonTitle:[String] = ["Test1", "Test2", "Test3"]
        
        for (index, title) in buttonTitle.enumerated(){
            let button = generateButton(title: title, tag: index)
            button.addTarget(self, action: #selector(switchData(_:)), for: .touchUpInside)
            buttonContianer.addArrangedSubview(button)
        }
    }
}

extension BarChartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BarCell.identifier, for: indexPath) as? BarCell ?? BarCell()
        cell.configCell(bar: barData[indexPath.row])
        return cell
    }
}

extension BarChartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / CGFloat(data.count),  height:collectionView.bounds.height)
    }
}

