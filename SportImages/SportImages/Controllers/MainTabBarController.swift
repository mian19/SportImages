//
//  MainTabBarController.swift
//  SportImages
//
//  Created by Kyzu on 19.10.22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().backgroundColor = .white
        let mainVC = MainViewController()
        let navigationVC = generateNavigationController(rootVC: mainVC, image: UIImage(systemName: "house.fill")!)
        let navigationVC2 = generateNavigationController(rootVC: SettingsViewController(), image: UIImage(systemName: "gearshape.fill")!)
        viewControllers = [navigationVC, navigationVC2]
    }
    
    private func generateNavigationController(rootVC: UIViewController, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.image = image
        UINavigationBar.appearance().backgroundColor = .white
      
        return navigationVC
    }
}
