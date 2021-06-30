import Foundation
import Combine
import Resolver

final class ForecastDetailsViewModel: ObservableObject {

    @Published
    var forecast: [DayForecastViewModel] = []
    @Injected
    private var getForecastUseCase: GetForecastUseCase
    @Injected
    private var mapper: ForecastViewModelMapper
    
    init() {
        if let cityName = UserDefaults.standard.string(forKey: "cityName") {
            getForecastUseCase.getForecast(for: cityName, callback: onForecastLoaded)
        }
    }
    
    private func onForecastLoaded(_ result: Result<Forecast, GetForecastError>) {
        onMain { [self] in
            switch result {
            case .success(let data):
                self.forecast = data.forecast.map(mapper.toViewModel)
            case .failure(_):
                print("Error fetching forecast")
            }
        }
    }
    
}
