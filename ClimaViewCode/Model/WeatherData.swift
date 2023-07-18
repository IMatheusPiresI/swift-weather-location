//
//  WeatherData.swift
//  ClimaViewCode
//
//  Created by Matheus Sousa on 17/07/23.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let id: Int
}

struct Main: Codable {
    let temp: Float
}
