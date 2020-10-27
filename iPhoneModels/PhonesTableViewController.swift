//
//  PhonesTableViewController.swift
//  iPhoneModels
//
//  Created by Alexandre Giguere on 2019-10-27.
//  Copyright © 2019 Alexandre Giguere. All rights reserved.
//

import UIKit
import SAPFiori

class PhonesTableViewController: UITableViewController {
    
    let viewModel = PhonesViewModel()
	let refreshControl1 = UIRefreshControl()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        configureSearchController()
        
        configureNavigationBar()
		
		refreshControl1.addTarget(self, action: #selector(refresh), for: .valueChanged)
		refreshControl1.tintColor = .white
		tableView.refreshControl = refreshControl1
    }
    
	
	@objc func refresh() {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.refreshControl1.endRefreshing()
		}
	}
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
    
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FUIObjectTableViewCell
        
        viewModel.configureCell(cell, at: indexPath)
        
        return cell
    }
}

// MARK: - Private API
private extension PhonesTableViewController {
    
    func configureTableView() {
        tableView.register(FUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: FUITableViewHeaderFooterView.reuseIdentifier)
        tableView.register(FUIObjectTableViewCell.self, forCellReuseIdentifier: FUIObjectTableViewCell.reuseIdentifier)
    }
    
    func configureNavigationBar() {
        let filterImage = FUIIconLibrary.system.filter.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: #selector(displayFilters(_:)))
    }
    
    func configureSearchController() {
        
    }
    
    @objc func displayFilters(_ sender: UIBarButtonItem) {
        
    }
}
