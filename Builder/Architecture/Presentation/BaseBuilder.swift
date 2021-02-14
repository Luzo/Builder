//
//  Copyright © 2021. All rights reserved.
//

import Foundation

protocol Builder: AnyObject {
    associatedtype BuiltObject
    associatedtype Element: Hashable
    associatedtype ValidationError
    var mapping: [Element: String?] { get set }
    func build() -> Result<BuiltObject, ComposedError>
    func validate() -> [ValidationError]
    //TODO: how about picked values?
    func updateValue(_ value: String?, for element: Element)
}

class BaseBuilder<T, Element: BaseFormElement, ValidationError: ValidationFormError>: Builder {
    var mapping: [Element: String?] = [:]

    func updateValue(_ value: String?, for element: Element) {
        mapping[element] = value
    }

    func makeObject() -> Result<T, ComposedError> { .failure(ComposedError(errors: [])) }

    func build() -> Result<T, ComposedError> {
        switch makeObject() {
        case .success(let object):
            return .success(object)
        case .failure(let error):
            return .failure(ComposedError(errors: error.errors.compactMap { $0 as? BuildingFormError }))
        }
    }

    func validate() -> [ValidationError] {
        switch makeObject() {
        case .success: return []
        case .failure(let error): return error.errors.compactMap { $0 as? ValidationError }
        }
    }
}
