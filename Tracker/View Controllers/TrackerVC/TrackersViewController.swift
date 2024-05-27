//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func dateChanged(date: Date)
}

final class TrackersViewController: UIViewController, DatePickerDelegate {
    
//    MARK: - Public properties
    
//    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    var categories: [TrackerCategory] = [
        TrackerCategory(title: "111", trackers: [
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, true, false, false, false, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, true, true, true, true, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, true, true, true, true, true, true]))
            ]),
        TrackerCategory(title: "FFF", trackers: [
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, true, true, true, true, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, true, true, true, true, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, true, true, true, true, true, true]))
            ]),
        TrackerCategory(title: "FFF", trackers: [
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, false, true, true, true, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, false, true, true, true, true, true])),
            Tracker(id: UUID(), name: "111", color: .tBlack, emoji: "👾", schedule: Schedule(dateOfTheBeginning: Date(timeIntervalSince1970: 1716768351), weekdays: [true, false, true, true, true, true, true]))
            ])
        ]
    var categoriesForWeekday: [TrackerCategory] = []

    
//    MARK: - Private properties
    
    private let emptyListView = EmptyListView()
    private let trackersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let trackersCollectionViewCellIdentifier = "cell"
    private let trackersCollectionViewSectionIdentifier = "sectionName"
    
//    MARK: - Public methods
    
    func dateChanged(date: Date) {
        print(date)
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        print(weekday)
        addCategoriesForWeekday(date: date, weekday: weekday)
        trackersCollectionView.reloadData()
    }
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tWhite
//        addCategoriesForWeekday()
        dateChanged(date: Date(timeIntervalSinceNow: 0))
        setTrackersCollectionView()
        setViews()
    }
    
//    MARK: - Private methods
    
    private func addCategoriesForWeekday(date: Date, weekday: Int) {
        var tempTrackers: [Tracker] = []
        var tempCategories: [TrackerCategory] = []
        categories.forEach {
            $0.trackers.forEach{
                if ($0.schedule.dateOfTheBeginning <= date) && ($0.schedule.weekdays[weekday-1] == true) {
                    tempTrackers.append($0)
                }
            }
            if !tempTrackers.isEmpty {
                tempCategories.append(TrackerCategory(title: $0.title, trackers: tempTrackers))
            }
            tempTrackers = []
        }
        categoriesForWeekday = tempCategories
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

        if !categoriesForWeekday.isEmpty {
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
        print(categoriesForWeekday.count)
        return categoriesForWeekday.count
    }
    
//    установка кол-ва ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(categoriesForWeekday[section].trackers.count)
        return categoriesForWeekday[section].trackers.count
    }
    
//    настройка ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Cell for item at \(indexPath) is being requested")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trackersCollectionViewCellIdentifier, for: indexPath) as? TrackerCollectionViewCell else {
            return UICollectionViewCell()
        }
        let tracker = categoriesForWeekday[indexPath.section].trackers[indexPath.row]
        cell.setCell(trackerBackgroundColor: tracker.color, trackerLabelText: tracker.name, trackerEmojiText: tracker.emoji)
        return cell
    }
    
    //    названия для supplementary views
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            if kind == UICollectionView.elementKindSectionHeader {
                guard let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: trackersCollectionViewSectionIdentifier,
                    for: indexPath) as? TrackerCollectionViewCellSectionHeader else { return UICollectionReusableView() }
                view.headerLabel.text = categoriesForWeekday[indexPath.section].title
                return view
            }
        return UICollectionReusableView()
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
