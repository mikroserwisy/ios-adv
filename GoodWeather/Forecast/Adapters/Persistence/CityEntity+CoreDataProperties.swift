//
//  CityEntity+CoreDataProperties.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/06/2021.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var forecast: NSSet?

}

// MARK: Generated accessors for forecast
extension CityEntity {

    @objc(addForecastObject:)
    @NSManaged public func addToForecast(_ value: DayForecastEntity)

    @objc(removeForecastObject:)
    @NSManaged public func removeFromForecast(_ value: DayForecastEntity)

    @objc(addForecast:)
    @NSManaged public func addToForecast(_ values: NSSet)

    @objc(removeForecast:)
    @NSManaged public func removeFromForecast(_ values: NSSet)

}

extension CityEntity : Identifiable {

}
