//
//  VerticalSectionCollectionView.swift
//  SportImages
//
//  Created by Kyzu on 21.10.22.
//

import UIKit

class MoreImagesViewController: UIViewController {

    var networkDataFetcher = NetworkDataFetcher()
    var sectionName: String!
    var searchWord: String!
    var moreImagesCollection: MoreCollectionView!
    private var photos: [UnsplashPhoto]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        setupNavigationBar(text: sectionName)
        setMoreCollectionView()
   
    }

    private func setupNavigationBar(text: String) {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setMoreCollectionView() {
        moreImagesCollection = MoreCollectionView()
        moreImagesCollection.vcDelegate = self
        moreImagesCollection.searchWord = searchWord
        moreImagesCollection.fetchDataFromServer(searchText: searchWord, pageNumber: 2)
        view.addSubview(moreImagesCollection)
        
        moreImagesCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        moreImagesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        moreImagesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        moreImagesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //MARK: - Actions
    func openFullImage(photo: UnsplashPhoto) {
        let fullVC = FullImageViewController()
         fullVC.unsplashPhoto = photo
         navigationController?.pushViewController(fullVC, animated: true)
    }
 
}

