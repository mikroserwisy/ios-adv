import Foundation
import CoreData
import Resolver

final class CoreDataForecastRepository: ForecastQueries, ForecastUpdates {
 
    @Injected
    private var stack: CoreDataStack
    private var cityAsyncFetchRequest: NSAsynchronousFetchRequest<CityEntity>?
    private var forecastAsyncFetchRequest: NSAsynchronousFetchRequest<DayForecastEntity>?
    
    func getById(id: UUID, callback: @escaping (DayForecast) -> Void) {
        let request: NSFetchRequest<DayForecastEntity> = DayForecastEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(DayForecastEntity.internalId), id])
        forecastAsyncFetchRequest = NSAsynchronousFetchRequest<DayForecastEntity>(fetchRequest: request) { result in
            guard let forecastEntity = result.finalResult?.first else {
                return
            }
            callback(self.toModel(dayForecastEntity: forecastEntity))
        }
        do {
            try stack.managedContext.execute(forecastAsyncFetchRequest!)
        } catch let error as NSError {
            print("Error loading team \(error)")
        }
    }
    
    func getAll(for city: String, callback: @escaping ([DayForecast]) -> Void) {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(CityEntity.name), city])
        cityAsyncFetchRequest = NSAsynchronousFetchRequest<CityEntity>(fetchRequest: request) { result in
            guard let city = result.finalResult?.first, let dayForecastSet = city.forecast as? Set<DayForecastEntity> else {
                return
            }
            callback(dayForecastSet.map(self.toModel(dayForecastEntity:)).sorted { $0.date < $1.date })
        }
        do {
            try stack.managedContext.execute(cityAsyncFetchRequest!)
        } catch let error as NSError {
            print("Error loading team \(error)")
        }
    }
    
    func save(forecast: [DayForecast], for city: String) throws {
        let cityEntity = NSEntityDescription.insertNewObject(forEntityName: "CityEntity", into: stack.managedContext) as! CityEntity
        cityEntity.id = UUID()
        cityEntity.name = city
        for dayForecast in forecast {
            let dayForecastEntity = NSEntityDescription.insertNewObject(forEntityName: "DayForecastEntity", into: stack.managedContext) as! DayForecastEntity
            dayForecastEntity.internalId = UUID()
            dayForecastEntity.conditions = dayForecast.description
            dayForecastEntity.date = dayForecast.date
            dayForecastEntity.imageName = dayForecast.icon
            dayForecastEntity.pressure = dayForecast.pressure
            dayForecastEntity.temperature = dayForecast.temperature
            cityEntity.addToForecast(dayForecastEntity)
        }
    }
    
    func deleteAll() {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        cityAsyncFetchRequest = NSAsynchronousFetchRequest<CityEntity>(fetchRequest: request) { result in
            result.finalResult?.forEach {
                self.stack.managedContext.delete($0)
            }           
        }
        do {
            try stack.managedContext.execute(cityAsyncFetchRequest!)
        } catch let error as NSError {
            print("Error loading team \(error)")
        }
    }
    
    private func toModel(dayForecastEntity: DayForecastEntity) -> DayForecast {
        return DayForecast(date: dayForecastEntity.date!, temperature: dayForecastEntity.temperature, pressure: dayForecastEntity.pressure, icon: dayForecastEntity.imageName!, description: dayForecastEntity.conditions!)
    }
    
}
