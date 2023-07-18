//
//  ViewController.swift
//  ClimaViewCode
//
//  Created by Matheus Sousa on 12/07/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var screen: WeatherScreen?
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    var searchTextField: UITextField?
    
    override func loadView() {
        super.loadView()
        self.screen = WeatherScreen()
        self.view = screen
        self.screen?.searchTextField.delegate = self
        self.screen?.delegate(delegate: self)
        self.weatherManager.delegate = self
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
   
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension WeatherViewController: WeatherScreenDelegate {
    func tappedLocationButton() {
        self.screen?.endEditing(true)
        locationManager.requestLocation()
        screen?.searchTextField.text = ""
    }
    
    func tappedSearchButton() {
        self.screen?.endEditing(true)
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.screen?.temperatureLabel.text = weather.temperature
            self.screen?.cityNameLabel.text = weather.cityName
            
            let imageConfig = UIImage.SymbolConfiguration(
                pointSize: 85, weight: .regular, scale: .default)
            let imageIcon = UIImage(systemName: weather.conditionName, withConfiguration: imageConfig)?.withTintColor(.whiteDark, renderingMode: .alwaysOriginal)
            self.screen?.iconImageView.image = imageIcon
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        locationManager.stopUpdatingLocation()
        weatherManager.fetchWeather(latitude: lat, logitude: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
            break
        case .denied, .restricted:
            locationManager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        self.screen?.searchTextField.text = ""
    }
}
