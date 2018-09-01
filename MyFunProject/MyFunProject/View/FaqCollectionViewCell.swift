//
//  FaqCollectionViewCell.swift
//  MyFunProject
//
//  Created by Daniel Lau on 8/31/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import UIKit


class FaqCollectionViewCell: UICollectionViewCell {
    
    let questionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let answerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupLayout() {
        contentView.addSubview(questionLabel)
        contentView.addSubview(answerLabel)
        
        questionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        questionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        questionLabel.bottomAnchor.constraint(equalTo: answerLabel.topAnchor).isActive = true
        
        //        questionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        //        questionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        //        questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        
        //        answerLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        //        answerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        //        answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true
        //        answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        answerLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        answerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor).isActive = true
        answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = false
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                answerLabel.isHidden = false
            } else {
                answerLabel.isHidden = true
            }
        }
    }
    
}
