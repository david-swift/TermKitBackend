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
    @Property(set: { $0.text = $1 }, pointer: TermKit.Label.self)
    var label = ""

    /// Initialize a label.
    /// - Parameter label: The label.
    public init(_ label: String) {
        self.label = label
    }

    /// Get the widget.
    /// - Returns: The widget.
    public func initializeWidget() -> Any {
        TermKit.Label(label)
    }

}
