//
//  NotUpdatableEitherView.swift
//  TermKitBackend
//
//  Created by david-swift on 25.08.2024.
//

/// An either view for views which do not support updating.
public struct NotUpdatableEitherView: SimpleView, Meta.EitherView {

    /// The content.
    public var view: Body

    /// Initialize the either view.
    /// - Parameters:
    ///   - condition: The condition.
    ///   - view1: The first view.
    ///   - view2: The other view.
    public init(_ condition: Bool, view1: () -> Body, else view2: () -> Body) {
        self.view = condition ? view1() : view2()
    }

}
