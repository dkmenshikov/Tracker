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
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tWhite
        setViews()
    }
    
}

//  MARK: - set layout extension

extension TrackersViewController {
    
    private func setViews() {
        
        guard let navigationController else { return }
        guard let tabBarController else { return }
        let tabBar = tabBarController.tabBar
        let navigationBar = navigationController.navigationBar

        view.addSubview(navigationBar)
        view.addSubview(emptyListView)
        
        setConstraints(views: [emptyListView], tabBar: tabBar, navigationBar: navigationBar)
    }
    
    private func setConstraints(views: [UIView], tabBar: UITabBar, navigationBar: UINavigationBar) {
        
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        Вью с отображением инфоромации о пустом списке трекеров
        NSLayoutConstraint.activate([
            emptyListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyListView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            emptyListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBar.bounds.height))
        ])
    
    }
}
