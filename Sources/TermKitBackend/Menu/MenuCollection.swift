//
//  MenuCollection.swift
//  TermKitBackend
//
//  Created by david-swift on 13.07.2024.
//

import TermKit

/// A collection of menus.
public struct MenuCollection: MenuWidget, Wrapper {

    /// The content of the collection.
    var content: Body

    /// Initialize a menu.
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
    ) -> ViewStorage where Data: ViewRenderData {
        var storages: [ViewStorage] = []
        forEachMenu { menu in
            storages.append(menu.container(data: data, type: type))
        }
        return .init(storages.compactMap { $0.pointer }, content: [.mainContent: storages])
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
        // Menus cannot be updated
    }

    /// Run a function for each menu.
    /// - Parameter closure: The function.
    func forEachMenu(closure: @escaping (Menu) -> Void) {
        var index = 0
        for element in content {
            if let menu = element as? Menu {
                closure(menu)
                index += 1
            } else if let collection = element as? [Menu] {
                for menu in collection {
                    closure(menu)
                    index += 1
                }
            }
        }
    }

}
