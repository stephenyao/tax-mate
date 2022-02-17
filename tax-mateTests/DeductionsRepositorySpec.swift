////
////  QuickTest.swift
////  tax-mateTests
////
////  Created by Stephen Yao on 16/2/22.
////

import Quick
import Nimble
import Foundation

@testable import tax_mate
import CoreData

final class DeductionsRepositorySepc: QuickSpec {
            
    override func spec() {
        let persistenceController = PersistenceController(inMemory: true)
        let repository = DeductionsRepository(persistenceStore: persistenceController)
        
        describe("DeductionsRepositorySpec") {
            context("Insert") {
                it("should store a deduction to persistent storage") {
                    let deduction = Deduction(name: "name", date: Date(), image: nil, cost: 100)
                    repository.insert(deduction: deduction)
                    
                    let request = ManagedDeduction.fetchRequest()
                    let result = try! persistenceController.container.viewContext.fetch(request)
                    expect(result.count).to(equal(1))
                    expect(result.first!.name).to(equal("name"))
                }
            }
        }
    }
    
}
