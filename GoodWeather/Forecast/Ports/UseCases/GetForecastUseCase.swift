import Combine

protocol GetForecastUseCase {
    
    func getForecast(for city: String) -> AnyPublisher<Forecast, GetForecastError>
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, GetForecastError>
    
}
