//
//  ButtonCollection.swift
//  TermKitBackend
//
//  Created by david-swift on 18.07.2024.
//

import TermKit

/// A collection of buttons.
public struct ButtonCollection: ButtonContext.Widget, Wrapper {

    /// The content of the collection.
    var content: Body

    /// Initialize a collection.
    /// - Parameter content: The content of the collection.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content()
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify the views before updating.
    ///     - type: The type of the views.
    /// - Returns: The view storage.
    public func container<Data>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        var buttons: [Button] = []
        for element in content.storages(modifiers: modifiers, type: type) {
            if let button = element.pointer as? Button {
                buttons.append(button)
            } else if let collection = element.pointer as? [Button] {
                buttons += collection
            }
        }
        return .init(buttons, content: [.mainContent: content.storages(modifiers: modifiers, type: type)])
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify the views before updating.
    ///     - updateProperties: Whether to update the properties.
    ///     - type: The type of the views.
    public func update<Data>(
        _ storage: ViewStorage,
        modifiers: [(AnyView) -> AnyView],
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        // Buttons in dialogs cannot be updated
    }

}
