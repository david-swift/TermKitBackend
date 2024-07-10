//
//  Button.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

import TermKit

/// A simple button widget.
public struct Button: TermKitWidget {

    /// The button's label.
    var label: String
    /// The action.
    var action: () -> Void

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
    public func container<Storage>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Storage.Type
    ) -> ViewStorage where Storage: AppStorage {
        let button = TermKit.Button(label, clicked: action)
        return .init(button)
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Storage>(
        _ storage: ViewStorage,
        modifiers: [(any AnyView) -> any AnyView],
        updateProperties: Bool,
        type: Storage.Type
    ) where Storage: AppStorage {
        guard let storage = storage.pointer as? TermKit.Button else {
            return
        }
        storage.clicked = { _ in action() }
        if updateProperties {
            storage.text = label
        }
    }

}
