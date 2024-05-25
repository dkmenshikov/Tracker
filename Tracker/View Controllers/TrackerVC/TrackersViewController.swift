//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class TrackersViewController: UIViewController {
    
//    MARK: - Public properties
    
//    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    var categories: [TrackerCategory] = [
        TrackerCategory(title: "111", trackers: [
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dates: [
                .init(timeIntervalSince1970: 212314)
            ])),
            Tracker(id: UUID(), name: "1112", color: .tBlack, emoji: "👾", schedule: Schedule(dates: [
                .init(timeIntervalSince1970: 212314)
            ]))
        ]),
        TrackerCategory(title: "1113333", trackers: [
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dates: [
                .init(timeIntervalSince1970: 212314)
            ])),
            Tracker(id: UUID(), name: "1112", color: .tBlack, emoji: "👾", schedule: Schedule(dates: [
                .init(timeIntervalSince1970: 212314)
            ]))
        ])
    ]

    
//    MARK: - Private properties
    
    private let emptyListView = EmptyListView()
    private let trackersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let trackersCollectionViewCellIdentifier = "cell"
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tWhite
        
        trackersCollectionView.register(TrackerCollectionViewCell.self, forCellWithReuseIdentifier: trackersCollectionViewCellIdentifier)
        trackersCollectionView.dataSource = self
        trackersCollectionView.delegate = self

        setViews()
    }
    
}

//  MARK: - set layout extension

extension TrackersViewController {
    
    private func setViews() {
        
//        let category = TrackerCategory(title: "Category", trackers: [])
//        categories.append(category)
        
        guard let navigationController else { return }
        guard let tabBarController else { return }
        let tabBar = tabBarController.tabBar
        let navigationBar = navigationController.navigationBar

        view.addSubview(navigationBar)
        view.addSubview(trackersCollectionView)
        view.addSubview(emptyListView)

        
        if !categories.isEmpty {
            emptyListView.isHidden = true
        }
        
        setConstraints(views: [emptyListView, trackersCollectionView], 
                       tabBar: tabBar,
                       navigationBar: navigationBar)
    }
    
    private func setConstraints(views: [UIView], tabBar: UITabBar, navigationBar: UINavigationBar) {
        
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        emptyListView, trackersCollectionView
        [emptyListView, trackersCollectionView].forEach {
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBar.bounds.height))
            ])
        }
        
    }
}

//  MARK: - Data source

extension TrackersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(categories.count)
        return categories.count
    }
    
//    установка кол-ва ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(categories[section].trackers.count)
        return categories[section].trackers.count
    }
    
//    настройка ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Cell for item at \(indexPath) is being requested")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trackersCollectionViewCellIdentifier, for: indexPath) as? TrackerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setCell()
        return cell
    }
    
}

//  MARK: - Delegate

extension TrackersViewController: UITableViewDelegate {
    
//    тап на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TrackerCollectionViewCell
//        cell?.contentView.backgroundColor = .gray
    }
//    деселект ячейки
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TrackerCollectionViewCell
//        cell?.contentView.backgroundColor = .white
    }
    
//    отображение контекстного меню при долгом тапе на ячейку
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
//        guard indexPaths.count > 0 else { return nil }
//        let indexPath = indexPaths[0]
//        
//        return UIContextMenuConfiguration(actionProvider: { actions in
//                return UIMenu(children: [
//                    UIAction(title: "Bold", handler: { [weak self] _ in
//                        self?.makeBold(indexPath: indexPath)
//                    }),
//                    UIAction(title: "Italic", handler: { [weak self] _ in
//                        self?.makeItalic(indexPath: indexPath)
//                    })
//                ])
//        })
//    }

}


//  MARK: - FlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
//    ширина ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 2) - 3.5, height: 148)
    }
    
//    интервал между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }

}
