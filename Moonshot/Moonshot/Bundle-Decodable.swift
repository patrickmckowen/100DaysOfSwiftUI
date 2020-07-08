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
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        
        // dateFormat allows us to specify a precise format for our dates, whereas dateStyle has a selection of built-in formats that match the user's settings.
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
