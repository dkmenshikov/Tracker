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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        searchBar.placeholder = "Поиск"
//        searchBar.showsCancelButton = true
        searchBar.setValue("Отменить", forKey: "cancelButtonText")
    }
    
}
