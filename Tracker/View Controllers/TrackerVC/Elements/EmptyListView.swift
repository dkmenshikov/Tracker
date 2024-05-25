//
//  EmptyListView.swift
//  Tracker
//
//  Created by Dmitriy Menshikov on 11.05.24.
//

import UIKit

final class EmptyListView: UIView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        let starImage = UIImageView(image: .emptyList)
        let emptyListLabel = UILabel()
        emptyListLabel.text = "Что будем отслеживать?"
        emptyListLabel.font = .systemFont(ofSize: 12)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        [starImage, emptyListLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
}
