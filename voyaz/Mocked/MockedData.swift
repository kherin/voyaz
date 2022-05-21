//
//  LandmarksMockedData.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import Foundation

class LandmarkMock {
    var id: String
    var name: String?
    var district: String?
    var location: String?
    var primaryImagePath: String?
    var mapImagePath: String?
    var placeDescription: String?
    var isFavorite: Bool
    var category: String
    
    init(id: String, name: String?, district: String?, location: String?, primaryImagePath: String?, mapImagePath: String?, placeDescription: String?, isFavorite: Bool, category: String) {
        self.id = id
        self.name = name
        self.district = district
        self.location = location
        self.primaryImagePath = primaryImagePath
        self.mapImagePath = mapImagePath
        self.placeDescription = placeDescription
        self.isFavorite = isFavorite
        self.category = category
    }
}

class MockedData {
    var categories: [String] = [
        "mountain",
        "crater",
        "port",
        "dunes",
        "falls",
        "island",
        "ruins"
    ]
    var landmarks: [LandmarkMock] = [
        LandmarkMock( // 1
            id: "1",
            name: "Trou aux Cerfs",
            district: "Plaines Wilhems",
            location: "Floreal/Curepipe",
            primaryImagePath: "trou_aux_cerfs_primary",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: true,
            category: "crater"
        ),
        LandmarkMock( // 2
            id: "2",
            name: "Le Morne Brabant",
            district: "Plaines Wilhems",
            location: "Le Morne Peninsula",
            primaryImagePath: "le_morne_brabant_primary",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: true,
            category: "mountain"
        ),
        LandmarkMock( // 3
            id: "3",
            name: "Signal Mountain",
            district: "Port Louis",
            location: "Port Louis",
            primaryImagePath: "signal_mountain_primary",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: false,
            category: "mountain"
        ),
        LandmarkMock( // 4
            id: "4",
            name: "Fort Adelaide",
            district: "Port Louis,",
            location: "Suffren Street",
            primaryImagePath: "fort_adelaide_primary",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: true,
            category: "port"
        ),
        LandmarkMock( // 5
            id: "5",
            name: "Vieux Grand Port",
            district: "Mahebourg",
            location: "Mahebourg",
            primaryImagePath: "vieux_grand_port_primary",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: false,
            category: "port"
        ),
        LandmarkMock( // 6
            id: "6",
            name: "Balaclava Ruins",
            district: "Baie aux Tortues",
            location: "Baie aux Tortues",
            primaryImagePath: "balaclava_ruins_primary",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: true,
            category: "ruins"
        ),
        LandmarkMock( // 7
            id: "7",
            name: "Chamarel Dunes",
            district: "Chamarel",
            location: "Chamarel",
            primaryImagePath: "chamarel_primary",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: true,
            category: "dunes"
        ),
        LandmarkMock( // 8
            id: "8",
            name: "Ile aux Cerfs",
            district: "Ile aux Cerfs",
            location: "Ile aux Cerfs",
            primaryImagePath: "ile_aux_cerfs",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: false,
            category: "island"
        ),
        LandmarkMock( // 9
            id: "9",
            name: "Tamarind Falls",
            district: "Plaines Wilhems ",
            location: "Curepipe",
            primaryImagePath: "tamarind_falls",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: true,
            category: "falls"
        ),
        LandmarkMock( // 10
            id: "10",
            name: "Rochester Falls",
            district: "Plaines Wilhems",
            location: "Floreal/Curepipe",
            primaryImagePath: "rochester_falls_primary",
            mapImagePath: "map_image",
            placeDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            isFavorite: false,
            category: "falls"
        )
    ]
}
