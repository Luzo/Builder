//
//  Copyright © 2021. All rights reserved.
//

struct Bban {
    let accountNumber: String
    let bankCode: String
    let variableToShowFlatten: Bool
}

enum BbanBuilderFormError: FormError {
    case missingElement(BbanBuilderElement)
    case invalidBban

    var isValidation: Bool {
        switch self {
        case .missingElement: return true
        case .invalidBban: return false
        }
    }
}

class BbanBuilder: BaseBuilder<Bban, BbanBuilderElement, BbanBuilderFormError> {
    override init() {
        super.init()
        mapping = [
            BbanBuilderElement(.accountNumber): "",
            BbanBuilderElement(.bankCode): ""
        ]
    }

    override func makeObject() -> Result<Bban, ComposedError<BbanBuilderFormError>> {
        return buildAccountNumber().pack(
            with: notEmpty(
                mapping[BbanBuilderElement(.bankCode)],
                else: BbanBuilderFormError.missingElement(.init(.bankCode))
            )
        ).pack(with: .success(true))
        .map(flatten)
        .map(Bban.init)
    }

    private func buildAccountNumber() -> Result<String, ComposedError<BbanBuilderFormError>> {
        let accNumber = mapping[BbanBuilderElement(.accountNumber)]

        return notEmpty(
            accNumber,
            else: BbanBuilderFormError.missingElement(.init(.accountNumber))
        ).packError(BbanBuilderFormError.invalidBban, ifMet: { accNumber != "123456789" })
    }
}
