//
//  ButtonCollection.swift
//  TermKitBackend
//
//  Created by david-swift on 18.07.2024.
//

@preconcurrency import TermKit

/// A collection of buttons.
public struct ButtonCollection: ButtonWidget, Wrapper {

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
        data: WidgetData,
        type: Data.Type
    ) async -> ViewStorage where Data: ViewRenderData {
        var buttons: [Button] = []
        for element in await content.storages(data: data, type: type) {
            if let button = await element.pointer as? Button {
                buttons.append(button)
            } else if let collection = await element.pointer as? [Button] {
                buttons += collection
            }
        }
        return await .init(buttons, content: [.mainContent: content.storages(data: data, type: type)])
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify the views before updating.
    ///     - updateProperties: Whether to update the properties.
    ///     - type: The type of the views.
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        // Buttons in dialogs cannot be updated
    }

}
