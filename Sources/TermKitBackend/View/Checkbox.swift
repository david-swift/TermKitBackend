//
//  Checkbox.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

import TermKit

/// A simple checkbox widget.
public struct Checkbox: TermKitWidget {

    /// The label of the checkbox.
    var label: String
    /// Whether the checkbox is on.
    var isOn: Binding<Bool>

    /// Initialize the checkbox.
    /// - Parameters:
    ///     - label: The label.
    ///     - isOn: Whether the checkbox is on.
    public init(_ label: String, isOn: Binding<Bool>) {
        self.label = label
        self.isOn = isOn
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    public func container<Storage>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Storage.Type
    ) -> ViewStorage where Storage: AppStorage {
        let button = TermKit.Checkbox(label, checked: isOn.wrappedValue)
        button.toggled = { _ in
            isOn.wrappedValue = button.checked
        }
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
        guard let storage = storage.pointer as? TermKit.Checkbox, updateProperties else {
            return
        }
        storage.text = label
        storage.checked = isOn.wrappedValue
        storage.toggled = { _ in
            isOn.wrappedValue = storage.checked
        }
    }

}
