//
//  APIController.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import Foundation
import Alamofire

class APIController: ObservableObject {
    @Published var arrNetworks: [Network] = []
        
    func fetchBikeNetworks() {
        let apiURL = "https://api.citybik.es/v2/networks"
        
        AF.request(apiURL)
            .validate()
            .response { res in
                switch res.result {
                    case .success(let responseData):
                        do {
                            if let responseData = responseData {
                                let networkResponse = try JSONDecoder().decode(NetworkResponse.self, from: responseData)
                                self.arrNetworks = networkResponse.networks
                            }
                        } catch {
                            print("Error decoding products!")
                        }
                        
                    case .failure(let error):
                        print("Error fetching products! \(error.localizedDescription)")
                }
            }
    }
}
