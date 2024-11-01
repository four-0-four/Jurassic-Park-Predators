//
//  PredatorMap.swift
//  JPApexPredators17
//
//  Created by Sina on 2024-11-01.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    var predators = Predators()
    
    @State var position: MapCameraPosition
    @State var imageStyle: Bool = false
    
    var body: some View {
        Map(position: $position){
            ForEach(predators.apexPredators){predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height:100)
                        .scaleEffect(x:-1)
                }
            }
        }.mapStyle(imageStyle ? .imagery(elevation: .realistic) : .standard(elevation:.realistic))
            .overlay(alignment: .bottomTrailing){
                Button{
                    imageStyle.toggle()
                }label:{
                    Image(systemName: imageStyle ? "globe.americas.fill" : "globe.americas" )
                        .font(.largeTitle)
                        .imageScale(.large)
                        .padding(3)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius:3)
                        .padding()
                }
            }
            .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(
        position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 1000, heading: 250, pitch: 80))
    )
}
