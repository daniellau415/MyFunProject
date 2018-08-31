//
//  FAQViewController.swift
//  MyFunProject
//
//  Created by Daniel Lau on 8/31/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import UIKit


class FaqListViewController : UIViewController {
    

    @IBOutlet var faqTableView: UITableView!
    
    @IBAction func buttonRequest(_ sender: Any) {
        FaqController.shared.createRequest { (_) in
            DispatchQueue.main.async {
                self.faqTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faqTableView.delegate = self
        faqTableView.dataSource = self
    }
}

extension FaqListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FaqController.shared.questAns.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if FaqController.shared.questAns[section].opened == true {
            return FaqController.shared.questAns[section].theValue.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! FaqCell
            let questions = FaqController.shared.questAns[indexPath.section]
            cell.faqLabel.text = questions.key
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! FaqCell
            let answers = FaqController.shared.questAns[indexPath.section].theValue[dataIndex]
            cell.faqLabel.text = answers
            return cell
        }
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            if indexPath.row == 0 {
                if FaqController.shared.questAns[indexPath.section].opened == true {
                    FaqController.shared.questAns[indexPath.section].opened = false
                    let sections = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(sections, with: .fade)
                    print("this tapped")
                } else {
                    FaqController.shared.questAns[indexPath.section].opened = true
                    let sections = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(sections, with: .fade)
                    print("other tapped")
                }
            }
    
        }
}
