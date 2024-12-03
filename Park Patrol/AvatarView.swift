//
//  AvatarView.swift
//  Park Patrol
//
//  Created by Hector Mojica on 11/27/24.
//

import SwiftUI
import CoreData

struct AvatarView: View {
    @State private var firstName = "John"
    @State private var lastName = "Doe"
    @State private var username = "johndoe"
    @State private var email = "johndoe@example.com"
    @Binding var profileImage: UIImage?
    @State private var showingImagePicker = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Report.timestamp, ascending: false)],
        animation: .default
    )
    private var reports: FetchedResults<Report>

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Avatar section
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        .onTapGesture {
                            showingImagePicker = true
                        }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showingImagePicker = true
                        }
                }

                Text(username)
                    .font(.title)
                    .fontWeight(.bold)

                // User information form
                Form {
                    Section(header: Text("Personal Information")) {
                        Text("First Name: \(firstName)")
                        Text("Last Name: \(lastName)")
                        Text("Email: \(email)")
                    }
                }

                // Alert history
                Text("Your Alert History")
                    .font(.title)
                    .fontWeight(.bold)

                // History list or empty state
                if reports.isEmpty {
                    Text("No alerts sent yet.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    ForEach(reports.filter { $0.latitude != 0 && $0.longitude != 0 }, id: \.self) { report in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(report.location ?? "Unknown Location")
                                .font(.headline)
                            Text("Coordinates: \(report.latitude), \(report.longitude)")
                                .font(.subheadline)
                            if let timestamp = report.timestamp {
                                Text("Date: \(timestamp, style: .date)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }

                // Clear History Button
                Button(action: clearHistory) {
                    Text("Clear History")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 16)
                .padding(.horizontal)
            }
            .padding()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $profileImage)
        }
    }

    // Function to clear all history
    private func clearHistory() {
        for report in reports {
            viewContext.delete(report)
        }
        do {
            try viewContext.save()
        } catch {
            print("Failed to clear history: \(error.localizedDescription)")
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }
}
