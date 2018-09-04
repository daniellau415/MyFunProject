//
//  FaqController.swift
//  MyFunProject
//
//  Created by Daniel Lau on 8/31/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import Foundation
import SwiftyJSON

class FaqController {
    
    //Source of truth
   static var questAns: [Faq] = []
    
    //MARK: - Properties

    static let username = accessKey(keyname: "username")
    static let password = accessKey(keyname: "password")
    
    //MARK: - HTTP Request
    
    static func createRequest(completion: @escaping(JSON?) -> Void) {
        
        let loginString = String(format: "%@:%@", username, password)
        guard let loginData = loginString.data(using: String.Encoding.utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()
        
        guard let url = URL(string: "https://prep2.gw.gocopia.com/prep/faq") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue(password, forHTTPHeaderField: username)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    self.questAns.removeAll()
                    for (_, dictionaryValue) in json {
                        for (key, value) in dictionaryValue {
                            let valueArray = [value.description]
                            let newQuestAns = Faq(opened: false, key: key, theValue: valueArray)
                            self.questAns.append(newQuestAns)
                        }
                    }
                    completion(json)
                } catch let error {
                    print("error converting data to json", error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
}
