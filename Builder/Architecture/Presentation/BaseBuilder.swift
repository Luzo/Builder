//
//  Copyright © 2021. All rights reserved.
//

import Foundation

protocol Builder: AnyObject {
    associatedtype BuiltObject
    associatedtype Element: Hashable
    associatedtype ValidationError: FormError
    var mapping: [Element: String] { get set }
    func build() -> Result<BuiltObject, ComposedError<ValidationError>>
    func validate() -> [ValidationError]
    //TODO: how about picked values?
    func updateValue(_ value: String?, for element: Element)
}

class BaseBuilder<T, Element: BaseFormElement, ValidationError: FormError>: Builder {
    var mapping: [Element: String] = [:]

    func updateValue(_ value: String?, for element: Element) {
        if value == nil {
            mapping.removeValue(forKey: element)
        } else {
            mapping[element] = value
        }
    }

    func makeObject() -> Result<T, ComposedError<ValidationError>> { .failure(ComposedError(errors: [])) }

    func build() -> Result<T, ComposedError<ValidationError>> {
        switch makeObject() {
        case .success(let object):
            return .success(object)
        case .failure(let error):
            return .failure(ComposedError(errors: error.errors))
        }
    }

    func validate() -> [ValidationError] {
        switch makeObject() {
        case .success: return []
        case .failure(let error): return error.errors.filter(\.isValidation)
        }
    }

    func notNil<T>(_ value: T?, else error: ValidationError) -> Result<T, ComposedError<ValidationError>> {
        guard let value = value else { return .failure(ComposedError(errors: [error])) }
        return .success(value)
    }

    func notEmpty(_ value: String?, else error: ValidationError) -> Result<String, ComposedError<ValidationError>> {
        guard let value = value, !value.isEmpty else { return .failure(ComposedError(errors: [error])) }
        return .success(value)
    }
}

