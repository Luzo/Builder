//
//  Copyright © 2021. All rights reserved.
//

protocol ValidationFormError: BuildingFormError {}

protocol BuildingFormError: FormError {}

protocol FormError: Error {}

struct ComposedError: Error {
    let errors: [FormError]
}

//extension Array where Element: BuildingFormError {
//    func chain<U: FormError>(with otherErrors: [U], transform: (U) -> Element?) -> [Element] {
//        self + otherErrors.compactMap(transform)
//    }
//}
