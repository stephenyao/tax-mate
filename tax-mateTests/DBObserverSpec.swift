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

final class DeductionsPagingObserverSpec: QuickSpec {
    override func spec() {
        var observer: DeductionsPagingObserver!
        var cancellabels: Set<AnyCancellable> = []
        var persistenceController: PersistenceController!
        
        describe("DBObserverSpec") {
            beforeEach {
                persistenceController =  PersistenceController(inMemory: true)
                observer = DeductionsPagingObserver(persistence: persistenceController)
            }
            
            context("fetching the initial values") {
                it("should first send an empty array") {
                    observer.entityChangedPublisher.sink { deductions in
                        expect(deductions.count).to(equal(0))
                    }.store(in: &cancellabels)
                }
                
                it("should subsequently send an array of deductions from the DB") {
                    var firstReceived = false
                    var secondReceived = false
                    
                    observer.entityChangedPublisher.sink { deductions in
                        if !firstReceived {
                            expect(deductions.count).to(equal(0))
                            firstReceived = true
                        } else {
                            expect(deductions.count).to(equal(10))
                            secondReceived = true
                        }
                    }.store(in: &cancellabels)
                                     
                    let viewContext = persistenceController.container.viewContext
                    for _ in 0..<10 {
                        let _ = DeductionsTestHelper.insertFakeObject(to: viewContext)
                    }
                    try! viewContext.save()

                    expect(firstReceived).toEventually(beTrue())
                    expect(secondReceived).toEventually(beTrue())
                }
            }
        }
    }
}
