//
//  Copyright © 2021. All rights reserved.
//


class MyBuilderElement: BaseFormElement {
    enum MyBuilderElements: String {
        case accountNumber
        case bankCode
        case title
    }

    let value: MyBuilderElements

    init(_ value: MyBuilderElements) {
        self.value = value
    }

    override func hash(into hasher: inout Hasher) {
        hasher.combine(value.hashValue)
    }
}
