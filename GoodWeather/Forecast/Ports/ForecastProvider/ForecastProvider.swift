import Combine

protocol ForecastProvider {
    
    func getForecast(for city: String) -> AnyPublisher<Forecast, ForecastProviderError>
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, ForecastProviderError>
    
}
