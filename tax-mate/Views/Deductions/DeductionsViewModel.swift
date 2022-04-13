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
    @Published var filterData: DateFilterData = DateFilterData.init(selectedOption: .all)
    private var deductions: [Deduction] = []
    
    private let pagingObserver: DeductionsPagingObserver
    private var cancellables: Set<AnyCancellable> = []
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    init(
        pagingObserver: DeductionsPagingObserver
    ) {
        self.pagingObserver = pagingObserver
        pagingObserver.entityChangedPublisher.sink { [weak self] in
            self?.deductionsGroup = DeductionsGroup.groups(from: $0)
            self?.deductions = $0
        }
        .store(in: &cancellables)
        
        $filterData
            .sink { _ in
                fatalError("Stream should never end")
            } receiveValue: { data in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    pagingObserver.reload(dateRange: (data.from, data.to))
                }
            }
            .store(in: &cancellables)
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
