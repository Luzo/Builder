//
//  Copyright © 2021. All rights reserved.
//

enum BbanBuilderValidationFormError: ValidationFormError {
    case missingElement(BbanBuilderElement)
}

enum BbanBuilderBuildingFormError: BuildingFormError {
    case invalidBban
}

class BbanBuilder: BaseBuilder<Bban, BbanBuilderElement, BbanBuilderValidationFormError> {
    override init() {
        super.init()
        mapping = [
            BbanBuilderElement(.accountNumber): "",
        ]
    }

    override func makeObject() -> Result<Bban, ComposedError> {
        guard
            let optNumber = mapping[BbanBuilderElement(.accountNumber)],
            let number = optNumber,
            !number.isEmpty
        else {
            return .failure(
                ComposedError(errors: [BbanBuilderValidationFormError.missingElement(.init(.accountNumber))])
            )
        }

        guard number == "123456789" else {
            return .failure(ComposedError(errors: [BbanBuilderBuildingFormError.invalidBban]))
        }

        return .success(Bban(accountNumber: number))
    }
}
