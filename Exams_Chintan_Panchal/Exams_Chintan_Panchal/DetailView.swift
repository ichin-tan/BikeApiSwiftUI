//
//  DetailView.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let bike: Bike
    @EnvironmentObject var dbController: DatabaseController
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: bike.location.latitude,
                                                 longitude: bike.location.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))),
                    annotationItems: [bike]) { bike in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: bike.location.latitude,
                                                               longitude: bike.location.longitude))
                }
                .frame(height: 300)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("City: \(bike.location.city)")
                    Text("Country: \(bike.location.country)")
                    Text("Companies: \(bike.company?.joined(separator: ", ") ?? "N/A")")
                }
                .padding()
                
                Button("MARK AS FAVORITE") {
                    dbController.saveFavorite(bike: bike)
                    showAlert = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
        }
        .alert("Success", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Location added to favorites!")
        }
        .navigationTitle(bike.location.city)
        .background(Color("Background"))
    }
}

extension Bike: IdentifiableMapAnnotation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
}

protocol IdentifiableMapAnnotation: Identifiable {
    var coordinate: CLLocationCoordinate2D { get }
}
