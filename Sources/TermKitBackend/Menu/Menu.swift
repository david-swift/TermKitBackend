//
//  Menu.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

import TermKit

/// A menu is an item of a `MenuBar`.
public struct Menu: MenuWidget {

    /// The menu's label, displayed in the menu bar.
    var label: String
    /// The content of the menu.
    var content: Body

    /// Initialize a menu.
    /// - Parameters:
    ///     - label: The menu's label, displayed in the menu bar.
    ///     - content: The content of the menu.
    public init(_ label: String, @ViewBuilder content: () -> Body) {
        self.label = label
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
    ) -> ViewStorage where Data: ViewRenderData {
        let children = content.storages(data: data, type: type)
        let menu = MenuBarItem(title: label, children: children.compactMap { $0.pointer as? MenuItem })
        return .init(menu, content: [.mainContent: children])
    }

    /// Update the view storage.
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
        guard let storages = storage.content[.mainContent] else {
            return
        }
        content.update(storages, data: data, updateProperties: updateProperties, type: type)
    }

}
