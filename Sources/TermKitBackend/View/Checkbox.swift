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
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let button = TermKit.Checkbox(label, checked: isOn.wrappedValue)
        button.toggled = { _ in
            isOn.wrappedValue = button.checked
        }
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
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        guard let pointer = storage.pointer as? TermKit.Checkbox else {
            return
        }
        if updateProperties {
            if (storage.previousState as? Self)?.label != label {
                pointer.text = label
            }
            if (storage.previousState as? Self)?.isOn.wrappedValue != isOn.wrappedValue {
                pointer.checked = isOn.wrappedValue
            }
            storage.previousState = self
        }
        pointer.toggled = { _ in
            isOn.wrappedValue = pointer.checked
        }
    }

}
