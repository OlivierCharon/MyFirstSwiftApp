//
//  MovieObject.swift
//  myFirstApp
//
//  Created by Olivier on 22/10/2020.
//

import UIKit

struct MovieObject: Codable {
    var name: String, year: Int, genre: String, poster: String
    enum MovieCodingKeys: String, CodingKey {
        case name = "Title"
        case year = "Year"
        case genre = "Genre"
        case poster = "Poster"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
    
        self.name = try container.decode(String.self, forKey: .name)

        do {
            self.year = try container.decode(Int.self, forKey: .year)
        } catch DecodingError.typeMismatch {
            let returnValue = try container.decode(String.self, forKey: .year)
            self.year = Int(returnValue) ?? 0
        }
        
        do {
            self.genre = try container.decode(String.self, forKey: .genre)
        } catch {
            self.genre = "N/A"
        }
        
        self.poster = try container.decode(String.self, forKey: .poster)
    }
}
