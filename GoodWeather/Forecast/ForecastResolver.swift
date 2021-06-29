import Resolver

extension Resolver.Name {
    static let fake = Self("Fake")
}

extension Resolver {

    public static func registerForecastComponents() {
        register(name: .fake) { FakeForecastProvider() as ForecastProvider }
        register { URLSessionForecastProvider() as ForecastProvider }
        register { ForecastViewModelMapper() }
        register { try? DatabaseForecastRepository() as ForecastQueries & ForecastUpdates }
        register { CoreLocationProvider() as LocationProvider }
        register { GetForecastService() }
            .implements(GetForecastUseCase.self)
    }
    
}
