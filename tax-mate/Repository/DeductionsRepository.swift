//
//  DeductionsRepository.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import Foundation
import CoreData
import UIKit

final class DeductionsRepository {
    
    private let persistenceStore: PersistenceController
    
    private lazy var viewContext: NSManagedObjectContext = {
        persistenceStore.container.newBackgroundContext()        
    }()
    
    init(persistenceStore: PersistenceController = PersistenceController.shared) {
        self.persistenceStore = persistenceStore
    }

    func insert(deduction: Deduction) {
        let managedDeduction = ManagedDeduction(context: viewContext)
        managedDeduction.copyAttributes(from: deduction)
        do {
            try viewContext.save()
        } catch (let error) {
            print(error)
        }
    }
    
    func fetch() -> [Deduction] {
        let request = ManagedDeduction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let result = try viewContext.fetch(request)
            return result.map { $0.toPlainObject() }
        } catch (let error) {
            fatalError("Failed to retrieve deductions with error: \(error.localizedDescription)")
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

private extension ManagedDeduction {
    func toPlainObject() -> Deduction {
        guard let name = name,
              let date = date else {
                  fatalError("Data corrupted while converting core data object to plain object")
              }
        
        let image: UIImage? = self.image != nil ? UIImage(data: self.image!) : nil
                      
        return Deduction(
            name: name,
            date: date,
            image: image,
            cost: cost
        )
    }
}
