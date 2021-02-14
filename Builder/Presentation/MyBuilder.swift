//
//  Copyright © 2021. All rights reserved.
//


enum MyBuilderValidationFormError: ValidationFormError {
    case missingElement(MyBuilderElement)
}

enum MyBuilderBuildingFormError: BuildingFormError {
    case invalidBban
}

class MyBuilder: BaseBuilder<MyObject, MyBuilderElement, MyBuilderValidationFormError> {
    let bbanBuilder = BbanBuilder()

    override init() {
        super.init()

        mapping = [
            MyBuilderElement(.accountNumber): "",
            MyBuilderElement(.bankCode): "",
            MyBuilderElement(.title): ""
        ]
    }

    //TODO: packing errors should be easier
    override func makeObject() -> Result<MyObject, ComposedError> {
        var errors: [FormError] = []

        var objectTitle: String?
        if let title = mapping[MyBuilderElement(.title)] {
            objectTitle = title
        } else {
            errors.append(MyBuilderValidationFormError.missingElement(MyBuilderElement(.title)))
        }

        var objectBban: Bban?
        switch bbanBuilder.build() {
        case .success(let bban): objectBban = bban
        case .failure(let composedError):
            errors.append(contentsOf: composedError.errors.compactMap(mapBbanValidationError))
            errors.append(contentsOf: composedError.errors.compactMap(mapBbanBuildingError))
        }

        guard let bban = objectBban, let title = objectTitle, errors.isEmpty else {
            return .failure(ComposedError(errors: errors))
        }

        return .success(MyObject(title: title, bban: bban))
    }

    override func updateValue(_ value: String?, for element: MyBuilderElement) {
        super.updateValue(value, for: element)

        switch element.value {
        case .accountNumber: bbanBuilder.updateValue(value, for: BbanBuilderElement(.accountNumber))
        case .bankCode: break
        case .title: break
        }
    }

    private func mapBbanBuildingError(_ error: FormError) -> MyBuilderBuildingFormError? {
        guard let error = error as? BbanBuilderBuildingFormError else { return nil }

        switch error {
        case .invalidBban: return MyBuilderBuildingFormError.invalidBban
        }
    }

    private func mapBbanValidationError(_ error: FormError) -> MyBuilderValidationFormError? {
        guard let error = error as? BbanBuilderValidationFormError else { return nil }

        switch error {
        case .missingElement(let element):
            switch element.value {
            case .accountNumber: return MyBuilderValidationFormError.missingElement(.init(.accountNumber))
            }
        }
    }
}

struct MyObject {
    let title: String
    let bban: Bban
}

struct Bban {
    let accountNumber: String
}
