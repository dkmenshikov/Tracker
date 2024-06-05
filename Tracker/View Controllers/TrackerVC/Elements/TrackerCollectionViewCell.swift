//
//  TrackerCollectionViewCell.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 25.05.24.
//

import UIKit

class TrackerCollectionViewCell: UICollectionViewCell {
    
    private weak var delegateVC: TrackerCollectionViewCellDelegate?
    
    private var trackerBackgroundColor: UIColor = .black
    private var trackerLabel = UILabel()
    private var trackerEmojiLabel = UILabel()
    
    private let cellButton: UIButton = UIButton()
    private let quantityLabel: UILabel = UILabel()
    private let trackerBackgroundView = UIView()
    private let emojiBackgroundView = UIView()
    
    private var isCompleted: Bool = false
    private var trackerID = UUID()
    private var completedDays = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(tracker: Tracker, delegate: TrackerCollectionViewCellDelegate? = nil, isCompleted: Bool, completedDays: Int) {
        self.trackerBackgroundColor = tracker.color
        self.trackerLabel.text = tracker.name
        self.trackerEmojiLabel.text = tracker.emoji
        self.delegateVC = delegate
        self.isCompleted = isCompleted
        self.completedDays = completedDays
        trackerID = tracker.id
        cellButton.addTarget(self, action: #selector(cellButtonDidTap), for: .touchUpInside)
        setViews()
    }
    
    @objc private func cellButtonDidTap() {
        isCompleted = !isCompleted
        if isCompleted {
            completedDays += 1
        } else {
            completedDays -= 1
        }
        setButtonImage()
        quantityLabel.text = quantityLabelText(count: completedDays)
        delegateVC?.cellButtonDidTap(id: trackerID, isCompleted: isCompleted)
    }
    
    private func setButtonImage() {
        if isCompleted {
            cellButton.setImage(.trackerCellCheckmark.withTintColor(trackerBackgroundColor), for: [])
        } else {
            cellButton.setImage(.trackerCellPlus.withTintColor(trackerBackgroundColor), for: [])
        }
    }
    
    private func quantityLabelText(count: Int) -> String {
        switch count % 10 {
        case 1:
            return "\(count) день"
        case 2, 3, 4:
            return "\(count) дня"
        default:
            return "\(count) дней"
        }
    }
    
    private func setViews() {
        trackerLabel.font = .systemFont(ofSize: 12)
        trackerLabel.textColor = .tWhite
        trackerLabel.numberOfLines = 2
        trackerEmojiLabel.font = .systemFont(ofSize: 16)
        trackerEmojiLabel.backgroundColor = .clear
        quantityLabel.font = .systemFont(ofSize: 12)
        quantityLabel.textColor = .tBlack
        quantityLabel.text = quantityLabelText(count: completedDays)
        trackerBackgroundView.backgroundColor = trackerBackgroundColor
        trackerBackgroundView.layer.cornerRadius = 16
        emojiBackgroundView.backgroundColor = .tEmojiBackground
        emojiBackgroundView.layer.cornerRadius = 12
        setButtonImage()
        contentView.addSubview(trackerBackgroundView)
        trackerBackgroundView.addSubview(emojiBackgroundView)
        emojiBackgroundView.addSubview(trackerEmojiLabel)
        trackerBackgroundView.addSubview(trackerLabel)
        contentView.addSubview(cellButton)
        contentView.addSubview(quantityLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        [trackerBackgroundView, emojiBackgroundView, trackerEmojiLabel, trackerLabel, quantityLabel, cellButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        trackerBackgroundView
        NSLayoutConstraint.activate([
            trackerBackgroundView.heightAnchor.constraint(equalToConstant: 90),
            trackerBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            trackerBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trackerBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
//        emojiBackgroundView
        NSLayoutConstraint.activate([
            emojiBackgroundView.heightAnchor.constraint(equalToConstant: 24),
            emojiBackgroundView.widthAnchor.constraint(equalToConstant: 24),
            emojiBackgroundView.leadingAnchor.constraint(equalTo: trackerBackgroundView.leadingAnchor, constant: 12),
            emojiBackgroundView.topAnchor.constraint(equalTo: trackerBackgroundView.topAnchor, constant: 12)
        ])
        
//        trackerEmojiLabel
        NSLayoutConstraint.activate([
            trackerEmojiLabel.centerXAnchor.constraint(equalTo: emojiBackgroundView.centerXAnchor),
            trackerEmojiLabel.centerYAnchor.constraint(equalTo: emojiBackgroundView.centerYAnchor)
        ])
        
//        trackerLabel
        NSLayoutConstraint.activate([
            trackerLabel.bottomAnchor.constraint(equalTo: trackerBackgroundView.bottomAnchor, constant: -12),
            trackerLabel.leadingAnchor.constraint(equalTo: trackerBackgroundView.leadingAnchor, constant: 12),
            trackerLabel.trailingAnchor.constraint(equalTo: trackerBackgroundView.trailingAnchor, constant: -12)
        ])
        
//        quantityLabel
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: trackerBackgroundView.bottomAnchor, constant: 16),
            quantityLabel.leadingAnchor.constraint(equalTo: trackerBackgroundView.leadingAnchor, constant: 12)
        ])
        
//        addDayToStatButton
        NSLayoutConstraint.activate([
            cellButton.heightAnchor.constraint(equalToConstant: 34),
            cellButton.widthAnchor.constraint(equalToConstant: 34),
            cellButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            cellButton.trailingAnchor.constraint(equalTo: trackerBackgroundView.trailingAnchor, constant: -12)
        ])
        
//        contentView
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 148)
        ])
        
    }
    
}
