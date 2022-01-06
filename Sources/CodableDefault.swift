//
//  CodableDefault.swift
//

import Foundation


public protocol CodableDefaultSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

public enum CodableDefault {}

extension CodableDefault {
    @propertyWrapper
    public struct Wrapper<Source: CodableDefaultSource> {
        public typealias Value = Source.Value
        public var wrappedValue = Source.defaultValue
        
        public init(wrappedValue: Source.Value = Source.defaultValue) {
            self.wrappedValue = wrappedValue
        }
    }
}

extension CodableDefault.Wrapper: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Value.self)
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: CodableDefault.Wrapper<T>.Type,
                   forKey key: Key) throws -> CodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

public extension CodableDefault {
    typealias Source = CodableDefaultSource
    typealias List = Decodable & ExpressibleByArrayLiteral
    typealias Map = Decodable & ExpressibleByDictionaryLiteral
    typealias FloatNumber = Decodable & ExpressibleByFloatLiteral
    typealias Number = Decodable & Numeric

    enum Sources {
        public enum True: Source {
            public static var defaultValue: Bool { true }
        }

        public enum False: Source {
            public static var defaultValue: Bool { false }
        }

        public enum EmptyString: Source {
            public static var defaultValue: String { "" }
        }
        
        public enum Zero<T: Number>: Source {
            public static var defaultValue: T { 0 }
        }

        public enum EmptyList<T: List>: Source {
            public static var defaultValue: T { [] }
        }

        public enum EmptyMap<T: Map>: Source {
            public static var defaultValue: T { [:] }
        }
    }
}

public extension CodableDefault {
    typealias True = Wrapper<Sources.True>
    typealias False = Wrapper<Sources.False>
    typealias EmptyString = Wrapper<Sources.EmptyString>
    typealias EmptyList<T: List> = Wrapper<Sources.EmptyList<T>>
    typealias EmptyMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
    typealias Zero<T: Number> = Wrapper<Sources.Zero<T>>
}

extension CodableDefault.Wrapper: Equatable where Value: Equatable {}
extension CodableDefault.Wrapper: Hashable where Value: Hashable {}

extension CodableDefault.Wrapper: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
