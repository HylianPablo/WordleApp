//
//  KeyCell.swift
//  Wordle
//
//  Created by Pablo Martinez Lopez on 15/4/22.
//

import UIKit

class KeyCell: UICollectionViewCell {
    static let identifier = "KeyCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray5
        contentView.addSubview(self.label)
        NSLayoutConstraint.activate([
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
    }
    
    func configure(with letter: Character) {
        self.label.text = String(letter).uppercased()
    }
}
