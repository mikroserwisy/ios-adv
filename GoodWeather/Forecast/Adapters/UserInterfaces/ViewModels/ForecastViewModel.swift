import Foundation
import Combine

final class ForecastViewModel: ObservableObject {

    @Published
    var currentForecast: DayForecastViewModel?
    @Published
    var forecast: [DayForecastViewModel] = []
    @Inject
    private var getForecastUseCase: GetForecastUseCase
    @Inject
    private var mapper: ForecastViewModelMapper

    init() {
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
                self.forecast = Array(forecast.dropFirst())
            case .failure(_):
                print("Refresh failed")
            }
        }
    }

}
