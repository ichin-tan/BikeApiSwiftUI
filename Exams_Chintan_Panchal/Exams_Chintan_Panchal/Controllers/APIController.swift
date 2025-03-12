//
//  APIController.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import Foundation

class APIController: ObservableObject {
    @Published var bikes: [Bike] = []
    
    func fetchNetworks() {
        guard let url = URL(string: "https://api.citybik.es/v2/networks") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(BikeResponse.self, from: data)
                DispatchQueue.main.async {
                    self.bikes = result.networks
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }
}
