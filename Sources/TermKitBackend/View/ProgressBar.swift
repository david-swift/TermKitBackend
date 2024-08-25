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

    /// The fraction displayed in the progress bar.
    var fraction: Float {
        .init(value / max)
    }

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
    /// - Returns: The view storage.
    public func container<Data>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let bar = TermKit.ProgressBar()
        bar.fraction = fraction
        return .init(bar, state: self)
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
        guard let pointer = storage.pointer as? TermKit.ProgressBar,
              updateProperties,
              (storage.previousState as? Self)?.fraction != fraction else {
            return
        }
        pointer.fraction = fraction
        storage.previousState = self
    }

}
