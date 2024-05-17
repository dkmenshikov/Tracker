//
//  TrackersNavigationController.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class TrackersNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        configureVC()
        configureItems()
    }
    
    private func configureVC() {
        let trackersVC = TrackersViewController()
        viewControllers = [trackersVC]
    }
    
    private func configureItems() {
        let leftItem = UIButton()
        leftItem.setImage(.addTrackerButton, for: [])
        navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
//        TODO: - ПЕРЕОПРЕДЕЛИТЬ ОБЛАСТЬ НАЖАТИЯ КНОПКИ НА 42*42 с 19*18
        
        let rightItem = TrackerDatePicker()
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: rightItem)
        
        let searchController = TrackerSearchBar(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationBar.prefersLargeTitles = true
        navigationBar.topItem?.title = "Трекеры"
        navigationBar.topItem?.searchController = searchController

    }

}
