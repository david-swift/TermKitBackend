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
    var text: Binding<String>
    /// Whether the text field is secret.
    var secret = false

    /// The identifier for the closure.
    let closureID = "closure"

    /// Initialize the text field.
    /// - Parameter text: The text.
    public init(text: Binding<String>) {
        self.text = text
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
        let field = TermKit.TextField(text.wrappedValue)
        let storage = ViewStorage(field, state: self)
        field.secret = secret
        field.textChanged = { _, _ in
            (storage.fields[closureID] as? () -> Void)?()
        }
        storage.fields[closureID] = {
            text.wrappedValue = field.text
        }
        return storage
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
        guard let field = storage.pointer as? TermKit.TextField else {
            return
        }
        storage.fields[closureID] = {
            text.wrappedValue = field.text
        }
        if updateProperties {
            if (storage.previousState as? Self)?.secret != secret {
                field.secret = secret
            }
            if field.text != text.wrappedValue {
                field.text = text.wrappedValue
            }
            storage.previousState = self
        }
    }

    /// Set whether the text field is secret.
    /// - Parameter secret: Whether the text field is secret.
    /// - Returns: The view.
    public func secret(_ secret: Bool) -> Self {
        modify { $0.secret = secret }
    }

}
