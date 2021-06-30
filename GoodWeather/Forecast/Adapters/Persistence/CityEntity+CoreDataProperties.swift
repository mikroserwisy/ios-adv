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
    @NSManaged public var forecat: NSSet?

}

// MARK: Generated accessors for forecat
extension CityEntity {

    @objc(addForecatObject:)
    @NSManaged public func addToForecat(_ value: DayForecastEntity)

    @objc(removeForecatObject:)
    @NSManaged public func removeFromForecat(_ value: DayForecastEntity)

    @objc(addForecat:)
    @NSManaged public func addToForecat(_ values: NSSet)

    @objc(removeForecat:)
    @NSManaged public func removeFromForecat(_ values: NSSet)

}

extension CityEntity : Identifiable {

}
