//
//  TrackerDatePicker.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class TrackerDatePicker: UIDatePicker {
    
    weak var delegateVC: TrackersNavBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearance()
        addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAppearance() {
        datePickerMode = .date
        locale = Locale(identifier: "ru_RU")
        preferredDatePickerStyle = .compact
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.widthAnchor.constraint(equalToConstant: 120)])
        
        tintColor = .tBlack
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let calendar = Calendar.current
        let selectedDate = calendar.startOfDay(for: sender.date)
        
        delegateVC?.dateChanged(date: selectedDate)
    }
}
