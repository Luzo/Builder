//
//  Copyright © 2021. All rights reserved.
//

protocol BuilderView: AnyObject {
    var mapping: [BaseFormElement: ViewBindable] { get }
    func bindViews(_ elements: [BaseFormElement]) throws
    func showErrors(_ errors: [FormDisplayableError])
}
