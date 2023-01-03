//
//  RocketsModel.swift
//  SpaceX
//
//  Created by Богдан Баринов on 02.08.2022.
//

//MARK: - Results

struct Rockets: Decodable {
    let name: String
    let flickrImages: [String]
    let height: MeasurementUnit
    let diameter: MeasurementUnit
    let mass: MeasurementUnitMass
    let payloadWeights: [MeasurementUnitMass]
    let firstFlight: String
    let country: String
    let costPerLaunch: Int
    let firstStage: Stage
    let secondStage: Stage

    enum CodingKeys: String, CodingKey {
        case name
        case flickrImages = "flickr_images"
        case height
        case diameter
        case mass
        case payloadWeights = "payload_weights"
        case firstFlight = "first_flight"
        case country
        case costPerLaunch = "cost_per_launch"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
    }
}

struct MeasurementUnit: Decodable {
    let meters: Double
    let feet: Double
}

struct MeasurementUnitMass: Decodable {
    let kg: Int
    let lb: Int
}

struct Stage: Decodable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSec: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}
