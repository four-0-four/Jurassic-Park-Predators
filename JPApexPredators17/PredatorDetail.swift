//
//  PredatorDetail.swift
//  JPApexPredators17
//
//  Created by Sina on 2024-10-31.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    @State var position: MapCameraPosition
    var body: some View {
        GeometryReader{geo in
            ScrollView{
                ZStack(alignment:.bottomTrailing){
                    //background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops:
                                            [
                                                Gradient.Stop(color: Color.clear, location: 0.8),
                                                Gradient.Stop(color:.black, location: 1)
                                            ]
                                           , startPoint: .top, endPoint: .bottom)
                        }
                    
                    //dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:geo.size.width/1.5,height:geo.size.height/3)
                        .scaleEffect(x: -1)
                        .shadow(color:.black, radius: 7)
                        .offset(y:20)
                }
                
                VStack(alignment: .leading){
                    //dino image
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    
                    //current location
                    NavigationLink{
                        PredatorMap(
                            position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80))
                        )
                    }label:{
                        Map(position:$position){
                            Annotation(predator.name, coordinate: predator.location){
                                Image(systemName:"mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                            }
                        }
                        .frame(height: 125)
                        .overlay(alignment:.trailing){
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                        }
                        .overlay(alignment:.topLeading){
                            Text("Current Location")
                                .padding([.leading,.bottom],5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius:15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(.bottom,15)
                    }
                    
                    //appears in
                    Text("Appears In:")
                        .font(.title3)
                    
                    ForEach(predator.movies, id:\.self) { movie in
                            Text("▸ "+movie)
                                .font(.subheadline)
                    }
                    
                    //movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    //link to webpage
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width:geo.size.width, alignment: .leading)
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack{
        PredatorDetail(predator: Predators().apexPredators[5], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[5].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
