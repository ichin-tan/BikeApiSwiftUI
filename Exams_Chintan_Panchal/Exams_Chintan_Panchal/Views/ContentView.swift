//
//  ContentView.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var apiController = APIController()
    @StateObject private var dbController = DatabaseController()

    
    var body: some View {
        TabView {
            BikeNetworkListView(apiController: apiController)
                .tabItem {
                    Label("All Locations", systemImage: "bicycle")
                }
            favoriteLocationListView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .environmentObject(dbController)
        .accentColor(.blue)
        .background(Color.white)
    }
}

#Preview {
    ContentView()
}
