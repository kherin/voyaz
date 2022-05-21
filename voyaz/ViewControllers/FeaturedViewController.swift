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
        LandmarksDataSource.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedLandmarkCell", for: indexPath)
        return cell
    }
}
