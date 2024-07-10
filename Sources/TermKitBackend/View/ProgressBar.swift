//
//  ProgressBar.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

import TermKit

/// A simple progress bar view.
public struct ProgressBar: TermKitWidget {

    /// The current value.
    var value: Double
    /// The maximum value.
    var max: Double

    /// Initialize a progress bar.
    /// - Parameters:
    ///     - value: The current value.
    ///     - max: The maximum value.
    public init(value: Double, max: Double = 1) {
        self.value = value
        self.max = max
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    public func container<Storage>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Storage.Type
    ) -> ViewStorage where Storage: AppStorage {
        let bar = TermKit.ProgressBar()
        bar.fraction = .init(value / max)
        return .init(bar)
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
        guard let storage = storage.pointer as? TermKit.ProgressBar, updateProperties else {
            return
        }
        storage.fraction = .init(value / max)
    }

}
