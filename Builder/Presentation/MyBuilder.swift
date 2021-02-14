//
//  Copyright © 2021. All rights reserved.
//

struct MyObject {
    let title: String
    let bban: Bban
}

class MyBuilder: BaseBuilder<MyObject, MyBuilderElement, MyBuilderFormError> {
    let bbanBuilder = BbanBuilder()

    override init() {
        super.init()

        mapping = [
            MyBuilderElement(.accountNumber): "",
            MyBuilderElement(.bankCode): "",
            MyBuilderElement(.title): ""
        ]
    }

    override func makeObject() -> Result<MyObject, ComposedError<MyBuilderFormError>> {
        return notEmpty(
            mapping[MyBuilderElement(.title)],
            else: MyBuilderFormError.missingElement(.init(.title))
        ).pack(with: bbanBuilder.build(), transform: mapBbanError)
        .map(MyObject.init)
    }

    override func updateValue(_ value: String?, for element: MyBuilderElement) {
        super.updateValue(value, for: element)

        switch element.value {
        case .accountNumber: bbanBuilder.updateValue(value, for: .init(.accountNumber))
        case .bankCode: bbanBuilder.updateValue(value, for: .init(.bankCode))
        case .title: break
        }
    }

    private func mapBbanError(_ error: FormError) -> MyBuilderFormError? {
        guard let error = error as? BbanBuilderFormError else { return nil }

        switch error {
        case .invalidBban: return MyBuilderFormError.invalidBban
        case .missingElement(let element):
            switch element.value {
            case .accountNumber: return MyBuilderFormError.missingElement(.init(.accountNumber))
            case .bankCode: return MyBuilderFormError.missingElement(.init(.bankCode))
            }
        }
    }
}
