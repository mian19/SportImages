//
//  SectionView.swift
//  Healthy Food
//
//  Created by Kyzu on 4.10.22.
//

import UIKit

class SectionView: UIView {
    
    var sectionName: UILabel!
    var moreButton: UIButton!
    var sectionsCollection: SectionCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        setSectionName()
        setMoreButton()
        setArticlesCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSectionName() {
        sectionName = UILabel()
        sectionName.translatesAutoresizingMaskIntoConstraints = false
        sectionName.font = UIFont.boldSystemFont(ofSize: 25.0)
        sectionName.textAlignment = .left
        sectionName.textColor = .black
        
        addSubview(sectionName)
        
        sectionName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sectionName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        sectionName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setMoreButton() {
        moreButton = UIButton()
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setTitleColor(.systemBlue, for: .normal)
        moreButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        moreButton.setTitle("Больше →", for: .normal)
        addSubview(moreButton)
        trailingAnchor.constraint(equalTo: moreButton.trailingAnchor, constant: 10).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        moreButton.centerYAnchor.constraint(equalTo: sectionName.centerYAnchor).isActive = true
    }
    
    private func setArticlesCollectionView() {
        sectionsCollection = SectionCollectionView()
        addSubview(sectionsCollection)
        
        sectionsCollection.topAnchor.constraint(equalTo: sectionName.bottomAnchor, constant: 5).isActive = true
        sectionsCollection.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sectionsCollection.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sectionsCollection.heightAnchor.constraint(equalToConstant: sectionsCollection.cellHeight).isActive = true
    }
    
}
