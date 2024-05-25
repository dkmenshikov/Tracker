//
//  TrackerSearchBar.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class TrackerSearchBar: UISearchController {
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        searchBar.placeholder = "Поиск"
        searchBar.setValue("Отменить", forKey: "cancelButtonText")
    }
    
}