//
//  FeaturedViewController.swift
//  voyaz
//
//  Created by Kherin on 06/05/2022.
//

import UIKit

class FeaturedViewController: UITableViewController {
    var landmarksDataSource = LandmarksDataSource()
}

extension FeaturedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        landmarksDataSource.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedLandmarkCell", for: indexPath)
        //        cell = landmarksDataSource.landmark(
        //            at: indexPath
        //        )
        return cell
    }
}
