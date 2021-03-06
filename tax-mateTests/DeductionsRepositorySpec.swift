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
        var persistenceController: PersistenceController!
        var repository: DeductionsRepository!
        var viewContext: NSManagedObjectContext!
        
        describe("DeductionsRepositorySpec") {
            beforeEach {
                persistenceController = PersistenceController(inMemory: true)
                repository = DeductionsRepository(persistenceStore: persistenceController)
                viewContext = persistenceController.container.viewContext
            }
            
            context("Insert") {
                beforeEach {
                    let deduction =
                    Deduction(
                        name: "name",
                        date: Date.init(timeIntervalSinceReferenceDate: 100),
                        image: nil,
                        cost: 100
                    )
                    repository.insert(deduction: deduction)
                }
                
                it("should store a deduction to persistent storage") {
                    let request = ManagedDeduction.fetchRequest()
                    let result = try! persistenceController.container.viewContext.fetch(request)
                    expect(result.count).to(equal(1))
                    expect(result.first?.name).to(equal("name"))
                    expect(result.first?.date).to(equal(Date.init(timeIntervalSinceReferenceDate: 100)))
                    expect(result.first?.image).to(beNil())
                    expect(result.first?.cost).to(equal(100))
                }
            }
            
            context("Fetch") {
                beforeEach {
                    for _ in 0..<10 {
                        let viewContext = persistenceController.container.viewContext
                        let _ = DeductionsTestHelper.insertFakeObject(to: viewContext)
                        try! viewContext.save()
                    }
                }
                
                it("should fetch deductions from persistent storage") {
                    let result = repository.fetch()
                    expect(result.count).to(equal(10))
                }
            }
            
            context("Fetch with search query") {
                beforeEach {
                    for i in 0..<10 {
                        let viewContext = persistenceController.container.viewContext
                        let _ = DeductionsTestHelper.insertFakeObject(withName: "\(i)", to: viewContext)
                    }
                    let _ = DeductionsTestHelper.insertFakeObject(withName: "FFFFakeDeduction", to: viewContext)
                }
                
                it("should fetch the deductions based on the search query") {
                    let result = repository.fetch(searchQuery: "1")
                    expect(result.count).to(equal(1))
                }
                
                it("should fetch the deductions and ignore the uppercase characters") {
                    let result = repository.fetch(searchQuery: "ffffakededuction")
                    expect(result.count).to(equal(1))                    
                }
            }
            
            context("Delete") {
                var testObject: Deduction!
                
                beforeEach {
                    let deduction =
                    Deduction(
                        name: "name",
                        date: Date.init(timeIntervalSinceReferenceDate: 100),
                        image: nil,
                        cost: 100
                    )
                    repository.insert(deduction: deduction)
                    testObject = deduction
                }
                
                it("will delete the deduction") {
                    var result = repository.fetch()
                    expect(result.count).to(equal(1))
                    repository.delete(deduction: testObject)
                    result = repository.fetch()
                    expect(result.count).to(equal(0))
                    
                }
            }
        }
    }
    
}
