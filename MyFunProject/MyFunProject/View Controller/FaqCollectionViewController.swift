//
//  FaqCollectionViewController.swift
//  MyFunProject
//
//  Created by Daniel Lau on 8/31/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import UIKit


private let reuseIdentifier = "collectionCell"

class FaqCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(FaqCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.title = "TroubleShoot"
        
        fetchFAQ()
    }
    
    func fetchFAQ() {
        FaqController.shared.createRequest { (_) in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
}


extension FaqCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FaqController.shared.questAns.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FaqCollectionViewCell else { return UICollectionViewCell()}
        let questions = FaqController.shared.questAns[indexPath.row].key
        cell.questionLabel.text = questions
        
        let answers = FaqController.shared.questAns[indexPath.row].theValue[0]
        cell.answerLabel.text = answers
        cell.answerLabel.isHidden = true
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        
        switch collectionView.indexPathsForSelectedItems?.first {
        case .some(indexPath):
            return CGSize(width: view.frame.width - 60, height: 200.0)
        default:
            return CGSize(width: view.frame.width - 60, height: 100.0)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}
