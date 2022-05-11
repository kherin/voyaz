//
//  Landmark.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import Foundation

struct Landmark {
    var id: String
    var name: String?
    var district: String?
    var location: String?
    var primaryImagePath: String?
    var mapImagePath: String?
    var description: String?
    var isFavorite: Bool = false
    var category: String
}
