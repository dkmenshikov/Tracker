//
//  TrackerCollectionViewCell.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 25.05.24.
//

import UIKit

class TrackerCollectionViewCell: UICollectionViewCell {
    
    private var trackerBackgroundColor: UIColor = .black
    private var trackerLabel = UILabel()
    private var trackerEmojiLabel = UILabel()
    
    private let addDayToStatButton: UIButton = UIButton()
    private let quantityLabel: UILabel = UILabel()
    private let trackerBackgroundView = UIView()
    private let emojiBackgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCell (trackerBackgroundColor: UIColor = .black, trackerLabelText: String = "ПУСТО", trackerEmojiText: String = "☠️") {
        self.trackerBackgroundColor = trackerBackgroundColor
        self.trackerLabel.text = trackerLabelText
        self.trackerEmojiLabel.text = trackerEmojiText
        setViews()
    }
    
    private func setViews() {
        trackerLabel.font = .systemFont(ofSize: 12)
        trackerLabel.textColor = .tWhite
        trackerLabel.numberOfLines = 2
        trackerEmojiLabel.font = .systemFont(ofSize: 16)
        trackerEmojiLabel.backgroundColor = .clear
        quantityLabel.font = .systemFont(ofSize: 12)
        quantityLabel.textColor = .tBlack
        quantityLabel.text = "0 дней"
        trackerBackgroundView.backgroundColor = trackerBackgroundColor
        trackerBackgroundView.layer.cornerRadius = 16
        emojiBackgroundView.backgroundColor = .tEmojiBackground
        emojiBackgroundView.layer.cornerRadius = 12
        addDayToStatButton.backgroundColor = .clear
        addDayToStatButton.setImage(.trackerCellPlus.withTintColor(trackerBackgroundColor), for: [])
        
        contentView.addSubview(trackerBackgroundView)
        trackerBackgroundView.addSubview(emojiBackgroundView)
        emojiBackgroundView.addSubview(trackerEmojiLabel)
        trackerBackgroundView.addSubview(trackerLabel)
        contentView.addSubview(addDayToStatButton)
        contentView.addSubview(quantityLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        [trackerBackgroundView, emojiBackgroundView, trackerEmojiLabel, trackerLabel, quantityLabel, addDayToStatButton].forEach {
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
            addDayToStatButton.heightAnchor.constraint(equalToConstant: 34),
            addDayToStatButton.widthAnchor.constraint(equalToConstant: 34),
            addDayToStatButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            addDayToStatButton.trailingAnchor.constraint(equalTo: trackerBackgroundView.trailingAnchor, constant: -12)
        ])
        
//        contentView
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 148)
        ])
        
    }
    
}
