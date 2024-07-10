//
//  Menu.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

import TermKit

/// A menu is an item of a ``MenuBar``.
public struct Menu: Renderable {

    /// The menu's label, displayed in the menu bar.
    var label: String
    /// The content of the menu.
    var content: [Button]

    /// Initialize a menu.
    /// - Parameters:
    ///     - label: The menu's label, displayed in the menu bar.
    ///     - content: The content of the menu.
    public init(_ label: String, @Builder<Button> content: () -> [Button]) {
        self.label = label
        self.content = content()
    }

    /// The view storage.
    /// - Parameters:
    ///     - type: The type of the renderable elements.
    ///     - fields: More information.
    public func container<RenderableType>(type: RenderableType.Type, fields: [String: Any]) -> RenderableStorage {
        let children = (content as [Renderable]).storages(type: Button.self, fields: [:])
        let menu = MenuBarItem(title: label, children: children.compactMap { $0.pointer as? MenuItem })
        return .init(menu, content: [.mainContent: children])
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
        guard let storages = storage.content[.mainContent] else {
            return
        }
        (content as [Renderable]).update(storages, updateProperties: updateProperties, type: type, fields: [:])
    }

}
