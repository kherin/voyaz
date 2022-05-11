
//  TabBarViewController.swift
//  voyaz
//
//  Created by Kherin on 06/05/2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.selectedImage = UIImage(named: "item_selected")
        self.tabBarItem.image = UIImage(named: "item")
    }
}
