protocol GetForecastUseCase {
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, GetForecastError>) -> ())
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, GetForecastError>) -> ())
    
}
