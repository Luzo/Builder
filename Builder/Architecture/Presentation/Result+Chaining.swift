//
//  Copyright © 2021. All rights reserved.
//

extension Result {
    func pack<OtherValue, FirstError, SecondError>(
        with other: Result<OtherValue, ComposedError<SecondError>>,
        transform: (SecondError) -> FirstError?
    ) -> Result<(Success, OtherValue), ComposedError<FirstError>> where Failure == ComposedError<FirstError> {
        switch (self, other) {
        case let (.success(this), .success(other)): return .success((this, other))
        case let (.failure(this), .failure(other)): return .failure(this.chain(with: other.errors, transform: transform))
        case let (.success, .failure(error)): return .failure(ComposedError(errors: error.errors.compactMap(transform)))
        case let (.failure(error), .success): return .failure(error)
        }
    }

    func pack<OtherValue, FirstError>(
        with other: Result<OtherValue, Failure>
    ) -> Result<(Success, OtherValue), Failure> where Failure == ComposedError<FirstError> {
        switch (self, other) {
        case let (.success(this), .success(other)): return .success((this, other))
        case let (.failure(this), .failure(other)): return .failure(this.chain(with: other.errors))
        case let (.success, .failure(error)): return .failure(ComposedError(errors: error.errors))
        case let (.failure(error), .success): return .failure(error)
        }
    }

    func packError<FirstError>(_ error: FirstError, ifMet: () -> Bool) -> Result<Success, Failure> where Failure == ComposedError<FirstError> {
        guard ifMet() else { return self }
        switch self {
        case .success: return .failure(ComposedError(errors: [error]))
        case let .failure(this): return .failure(this.chain(with: [error]))
        }
    }
}
