import SwiftUI

@main
struct GoodWeatherApp: App {
    
    private var container = Container {
        Dependency { URLSessionForecastProvider() }
        Dependency { ForecastViewModelMapper() }
        Dependency { GetForecastService()}
    }
    
    init() {
        container.build()
    }
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(Router())
        }
    }
    
}
