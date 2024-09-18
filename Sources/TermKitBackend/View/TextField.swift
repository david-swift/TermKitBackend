//
//  Button.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

import TermKit

/// A simple text field view.
public struct TextField: TermKitWidget {

    /// The text.
    @BindingProperty(
        observe: { pointer, value in
            pointer.textChanged = { _, _ in
                value.wrappedValue = pointer.text
            }
        },
        set: { $0.text = $1 },
        pointer: TermKit.TextField.self
    )
    var text: Binding<String> = .constant("")
    /// Whether the text field is secret.
    @Property(set: { $0.secret = $1 }, pointer: TermKit.TextField.self)
    var secret = false

    /// The identifier for the closure.
    let closureID = "closure"

    /// Initialize the text field.
    /// - Parameter text: The text.
    public init(text: Binding<String>) {
        self.text = text
    }

    /// Get the widget.
    /// - Returns: The widget.
    public func initializeWidget() -> Any {
        TermKit.TextField(text.wrappedValue)
    }

    /// Set whether the text field is secret.
    /// - Parameter secret: Whether the text field is secret.
    /// - Returns: The view.
    public func secret(_ secret: Bool) -> Self {
        modify { $0.secret = secret }
    }

}
