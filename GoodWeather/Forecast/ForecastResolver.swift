import Resolver

extension Resolver.Name {
    static let fake = Self("Fake")
}

extension Resolver {

    public static func registerForecastComponents() {
        register { URLSessionForecastProvider() as ForecastProvider }
        register(name: .fake) { FakeForecastProvider() as ForecastProvider }
        register { ForecastViewModelMapper() }
        register { GetForecastService(forecastProvider: resolve()) }
            .implements(GetForecastUseCase.self)
    }
    
}
