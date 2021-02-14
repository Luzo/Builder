//
//  Copyright © 2021. All rights reserved.
//

enum MyBuilderFormError: FormError {
    case missingElement(MyBuilderElement)
    case invalidBban

    var isValidation: Bool {
        switch self {
        case .missingElement: return true
        case .invalidBban: return false
        }
    }
}
