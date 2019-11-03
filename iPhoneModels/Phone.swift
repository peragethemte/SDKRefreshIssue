//
//  Phone.swift
//  iPhoneModels
//
//  Created by Alexandre Giguere on 2019-10-27.
//  Copyright © 2019 Alexandre Giguere. All rights reserved.
//

import Foundation

struct Phone: Decodable {
    let name: String
    let yearIntroduced: String
    let imageName: String
    let capacity: [Int]
    let colors: [String]?
    let modelNumbers: [String]
}

extension Phone {
    
    static func getFromPropertyList() -> [Phone]? {
        guard let url = Bundle.main.url(forResource: "PhoneModels", withExtension: "plist") else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            
            return try PropertyListDecoder().decode([Phone].self, from: data)
            
        } catch {
            return nil
        }
    }
}
