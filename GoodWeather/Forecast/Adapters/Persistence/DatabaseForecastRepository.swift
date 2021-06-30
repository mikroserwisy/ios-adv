import SQLite
import Foundation
import Resolver

final class DatabaseForecastRepository: ForecastQueries, ForecastUpdates {
    
    private let db: Connection
    private let forecastTable = Table("forecast")
    private let id = Expression<String>("id")
    private let date = Expression<Date>("date")
    private let temperature = Expression<Double>("temperature")
    private let pressure = Expression<Double>("pressure")
    private let icon = Expression<String>("icon")
    private let description = Expression<String>("description")
    private let city = Expression<String>("city")

    init() throws {
        let dbPath = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("forecast.db")
            .path
        db = try Connection(dbPath)
        try db.run(forecastTable.create(ifNotExists: true) { table in
            table.column(id, primaryKey: true)
            table.column(date)
            table.column(temperature)
            table.column(pressure)
            table.column(icon)
            table.column(description)
            table.column(city)
        })
    }
    
    func save(dayForecast: DayForecast, for city: String) throws {
        let insert = forecastTable.insert(id <- UUID().uuidString, date <- dayForecast.date, temperature <- dayForecast.temperature, pressure <- dayForecast.pressure, icon <- dayForecast.icon, description <- dayForecast.description, self.city <- city)
        try db.run(insert)
    }
    
    func getById(id: UUID, callback: @escaping (DayForecast) -> Void) {
        guard let row = try? db.pluck(forecastTable.filter(id.uuidString == self.id)) else {
            return
        }
        callback(toModel(row: row))
    }
    
    func getAll(for city: String, callback: @escaping ([DayForecast]) -> Void) {
        guard let rows = try? db.prepare(forecastTable.filter(city == self.city)) else {
            return
        }
        callback(Array(rows).map(toModel(row:)))
    }
    
    func deleteAll() {
        _ = try? db.run(forecastTable.delete())
    }
    
    private func toModel(row: Row) -> DayForecast {
        DayForecast(date: row[date], temperature: row[temperature], pressure: row[pressure], icon: row[icon], description: row[description])
    }
    
}
