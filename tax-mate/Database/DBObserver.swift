//
//  DBObserver.swift
//  tax-mate
//
//  Created by Stephen Yao on 20/2/22.
//

import Foundation
import Combine

protocol DBObserver {
    associatedtype Entity
    var entityChangedPublisher: AnyPublisher<Entity, Never> { get }
}

final class AnyDBObserver<Entity>: DBObserver {
    let entityChangedPublisher: AnyPublisher<Entity, Never>
    private let observer: Any
    
    init<Observer: DBObserver>(wrapped: Observer) where Observer.Entity == Entity {
        self.observer = wrapped
        self.entityChangedPublisher = wrapped.entityChangedPublisher
    }
}
