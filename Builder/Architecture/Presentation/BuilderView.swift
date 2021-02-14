//
//  Copyright © 2021. All rights reserved.
//

protocol BuilderView: AnyObject {
    var mapping: [BaseFormElement: ViewBindable] { get }
    func bindViews(_ elements: [BaseFormElement]) throws
    func showErrors(_ errors: [FormError])
}

extension BuilderView {

    func validationErrors(_ errors: [ValidationFormError]) {
        showErrors(errors)
    }

    func buildingErrors(_ errors: [BuildingFormError]) {
        showErrors(errors)
    }
}
