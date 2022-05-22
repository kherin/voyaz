//
//  FeaturedViewController.swift
//  voyaz
//
//  Created by Kherin on 06/05/2022.
//

import UIKit

class FeaturedViewController: UITableViewController {
}

extension FeaturedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return 0
        }
        return LandmarksDataSource.getCount(appDelegate: appDelegate)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedLandmarkCell", for: indexPath)
        return cell
    }
}
