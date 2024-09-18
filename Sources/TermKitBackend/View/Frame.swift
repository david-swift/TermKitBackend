//
//  Frame.swift
//  TermKitBackend
//
//  Created by david-swift on 06.07.2024.
//

import TermKit

/// A container which draws a frame around its contents.
public struct Frame: TermKitWidget {

    /// The frame's label.
    @Property(set: { $0.title = $1 }, pointer: TermKit.Frame.self)
    var label: String?
    /// The content.
    @ViewProperty(set: { $0.addSubview($1) }, pointer: TermKit.Frame.self, subview: TermKit.View.self)
    var view: Body

    /// Initialize a frame.
    /// - Parameters:
    ///     - label: The frame's label.
    ///     - content: The content.
    public init(_ label: String? = nil, @ViewBuilder content: @escaping () -> Body) {
        self.view = content()
        self.label = label
    }

    /// Get the widget.
    /// - Returns: The widget.
    public func initializeWidget() -> Any {
        TermKit.Frame()
    }

}
