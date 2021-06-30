import Foundation
import CoreData
import Resolver

final class CoreDataForecastRepository: ForecastQueries, ForecastUpdates {
 
    @Injected
    private var stack: CoreDataStack
    private var asyncFetchRequest: NSAsynchronousFetchRequest<CityEntity>?
    
    func getById(id: UUID, callback: @escaping (DayForecast) -> Void) {
        
    }
    
    func getAll(for city: String, callback: @escaping ([DayForecast]) -> Void) {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(CityEntity.name), city])
        asyncFetchRequest = NSAsynchronousFetchRequest<CityEntity>(fetchRequest: request) { result in
            guard let city = result.finalResult?.first, let forecast = city.forecat, let dayForecastSet = forecast as? Set<DayForecastEntity> else {
                return
            }
            callback(dayForecastSet.map(self.toModel(dayForecastEntity:)))
        }
        do {
            try stack.managedContext.execute(asyncFetchRequest!)
        } catch let error as NSError {
            print("Error loading team \(error)")
        }
    }
    
    func save(dayForecast: DayForecast, for city: String) throws {
        
    }
    
    func deleteAll() {
        
    }
    
    private func toModel(dayForecastEntity: DayForecastEntity) -> DayForecast {
        return DayForecast(date: dayForecastEntity.date, temperature: dayForecastEntity.temperature, pressure: dayForecastEntity.pressure, icon: dayForecastEntity.imageName, description: dayForecastEntity.conditions)
    }
    
}
