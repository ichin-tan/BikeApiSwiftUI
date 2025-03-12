//
//  FavouriteView.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import SwiftUI
import CoreData

struct FavoriteLocationListView: View {
    @EnvironmentObject var dbController: DatabaseController
    @State private var showDeleteAlert = false
    @State private var favoriteToDelete: Favorites?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    ForEach(dbController.favoriteNetworks, id: \.self) { favoriteNetwork in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.2))
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.blue, lineWidth: 1)
                                )
                            VStack(alignment: .leading, spacing: 5) {
                                Text("CITY: \(favoriteNetwork.city ?? "")")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.blue)
                                Text("COMPANIES: \(favoriteNetwork.companies ?? "")")
                                    .font(.system(size: 13))
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15))

                        .swipeActions {
                            Button(role: .destructive) {
                                favoriteToDelete = favoriteNetwork
                                showDeleteAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Favorites")
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
}
