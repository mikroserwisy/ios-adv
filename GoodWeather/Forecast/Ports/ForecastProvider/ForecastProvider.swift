import Combine

protocol ForecastProvider {
    
    func getForecast(for city: String) -> AnyP, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ())
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ())
    
}
