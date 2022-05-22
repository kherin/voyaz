//
//  LandmarkCellTableViewCell.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import UIKit

class LandmarkCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var primaryImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var landmark: Landmark? {
        didSet {
            guard let landmark = landmark else { return }
            
            nameLabel.text = landmark.name
            primaryImageView.image = image(atPath: landmark.primaryImagePath)
            favoriteImageView.image = starImage(isFavorite: landmark.isFavorite)
            favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LandmarkCell.onStarIconTapped)))
            favoriteImageView.isUserInteractionEnabled = true
            
        }
    }
    
    @objc func onStarIconTapped() {
        let landmarkId: String = landmark?.id ?? ""
        let isFavorite: Bool = landmark?.isFavorite ?? false
        landmark?.isFavorite = !isFavorite
        primaryImageView.image = image(atPath: landmark?.primaryImagePath)
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        LandmarksDataSource.setAsFavorite(appDelegate: appDelegate, landmarkId: landmarkId, isFavorite: !isFavorite)
    }
    
    private func image(atPath path: String?) -> UIImage? {
        if path == nil {
            return UIImage(systemName: "exclamationmark")
        } else {
            return UIImage(named: path ?? "")
        }
    }
    
    private func starImage(isFavorite: Bool) -> UIImage? {
        if isFavorite {
            return UIImage(systemName: "star.fill")
        } else {
            return UIImage(systemName: "star")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
