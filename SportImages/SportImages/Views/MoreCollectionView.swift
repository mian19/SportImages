//
//  MoreCollectionView.swift
//  SportImages
//
//  Created by Kyzu on 21.10.22.
//

import UIKit

class MoreCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var vcDelegate: MoreImagesViewController!
    private var pageNumber = 2
    private var isFetchingMore = false
    private var cellWidth = (UIScreen.main.bounds.width - 60) / 2
    private var cellHeight: CGFloat { return (cellWidth * 2.1) }
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var networkDataFetcher = NetworkDataFetcher()
    var photos: [UnsplashPhoto]?
    var searchWord: String!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: "sportImage")
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos?.count ?? 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "sportImage", for: indexPath) as! SectionCollectionViewCell
        guard let image = photos?[indexPath.item] else { return cell}
        cell.backgroundColor = .gray
        cell.unsplashPhoto = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = photos?[indexPath.row] else { return }
        vcDelegate.openFullImage(photo: photo)
    }
    
    func fetchDataFromServer(searchText: String, pageNumber: Int) {
        
        self.networkDataFetcher.fetchImages(searchTerm: searchText, pageNumber: pageNumber) { [weak self] searchResults in
            guard let fetchedPhotos = searchResults else { return}
            if pageNumber != 2 {
                self?.photos! += fetchedPhotos.results
            } else {
                self?.photos = fetchedPhotos.results
            }
            self?.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offset > contentHeight - scrollView.frame.height {
            if isFetchingMore {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                    if self?.pageNumber == 2 {
                        self?.pageNumber = 3
                        self?.fetchDataFromServer(searchText: self?.searchWord ?? "", pageNumber: self?.pageNumber ?? 3)
                    }
                })
            }
            isFetchingMore = true
        }
    }
}
