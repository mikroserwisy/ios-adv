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
    @Published
    var userName = ""
    @Injected
    private var getForecastUseCase: GetForecastUseCase
    @Injected
    private var mapper: ForecastViewModelMapper
    @Injected
    private var locationProvider: LocationProvider
    @Injected
    var profileStore: ProfileStore
    private var disposableBag = Set<AnyCancellable>()
    @UserProperty(key: "cityName", defaultValue: "Warsaw")
    var cachedCityName: String
    
    init() {
        refreshForecast(for: cachedCityName)
        locationProvider.location.sink { location in
            self.onForecastLoaded(publisher: self.getForecastUseCase.getForecast(for: location))
        }
        .store(in: &disposableBag)
        profileStore.user
            .map { $0.firstName }
            .assign(to: &$userName)
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
