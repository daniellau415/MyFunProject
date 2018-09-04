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
   static var faqs: [Faq] = []
    
    //MARK: - Properties

    static private let username = accessKey(keyname: "username")
    static private let password = accessKey(keyname: "password")
    
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
                    self.faqs.removeAll()
                    for (_, dictionaryValue) in json {
                        for (key, value) in dictionaryValue {
                            let valueArray = [value.description]
                            let newQuestAns = Faq(opened: false, key: key, theValue: valueArray)
                            self.faqs.append(newQuestAns)
                        }
                    }
                    completion(json)
                } catch let error {
                    print("error converting data to json", error.localizedDescription)
                    completion(nil)
                    return
                }
            }
        }
        dataTask.resume()
    }
}

  //Uncomment to use JSONSerialization instead of SwiftyJSON
    /*
    static func createRequest(completion: @escaping(Bool?) -> Void) {

        let base64LoginString = "MTIzNDpleUpoYkdjaU9pSklVekkxTmlKOS5leUpWVTBsRUlqb2lObVZqWlRaaVpXVXdZVFJsTVRsbU1HRTRNamRpTlRNNU1tSTJOVFJoTkdNMU1XWXdNRE5qT1NJc0luUnpJam94TlRNek16TTVPRGMwZlEuYlQtMlF4TGlRZnlxcDNVYndpX0EzZXI3N3RYNWZlUjlnMUFoeDJpWWpGdw=="

        guard let url = URL(string: "https://prep2.gw.gocopia.com/prep/faq") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let data = data {
                do {

                    guard let dictionaryArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:String]] else { return }

                    for dictionary in dictionaryArray {
                        for (key, value) in dictionary {
                            let valueArray = [value]
                            let newQuestAns = Faq(opened: false, key: key, theValue: valueArray)
                            self.faqs.append(newQuestAns)
                        }
                    }
                    completion(true)
                } catch let error {
                    print("error converting data to json", error.localizedDescription)
                    completion(false)
                    return
                }
            }
        }
        dataTask.resume()
    }
}
 */

