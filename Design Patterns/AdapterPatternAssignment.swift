//
//  AdapterPatternAssignment.swift
//  
//
//  Created by Damir Aliyev on 10.03.2023.
//

import Foundation
import UIKit


protocol WeatherAPIProtocol {
    func getTempInCelcius() -> Int
    func getWindSpeedInKmHour() -> Int
}

class EuropianWeatherAPI: WeatherAPIProtocol {
    
    func getTempInCelcius() -> Int {
        return Int.random(in: 0...35)
    }
    
    func getWindSpeedInKmHour() -> Int {
        return Int.random(in: 5...30)
    }
}


class AmericanWeatherAPI {
    
    func getTempInFahreinheit() -> Int {

        return Int.random(in: 32...95)
    }
    
    func getWindSpeedInMilesHour() -> Float {
        return Float.random(in: 5...15)
    }
}

class AmericanWeatherAPIAdapter: WeatherAPIProtocol {
    
    private let americanWeatherAPI: AmericanWeatherAPI
    
    init(americanWeatherAPI: AmericanWeatherAPI) {
        self.americanWeatherAPI = americanWeatherAPI
    }

    func getTempInCelcius() -> Int {
        let convertedTemp = ((americanWeatherAPI.getTempInFahreinheit() - 32) * 5) / 9
        return convertedTemp
    }
    
    func getWindSpeedInKmHour() -> Int {
        let convertedSpeed = Int(americanWeatherAPI.getWindSpeedInMilesHour() * 1.6)
        return convertedSpeed
    }
}

class Client {
    
    private var weatherAPI: WeatherAPIProtocol
    
    init(weatherAPI: WeatherAPIProtocol) {
        self.weatherAPI = weatherAPI
    }
    
    func setAPI(weatherAPI: WeatherAPIProtocol) {
        self.weatherAPI = weatherAPI
    }
    
    func getTemperature() {
        print("Temperature in Celcius: \(weatherAPI.getTempInCelcius())")
    }
    
    func getWindSpeed() {
        print("Wind speed in km/hours: \(weatherAPI.getWindSpeedInKmHour())")
    }
}

//So now our client can work with AmericanAPI also

let americanWeather = AmericanWeatherAPI()
let americanWeatherAdapter = AmericanWeatherAPIAdapter(americanWeatherAPI: americanWeather)

let client = Client(weatherAPI: americanWeatherAdapter)
client.getTemperature()
client.getWindSpeed()


let europianWeather = EuropianWeatherAPI()
client.setAPI(weatherAPI: europianWeather)
client.getTemperature()
client.getWindSpeed()
