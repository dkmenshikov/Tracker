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
    
    private func setVCs() {
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

//MARK: - Layout
extension TabBarController {
    
    private func setAppearence() {
        tabBar.backgroundColor = .tWhite
        
        let tabBarEdgeView = UIView()
        tabBarEdgeView.backgroundColor = .lightGray
        tabBar.addSubview(tabBarEdgeView)
        
        tabBarEdgeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tabBarEdgeView.leftAnchor.constraint(equalTo: tabBar.leftAnchor),
            tabBarEdgeView.rightAnchor.constraint(equalTo: tabBar.rightAnchor),
            tabBarEdgeView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -1),
            tabBarEdgeView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

}
