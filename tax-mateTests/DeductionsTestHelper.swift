//
//  DeductionsHelper.swift
//  tax-mateTests
//
//  Created by Stephen Yao on 20/2/22.
//

import Foundation
import CoreData
import Fakery
@testable import tax_mate

final class DeductionsTestHelper {
    static func insertFakeObject(to context: NSManagedObjectContext) -> ManagedDeduction {
        let faker = Faker.init()
        return insertFakeObject(withName: faker.company.name(), to: context)
    }
    
    static func insertFakeObject(withName name: String, to context: NSManagedObjectContext) -> ManagedDeduction {
        let faker = Faker.init()
        let d = ManagedDeduction(context: context)
        d.name = name
        d.cost = faker.number.randomDouble(min: 50, max: 1000)
        d.date = faker.date.between(Date.init(timeIntervalSince1970: 0), .now)
        d.identifier = UUID().uuidString
        return d
    }
}
