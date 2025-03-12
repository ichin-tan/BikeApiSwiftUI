//
//  DetailView.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI
import MapKit

struct BikeNetworkDetailView: View {
    let bikeNetwork: Network
    @EnvironmentObject var dbController: DatabaseController
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: bikeNetwork.location.latitude,
                                                   longitude: bikeNetwork.location.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))),
                    annotationItems: [bikeNetwork]) { network in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: network.location.latitude,
                                                                 longitude: network.location.longitude))
                }
                .frame(height: 300)
                // Have to display city name on marker
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name: \(bikeNetwork.name)")
                    Text("City: \(bikeNetwork.location.city)")
                    Text("Country: \(bikeNetwork.location.country)")
                    Text("Companies: \(bikeNetwork.company?.joined(separator: ", ") ?? "N/A")")
                }
                .padding()
                
                Button("MARK AS FAVORITE") {
                    dbController.saveFavoriteNetwork(network: bikeNetwork)
                    showAlert = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
        }
        .alert("Success", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Network location added to favorites!")
        }
        .navigationTitle(bikeNetwork.location.city)
        .background(.white)
    }
}
