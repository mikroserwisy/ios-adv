import Resolver
import Combine

final class GetForecastService: GetForecastUseCase {
    
    @Injected
    private var forecastProvider: ForecastProvider
    @Injected
    private var forecastReposiotry: ForecastQueries & ForecastUpdates
    private var disposableBag = Set<AnyCancellable>()
    
    func getForecast(for city: String) -> AnyPublisher<Forecast, GetForecastError> {
        let result = PassthroughSubject<Forecast, GetForecastError>()
        
        forecastProvider.getForecast(for: city)
            .mapError { _ in GetForecastError.refreshFailed }
            .sink(receiveCompletion: { _ in }) {
                self.forecastReposiotry.deleteAll()
                try? self.forecastReposiotry.save(forecast: $0.forecast, for: $0.city)
                result.send($0)
            }
            .store(in: &disposableBag)

        forecastReposiotry.getAll(for: city) { cachedForecast in
            result.send(Forecast(city: city, forecast: cachedForecast))
        }
        return result.eraseToAnyPublisher()
    }
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, GetForecastError> {
        forecastProvider.getForecast(for: location)
            .mapError { _ in GetForecastError.refreshFailed }
            .eraseToAnyPublisher()
    }

}
