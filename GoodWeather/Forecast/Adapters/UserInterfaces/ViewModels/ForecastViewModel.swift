import Foundation
import Combine
import Resolver

final class ForecastViewModel: ObservableObject {

    @Published
    var currentForecast: DayForecastViewModel?
    @Published
    var nextDaysForecast: [DayForecastViewModel] = []
    @Injected
    private var getForecastUseCase: GetForecastUseCase
    @Injected
    private var mapper: ForecastViewModelMapper

    init(getForecastUseCase: GetForecastUseCase) {
        refreshForecast(for: "warsaw")
    }
    
    func refreshForecast(for city: String) {
        getForecastUseCase.getForecast(for: city, callback: onForecastLoaded)
    }

    private func onForecastLoaded(_ result: Result<Forecast, GetForecastError>) {
        DispatchQueue.main.async { [self] in
            switch result {
            case .success(let data):
                let forecast = data.forecast.map(mapper.toViewModel)
                currentForecast = forecast.first
                self.nextDaysForecast = Array(forecast.dropFirst())
            case .failure(_):
                print("Refresh failed")
            }
        }
    }

}
