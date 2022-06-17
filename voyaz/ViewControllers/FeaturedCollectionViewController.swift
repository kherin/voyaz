//
//  FeaturedCollectionViewController.swift
//  voyaz
//
//  Created by Kherin on 17/06/2022.
//

import UIKit

private let reuseIdentifier = "FeaturedCell"
private let sectionInsets = UIEdgeInsets(
    top: 50.0,
    left: 20.0,
    bottom: 50.0,
    right: 20.0
)

private let itemsPerRow: CGFloat = 3

class FeaturedCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension FeaturedCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return LandmarksDataSource.getCategories().count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section : Int
    ) -> Int {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return 0
        }
        let category = MockedData().categories[section]
        return LandmarksDataSource.getCountByCategory(appDelegate: appDelegate, category: category)
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as! FeaturedPhotoCell
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let landmark: Landmark = LandmarksDataSource.landmark(appDelegate: appDelegate, at: indexPath)
        cell.imageView.image = UIImage(named: landmark.primaryImagePath)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        // 1
        case UICollectionView.elementKindSectionHeader:
            // 2
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "FeaturedHeaderView",
                for: indexPath)
            
            // 3
            guard let typedHeaderView = headerView as? FeaturedHeaderView
            else { return headerView }
            
            // 4
            print("IndexPath: \(indexPath.section)")
            let category = MockedData().categories[indexPath.section]
            typedHeaderView.titleLabel.text = category.capitalized
            return typedHeaderView
        default:
            // 5
            assert(false, "Invalid element type")
        }
    }
    
    
}

// MARK: - Collection View Flow Layout Delegate
extension FeaturedCollectionViewController: UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}

