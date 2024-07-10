//
//  Button.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

import TermKit

extension Button: Renderable {

    /// An identifier for the button's action.
    var actionID: String { "action" }

    /// The view storage.
    /// - Parameters:
    ///     - type: The type of the renderable elements.
    ///     - fields: More information.
    public func container<RenderableType>(type: RenderableType.Type, fields: [String: Any]) -> RenderableStorage {
        let storage = RenderableStorage(nil)
        let menuItem = MenuItem(title: label) {
            (storage.fields[actionID] as? () -> Void)?()
        }
        storage.pointer = menuItem
        storage.fields[actionID] = action
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - updateProperties: Whether to update the properties.
    ///     - type: The type of the renderable elements.
    ///     - fields: More information.
    public func update<RenderableType>(
        _ storage: RenderableStorage,
        updateProperties: Bool,
        type: RenderableType.Type,
        fields: [String: Any]
    ) {
        guard updateProperties else {
            return
        }
        storage.fields[actionID] = action
    }

}
