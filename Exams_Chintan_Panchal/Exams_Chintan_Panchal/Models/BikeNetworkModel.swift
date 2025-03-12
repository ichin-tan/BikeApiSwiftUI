//
//  BikeModel.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

struct NetworkResponse: Codable {
    let networks: [Network]
}

struct Network: Codable, Identifiable {
    let id: String
    let name: String
    let location: NetworkLocation
    let company: [String]?
    
}

struct NetworkLocation: Codable {
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
}
