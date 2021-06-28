import SwiftUI

@main
struct GoodWeatherApp: App {
    
    private var container = Container {
        Dependency { URLSessionForecastProvider() }
        //Dependency { FakeForecastProvider() }
        Dependency { GetForecastService()}
    }
    
    init() {
        container.build()
    }
    
    var body: some Scene {
        WindowGroup {
            ForecastView(viewModel: ForecastViewModel())
        }
    }
    
}
