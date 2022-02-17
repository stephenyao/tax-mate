//
//  DeductionsRepository.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import Foundation
import CoreData

final class DeductionsRepository {
    
    private let persistenceStore: PersistenceController
    
    private var viewContext: NSManagedObjectContext {
        persistenceStore.container.viewContext
    }
    
    init(persistenceStore: PersistenceController = PersistenceController.shared) {
        self.persistenceStore = persistenceStore
    }

    func insert(deduction: Deduction) {
        let managedDeduction = ManagedDeduction(context: viewContext)
        managedDeduction.copyAttributes(from: deduction)
        do {
            try persistenceStore.container.viewContext.save()
        } catch (let error) {
            print(error)
        }
    }

}

private extension ManagedDeduction {
    func copyAttributes(from deduction: Deduction) {
        self.name = deduction.name
        self.cost = deduction.cost
        self.identifier = deduction.identifier
        self.date = deduction.date
        self.image = deduction.image?.pngData()
    }
}
