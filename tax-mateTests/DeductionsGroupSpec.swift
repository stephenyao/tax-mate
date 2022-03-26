//
//  DeductionsGroupSpec.swift
//  tax-mateTests
//
//  Created by Stephen Yao on 26/3/22.
//

import Quick
import Nimble
import Foundation
@testable import tax_mate

private final class DeductionsGroupSpec: QuickSpec {
    override func spec() {
        describe("DeductionsGroupSpec") {
            context("Given an array of deductions all with different dates") {
                it("Will group them based on date") {
                    let group = DeductionsGroup.groups(from: differentDateDeductions())
                    expect(group.count).to(equal(10))
                }
            }
            
            context("Given an array of deductions with some in the same dates") {
                it("Will group them based on date") {
                    let group = DeductionsGroup.groups(from: sameDateDeductions())
                    expect(group.count).to(equal(2))
                }
            }
            
            context("Given an array of deductions on the same day but with different time") {
                it("Will return just 1 deduction group") {
                    let group = DeductionsGroup.groups(from: sameDateWithDifferentTime())
                    expect(group.count).to(equal(1))
                }
            }
        }
    }
}

private func differentDateDeductions() -> [Deduction] {
    var array = [Deduction]()
    for i in 0..<10 {
        let d = Deduction(name: "", date: Date.init(timeIntervalSince1970: TimeInterval(i * 24 * 3600)), image: nil, cost: 0)
        array.append(d)
    }
    return array
}

private func sameDateDeductions() -> [Deduction] {
    let groupOne = Array(repeating: Deduction(name: "", date: .init(timeIntervalSinceReferenceDate: 0), image: nil, cost: 0), count: 10)
    let groupTwo = Array(repeating: Deduction(name: "", date: .init(timeIntervalSince1970: 86400), image: nil, cost: 0), count: 10)
    return groupOne + groupTwo
}

private func sameDateWithDifferentTime() -> [Deduction] {
    var array: [Deduction] = []
    for i in 0..<10 {
        let d = Deduction(name: "", date: .init(timeIntervalSince1970: TimeInterval(i)), image: nil, cost: 0)
        array.append(d)
    }
    return array
}
