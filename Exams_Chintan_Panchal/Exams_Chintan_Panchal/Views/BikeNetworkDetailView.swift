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
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.01, longitude: -116.16),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    ))
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Map(position: $cameraPosition) {
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: bikeNetwork.location.latitude,longitude: bikeNetwork.location.longitude)){
                        Button(action: {}) {
                            VStack(spacing: 0) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.blue.opacity(0.5))
                                        .frame(width: 30, height: 30)
                                    Text("📍")
                                        .padding(5)
                                        .font(.system(size: 20))
                                }
                                Text("\(bikeNetwork.location.city)")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 10))
                                    .fontWeight(.medium)
                            }
                        }
                    }
                }
                .onAppear() {
                    let region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: bikeNetwork.location.latitude,
                                                       longitude: bikeNetwork.location.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                    cameraPosition = MapCameraPosition.region(region)
                }
                .frame(height: 300)
                
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
