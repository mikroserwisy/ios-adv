import Foundation

protocol ForecastUpdates {
    
    func save(forecast: [DayForecast], for city: String) throws
    
    func deleteAll()
    
}
