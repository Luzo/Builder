//
//  Copyright © 2021. All rights reserved.
//

class BbanBuilderElement: BaseFormElement {
    enum BbanBuilderElements: String {
        case accountNumber
        case bankCode
    }

    let value: BbanBuilderElements

    init(_ value: BbanBuilderElements) {
        self.value = value
    }

    override func hash(into hasher: inout Hasher) {
        hasher.combine(value.hashValue)
    }
}
