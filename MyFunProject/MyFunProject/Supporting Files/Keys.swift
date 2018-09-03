//
//  Keys.swift
//  MyFunProject
//
//  Created by Daniel Lau on 9/1/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import Foundation

     func accessKey(keyname : String) -> String {
        
        guard let filePath = Bundle.main.path(forResource: "keys", ofType: "plist") else { return ""}
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let value = plist?.object(forKey: keyname) as? String else { return ""}
        
        return value
    }


