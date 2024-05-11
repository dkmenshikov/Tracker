//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class TrackersViewController: UIViewController {
    
//    MARK: - Private properties
    
    let trackersLabel = UILabel()
    
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
        
        view.addSubview(navigationController.navigationBar)
        view.addSubview(tabBarController.tabBar)
        
        trackersLabel.text = "Трекеры"
        trackersLabel.textColor = .tBlack
        trackersLabel.font = .systemFont(ofSize: 34)
        
        view.addSubview(trackersLabel)
        
        setConstraints(views: [trackersLabel])
    }
    
    func setConstraints(views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            trackersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackersLabel.topAnchor.constraint(equalTo: navigationController?.navigationBar.bottomAnchor ?? view.topAnchor),
            trackersLabel.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
}
