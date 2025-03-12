//
//  BikeListView.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI

struct BikeListView: View {
    @ObservedObject var apiController: APIController
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(apiController.bikes.filter {
                searchText.isEmpty ? true : $0.location.city.lowercased().contains(searchText.lowercased())
            }) { bike in
                NavigationLink(destination: DetailView(bike: bike)) {
                    Text(bike.location.city)
                        .foregroundColor(.primary)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("City Bikes")
            .background(Color("Background"))
        }
        .onAppear {
            apiController.fetchNetworks()
        }
    }
}
