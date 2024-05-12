//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class TrackersViewController: UIViewController {
    
//    MARK: - Private properties
    
    private let emptyListView = EmptyListView()
    private let tabBarEdgeView = UIView()

    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tWhite
        setViews()
    }
    
}

//  MARK: - set layout extension

extension TrackersViewController {
    
    func setViews() {
        
        guard let navigationController else { return }
        guard let tabBarController else { return }
        let tabBar = tabBarController.tabBar
        let navigationBar = navigationController.navigationBar

        view.addSubview(navigationBar)
        view.addSubview(emptyListView)
        
        tabBarEdgeView.backgroundColor = .lightGray
        tabBar.addSubview(tabBarEdgeView)

        
        setConstraints(views: [emptyListView, tabBarEdgeView], tabBar: tabBar, navigationBar: navigationBar)
    }
    
    func setConstraints(views: [UIView], tabBar: UITabBar, navigationBar: UINavigationBar) {
        
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        полоса края TabBar
        NSLayoutConstraint.activate([
            tabBarEdgeView.leftAnchor.constraint(equalTo: tabBar.leftAnchor),
            tabBarEdgeView.rightAnchor.constraint(equalTo: tabBar.rightAnchor),
            tabBarEdgeView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 1),
            tabBarEdgeView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
//        Вью с отображением инфоромации о пустом списке трекеров
        NSLayoutConstraint.activate([
            emptyListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyListView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            emptyListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBar.bounds.height))
        ])
    
    }
}
