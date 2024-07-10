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
    public func container<Storage>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Storage.Type
    ) -> ViewStorage where Storage: AppStorage {
        let button = TermKit.Label(label)
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
        guard let storage = storage.pointer as? TermKit.Label, updateProperties else {
            return
        }
        storage.text = label
    }

}
