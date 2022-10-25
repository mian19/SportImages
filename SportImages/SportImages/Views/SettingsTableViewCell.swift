//
//  SettingsTableViewCell.swift
//  SportImages
//
//  Created by Kyzu on 23.10.22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    var cellImageView = UIImageView()
     var cellLabel = UILabel()

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: "TableCell")
         backgroundColor = .secondarySystemBackground
         cellImageView.translatesAutoresizingMaskIntoConstraints = false
         cellImageView.contentMode = .scaleAspectFit
         cellImageView.tintColor = .black
         contentView.addSubview(cellImageView)
         cellLabel.translatesAutoresizingMaskIntoConstraints = false
         cellLabel.font = UIFont.systemFont(ofSize: 20)
         contentView.addSubview(cellLabel)
         
         NSLayoutConstraint.activate([
             cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
             cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
             cellImageView.widthAnchor.constraint(equalToConstant: 44),
             
             cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             cellLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
             
         ])
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

}
