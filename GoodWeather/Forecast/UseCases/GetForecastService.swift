import Resolver

final class GetForecastService: GetForecastUseCase {
    
    @Injected
    private var forecastProvider: ForecastProvider
    @Injected
    private var forecastReposiotry: ForecastQueries & ForecastUpdates

    func getForecast(for city: String, callback: @escaping (Result<Forecast, GetForecastError>) -> ()) {
        let cachedForecast = forecastReposiotry.getAll(for: city)
        if !cachedForecast.isEmpty {
            callback(.success(Forecast(city: city, forecast: cachedForecast)))
        }
        forecastProvider.getForecast(for: city) { self.onForecastLoaded(result: $0, callback: callback) }
    }
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, GetForecastError>) -> ()) {
        forecastProvider.getForecast(for: location) { self.onForecastLoaded(result: $0, callback: callback) }
    }
    
    private func onForecastLoaded(result: Result<Forecast, ForecastProviderError>, callback: @escaping (Result<Forecast, GetForecastError>) -> ()) {
        switch result {
        case .success(let forecast):
            forecastReposiotry.deleteAll()
            forecast.forecast.forEach { try? forecastReposiotry.save(dayForecast: $0, for: forecast.city) }
            callback(.success(forecast))
        case .failure(let error):
            print(error)
            callback(.failure(.refreshFailed))
        }
    }

}
