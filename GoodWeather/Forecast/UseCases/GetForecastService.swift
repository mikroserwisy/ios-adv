final class GetForecastService: GetForecastUseCase {
    
    @Inject
    private var forecastProvider: ForecastProvider
    
    /*init(forecastProvider: ForecastProvider) {
        self.forecastProvider = forecastProvider
    }*/
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, GetForecastError>) -> ()) {
        forecastProvider.getForecast(for: city) { self.onForecastLoaded(result: $0, callback: callback) }
    }
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, GetForecastError>) -> ()) {
        forecastProvider.getForecast(for: location) { self.onForecastLoaded(result: $0, callback: callback) }
    }
    
    private func onForecastLoaded(result: Result<Forecast, ForecastProviderError>, callback: @escaping (Result<Forecast, GetForecastError>) -> ()) {
        switch result {
        case .success(let forecast):
            callback(.success(forecast))
        case .failure(let error):
            print(error)
            callback(.failure(.refreshFailed))
        }
    }

}
