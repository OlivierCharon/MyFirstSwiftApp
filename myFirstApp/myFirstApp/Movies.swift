//
//  Movies.swift
//  myFirstApp
//
//  Created by Olivier on 21/10/2020.
//

import UIKit

struct Movie: Codable {
    var movieObject: Array<MovieObject>
    
    enum MovieObjectCodingKeys: String, CodingKey {
        case search = "Search"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieObjectCodingKeys.self)
        self.movieObject = try container.decode(Array<MovieObject>.self, forKey: .search)
    }
}
