import Foundation

final class URLSessionForecastProvider: ForecastProvider {
    
    private let url = "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8"
 
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        guard let requestURL = URL(string: "\(url)&q=\(city)") else {
            callback(.failure(.invalidRequestUrl))
            return
        }
        getForecast(requestURL: requestURL, callback: callback)
    }
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        guard let requestURL = URL(string: "\(url)&lon=\(location.0)&lat=\(location.1)") else {
            callback(.failure(.invalidRequestUrl))
            return
        }
        getForecast(requestURL: requestURL, callback: callback)
    }
    
    private func getForecast(requestURL: URL, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        let request = URLRequest(url: requestURL)
        URLSession.shared.dataTask(with: request) { text, response, error in
            if let error = error {
                callback(.failure(.error(error.localizedDescription)))
                return
            }
            let responseStatusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            guard (200...299).contains(responseStatusCode) else {
                callback(.failure(.requestFailed(responseStatusCode)))
                return
            }
            guard let json = text else {
                callback(.failure(.invalidResponseData))
                return
            }
            do {
                let response = try JSONDecoder().decode(ForecastDto.self, from: json)
                let forecast = Forecast(city: response.city.name, forecast: response.forecast.map(self.toModel))
                callback(.success(forecast))
            } catch {
                callback(.failure(.parsingFailed(error.localizedDescription)))
            }
        }.resume()
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
