//
//  FaqCollectionViewCell.swift
//  MyFunProject
//
//  Created by Daniel Lau on 8/31/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import UIKit


class FaqCollectionViewCell: UICollectionViewCell {
    
    var bubbleBottomAnchor: NSLayoutConstraint!
    
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
    
    let bubbleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#77a2ea")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
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
        
        addSubview(bubbleBackgroundView)
        addSubview(questionLabel)
        addSubview(answerLabel)
        addSubview(arrowImage)
        
        questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        questionLabel.bottomAnchor.constraint(equalTo: answerLabel.topAnchor, constant: -16).isActive = true
        
        answerLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        answerLabel.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor).isActive = true
        answerLabel.bottomAnchor.constraint(lessThanOrEqualTo: bubbleBackgroundView.bottomAnchor).isActive = true
        
        //        arrowImage.leadingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 10).isActive = true
        //        arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        //        arrowImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        bubbleBackgroundView.topAnchor.constraint(equalTo: questionLabel.topAnchor, constant: -16).isActive = true
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor, constant: -16).isActive = true

        bubbleBackgroundView.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor).isActive = true
        
        self.backgroundColor = .clear
        
        
        bubbleBottomAnchor = bubbleBackgroundView.bottomAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 16)
        bubbleBottomAnchor.isActive = true
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                answerLabel.isHidden = false
                self.bubbleBackgroundView.backgroundColor = UIColor(hexString: "#5cbc8b")
                UIView.animate(withDuration: 0.3, animations: {
                    self.arrowImage.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                }, completion: nil)
            } else {
                answerLabel.isHidden = true
                self.bubbleBackgroundView.backgroundColor = UIColor(hexString: "#77a2ea")
                self.arrowImage.transform = .identity
            }
        }
    }
}
