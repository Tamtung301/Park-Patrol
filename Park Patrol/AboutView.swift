//
//  AboutView.swift
//  Park Patrol
//
//  Created by Hector Mojica on 11/27/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title with Icon
                HStack {
                    Image(systemName: "car.2.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    Text("About Park Patrol")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .padding(.bottom, 10)

                // Description
                Text("Park Patrol is your go-to app for reporting and staying informed about parking issues on and around CSUF's campus. Use our app to be aware of parking patrollers, and park smart, saving yourself from tickets and fines. \n\nTap anywhere on the map to select a location, and then share your findings with the community!")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)

                // Features List
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.blue)
                        Text("Report Patrollers: Easily notify others about parking patrol.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.blue)
                        Text("Stay Alert: Get notifications about patrols or reported issues.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.blue)
                        Text("Find Safer Spots: Access a map of reported concerns and avoid trouble.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical)

                Spacer()

                // Navigation Button to HomeView
                NavigationLink(destination: HomeView()) {
                    Text("Get Started!")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

