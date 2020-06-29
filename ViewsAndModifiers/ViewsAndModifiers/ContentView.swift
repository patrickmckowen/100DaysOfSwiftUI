//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by McKowen, Patrick on 6/29/20.
//  Copyright © 2020 Patrick McKowen. All rights reserved.
//

import SwiftUI

var button1: some View {
    Button("Button One") {
        print("Button One")
    }
    .frame(width: 200, height: 64)
    .background(Color.red)
}
var button2: some View {
    Button("Button Two") {
        print("Button Two")
    }
    .frame(width: 200, height: 64)
    .background(Color.black)
}

struct ContentView: View {
    var body: some View {
        VStack() {
            button1
            button2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
