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
    
    func configureVC() {
        let trackersVC = TrackersViewController()
        viewControllers = [trackersVC]
    }
    
    func configureItems() {
        let leftItem = UIButton()
        leftItem.setImage(.addTrackerButton, for: [])
        navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
        
        let rightItem = TrackerDatePicker()
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: rightItem)
    }

}
