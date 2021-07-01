import Resolver
import Combine

final class GetForecastService: GetForecastUseCase {
    
    @Injected
    private var forecastProvider: ForecastProvider
    @Injected
    private var forecastReposiotry: ForecastQueries & ForecastUpdates

    func getForecast(for city: String) -> AnyPublisher<Forecast, GetForecastError> {
//        forecastReposiotry.getAll(for: city) { cachedForecast in
//            if !cachedForecast.isEmpty {
//                callback(.success(Forecast(city: city, forecast: cachedForecast)))
//            }
//        }
        return forecastProvider.getForecast(for: city)
            .mapError { _ in GetForecastError.refreshFailed }
            .eraseToAnyPublisher()
            
    }
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, GetForecastError> {
        forecastProvider.getForecast(for: location)
            .mapError { _ in GetForecastError.refreshFailed }
            .eraseToAnyPublisher()
    }
    
//    private func onForecastLoaded(result: Result<Forecast, ForecastProviderError>, callback: @escaping (Result<Forecast, GetForecastError>) -> ()) {
//        switch result {
//        case .success(let data):
//            forecastReposiotry.deleteAll()
//            try? forecastReposiotry.save(forecast: data.forecast, for: data.city)
//            callback(.success(data))
//        case .failure(let error):
//            print(error)
//            callback(.failure(.refreshFailed))
//        }
//    }

}
