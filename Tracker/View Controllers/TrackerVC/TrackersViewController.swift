//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

protocol TrackersNavBarDelegate: AnyObject, UITextFieldDelegate, UISearchControllerDelegate {
    func dateChanged(date: Date)
}

protocol TrackerCollectionViewCellDelegate: AnyObject {
    func cellButtonDidTap(id: UUID, isCompleted: Bool)
}

final class TrackersViewController: UIViewController, TrackersNavBarDelegate, TrackerCollectionViewCellDelegate {
    
//    MARK: - Public properties
    
//    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    var categories: [TrackerCategory] = [
        TrackerCategory(title: "111", trackers: [
            Tracker(id: UUID(), name: "112", color: .red, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, true, false, false, false, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, true, true, true, true, true, true])),
            Tracker(id: UUID(), name: "111", color: .blue, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, true, true, true, true, true, true]))
            ]),
        TrackerCategory(title: "FFF", trackers: [
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, true, true, true, true, true, true])),
            Tracker(id: UUID(), name: "121", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, true, true, true, true, true, true])),
            Tracker(id: UUID(), name: "121", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, true, true, true, true, true, true]))
            ]),
        TrackerCategory(title: "FFF", trackers: [
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, false, true, true, true, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, false, true, true, true, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [false, false, true, true, true, true, true]))
            ])
        ]
    var categoriesFiltered: [TrackerCategory] = []

    
//    MARK: - Private properties
    
    private let emptyListView = EmptyListView()
    private let trackersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let trackersCollectionViewCellIdentifier = "cell"
    private let trackersCollectionViewSectionIdentifier = "sectionName"
    
    private var date = Date(timeIntervalSinceNow: 0)
    private var searchedTitle = ""
    
//    MARK: - Public methods
    
    func cellButtonDidTap(id: UUID, isCompleted: Bool) {
        if isCompleted {
            let newRecord = TrackerRecord(id: id, date: date)
            completedTrackers.append(newRecord)
        } else {
            completedTrackers.removeAll { trackerRecord in
                trackerRecord.date == date && trackerRecord.id == id
            }
        }
    }
    
    func dateChanged(date: Date) {
        self.date = date
        filterTrackers()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchedTitle = textField.text ?? ""
        filterTrackers()
        return true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        searchedTitle = ""
        filterTrackers()
    }
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tWhite
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        dateChanged(date: startOfDay)
        setTrackersCollectionView()
        setViews()
    }
    
//    MARK: - Private methods
    
    private func filterTrackers() {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        var tempTrackers: [Tracker] = []
        var tempCategories: [TrackerCategory] = []
        categories.forEach {
            $0.trackers.forEach{
                if ($0.schedule.dateOfTheBeginning <= date) &&
                    ($0.schedule.weekdays[weekday-1] == true) &&
                    (searchedTitle == "" || $0.name.contains(searchedTitle)) {
                    tempTrackers.append($0)
                }
            }
            if !tempTrackers.isEmpty {
                tempCategories.append(TrackerCategory(title: $0.title, trackers: tempTrackers))
            }
            tempTrackers = []
        }
        categoriesFiltered = tempCategories
        if categoriesFiltered.isEmpty {
            emptyListView.isHidden = false
        } else {
            emptyListView.isHidden = true
        }
        trackersCollectionView.reloadData()
    }
    
    private func setTrackersCollectionView() {
        trackersCollectionView.register(TrackerCollectionViewCell.self, forCellWithReuseIdentifier: trackersCollectionViewCellIdentifier)
        trackersCollectionView.register(TrackerCollectionViewCellSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: trackersCollectionViewSectionIdentifier)
        trackersCollectionView.dataSource = self
        trackersCollectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = CGSize(width: trackersCollectionView.frame.width, height: 47)
        trackersCollectionView.collectionViewLayout = flowLayout
        trackersCollectionView.showsVerticalScrollIndicator = false
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
        view.addSubview(trackersCollectionView)
        view.addSubview(emptyListView)
        
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
        return categoriesFiltered.count
    }
    
//    установка кол-ва ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesFiltered[section].trackers.count
    }
    
//    настройка ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trackersCollectionViewCellIdentifier, for: indexPath) as? TrackerCollectionViewCell else {
            return UICollectionViewCell()
        }
        let tracker = categoriesFiltered[indexPath.section].trackers[indexPath.row]
        let isCompleted = completedTrackers.contains { trackerRecord in
            trackerRecord.date == date && trackerRecord.id == tracker.id
        }
        let completedDays = completedTrackers.filter {
            $0.id == tracker.id
        }.count
        cell.setCell(tracker: tracker, delegate: self, isCompleted: isCompleted, completedDays: completedDays)
        return cell
    }
    
    //    названия для supplementary views
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            if kind == UICollectionView.elementKindSectionHeader {
                guard let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: trackersCollectionViewSectionIdentifier,
                    for: indexPath) as? TrackerCollectionViewCellSectionHeader else { return UICollectionReusableView() }
                view.headerLabel.text = categoriesFiltered[indexPath.section].title
                return view
            }
        return UICollectionReusableView()
    }
    
}

//  MARK: - CollectionViewDelegate

extension TrackersViewController: UICollectionViewDelegate {
    
//    тап на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as? TrackerCollectionViewCell
//        cell?.contentView.backgroundColor = .gray
    }
//    деселект ячейки
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as? TrackerCollectionViewCell
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
