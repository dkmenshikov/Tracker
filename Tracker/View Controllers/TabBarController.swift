//
//  TabBarController.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        setVCs()
        setAppearence()
    }
    
    func setAppearence() {
        tabBar.backgroundColor = .tWhite
    }
    
}

extension TabBarController {
    
    func setVCs() {
        let trackersNavigationController = TrackersNavigationController()
        trackersNavigationController.tabBarItem = UITabBarItem(title: "Трекеры",
                                                               image: .trackerTabBarIcon,
                                                               selectedImage: nil)
        let statsVC = StatsViewController()
        statsVC.tabBarItem = UITabBarItem(title: "Статистика",
                                          image: .statsTabBarIcon,
                                          selectedImage: nil)
        viewControllers = [trackersNavigationController, statsVC]
    }
}
