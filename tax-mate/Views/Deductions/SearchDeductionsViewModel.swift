//
//  SearchDeductionsViewModel.swift
//  tax-mate
//
//  Created by Stephen Yao on 31/3/22.
//

import Foundation
import Combine

final class SearchDeductionsViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var searchResults: [Deduction] = []
    private let repository: DeductionsRepository
    private var cancellable: AnyCancellable!
    
    init(repository: DeductionsRepository = DeductionsRepository(persistenceStore: PersistenceController.shared)) {
        self.repository = repository
        self.cancellable = $searchQuery.debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] in
            self?.searchResults = repository.fetch(searchQuery: $0)
        }
    }
}
