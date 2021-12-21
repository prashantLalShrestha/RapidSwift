//
//  FakeHashable.swift
//

import Foundation

public struct FakeHashable<T>: Hashable {
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func hash(into hasher: inout Hasher) {
        
    }
    
    public static func == (lhs: FakeHashable<T>, rhs: FakeHashable<T>) -> Bool {
        return true
    }
}
