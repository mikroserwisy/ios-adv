import Foundation
import Combine

final class FakeForecastProvider: ForecastProvider {
    
//    private let forecast = Just(Forecast(city: "Warsaw", forecast: [
//        DayForecast(date: Date(), temperature: 15.0, pressure: 1011.0, icon: "03d", description: "Clear sky"),
//        DayForecast(date: Date(), temperature: 18.0, pressure: 999.0, icon: "04d", description: "Clear sky"),
//        DayForecast(date: Date(), temperature: 22.0, pressure: 1001.0, icon: "09d", description: "Clear sky"),
//        DayForecast(date: Date(), temperature: 14.0, pressure: 1004.0, icon: "10d", description: "Clear sky"),
//        DayForecast(date: Date(), temperature: 16.0, pressure: 1000.0, icon: "11d", description: "Clear sky"),
//        DayForecast(date: Date(), temperature: 21.0, pressure: 1015.0, icon: "13d", description: "Clear sky")
//    ]))
    

    
    func getForecast(for city: String) -> AnyPublisher<Forecast, ForecastProviderError> {
        Just(readData())
                .setFailureType(to: ForecastProviderError.self)
                .eraseToAnyPublisher()
    }
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, ForecastProviderError> {
        Just(readData())
                .setFailureType(to: ForecastProviderError.self)
                .eraseToAnyPublisher()
    }
    
    private func readData() -> Forecast {
        let data = readFile(withName: "data")!
        let response = try! JSONDecoder().decode(ForecastDto.self, from: data)
        return Forecast(city: response.city.name, forecast: response.forecast.map(self.toModel))
    }
    
    private func readFile(withName name: String, ofType type: String = "json") -> Data? {
        guard let bundlePath = Bundle.main.path(forResource: name, ofType: type),
              let data = try? String(contentsOfFile: bundlePath).data(using: .utf8)  else {
            return nil
        }
        return data
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
