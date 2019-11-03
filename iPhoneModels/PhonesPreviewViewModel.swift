//
//  PhonesPreviewViewModel.swift
//  iPhoneModels
//
//  Created by Alexandre Giguere on 2019-10-27.
//  Copyright © 2019 Alexandre Giguere. All rights reserved.
//

import Foundation
import SAPFiori

class PhonesPreviewViewModel {
    
    private let newPhones: [Phone]
    private let phones: [Phone]
    
    init() {
        phones = Phone.getFromPropertyList() ?? []
        
        newPhones = phones.filter({$0.yearIntroduced == "2019"})
    }
    
    var numberOfSections: Int { 1 }
    
    func numberOfRows(in section: Int) -> Int {
        newPhones.count
    }
    
    func configureCell(_ cell: FUIObjectTableViewCell, at indexPath: IndexPath) {
        let phone = newPhones[indexPath.row]
        
        cell.headlineText = phone.name
        cell.detailImage = UIImage(named: phone.imageName)
        cell.accessoryType = .disclosureIndicator
    }
    
    func configureView(_ view: FUITableViewHeaderFooterView, forHeaderInSection section: Int) {
        view.titleLabel.text = "What's new!"
        view.selectionStyle = .none
    }
    
    func configureView(_ view: FUITableViewHeaderFooterView, forFooterInSection section: Int) {
        view.style = .attribute
        view.titleLabel.text = "All"
        view.attributeLabel.text = "\(phones.count)"
    }
}
