import Foundation

protocol ForecastUpdates {
    
    func save(dayForecast: DayForecast, for city: String) throws
    
    func deleteAll()
    
}
