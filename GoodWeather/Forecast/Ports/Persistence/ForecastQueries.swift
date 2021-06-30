import Foundation

protocol ForecastQueries {
    
    func getById(id: UUID, callback: @escaping (DayForecast) -> Void)
    
    func getAll(for city: String, callback: @escaping ([DayForecast]) -> Void)
    
}
