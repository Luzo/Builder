//
//  Copyright © 2021. All rights reserved.
//

import UIKit

struct BindingError: Error {}

class BaseBuilderViewController: UIViewController {
    var mapping: [BaseFormElement: ViewBindable] { [:] }
    var builderPresenter: BuilderPresenter!

    func bindViews(_ elements: [BaseFormElement]) throws {
        try elements.forEach { mapKey in
            guard let element = mapping[mapKey] else { throw BindingError() }
            element.valueUpdate = { [weak self] in self?.builderPresenter.updateValue($0, for: mapKey) }
        }
    }

    func showErrors(_ errors: [FormDisplayableError]) {
        guard let error = errors.first else {
            return
        }
        let alert = UIAlertController(title: "ERROR", message: error.text, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}


