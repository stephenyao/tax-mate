//
//  DeductionsViewModel.swift
//  tax-mate
//
//  Created by Stephen Yao on 20/2/22.
//

import Foundation
import Combine

final class DeductionsViewModel: ObservableObject {
    
    @Published var deductionsGroup: [DeductionsGroup] = []
    
    private let observer: AnyDBObserver<[Deduction]>
    private var cancellable: AnyCancellable!
    
    init(observer: AnyDBObserver<[Deduction]> = AnyDBObserver<[Deduction]>(wrapped: DeductionsDBObserver(persistence: PersistenceController.shared))) {
        self.observer = observer
        self.cancellable = observer.entityChangedPublisher.sink { [weak self] in
            self?.deductionsGroup =  DeductionsGroup.groups(from: $0)
        }
    }
        
}
