//
//  BikeListView.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI

struct BikeNetworkListView: View {
    @ObservedObject var apiController: APIController
    @State private var searchText = ""
    @State private var goToDetailScreen = false
    @State private var selectedBikeNetwork: Network?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    ForEach(searchedNetworks()) { network in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.2))
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.blue, lineWidth: 1)
                                )
                            Text(network.location.city)
                                .font(.system(size: 15))
                                .foregroundColor(.blue)
                                .padding(10)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .onTapGesture {
                            selectedBikeNetwork = network
                            goToDetailScreen = true
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Network List")
            .navigationDestination(isPresented: $goToDetailScreen) {
                BikeNetworkDetailView(bikeNetwork: selectedBikeNetwork)
            }
            .onAppear {
                apiController.fetchBikeNetworks()
            }
        }
    }
    
    func searchedNetworks() -> [Network] {
        return apiController.arrNetworks.filter {
            searchText.isEmpty ? true : $0.location.city.lowercased().contains(searchText.lowercased())
        }
    }
}
