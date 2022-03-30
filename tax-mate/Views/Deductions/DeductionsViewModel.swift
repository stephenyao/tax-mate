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
    
    private let pagingObserver: DeductionsPagingObserver
    private var cancellable: AnyCancellable!
    
    init(
        pagingObserver: DeductionsPagingObserver        
    ) {
        self.pagingObserver = pagingObserver
        self.cancellable = pagingObserver.entityChangedPublisher.sink { [weak self] in
            self?.deductionsGroup =  DeductionsGroup.groups(from: $0)
        }
    }
    
    func loadNext() {
        pagingObserver.loadNext()
    }
}
