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
    
    @IBAction func onFilterFavoritesSwitchValueChanged(_ sender: UISwitch) {
        isFavoriteFilterActive = sender.isOn
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let appDelegate =
//                UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        
//        // 1
//        let managedContext =
//            appDelegate.persistentContainer.viewContext
//        
//        // 2
//        let entity =
//            NSEntityDescription.entity(forEntityName: "LandmarkModel",
//                                       in: managedContext)!
//        
//        let landmark = NSManagedObject(entity: entity,
//                                       insertInto: managedContext)
//        
//        // 3
//        landmark.setValue(UUID().uuidString, forKeyPath: "id")
//        landmark.setValue("Trou aux Cerfs", forKeyPath: "name")
//        
//        
//        // 4
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "LandmarkModel")
        
        //3
        do {
            let landmarks = try managedContext.fetch(fetchRequest)
            print("landmarks: \(landmarks)")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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
