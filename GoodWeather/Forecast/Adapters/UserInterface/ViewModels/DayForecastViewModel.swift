import Foundation

struct DayForecastViewModel: Identifiable {
    
    let id = UUID()
    let date: String
    let temperature: String
    let pressure: String
    let icon: String
    let description: String
    
}
