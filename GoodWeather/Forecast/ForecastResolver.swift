import Resolver

extension Resolver.Name {
    static let fake = Self("Fake")
}

extension Resolver {

    public static func registerForecastComponents() {
        register { CoreDataStack(modelName: "ForecastModel") }
        register(name: .fake) { FakeForecastProvider() as ForecastProvider }
        register { URLSessionForecastProvider() as ForecastProvider }
        register { ForecastViewModelMapper() }
        register { CoreDataForecastRepository() as ForecastQueries & ForecastUpdates }
        // register { try? DatabaseForecastRepository() as ForecastQueries & ForecastUpdates }
        register { CoreLocationProvider() as LocationProvider }
        register { GetForecastService() }
            .implements(GetForecastUseCase.self)
    }
    
}
