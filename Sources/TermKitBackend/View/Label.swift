//
//  Label.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

import TermKit

/// A simple label view.
public struct Label: TermKitWidget {

    /// The label.
    var label: String

    /// Initialize a label.
    /// - Parameter label: The label.
    public init(_ label: String) {
        self.label = label
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
        let button = TermKit.Label(label)
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
        guard let pointer = storage.pointer as? TermKit.Label,
              updateProperties,
              (storage.previousState as? Self)?.label != label else {
            return
        }
        pointer.text = label
        storage.previousState = self
    }

}
