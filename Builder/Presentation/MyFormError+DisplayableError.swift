//
//  Copyright © 2021. All rights reserved.
//

extension MyBuilderFormError: FormDisplayableError {
    var text: String? {
        switch self {
        case .missingElement: return nil
        case .invalidBban: return "zly BBAN"
        }
    }

    var element: BaseFormElement {
        switch self {
        case .missingElement(let element): return element
        case .invalidBban: return MyBuilderElement(.accountNumber)
        }
    }
}


extension BbanBuilderFormError: FormDisplayableError {
    var text: String? {
        switch self {
        case .missingElement: return nil
        case .invalidBban: return "zly bban"
        }
    }

    var element: BaseFormElement {
        switch self {
        case .missingElement(let element): return element
        case .invalidBban: return BbanBuilderElement(.accountNumber)
        }
    }
}

