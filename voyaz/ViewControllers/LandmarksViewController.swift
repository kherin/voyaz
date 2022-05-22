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
    var landmarkDataSource = LandmarksDataSource()
    
    @IBAction func onFilterFavoritesSwitchValueChanged(_ sender: UISwitch) {
        isFavoriteFilterActive = sender.isOn
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let _ = LandmarksDataSource.fetch(appDelegate: appDelegate)
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // MARK - Preloading landmarks data
//        LandmarksDataSource.preload(appDelegate: appDelegate)
        let _ = LandmarksDataSource.fetch(appDelegate: appDelegate)
    }
}

extension LandmarksViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return 0
        }
        return LandmarksDataSource.getCount(appDelegate: appDelegate, onlyFavorites: isFavoriteFilterActive)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkCell", for: indexPath) as! LandmarkCell
        
        cell.landmark = LandmarksDataSource.landmark(
            appDelegate: appDelegate,
            at: indexPath,
            onlyFavorites: isFavoriteFilterActive
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showLandmarkDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let destination = segue.destination as? LandmarkDetailViewController {
            destination.landmark = LandmarksDataSource.landmark(
                appDelegate: appDelegate,
                at: self.tableView.indexPathForSelectedRow!,
                onlyFavorites: isFavoriteFilterActive
            )
        }
    }
}
