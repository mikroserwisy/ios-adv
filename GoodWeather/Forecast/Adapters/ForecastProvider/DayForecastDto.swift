import Foundation

struct DayForecastDto: Decodable {
    
    let date: Double
    let temperature: TemperatureDto
    let pressure: Double
    let conditions: [ConditionsDto]
    
    enum CodingKeys: String, CodingKey {
    
        case date = "dt"
        case temperature = "temp"
        case pressure
        case conditions = "weather"
        
    }
    
}
