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
    
    typealias resultDictionary = [[String: String]]
    
    var results : [JSON] = []
    var questAns: [Faq] = []
    
    static let shared = FaqController()
    
    let username = "1234"
    let password = "eyJhbGciOiJIUzI1NiJ9.eyJVU0lEIjoiNmVjZTZiZWUwYTRlMTlmMGE4MjdiNTM5MmI2NTRhNGM1MWYwMDNjOSIsInRzIjoxNTMzMzM5ODc0fQ.bT-2QxLiQfyqp3Ubwi_A3er77tX5feR9g1Ahx2iYjFw"
    
        func createRequest(completion: @escaping(JSON?) -> Void) {
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
    
            let url = URL(string: "https://prep2.gw.gocopia.com/prep/faq")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            request.addValue(password, forHTTPHeaderField: username)
    
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
    
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 {
                    do {
                        guard let data = data else { return }
                        let json = try JSON(data: data)
                        self.results = json.arrayValue
                        self.questAns.removeAll()
                        for (_, dictionaryValue) in json {
                            for (key, value) in dictionaryValue {
                                let valueArray = [value.description]
                                let newQuestAns = Faq(opened: false, key: key, theValue: valueArray)
                                self.questAns.append(newQuestAns)
                            }
                        }
                        print(self.questAns.count)
                        completion(json)
                    } catch {
                        print("Could not convert JSON data into a dictionary.")
                        completion(nil)
                        return
                    }
                }
            }
            dataTask.resume()
        }
    
    }
    
    
    
//    func createRequest(completion: @escaping([Faq]?) -> Void) {
//        let loginString = String(format: "%@:%@", username, password)
//        let loginData = loginString.data(using: String.Encoding.utf8)!
//        let base64LoginString = loginData.base64EncodedString()
//
//        let url = URL(string: "https://prep2.gw.gocopia.com/prep/faq")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//        request.addValue(password, forHTTPHeaderField: username)
//
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if let data = data {
//                let jsonDecoder = JSONDecoder()
//                do {
//                    let decodedData = try jsonDecoder.decode(resultDictionary.self, from: data)
//
//
//                } catch let error {
//                    print(error.localizedDescription, "error decoding")
//                }
//            }
//
//            if let response = response {
//                print("got response", response)
//            }
//
//            if let error = error {
//                print("error", error.localizedDescription)
//            }
//
//
//        }
//        dataTask.resume()
//
//    }
//
//}
//
