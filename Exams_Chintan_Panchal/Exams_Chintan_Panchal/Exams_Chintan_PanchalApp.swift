//
//  Exams_Chintan_PanchalApp.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI

@main
struct Exams_Chintan_PanchalApp: App {
    @StateObject private var apiController = APIController()
    @StateObject private var dbController = DatabaseController()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                BikeListView(apiController: apiController)
                    .tabItem {
                        Label("All Locations", systemImage: "bicycle")
                    }
                FavouriteView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
            .environmentObject(dbController)
            .accentColor(.blue)
            .background(Color("Background"))
        }
    }
}
