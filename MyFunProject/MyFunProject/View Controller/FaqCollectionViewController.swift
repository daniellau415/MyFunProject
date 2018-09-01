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
    
    lazy var searchBar : UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = UIColor(hexString: "#edefee")
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
        sb.delegate = self
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(FaqCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.title = "TroubleShoot"
        setupViews()
        fetchFAQ()
    }
    
    func fetchFAQ() {
        FaqController.shared.createRequest { (_) in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    func setupViews() {
        collectionView?.backgroundColor = UIColor(hexString: "#edefee")
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .onDrag
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCellId")
    }
}


extension FaqCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
        header.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -10).isActive = true
        return header
    }
    
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
        searchBar.resignFirstResponder()
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}

extension FaqCollectionViewController : UISearchBarDelegate {
    
}
