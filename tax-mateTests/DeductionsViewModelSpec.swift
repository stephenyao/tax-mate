//
//  DeductionsViewModelSpec.swift
//  tax-mateTests
//
//  Created by Stephen Yao on 20/2/22.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import tax_mate

final class DeductionsViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("DeductionsViewModelSpec") {
            context("new deductions have been observed") {
                it("will change the deductions published attribute") {
                    let viewModel = DeductionsViewModel(observer: AnyDBObserver(wrapped: FakeObserver()))
                    expect(viewModel.deductions.count).to(equal(0))
                    expect(viewModel.deductions.count).toEventually(equal(0))
                }
            }
        }
    }
    
}

private class FakeObserver: DBObserver {
    
    var entityChangedPublisher: AnyPublisher<[Deduction], Never>
    
    init() {
        let d = Deduction(name: "Test", date: .now, image: nil, cost: 0)
        self.entityChangedPublisher = Just([d]).delay(for: .seconds(2), scheduler: RunLoop.main).eraseToAnyPublisher()
    }

}
