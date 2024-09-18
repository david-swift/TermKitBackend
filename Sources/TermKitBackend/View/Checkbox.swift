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
    @Property(set: { $0.text = $1 }, pointer: TermKit.Checkbox.self)
    var label = ""
    /// Whether the checkbox is on.
    @BindingProperty(
        observe: { box, value in box.toggled = { value.wrappedValue = $0.checked } },
        set: { $0.checked = $1 },
        pointer: TermKit.Checkbox.self
    )
    var isOn: Binding<Bool> = .constant(false)

    /// Initialize the checkbox.
    /// - Parameters:
    ///     - label: The label.
    ///     - isOn: Whether the checkbox is on.
    public init(_ label: String, isOn: Binding<Bool>) {
        self.label = label
        self.isOn = isOn
    }

    /// Get the widget.
    /// - Returns: The widget.
    public func initializeWidget() -> Any {
        TermKit.Checkbox(label)
    }

}
