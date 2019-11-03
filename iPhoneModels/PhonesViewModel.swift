//
//  PhonesViewModel.swift
//  iPhoneModels
//
//  Created by Alexandre Giguere on 2019-10-27.
//  Copyright © 2019 Alexandre Giguere. All rights reserved.
//

import Foundation
import SAPFiori

class PhonesViewModel {
    
    private let phones = Phone.getFromPropertyList() ?? []
    
    init() { }
    
    var numberOfSections: Int { 1 }
    
    func numberOfRows(in section: Int) -> Int {
        phones.count
    }
    
    func configureCell(_ cell: FUIObjectTableViewCell, at indexPath: IndexPath) {
        let phone = phones[indexPath.row]
        
        cell.headlineText = phone.name
        cell.detailImage = UIImage(named: phone.imageName)
        cell.accessoryType = .disclosureIndicator
    }
}
