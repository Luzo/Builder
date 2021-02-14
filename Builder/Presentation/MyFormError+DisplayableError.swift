//
//  Copyright © 2021. All rights reserved.
//

extension MyBuilderBuildingFormError: FormDisplayableError {
    var text: String? {
        switch self {
        case .invalidBban: return "zly BBAN"
        }
    }

    var element: BaseFormElement {
        switch self {
        case .invalidBban: return MyBuilderElement(.accountNumber)
        }
    }
}

extension MyBuilderValidationFormError: FormDisplayableError {
    var text: String? {
        switch self {
        case .missingElement: return nil
        }
    }

    var element: BaseFormElement {
        switch self {
        case .missingElement(let element): return element
        }
    }
}

extension BbanBuilderBuildingFormError: FormDisplayableError {
    var text: String? {
        switch self {
        case .invalidBban: return "zly bban"
        }
    }

    var element: BaseFormElement {
        switch self {
        case .invalidBban: return BbanBuilderElement(.accountNumber)
        }
    }
}

extension BbanBuilderValidationFormError: FormDisplayableError {
    var text: String? {
        switch self {
        case .missingElement: return nil
        }
    }

    var element: BaseFormElement {
        switch self {
        case .missingElement(let element): return element
        }
    }
}
