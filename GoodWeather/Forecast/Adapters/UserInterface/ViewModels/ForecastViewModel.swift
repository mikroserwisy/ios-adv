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
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        if let cityName = UserDefaults.standard.string(forKey: "cityName") {
            refreshForecast(for: cityName)
        }
        locationProvider.location.sink { location in
            self.getForecastUseCase.getForecast(for: location, callback: self.onForecastLoaded)
        }
        .store(in: &cancellable)
    }
    
    func refreshForecast(for city: String) {
        getForecastUseCase.getForecast(for: city, callback: onForecastLoaded)
    }
    
    func refreshForecastForCurrentLocation() {
        locationProvider.refreshLocation()
    }

    private func onForecastLoaded(_ result: Result<Forecast, GetForecastError>) {
        onMain { [self] in
            errors = false
            switch result {
            case .success(let data):
                let forecast = data.forecast.map(mapper.toViewModel)
                cityName = data.city
                currentForecast = forecast.first
                self.nextDaysForecast = Array(forecast.dropFirst())
            case .failure(_):
                errors = true
            }
        }
    }

}
