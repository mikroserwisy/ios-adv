protocol ForecastProvider {
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ())
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ())
    
}
