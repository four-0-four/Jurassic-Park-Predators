//
//  ApexPredator.swift
//  JPApexPredators17
//
//  Created by Sina on 2024-10-30.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: predatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum predatorType: String, Decodable, CaseIterable, Identifiable {
        case all
        case land
        case air
        case sea
        
        var id: predatorType {
            self
        }
        
        var background: Color {
            switch self{
                case .all:
                    .brown
                case .land:
                    .brown
                case .air:
                    .teal
                case .sea:
                    .blue
            }
        }
        
        var icon: String {
            switch self{
                case .all:
                    "square.stack.3d.up.fill"
                case .land:
                    "leaf.fill"
                case .air:
                    "wind"
                case .sea:
                    "drop.fill"
            }
        }
    }
}
