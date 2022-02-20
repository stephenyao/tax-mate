//
//  DeductionsViewModel.swift
//  tax-mate
//
//  Created by Stephen Yao on 20/2/22.
//

import Foundation
import Combine

final class DeductionsViewModel: ObservableObject {
    
    @Published var deductions: [Deduction] = []
    
    private let observer: AnyDBObserver<[Deduction]>
    private var cancellable: AnyCancellable!
    
    init(observer: AnyDBObserver<[Deduction]>) {
        self.observer = observer
        self.cancellable = observer.entityChangedPublisher.assign(to: \.deductions, on: self)
    }
    
    
}
