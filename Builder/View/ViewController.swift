//
//  ViewController.swift
//  Builder
//
//  Created by Lubos Lehota on 13/02/2021.
//

import UIKit

protocol ViewBindable: AnyObject {
    func setErrrorText(_ text: String)
    var valueUpdate: (String?) -> Void { get set }
}

class MyField: UITextField, ViewBindable {
    var valueUpdate: (String?) -> Void = { _ in }
    var errorText: String?
    func setErrrorText(_ text: String) {
        errorText = text
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange() {
        valueUpdate(text)
    }
}

class ViewController: BaseBuilderViewController, MyView {
    @IBOutlet weak var titleLabel: MyField!
    @IBOutlet weak var accountNumber: MyField!
    @IBOutlet weak var bankCode: MyField!
    @IBOutlet weak var submitButton: UIButton!

    override var mapping: [BaseFormElement: ViewBindable] {[
        MyBuilderElement(.accountNumber): accountNumber,
        MyBuilderElement(.bankCode): bankCode,
        MyBuilderElement(.title): titleLabel
    ]}
    let presenter = MyPresenter()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        builderPresenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.becomeActive()
    }

    func setButtonEnabled(_ isEnabled: Bool) {
        submitButton.isEnabled = isEnabled
    }

    @IBAction func build() {
        presenter.submit()
    }
}
