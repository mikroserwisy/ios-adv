import Foundation
import Combine

final class URLSessionForecastProvider: ForecastProvider {
    
    private let url = "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8"
 
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func getForecast(for city: String) -> AnyPublisher<Forecast, ForecastProviderError>   {
        return getForecast(requestURL: "\(url)&q=\(city)")
    }
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, ForecastProviderError> {
        return getForecast(requestURL: "\(url)&lon=\(location.0)&lat=\(location.1)")
    }
    
    private func getForecast(requestURL: String) -> AnyPublisher<Forecast, ForecastProviderError>  {
        guard let requestURL = URL(string: requestURL) else {
            return Fail(error: ForecastProviderError.invalidRequestUrl).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .mapError { ForecastProviderError.requestFailed($0.errorCode) }
            .map { $0.data }
            .decode(type: ForecastDto.self, decoder: decoder)
            .mapError { ForecastProviderError.parsingFailed($0.localizedDescription) }
            .map { Forecast(city: $0.city.name, forecast: $0.forecast.map(self.toModel)) }
            .eraseToAnyPublisher()
    }
    
    private func toModel(dayForecastDto: DayForecastDto) -> DayForecast {
        let date = Date(timeIntervalSince1970: dayForecastDto.date)
        let temperature = dayForecastDto.temperature.day
        let pressure = dayForecastDto.pressure
        let icon = dayForecastDto.conditions.first?.icon ?? ""
        let description = dayForecastDto.conditions.first?.description ?? ""
        return DayForecast(date: date, temperature: temperature, pressure: pressure, icon: icon, description: description)
    }
    
}
