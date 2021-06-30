import SwiftUI
import Resolver

@main
struct GoodWeatherApp: App {
    
    init() {
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().isTranslucent = true
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ForecastView(viewModel: ForecastViewModel())
                    .tabItem {
                        Image(systemName: "sun.max.fill")
                        Text("Forecast")
                    }
                ForecastDetailsView(viewModel: ForecastDetailsViewModel())
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Details")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }.accentColor(.primary)
        }
    }
    
}
