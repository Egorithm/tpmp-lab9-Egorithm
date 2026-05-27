//
//  DepartmentCell.swift
//  FPMI_App
//
//  Created by user on 13.05.26.
//  Kurdeko Egor

import Foundation
import UIKit

class DepartmentCell: UICollectionViewCell {
    let img = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(img)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            img.heightAnchor.constraint(equalToConstant: 90),
            
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
