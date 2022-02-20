//
//  AnyObserverSpec.swift
//  tax-mateTests
//
//  Created by Stephen Yao on 20/2/22.
//

import Quick
import Nimble
import CoreData
import Combine
@testable import tax_mate

final class AnyObserverSpec: QuickSpec {
    override func spec() {
        var cancellables = Set<AnyCancellable>()
        
        describe("AnyObserverSpec") {
            var closureCalled = false
            let observer = AnyDBObserver<ManagedDeduction>(wrapped: SomeDBObserver())
            
            it("will have a deduction") {
                observer.entityChangedPublisher.sink {
                    expect($0.name).toNot(beNil())
                    closureCalled = true
                }.store(in: &cancellables)
                expect(closureCalled).to(beTrue())
            }
        }
    }
}

private class SomeDBObserver<ManagedDeduction>: DBObserver {
    var entityChangedPublisher: AnyPublisher<ManagedDeduction, Never>
    
    init() {
        let persistence = PersistenceController(inMemory: true)
        let deduction = DeductionsTestHelper.insertFakeObject(to: persistence.container.viewContext)
        self.entityChangedPublisher = Just(deduction as! ManagedDeduction).eraseToAnyPublisher()
        try! persistence.container.viewContext.save()
    }
}
