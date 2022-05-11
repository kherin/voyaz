//
//  LandmarksViewController.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import UIKit

class LandmarksViewController: UITableViewController {
    var isFavoriteFilterActive: Bool = false
    var filteredLandmarks: [Landmark] = []
    var landmarkDataSource = LandmarksDataSource()
    
    @IBAction func onFilterFavoritesSwitchValueChanged(_ sender: UISwitch) {
        isFavoriteFilterActive = sender.isOn
        self.tableView.reloadData()
    }
}

extension LandmarksViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkDataSource.getCount(onlyFavorites: isFavoriteFilterActive)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkCell", for: indexPath) as! LandmarkCell
        
        cell.landmark = landmarkDataSource.landmark(
            at: indexPath,
            onlyFavorites: isFavoriteFilterActive
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showLandmarkDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LandmarkDetailViewController {
            destination.landmark = landmarkDataSource.landmark(at: self.tableView.indexPathForSelectedRow!, onlyFavorites: isFavoriteFilterActive)
        }
    }
    
}
