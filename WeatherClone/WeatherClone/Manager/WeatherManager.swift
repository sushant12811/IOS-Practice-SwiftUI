import Foundation
import CoreLocation

import Foundation
import CoreLocation

struct WeatherManager {
    let apiKey = "406873bf744ce97d89ab71327c91d6d1"
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherData {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=406873bf744ce97d89ab71327c91d6d1&units=metric") else {
            fatalError("Invalid API URL")
        }

        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error")}
        let decodedResponse = try JSONDecoder().decode(WeatherData.self, from: data)
        return decodedResponse
    }
}


// MARK: - Weather Data Models
struct WeatherData: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: WindData
    // City name


    struct Coord: Decodable {
        let lat: Double
        let lon: Double  // Fixed: Changed `long` to `lon` to match API response
    }

    struct Weather: Decodable {
        let id : Double
        let main: String
        let description: String
        
    }
    struct Main: Decodable {
        let temp: Double
    }
        
    struct WindData: Decodable{
            let speed: Double
    }
    
    }
