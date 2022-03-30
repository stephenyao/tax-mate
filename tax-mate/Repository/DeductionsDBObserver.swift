//
//  DeductionsDBOvserver.swift
//  tax-mate
//
//  Created by Stephen Yao on 20/2/22.
//

import Foundation
import Combine
import CoreData

final class DeductionsPagingObserver: NSObject, NSFetchedResultsControllerDelegate {
    
    private let subject: CurrentValueSubject<[Deduction], Never>
    private let persistence: PersistenceController
    var entityChangedPublisher: AnyPublisher<[Deduction], Never> {
        subject.eraseToAnyPublisher()
    }
    private var controller: NSFetchedResultsController<ManagedDeduction>!
    private let pageSize: Int = 25
    private var currentPage: Int = 1

    init(persistence: PersistenceController = PersistenceController.shared) {
        self.subject = CurrentValueSubject([])
        self.persistence = persistence
        super.init()
        loadNext()
    }
    
    func loadNext() {
        let context = persistence.container.viewContext
        let fetchRequest = ManagedDeduction.fetchRequest()
        fetchRequest.fetchLimit = pageSize * currentPage
        
        // Configure the request's entity, and optionally its predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
            guard let results = controller.fetchedObjects else {
                fatalError("Fetched objects could not be cast to Deductions")
            }
            
            subject.send(results.map { $0.toPlainObject() })
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        controller.delegate = self
        self.controller = controller
        self.currentPage += 1
    }
    
    func hasNext() -> Bool {
        let context = persistence.container.viewContext
        let totalCount = (try? context.count(for: ManagedDeduction.fetchRequest())) ?? 0
        let fetchedCount = controller.fetchedObjects?.count ?? 0
        return totalCount != fetchedCount
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let results = controller.fetchedObjects as? [ManagedDeduction] else {
            fatalError("Fetched objects could not be cast to Deductions")
        }
        subject.send(results.map { $0.toPlainObject() })
    }
    
}
