//
//  Assign.swift
//  tax-mate
//
//  Created by Stephen Yao on 20/2/22.
//

import Combine

extension Publisher where Self.Failure == Never {
    public func assignNoRetain<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] (value) in
        object?[keyPath: keyPath] = value
    }
  }
}
