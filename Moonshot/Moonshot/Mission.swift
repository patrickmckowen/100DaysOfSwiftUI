//
//  Mission.swift
//  Moonshot
//
//  Created by McKowen, Patrick on 7/7/20.
//  Copyright © 2020 Patrick McKowen. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
