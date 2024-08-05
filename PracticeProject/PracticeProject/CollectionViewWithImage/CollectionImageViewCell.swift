//
//  CollectionImageViewCell.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-04.
//

import UIKit

class CollectionImageViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionImageViewCell"
    
    var imageView = UIImageView()
    override var isSelected: Bool {
        didSet {
            imageView.layer.borderWidth = isSelected ? 4.0 : 0.0
            imageView.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.clear.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(){
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    public func configCell(image: UIImage){
        DispatchQueue.main.async {
            self.imageView = UIImageView(frame: self.contentView.frame)
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.clipsToBounds = true
            self.imageView.image = image
            self.contentView.addSubview(self.imageView)
        }
    }
}
