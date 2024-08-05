//
//  RecipeViewCell.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import UIKit

class RecipeViewCell: UITableViewCell {
    
    static let identifier:String = "RecipeViewCell"
    
    @UsesAutoLayout
    private(set) var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = LayoutDimension.cellCornerRadius
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: LayoutDimension.cellShadowOffsetWidth, height: LayoutDimension.cellShadowOffsetHeight)
        cardView.layer.shadowRadius = LayoutDimension.cellShadowRadiusRadius
        return cardView
    }()
    
    @UsesAutoLayout
    private(set) var foodImageView: UIImageView = {
        let foodImageView = UIImageView()
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.clipsToBounds = true
        foodImageView.layer.cornerRadius = LayoutDimension.cellCornerRadius
        foodImageView.layer.masksToBounds = true
        foodImageView.backgroundColor = .clear
        return foodImageView
        
    }()
    
    @UsesAutoLayout
    private(set) var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.numberOfLines = 2
        return titleLabel
        
    }()
 
    @UsesAutoLayout
    private(set) var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .darkGray
        timeLabel.numberOfLines = 1
        return timeLabel
    }()
    
    @UsesAutoLayout
    private(set) var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.font = UIFont.boldSystemFont(ofSize: 12)
        levelLabel.textColor = .orange
        levelLabel.textAlignment = .right
        levelLabel.numberOfLines = 1
        levelLabel.adjustsFontSizeToFitWidth = true
        levelLabel.minimumScaleFactor = 0.5
        return levelLabel
    }()
    
    @UsesAutoLayout
    private(set) var pointLabel: UILabel = {
        let pointLabel = UILabel()
        pointLabel.font = UIFont.systemFont(ofSize: 12)
        pointLabel.textColor = .gray
        pointLabel.numberOfLines = 1
        return pointLabel
        
    }()
    
    @UsesAutoLayout
    private(set) var retryButton: UIButton = {
        let retryButton = UIButton(type: .system)
        retryButton.setTitle("Click to reload image", for: .normal)
        retryButton.layer.borderColor = UIColor.black.cgColor
        retryButton.isHidden = true
        retryButton.titleLabel?.font = .systemFont(ofSize: 12)
        retryButton.titleLabel?.numberOfLines = 2
        return retryButton
    }()
    
    @UsesAutoLayout
    private(set) var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var foodImageUrl = ""
    var retryDownlaodImageAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        activityIndicator.startAnimating()
        retryButton.isHidden = true
    }
    
    @objc private func retryButtonTapped() {
        retryDownlaodImageAction?()
    }
    
    private func setupUI() {
        contentView.addSubview(cardView)
        [foodImageView, titleLabel, levelLabel, timeLabel, pointLabel, activityIndicator, retryButton].forEach {
            cardView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutDimension.cellVerticalMargin),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutDimension.cellVerticalMargin),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutDimension.cellHorizontalMargin),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutDimension.cellHorizontalMargin),
            
            levelLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: LayoutDimension.minorPadding),
            levelLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -LayoutDimension.padding),
            levelLabel.widthAnchor.constraint(equalToConstant: LayoutDimension.levelLabelWidth),
            
            foodImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 0),
            foodImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 0),
            foodImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            foodImageView.widthAnchor.constraint(equalToConstant: LayoutDimension.foodImageSize),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor,constant: LayoutDimension.minorPadding),
            titleLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: LayoutDimension.padding),
            titleLabel.trailingAnchor.constraint(equalTo: levelLabel.leadingAnchor, constant: -LayoutDimension.padding),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutDimension.cellLabelGap),
            timeLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: LayoutDimension.padding),
            timeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -LayoutDimension.padding),
            
            pointLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: LayoutDimension.cellLabelGap),
            pointLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: LayoutDimension.padding),
            pointLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -LayoutDimension.padding),
            pointLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -LayoutDimension.padding),
            
            activityIndicator.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            activityIndicator.topAnchor.constraint(equalTo: cardView.topAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: LayoutDimension.foodImageSize),
            activityIndicator.heightAnchor.constraint(equalToConstant: LayoutDimension.foodImageSize),
            
            retryButton.widthAnchor.constraint(equalToConstant: LayoutDimension.imageRetryButtonWidth),
            retryButton.heightAnchor.constraint(equalToConstant: LayoutDimension.imageRetryButtonHeight),
            retryButton.centerXAnchor.constraint(equalTo: foodImageView.centerXAnchor),
            retryButton.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor)
        ])
    }
    
    func configCell(recipt: Recipe) {
        foodImageView.image = UIImage()
        titleLabel.text = recipt.name
        levelLabel.text = recipt.difficultyLevel.rawValue
        timeLabel.text = "Preparation Time: \(recipt.preparationTime) min"
        pointLabel.text = "Point: \(recipt.points)"
        foodImageUrl = recipt.smallImage?.url ?? ""
        activityIndicator.startAnimating()
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.retryButton.isHidden = true
            self.activityIndicator.stopAnimating()
            self.foodImageView.image = image
        }
    }
    
    func setRetryDownloadImage(retryAction: @escaping (()->Void)) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.retryButton.isHidden = false
            self.retryDownlaodImageAction = retryAction
            self.retryButton.addTarget(self, action: #selector(self.retryButtonTapped), for: .touchUpInside)
        }
    }
}
