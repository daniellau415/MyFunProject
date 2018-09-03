//
//  FaqCollectionViewCell.swift
//  MyFunProject
//
//  Created by Daniel Lau on 8/31/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import UIKit


class FaqCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - Properties
    let questionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let answerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "arrow").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .right
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Layout Views
    
    func setupLayout() {
        
        contentView.addSubview(questionLabel)
        contentView.addSubview(answerLabel)
        contentView.addSubview(arrowImage)
        arrowImage.bringSubview(toFront: contentView)
        
        questionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        questionLabel.bottomAnchor.constraint(equalTo: answerLabel.topAnchor, constant: -10).isActive = true
        
        answerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        answerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        answerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        arrowImage.leftAnchor.constraint(equalTo: questionLabel.rightAnchor, constant: 10).isActive = true
        arrowImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        arrowImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = false
        self.backgroundColor = UIColor(hexString: "#a0dbbd")
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                answerLabel.isHidden = false
                self.backgroundColor = UIColor(hexString: "#5cbc8b")
                UIView.animate(withDuration: 0.3, animations: {
                    self.arrowImage.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                }, completion: nil)
            } else {
                answerLabel.isHidden = true
                self.backgroundColor = UIColor(hexString: "#a0dbbd")
                self.arrowImage.transform = .identity
            }
        }
    }
}
