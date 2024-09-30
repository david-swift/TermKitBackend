//
//  Menu.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

@preconcurrency import TermKit

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
    ) async -> ViewStorage where Data: ViewRenderData {
        let children = await content.storages(data: data, type: type)
        let menu = await MenuBarItem(title: label, children: children.compactMap { await $0.pointer as? MenuItem })
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
    ) async where Data: ViewRenderData {
        let storages = await storage.getContent(key: .mainContent)
        await content.update(storages, data: data, updateProperties: updateProperties, type: type)
    }

}
