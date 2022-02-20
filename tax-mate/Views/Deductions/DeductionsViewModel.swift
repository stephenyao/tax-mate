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
    private var c: AnyCancellable!
    
    init(observer: AnyDBObserver<[Deduction]> = AnyDBObserver<[Deduction]>(wrapped: DeductionsDBObserver(persistence: PersistenceController.shared))) {
        self.observer = observer
        self.cancellable = observer.entityChangedPublisher.assignNoRetain(to: \.deductions, on: self)
    }
    
}
