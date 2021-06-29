import SwiftUI
import Resolver

@main
struct GoodWeatherApp: App {
    
    var body: some Scene {
        WindowGroup {
            ForecastView(viewModel: ForecastViewModel(getForecastUseCase: Resolver.resolve()))
        }
    }
    
}
