//
//  AstronautView.swift
//  Moonshot
//
//  Created by McKowen, Patrick on 7/8/20.
//  Copyright © 2020 Patrick McKowen. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
   
    let astroMissions: [Mission]
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        for mission in missions {
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                matches.append(mission)
            }
        }
        
        self.astroMissions = matches
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                    // useful to fix rendering bugs with content getting clipped
                    //  .layoutPriority(1)
                    
                    Text("Missions")
                        .font(.headline)
                    
                    ForEach(self.astroMissions) { mission in
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.secondary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.formattedLaunchDate)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                        .padding(.horizontal)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
