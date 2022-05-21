//
//  LandmarksViewController.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import UIKit
import CoreData

class LandmarksViewController: UITableViewController {
    var isFavoriteFilterActive: Bool = false
    var filteredLandmarks: [Landmark] = []
    var landmarkDataSource = LandmarksDataSource()
    var loadedLandmarks: [Landmark] = []
    
    @IBAction func onFilterFavoritesSwitchValueChanged(_ sender: UISwitch) {
        isFavoriteFilterActive = sender.isOn
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // MARK - Preloading landmarks data
        LandmarksDataSource.preload(appDelegate: appDelegate)
    }
}

extension LandmarksViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LandmarksDataSource.getCount(onlyFavorites: isFavoriteFilterActive)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkCell", for: indexPath) as! LandmarkCell
        
        cell.landmark = LandmarksDataSource.landmark(
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
            destination.landmark = LandmarksDataSource.landmark(at: self.tableView.indexPathForSelectedRow!, onlyFavorites: isFavoriteFilterActive)
        }
    }
}
