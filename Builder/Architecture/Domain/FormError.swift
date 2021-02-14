//
//  Copyright © 2021. All rights reserved.
//

protocol FormError: Error {
    var isValidation: Bool { get }
}

struct ComposedError<ErrorType: FormError>: Error {
    let errors: [ErrorType]
}

extension Array where Element: FormError {
    func chain<U: FormError>(with otherErrors: [U], transform: (U) -> Element?) -> [Element] {
        self + otherErrors.compactMap(transform)
    }
}

extension ComposedError {
    func chain<U: FormError>(with otherErrors: [U], transform: (U) -> ErrorType?) -> ComposedError<ErrorType> {
        ComposedError<ErrorType>(errors: self.errors + otherErrors.compactMap(transform))
    }
}

extension ComposedError {
    func chain(with otherErrors: [ErrorType]) -> ComposedError<ErrorType> {
        ComposedError<ErrorType>(errors: self.errors + otherErrors)
    }
}
