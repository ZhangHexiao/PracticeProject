//
//  File.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-03.
//

import Foundation
import UIKit

class LandingCell: UITableViewCell {
    
    static let identifier = "LandingCell"
    
    private let pageNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 10
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = UIColor.lightGray
        contentView.addSubview(pageNameLabel)
        NSLayoutConstraint.activate([
            pageNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configCell(pageName: String){
        pageNameLabel.text = pageName
    }
    
}
