//
//  NewViewController.swift
//  iPhoneModels
//
//  Created by Per-Åge Themte on 27/10/2020.
//  Copyright © 2020 Alexandre Giguere. All rights reserved.
//

import UIKit
import SAPFiori

class NewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

	@IBOutlet weak var tableView: UITableView!
	private var searchController = FUISearchController(searchResultsController: nil)
	let refreshControl1 = UIRefreshControl()
	let viewModel = PhonesViewModel()
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		configureTableView()
		configureSearchController()
		
		refreshControl1.addTarget(self, action: #selector(refresh), for: .valueChanged)
		refreshControl1.tintColor = .white
		tableView.refreshControl = refreshControl1
    }
    
	@objc func refresh() {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			self.refreshControl1.endRefreshing()
		}
	}
	
	func configureSearchController() {
		searchController.searchBar.delegate = self
		searchController.searchResultsUpdater = self
		searchController.hidesNavigationBarDuringPresentation = true
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = NSLocalizedString("Search for Orders", comment: "")
//		searchController.searchBar.scopeButtonTitles = orderSearchTypes.allCases.map { $0.rawValue }
		navigationItem.searchController = searchController
	}
	
	func configureTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(FUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: FUITableViewHeaderFooterView.reuseIdentifier)
		tableView.register(FUIObjectTableViewCell.self, forCellReuseIdentifier: FUIObjectTableViewCell.reuseIdentifier)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows(in: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FUIObjectTableViewCell
		viewModel.configureCell(cell, at: indexPath)
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.numberOfSections
	}

}

extension NewViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		//
	}
}

extension NewViewController: UISearchBarDelegate {}

extension NewViewController: FUIBarcodeScanViewControllerDelegate {
	func barcodeScanViewController(_ barcodeScanViewController: FUIBarcodeScanViewController, didReceiveScanResult scanResult: FUIBarcodeScanResult?) {
		//
	}
}
