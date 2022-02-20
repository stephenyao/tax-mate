//
//  DBObserverSpec.swift
//  tax-mateTests
//
//  Created by Stephen Yao on 20/2/22.
//

import Quick
import Nimble
import Combine
@testable import tax_mate

final class DBObserverSpec: QuickSpec {
    override func spec() {
        var observer: DeductionsDBObserver!
        var cancellabels: Set<AnyCancellable> = []
        var persistenceController: PersistenceController!
        
        describe("DBObserverSpec") {
            beforeEach {
                persistenceController =  PersistenceController(inMemory: true)
                observer = DeductionsDBObserver(persistence: persistenceController)
            }
            
            context("fetching the initial values") {
                it("should first send an empty array") {
                    observer.subject.sink { deductions in
                        expect(deductions.count).to(equal(0))
                    }.store(in: &cancellabels)
                }
                
                it("should subsequently send an array of deductions from the DB") {
                    var firstReceived = false
                    
                    observer.subject.sink { deductions in
                        if firstReceived {
                            expect(deductions.count).to(equal(10))
                        } else {
                            expect(deductions.count).to(equal(0))
                            firstReceived = true
                        }
                    }.store(in: &cancellabels)
                    
                    for i in 0..<10 {
                        let viewContext = persistenceController.container.viewContext
                        let managedDeduction = ManagedDeduction(context: viewContext)
                        managedDeduction.name = "\(i)"
                        try! viewContext.save()
                    }
                }
            }
        }
    }
}
