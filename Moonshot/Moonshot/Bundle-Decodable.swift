//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by McKowen, Patrick on 7/7/20.
//  Copyright © 2020 Patrick McKowen. All rights reserved.
//

import Foundation


extension Bundle {
    // <T> is a way to make a method generic, allowing us to use a variety of Types.
    // "T" could be anything: <Type>, <Generic>, etc, but T is a programmer convention
    // This example can conform to Codable protocol because the json data contains IDs
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
