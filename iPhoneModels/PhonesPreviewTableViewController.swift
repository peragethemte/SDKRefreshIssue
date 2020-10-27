//
//  PhonesPreviewTableViewController.swift
//  iPhoneModels
//
//  Created by Alexandre Giguere on 2019-10-27.
//  Copyright © 2019 Alexandre Giguere. All rights reserved.
//

import UIKit
import SAPFiori

class PhonesPreviewTableViewController: UITableViewController {
    
    let viewModel = PhonesPreviewViewModel()
	let refreshControl1 = UIRefreshControl()

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    
		refreshControl1.addTarget(self, action: #selector(refresh), for: .valueChanged)
		refreshControl1.tintColor = .white
		tableView.refreshControl = refreshControl1
	}
	
	@objc func refresh() {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			self.refreshControl1.endRefreshing()
		}
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
    
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FUIObjectTableViewCell
        
        viewModel.configureCell(cell, at: indexPath)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FUITableViewHeaderFooterView.reuseIdentifier) as! FUITableViewHeaderFooterView

        viewModel.configureView(view, forHeaderInSection: section)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FUITableViewHeaderFooterView.reuseIdentifier) as! FUITableViewHeaderFooterView

        viewModel.configureView(view, forFooterInSection: section)
        
        view.didSelectHandler = {
            self.performSegue(withIdentifier: "DisplayPhoneList", sender: self)
        }
        
        return view
    }
}

// MARK: - Private API
private extension PhonesPreviewTableViewController {
    
    func configureTableView() {
        tableView.register(FUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: FUITableViewHeaderFooterView.reuseIdentifier)
        tableView.register(FUIObjectTableViewCell.self, forCellReuseIdentifier: FUIObjectTableViewCell.reuseIdentifier)
    }
}
