//
//  ProgressBar.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

@preconcurrency import TermKit

/// A simple progress bar view.
public struct ProgressBar: TermKitWidget {

    /// The current value.
    @Property(set: { $0.fraction = $1 }, pointer: TermKit.ProgressBar.self)
    var fraction: Float = 0

    /// Initialize a progress bar.
    /// - Parameters:
    ///     - value: The current value.
    ///     - max: The maximum value.
    public init(value: Double, max: Double = 1) {
        self.fraction = .init(value / max)
    }

    /// Get the widget.
    /// - Returns: The widget.
    public func initializeWidget() -> Sendable {
        TermKit.ProgressBar()
    }

}
