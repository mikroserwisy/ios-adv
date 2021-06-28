import Foundation

final class ForecastViewModelMapper {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    private let icons = ["01d": "sun.max.fill", "02d": "cloud.sun.fill", "03d": "cloud.fill", "04d": "smoke.fill",
                        "09d": "cloud.rain.fill", "10d": "cloud.sun.rain.fill", "11d": "cloud.sun.bolt.fill",
                        "13d": "snow", "50d": "cloud.fog.fill"]
    
    func toViewModel(dayForecast: DayForecast) -> DayForecastViewModel {
        let date = dateFormatter.string(from: dayForecast.date)
        let temperature = "\(Int(dayForecast.temperature))°"
        let pressure = "\(Int(dayForecast.pressure))hPa"
        let icon = icons[dayForecast.icon] ?? "xmark.circle"
        let description = dayForecast.description
        return DayForecastViewModel(date: date, temperature: temperature, pressure: pressure, icon: icon, description: description)
    }
    
}
