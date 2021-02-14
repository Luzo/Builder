//
//  Copyright © 2021. All rights reserved.
//

protocol MyView: BuilderView {
    func setButtonEnabled(_ isEnabled: Bool)
}

protocol MyBuilderPresenter: BuilderPresenter {}

class MyPresenter: MyBuilderPresenter {
    weak var view: MyView?
    let builder = MyBuilder()

    init() {}

    func becomeActive() {
        try? view?.bindViews(builder.mapping.map(\.key))
        view?.setButtonEnabled(builder.validate().isEmpty)
    }

    func submit() {
        switch builder.build() {
        case .success: print("OK")
        case .failure(let errors):
            view?.showErrors(errors.errors)
        }
    }

    func updateValue(_ value: String?, for element: BaseFormElement) {
        guard let element = element as? MyBuilderElement else { return }
        builder.updateValue(value, for: element)
        view?.setButtonEnabled(builder.validate().isEmpty)
    }
}
