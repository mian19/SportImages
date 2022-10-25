//
//  FullImageViewController.swift
//  SportImages
//
//  Created by Kyzu on 22.10.22.
//

import UIKit
import SDWebImage

class FullImageViewController: UIViewController {

    private var homeButton: UIButton!
    private var saveButton: UIButton!
    private var crossButton: UIButton!
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
  
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["raw"]
            guard let imageUrl = photoUrl, let url = URL(string: "\(imageUrl)&w=\(UIScreen.main.bounds.width)&h=\(UIScreen.main.bounds.height)&dpr=2") else { return }
            photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            photoImageView.sd_setImage(with: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        setPhotoImageView()
        setButtons()
        setActionsForButtons()
    }
    
    private func setPhotoImageView() {
        view.addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setButtons() {
        saveButton = UIButton.roundedButton(imageName: "arrow.down.to.line.alt", side: 60)
        homeButton = UIButton.roundedButton(imageName: "house.fill", side: 40)
        crossButton = UIButton.roundedButton(imageName: "xmark", side: 40)
        
        photoImageView.addSubview(saveButton)
        photoImageView.addSubview(homeButton)
        photoImageView.addSubview(crossButton)
        
        saveButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        homeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        homeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        homeButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor).isActive = true
        homeButton.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -30).isActive = true
        
        crossButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        crossButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        crossButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor).isActive = true
        crossButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 30).isActive = true
    }
    
    private func setActionsForButtons() {
        saveButton.addTarget(self, action: #selector(onSave), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(onHome), for: .touchUpInside)
        crossButton.addTarget(self, action: #selector(onCross), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    @objc private func onHome() {
        navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc private func onCross() {
        if navigationController?.viewControllers.count == 3 {
            navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
        } else {
            onHome()
        }
    }
    
    @objc private func onSave() {
        guard let image = photoImageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

}
