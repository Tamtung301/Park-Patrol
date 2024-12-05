//
//  SideMenu.swift
//  Park Patrol
//
//  Created by Hector Mojica on 11/27/24.
//


import SwiftUI

enum MenuOption: String, CaseIterable, Identifiable {
    case home = "Home"
    case settings = "Settings"
    case about = "About"

    var id: String { rawValue }
}

struct SideMenu: View {
    @Binding var isShowing: Bool
    @Binding var selectedOption: MenuOption?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(MenuOption.allCases) { option in
                Button(action: {
                    withAnimation {
                        selectedOption = option
                        isShowing = false
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text(option.rawValue)
                        .font(.headline)
                        .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)))
                        .cornerRadius(8)
                }
            }

            Spacer()
        }
        .padding()
        .frame(width: 250)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 0)
        .transition(.move(edge: .leading).combined(with: .opacity))
    }
}
