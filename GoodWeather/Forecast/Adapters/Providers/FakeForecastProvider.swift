import Foundation

final class FakeForecastProvider: ForecastProvider {
    
    private let forecast = [
        DayForecast(date: Date(), temperature: 130, pressure: 1000.0, icon: "02d", description: "Clear sky")
    ]

    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        callback(.success(Forecast(city: "Warsaw", forecast: forecast)))
    }
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        callback(.success(Forecast(city: "Warsaw", forecast: forecast)))
    }
    
}
