//
//  SeedDb.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import Foundation
import Fakery

final class SeedDb {
    static func populate() {
        let repository = DeductionsRepository()
        
        for _ in 0..<100 {
            let faker = Faker()
            let deduction = Deduction(
                name: faker.company.name(),
                date: faker.date.between(Date.init(timeIntervalSinceNow: -60*60*24*365), Date.now),
                image: nil,
                cost: faker.number.randomDouble(min: 10, max: 10000)
            )
            
            repository.insert(deduction: deduction)
        }
    }
}
