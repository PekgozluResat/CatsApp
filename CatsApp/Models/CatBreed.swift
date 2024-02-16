//
//  CatBreed.swift
//  CatsApp
//
//  Created by Resat Pekgozlu on 16/02/2024.
//

import Foundation

struct CatBreed: Codable {
    let name: String
    let description: String
    let imageId: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case imageId = "reference_image_id"
    }
}
