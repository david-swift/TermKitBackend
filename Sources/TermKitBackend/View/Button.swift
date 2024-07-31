//
//  Button.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

import TermKit

/// A simple button widget.
public struct Button: TermKitWidget, ButtonWidget, MenuWidget {

    /// The button's label.
    var label: String
    /// The action.
    var action: () -> Void

    /// The identifier for the action closure.
    let actionID = "action"

    /// Initialize a button.
    /// - Parameters:
    ///     - The button's label.
    ///     - The action.
    public init(_ label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        if type == MenuContext.self {
            let storage = ViewStorage(nil)
            let menuItem = MenuItem(title: label) {
                (storage.fields[actionID] as? () -> Void)?()
            }
            storage.pointer = menuItem
            storage.fields[actionID] = action
            return storage
        } else if type == ButtonContext.self {
            return ViewStorage(self)
        }
        let button = TermKit.Button(label, clicked: action)
        return .init(button, state: self)
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(
        _ storage: ViewStorage,
        modifiers: [(any AnyView) -> any AnyView],
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        if type == MenuContext.self {
            storage.fields[actionID] = action
        }
        guard let pointer = storage.pointer as? TermKit.Button else {
            return
        }
        pointer.clicked = { _ in action() }
        if updateProperties, (storage.previousState as? Self)?.label != label {
            pointer.text = label
            storage.previousState = self
        }
    }

}
