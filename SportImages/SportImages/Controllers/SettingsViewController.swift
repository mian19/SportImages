//
//  SettingsViewController.swift
//  SportImages
//
//  Created by Kyzu on 23.10.22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var tableView = UITableView()
    let cellTitles = ["Связаться с нами", "Оценить нас", "Поделиться"]
    let imageNames = ["envelope", "star", "square.and.arrow.up"]
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBarButton()
        setSettingsTable()
    }
    
    private func setBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func setSettingsTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "TableCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 48
        view.addSubview(tableView)
        
        let g = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20),
            tableView.heightAnchor.constraint(equalTo: g.heightAnchor, multiplier: 0.6)
        ])
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? SettingsTableViewCell else {
            fatalError("Unable to dequeue TableCell")
        }
        let imageName = imageNames[indexPath.row]
        cell.cellImageView.image = UIImage(systemName: imageName)
        
        let title = cellTitles[indexPath.row]
        cell.cellLabel.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 8)
    }
}
