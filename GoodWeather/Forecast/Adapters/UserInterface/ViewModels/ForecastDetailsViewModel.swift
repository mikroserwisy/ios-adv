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
    private var disposableBag = Set<AnyCancellable>()
    
    init() {
        if let cityName = UserDefaults.standard.string(forKey: "cityName") {
            getForecastUseCase.getForecast(for: cityName)
                .map { $0.forecast.map(self.mapper.toViewModel) }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in  print("Error fetching forecast") }) {
                    self.forecast = $0
                }
                .store(in: &disposableBag)
        }
    }
        
}
