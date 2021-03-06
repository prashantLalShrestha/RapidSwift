//
//  Publisher++.swift
//

import Combine
import Foundation

public extension Publisher {
    /// Waits for this publisher to produce values.
    /// - Returns: The result of the wait operation.
    @discardableResult
    func wait() -> Result<Output, Error> {
        let dispatchGroup = DispatchGroup()
        var value: Output? = nil
        var completion: Subscribers.Completion<Failure>?
        var cancellable: AnyCancellable?
        
        dispatchGroup.enter()
        cancellable = self.sink(receiveCompletion: {
            completion = $0
            dispatchGroup.leave()
        }, receiveValue: {
            completion = .finished
            value = $0
            dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
        
        cancellable?.cancel()

        switch completion {
        case .none:
            return .failure(NSError(domain: "Publisher", code: -1, userInfo: [NSLocalizedDescriptionKey : "Cancelled"]))
        case .finished:
            if let value = value {
                return .success(value)
            } else  {
                return .failure(NSError(domain: "Publisher", code: -1, userInfo: [NSLocalizedDescriptionKey : "Nil Value"]))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func execute(completion: @escaping ((Result<Output, Error>) -> Void)) {
        var cancellable: AnyCancellable?
        cancellable = self.eraseToResultPublisher().sink { result in
            completion(result)
            cancellable?.cancel()
        }
    }
    
    func eraseToResultPublisher() -> AnyPublisher<Result<Output, Error>, Never> {
        map{ .success($0) }
        .catch{ Just(.failure($0)) }
        .eraseToAnyPublisher()
    }
}
