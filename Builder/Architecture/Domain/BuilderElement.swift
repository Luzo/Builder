//
//  Copyright © 2021. All rights reserved.
//


protocol FormElement {}

class BaseFormElement: FormElement, Hashable {
    var typeName: String { String(describing: Self.self) }

    static func == (lhs: BaseFormElement, rhs: BaseFormElement) -> Bool {
        return lhs.hashValue == rhs.hashValue && lhs.typeName == rhs.typeName
    }

    func hash(into hasher: inout Hasher) {
        fatalError()
    }
}
