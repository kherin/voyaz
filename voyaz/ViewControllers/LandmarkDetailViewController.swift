//
//  LandmarkDetailViewController.swift
//  voyaz
//
//  Created by Kherin on 06/05/2022.
//

import UIKit

extension UIImage {
    var isPortrait:  Bool    { size.height > size.width }
    var isLandscape: Bool    { size.width > size.height }
    var breadth:     CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
    var breadthRect: CGRect  { .init(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        guard let cgImage = cgImage?
                .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
                                                  y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                    size: breadthSize)) else { return nil }
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: breadthSize, format: format).image { _ in
            UIBezierPath(ovalIn: breadthRect).addClip()
            UIImage(cgImage: cgImage, scale: format.scale, orientation: imageOrientation)
                .draw(in: .init(origin: .zero, size: breadthSize))
        }
    }
}

class LandmarkDetailViewController: UIViewController {
    
    lazy var mapImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        image.backgroundColor = .white
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var landmarkImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var landmarkTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var landmarkLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var landmarkDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        return label
    }()
    
    
    
    var landmark: Landmark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize text and image
        self.navigationItem.title = landmark?.name
        
        // images
        mapImageView.image = UIImage(named: landmark?.mapImagePath ?? "")
        landmarkImageView.image = UIImage(named: landmark?.primaryImagePath ?? "")?.circleMasked
        mapImageView.addSubview(landmarkImageView)
        
        
        //text
        landmarkTitleLabel.text = landmark?.name
        landmarkLocationLabel.text = "\(landmark?.location ?? "-"), \(landmark?.district ?? "")"
        landmarkDescriptionLabel.text = landmark?.placeDescription ?? "No description"
        
        
        
        // setup layout
        setupViews()
        setupConstraints()
    }
    
    
    private func setupViews() {
        view.addSubview(mapImageView)
        view.addSubview(landmarkTitleLabel)
        view.addSubview(landmarkLocationLabel)
        view.addSubview(landmarkDescriptionLabel)
        //        view.addSubview(landmarkImageView)
    }
    
    private func setupConstraints() {
        // setup constraint for map image
        NSLayoutConstraint.activate([
            mapImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mapImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 500),
            mapImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        ])
        
        // setup constraint for landmark image
        NSLayoutConstraint.activate([
            landmarkImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            landmarkImageView.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width / 2),
            landmarkImageView.widthAnchor.constraint(equalToConstant: 200),
            landmarkImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // setup constraint for title
        NSLayoutConstraint.activate([
            landmarkTitleLabel.topAnchor.constraint(equalTo: landmarkImageView.bottomAnchor, constant: 5),
            landmarkTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            landmarkTitleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            landmarkTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // setup constraint for location
        NSLayoutConstraint.activate([
            landmarkLocationLabel.topAnchor.constraint(equalTo: landmarkTitleLabel.bottomAnchor, constant: 1),
            landmarkLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            landmarkLocationLabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            landmarkLocationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        // setup constraint for description
        NSLayoutConstraint.activate([
            landmarkDescriptionLabel.topAnchor.constraint(equalTo: landmarkLocationLabel.bottomAnchor, constant: 1),
            landmarkDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            landmarkDescriptionLabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            landmarkDescriptionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
