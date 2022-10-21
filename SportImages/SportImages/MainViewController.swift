//
//  ViewController.swift
//  SportImages
//
//  Created by Kyzu on 20.10.22.
//

import UIKit

class MainViewController: UIViewController {

    private let sectionsDict = ["Футбол": "Football", "Хоккей": "Ice Hockey", "Баскетбол": "Basketball", "Теннис": "tennis"]
    private var sectionHeight: CGFloat = 300
    private var contentSize: CGSize {
        let height: CGFloat = CGFloat(sectionsDict.count) * sectionHeight + CGFloat(sectionsDict.count * 25)
        return CGSize(width: view.frame.width, height: height)
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: view.bounds.width, height: view.bounds.height)
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var burgerBarButtonItem: UIBarButtonItem = {
        var button = UIBarButtonItem(image: UIImage(systemName: "text.justifyleft"), style: .plain, target: self, action: #selector(onBurgerButton))
        button.tintColor = .black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Галерея"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButton()
        setCategoryCollection()
        setConstraints()
    }
    
    private func setView() {
     
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }

    private func setBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = burgerBarButtonItem
    }
    
    private func setCategoryCollection() {
        for (index, item) in sectionsDict.keys.sorted(by: <).enumerated() {
            let sectionView = SectionView()
            sectionView.sectionsCollection.indexInStack = index
            sectionView.sectionName.text = item
 //           sectionView.sectionsCollection.fetchDataFromServer(searchText: sectionsDict[item]!)
            stackView.addArrangedSubview(sectionView)

        }
    }
    
    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10)
        ])
        
        for view in stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: stackView.widthAnchor),
                view.heightAnchor.constraint(equalToConstant: sectionHeight)
            ])
        }
    }
    
    @objc private func onBurgerButton() {
        print("burger")
    }

}

