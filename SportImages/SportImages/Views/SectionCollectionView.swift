//
//  SectionCollectionView.swift
//  SportImages
//
//  Created by Kyzu on 20.10.22.
//

import UIKit

class SectionCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var vcDelegate: MainViewController!
    var networkDataFetcher = NetworkDataFetcher()
    var indexInStack: Int!
    var photos: [UnsplashPhoto]?
    var cellWidth: CGFloat  = 120
    var cellHeight: CGFloat { return (cellWidth * 2.1) }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
        register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: "sportImage")
        delegate = self
        dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "sportImage", for: indexPath) as! SectionCollectionViewCell
        guard let image = photos?[indexPath.item] else { return cell}
        cell.unsplashPhoto = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = photos?[indexPath.row] else { return }
        vcDelegate.openFullImage(photo: photo)
    }
    
    func fetchDataFromServer(searchText: String, pageNumber: Int = 1) {
        self.networkDataFetcher.fetchImages(searchTerm: searchText, pageNumber: pageNumber) { [weak self] searchResults in
            guard let fetchedPhotos = searchResults else { return}
            self?.photos = fetchedPhotos.results
            self?.reloadData()
        }
    }
}
