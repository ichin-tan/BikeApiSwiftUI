//
//  FavouriteView.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI
import CoreData

struct FavouriteView: View {
    @EnvironmentObject var dbController: DatabaseController
    @State private var showDeleteAlert = false
    @State private var favoriteToDelete: Favorites?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dbController.favoriteNetworks, id: \.self) { favorite in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(favorite.value(forKey: "city") as? String ?? "")
                                .font(.headline)
                            Text(favorite.value(forKey: "companies") as? String ?? "")
                                .font(.subheadline)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            favoriteToDelete = favorite
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .background(Color("Background"))
        }
        .onAppear {
            dbController.fetchFavorites()
        }
        .alert("Confirm Delete", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let favorite = favoriteToDelete {
                    dbController.deleteFavorite(favorite)
                }
            }
        } message: {
            Text("Are you sure you want to delete this favorite?")
        }
    }
}
