import Foundation

final class FakeForecastProvider: ForecastProvider {
    
    private let forecast = [
        DayForecast(date: Date(), temperature: 15.0, pressure: 1011.0, icon: "03d", description: "Clear sky"),
        DayForecast(date: Date(), temperature: 18.0, pressure: 999.0, icon: "04d", description: "Clear sky"),
        DayForecast(date: Date(), temperature: 22.0, pressure: 1001.0, icon: "09d", description: "Clear sky"),
        DayForecast(date: Date(), temperature: 14.0, pressure: 1004.0, icon: "10d", description: "Clear sky"),
        DayForecast(date: Date(), temperature: 16.0, pressure: 1000.0, icon: "11d", description: "Clear sky"),
        DayForecast(date: Date(), temperature: 21.0, pressure: 1015.0, icon: "13d", description: "Clear sky")
    ]
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        callback(.success(Forecast(city: "Warsaw", forecast: forecast)))
    }
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        callback(.success(Forecast(city: "Warsaw", forecast: forecast)))
    }
    
}
