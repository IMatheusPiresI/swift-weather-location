//
//  WeatherManager.swift
//  ClimaViewCode
//
//  Created by Matheus Sousa on 17/07/23.
//

import Foundation

protocol WeatherManagerDelegate: AnyObject {
    func didUpdateWeather(weather: WeatherModel)
}

class WeatherManager {
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=06c362defd7384101ffb0de073e8b191&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let url = "\(baseURL)&q=\(cityName)"

        performRequest(with: url)
    }
    
    func fetchWeather(latitude: Double, logitude: Double) {
        let url = "\(baseURL)&lat=\(latitude)&lon=\(logitude)"
        
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: {
                data, response, error in
                
                if error != nil {
                    print("error")
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(data: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            })
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let tempString = String(format: "%.1f", decodedData.main.temp)
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, temperature: tempString, cityName: name)
            
            return weather
        }
        catch {
            print(error)
            return nil
        }
        
    }
}
