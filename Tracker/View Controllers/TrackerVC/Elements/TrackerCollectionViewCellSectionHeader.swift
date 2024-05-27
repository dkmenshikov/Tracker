//
//  TrackerCollectionViewCellSectionHeader.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 26.05.24.
//

import UIKit

class TrackerCollectionViewCellSectionHeader: UICollectionReusableView {
    let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerLabel.font = .boldSystemFont(ofSize: 19)
        headerLabel.numberOfLines = 1
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 47),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
