//
//  ListView.swift
//  TermKitBackend
//
//  Created by david-swift on 06.07.2024.
//

import TermKit

/// A list view contains multiple clickable rows.
public struct ListView<Element>: TermKitWidget where Element: CustomStringConvertible {

    /// The rows.
    var items: [Element]
    /// Execute when a row gets clicked.
    var activate: (Element) -> Void

    /// Initialize the list view.
    /// - Parameters:
    ///     - items: The rows.
    ///     - activate: Execute when a row gets clicked.
    public init(_ items: [Element], activate: @escaping (Element) -> Void = { _ in }) {
        self.items = items
        self.activate = activate
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let list = TermKit.ListView(items: items.map { $0.description })
        setClosure(list: list)
        return .init(list)
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        guard let list = storage.pointer as? TermKit.ListView else {
            return
        }
        setClosure(list: list)
    }

    /// Set the closure executed when the row gets clicked.
    /// - Parameter list: The list view object.
    func setClosure(list: TermKit.ListView) {
        list.activate = { index in
            if let item = items[safe: index] {
                activate(item)
            }
            return false
        }
    }

}
