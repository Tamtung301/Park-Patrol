import SwiftUI
import MapKit

struct HomeView: View {
    @State private var isMenuVisible = false
    @State private var selectedOption: MenuOption? = nil
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.8818, longitude: -117.8855), // Default location: CSUF East Parking
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var pin: CLLocationCoordinate2D? = nil
    @State private var isAlertSent = false
    @State private var nearestLocation = "" // Nearest named location
    @State private var coordinatesText = "" // Text for coordinates
    @Environment(\.managedObjectContext) private var viewContext // Core Data context
    
    // Added state variable to store profile image
    @State private var profileImage: UIImage?
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Main content
                VStack {
                    // Map View
                    CustomMapView(region: $region, pin: $pin, nearestLocation: $nearestLocation, coordinatesText: $coordinatesText)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding()

                    // Location Label
                    VStack {
                        Text("Location: \(nearestLocation)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Coordinates: \(coordinatesText)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom)

                    // Send Alert Button
                    Button(action: {
                        if let pin = pin {
                            sendAlert(location: nearestLocation, coordinate: pin)
                            isAlertSent = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isAlertSent = false // Reset alert status
                            }
                        }
                    }) {
                        Text("Send Alert")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(pin == nil ? Color.gray : Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(pin == nil)
                    .padding(.horizontal)

                    Spacer()
                }
                .blur(radius: isMenuVisible ? 10 : 0)

                // Side Menu
                if isMenuVisible {
                    Rectangle()
                        .fill(Color.black.opacity(0.3))
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isMenuVisible = false
                            }
                        }
                        .transition(.opacity)

                    HStack {
                        SideMenu(isShowing: $isMenuVisible, selectedOption: $selectedOption)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 0)
                            .transition(.move(edge: .leading))
                            .zIndex(1)

                        Spacer()
                    }
                }

                // Handle Navigation to selected option
                NavigationLink(destination: SettingsView(), tag: .settings, selection: $selectedOption) {
                    SettingsView()
                }
                .hidden()

                NavigationLink(destination: AboutView(), tag: .about, selection: $selectedOption) {
                    AboutView()
                }
                .hidden()

                // Alert Sent Confirmation
                if isAlertSent {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Alert Sent Successfully!")
                                .font(.headline)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 20)
                        Spacer()
                    }
                    .transition(.opacity)
                    .zIndex(2)
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                    withAnimation {
                        isMenuVisible.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                },
                trailing: NavigationLink(destination: AvatarView(profileImage: $profileImage)) {
                    if let image = profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .imageScale(.large)
                    }
                }
            )
            .navigationTitle("Home")
        }
    }

    // Send alert to other users
    private func sendAlert(location: String, coordinate: CLLocationCoordinate2D) {
        let newReport = Report(context: viewContext)
        newReport.timestamp = Date()
        newReport.latitude = coordinate.latitude
        newReport.longitude = coordinate.longitude
        newReport.location = location

        do {
            try viewContext.save()
        } catch {
            print("Failed to send alert: \(error)")
        }
    }
}
