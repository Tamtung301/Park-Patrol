import SwiftUI
import MapKit
import CoreLocation

struct CustomMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var pin: CLLocationCoordinate2D?
    @Binding var nearestLocation: String
    @Binding var coordinatesText: String

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        locationManager.delegate = context.coordinator
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        mapView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:))))

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.removeAnnotations(uiView.annotations)
        if let pin = pin {
            let annotation = MKPointAnnotation()
            annotation.coordinate = pin
            uiView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: CustomMapView

        init(_ parent: CustomMapView) {
            self.parent = parent
        }

        // Update region to user's location
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                DispatchQueue.main.async {
                    self.parent.region.center = location.coordinate
                }
            }
        }

        // Handle tap gestures on the map
        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            guard let mapView = gestureRecognizer.view as? MKMapView else { return }
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            self.parent.pin = coordinate
            self.parent.region.center = coordinate // Update map center to selected pin location

            // Reverse geocoding
                        let tappedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        self.parent.geocoder.reverseGeocodeLocation(tappedLocation) { [weak self] placemarks, error in
                            guard let self = self else { return }
                            if let placemark = placemarks?.first {
                                DispatchQueue.main.async {
                                    self.parent.nearestLocation = placemark.name ?? "Unknown Location"
                                    self.parent.coordinatesText = "\(coordinate.latitude), \(coordinate.longitude)"
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.parent.nearestLocation = "Unknown Location"
                                    self.parent.coordinatesText = "\(coordinate.latitude), \(coordinate.longitude)"
                                }
                            }
                        }
                    }
                    
                    // Handle location manager authorization status
                    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
                        switch manager.authorizationStatus {
                        case .authorizedWhenInUse, .authorizedAlways:
                            manager.startUpdatingLocation()
                        case .denied, .restricted:
                            // Handle location services being denied or restricted
                            print("Location services denied or restricted")
                        case .notDetermined:
                            break
                        @unknown default:
                            break
                        }
                    }
                }
            }
