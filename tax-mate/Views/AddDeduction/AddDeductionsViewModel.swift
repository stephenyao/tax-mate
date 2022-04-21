//
//  AddDeductionsViewModel.swift
//  tax-mate
//
//  Created by Stephen Yao on 16/4/2022.
//

import UIKit
import Combine

final class AddDeductionsViewModel: ObservableObject {
    @Published var inputValid: Bool = false
    @Published var name: String = ""
    @Published var cost: Double?
    @Published var date: Date = .now.startOfDay()
    @Published var image: UIImage?
    private let repository = DeductionsRepository()
    private var cancellable: AnyCancellable?
    
    init() {
        bindInputValid()
    }
    
    private func bindInputValid() {
        cancellable = Publishers.CombineLatest($name, $cost)
            .map { (name, cost) -> Bool in
                guard let cost = cost, !name.isEmpty, !cost.isZero else {
                    return false
                }
                
                return true
            }
            .sink { [weak self] result in
                self?.inputValid = result
            }
    }
    
    func save() {
        let deduction = Deduction(name: name, date: date, image: image, cost: cost ?? 0)
        repository.insert(deduction: deduction)
    }
}

