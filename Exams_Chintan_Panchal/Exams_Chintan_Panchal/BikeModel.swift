//
//  BikeModel.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

struct BikeResponse: Codable {
    let networks: [Bike]
}

struct Bike: Codable, Identifiable {
    let id: String
    let name: String
    let location: BikeLocation
    let company: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case company
    }
}

struct BikeLocation: Codable {
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
}
