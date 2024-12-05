//
//  AboutView.swift
//  Park Patrol
//
//  Created by Hector Mojica on 11/27/24.
//


import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("About Park Patrol")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Park Patrol is a simple app that allows users to report any issues they encounter at their local parking lot.")

            Spacer()
        }
        .padding()
        .navigationBarTitle("About", displayMode: .inline)
    }
}
