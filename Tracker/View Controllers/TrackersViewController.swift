//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class TrackersViewController: UIViewController {
    
//    MARK: - Private properties
    
    private let trackersLabel = UILabel()
    private let searchBar = UISearchBar()
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

        view.addSubview(navigationController.navigationBar)
        
        trackersLabel.text = "Трекеры"
        trackersLabel.textColor = .tBlack
        trackersLabel.font = .boldSystemFont(ofSize: 34)
        view.addSubview(trackersLabel)
        
        searchBar.placeholder = "Поиск"
        searchBar.backgroundImage = UIImage()

        view.addSubview(searchBar)
        
        view.addSubview(emptyListView)
        
        tabBar.backgroundColor = .tWhite
        tabBarEdgeView.backgroundColor = .lightGray
        tabBar.addSubview(tabBarEdgeView)

        
        setConstraints(views: [trackersLabel, searchBar, emptyListView, tabBarEdgeView])
    }
    
    func setConstraints(views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        лейбл "Трекеры"
        NSLayoutConstraint.activate([
            trackersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackersLabel.topAnchor.constraint(equalTo: navigationController?.navigationBar.bottomAnchor ?? view.topAnchor),
            trackersLabel.heightAnchor.constraint(equalToConstant: 41)
        ])
        
//        SearchBar
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.topAnchor.constraint(equalTo: trackersLabel.bottomAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        guard let tabBarController else { return }
        let tabBar = tabBarController.tabBar
        
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
            emptyListView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            emptyListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBar.bounds.height))
        ])
    
    }
}
