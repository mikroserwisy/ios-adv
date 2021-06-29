final class ApplicationFactory {
    
    static var shared = ApplicationFactory()
    
    private init() {
    }
    
    /*lazy var fakeForecastUseCase: GetForecastUseCase = { GetForecastService(forecastProvider: FakeForecastProvider()) }()
    
    private lazy var getForecastUseCase: GetForecastUseCase = { GetForecastService(forecastProvider: URLSessionForecastProvider()) }()
    
    lazy var forecastViewModel = { ForecastViewModel(getForecastUseCase: self.getForecastUseCase) }()*/
    
}
