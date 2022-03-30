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
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    init(
        pagingObserver: DeductionsPagingObserver        
    ) {
        self.pagingObserver = pagingObserver
        self.cancellable = pagingObserver.entityChangedPublisher.sink { [weak self] in
            self?.deductionsGroup = DeductionsGroup.groups(from: $0)
        }
    }
    
    func displayString(for date: Date) -> String {
        formatter.string(from: date)
    }
    
    func loadNext() {
        pagingObserver.loadNext()
    }
    
    func hasNext() -> Bool {
        pagingObserver.hasNext()
    }
}
