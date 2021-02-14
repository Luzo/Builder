//
//  Copyright © 2021. All rights reserved.
//


protocol BuilderPresenter {
    func updateValue(_ value: String?, for: BaseFormElement)
    func submit()
}
