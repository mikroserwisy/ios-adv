//
//  DayForecastEntity+CoreDataProperties.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/06/2021.
//
//

import Foundation
import CoreData


extension DayForecastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayForecastEntity> {
        return NSFetchRequest<DayForecastEntity>(entityName: "DayForecastEntity")
    }

    @NSManaged public var conditions: String
    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var imageName: String
    @NSManaged public var pressure: Double
    @NSManaged public var temperature: Double

}

extension DayForecastEntity : Identifiable {

}
