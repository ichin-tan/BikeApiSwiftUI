//
//  DetailView.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI
import MapKit

struct BikeNetworkDetailView: View {
    let bikeNetwork: Network?
    @EnvironmentObject var dbController: DatabaseController
    @State private var showAlert = false
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.01, longitude: -116.16),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    ))
    
    var body: some View {
        ScrollView {
            if let bikeNetwork = bikeNetwork {
                VStack(spacing: 20) {
                    ZStack {
                        Map(position: $cameraPosition) {
                            Annotation("", coordinate: CLLocationCoordinate2D(
                                latitude: bikeNetwork.location.latitude,
                                longitude: bikeNetwork.location.longitude
                            )) {
                                VStack(spacing: 0) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.blue.opacity(0.8))
                                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                                            .frame(width: 30, height: 30)
                                        Text("📍")
                                            .font(.system(size: 20))
                                    }
                                    Text(bikeNetwork.location.city)
                                        .foregroundColor(.blue)
                                        .font(.system(size: 12, weight: .bold))
                                }
                            }
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .onAppear {
                            let region = MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: bikeNetwork.location.latitude,
                                    longitude: bikeNetwork.location.longitude
                                ),
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                            cameraPosition = MapCameraPosition.region(region)
                        }
                    }
                    .padding([.leading, .trailing], 15)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        detailRow(title: "Name", value: bikeNetwork.name)
                        detailRow(title: "City", value: bikeNetwork.location.city)
                        detailRow(title: "Country", value: bikeNetwork.location.country)
                        detailRow(title: "Companies", value: bikeNetwork.company?.joined(separator: ", ") ?? "N/A")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.2))
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 15)
                    
                    Button("MARK AS FAVORITE") {
                        dbController.saveFavoriteNetwork(network: bikeNetwork)
                        showAlert = true
                    }
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.2))
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .padding(.horizontal, 15)
                }
                .padding(.vertical, 20)
            }
        }
        .navigationTitle(bikeNetwork?.location.city ?? "")
        .alert("Success", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Network location added to favorites!")
        }
    }
    
    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text("\(title):")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.blue)
            Text(value)
                .font(.system(size: 15))
                .foregroundColor(.blue)
            Spacer()
        }
    }
}
