import Foundation

protocol ForecastQueries {
    
    func getById(id: UUID) -> DayForecast?
    
    func getAll(for city: String) -> [DayForecast]
    
}
