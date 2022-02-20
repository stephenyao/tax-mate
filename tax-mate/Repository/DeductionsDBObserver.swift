//
//  DeductionsDBOvserver.swift
//  tax-mate
//
//  Created by Stephen Yao on 20/2/22.
//

import Foundation
import Combine
import CoreData

protocol DBObserver {
    associatedtype Entity
    var subject: CurrentValueSubject<Entity, Never> { get }
}

final class DeductionsDBObserver: NSObject, DBObserver, NSFetchedResultsControllerDelegate {
    let subject: CurrentValueSubject<[Deduction], Never>
    private let persistence: PersistenceController
    
    init(persistence: PersistenceController = PersistenceController.shared) {
        self.subject = CurrentValueSubject([])
        self.persistence = persistence
    }
    
    private func load() {
        let context = persistence.container.viewContext
        let fetchRequest = ManagedDeduction.fetchRequest()
        // Configure the request's entity, and optionally its predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        controller.delegate = self
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let results = controller.fetchedObjects as? [ManagedDeduction] else {
            fatalError("Fetched objects could not be cast to Deductions")
        }
        subject.send(results.map { $0.toPlainObject() })
    }
}
