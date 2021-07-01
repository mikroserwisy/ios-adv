import Foundation
import Combine
import Resolver

final class ForecastViewModel: ObservableObject {
    
    @Published
    var currentForecast: DayForecastViewModel?
    @Published
    var nextDaysForecast: [DayForecastViewModel] = []
    @Published
    var cityName: String = ""
    @Published
    var errors = false
    @Injected
    private var getForecastUseCase: GetForecastUseCase
    @Injected
    private var mapper: ForecastViewModelMapper
    @Injected
    private var locationProvider: LocationProvider
    private var disposableBag = Set<AnyCancellable>()
    
    init() {
        if let cityName = UserDefaults.standard.string(forKey: "cityName") {
            refreshForecast(for: cityName)
        }
        locationProvider.location.sink { location in
            self.onForecastLoaded(publisher: self.getForecastUseCase.getForecast(for: location))
        }
        .store(in: &disposableBag)
    }
    
    func refreshForecast(for city: String) {
        onForecastLoaded(publisher: getForecastUseCase.getForecast(for: city))
    }
    
    func refreshForecastForCurrentLocation() {
        locationProvider.refreshLocation()
    }
    
    private func onForecastLoaded(publisher: AnyPublisher<Forecast, GetForecastError> ) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: onComplete, receiveValue: onForecastLoaded)
            .store(in: &disposableBag)
    }
    
    private func onForecastLoaded(model: Forecast) {
        cityName = model.city
        let forecast = model.forecast.map(mapper.toViewModel)
        currentForecast = forecast.first
        nextDaysForecast = Array(forecast.dropFirst())
    }
    
    private func onComplete(completion: Subscribers.Completion<GetForecastError>)  {
        switch completion {
        case .failure(_):
            errors = true
        default:
            errors = false
        }
    }
    
}
