//
//  EitherView.swift
//  TermKitBackend
//
//  Created by david-swift on 25.08.2024.
//

import TermKit

/// A container which draws a frame around its contents.
public struct EitherView: TermKitWidget, Meta.EitherView {

    /// The condition.
    var condition: Bool
    /// The first view.
    var view1: Body
    /// The second view.
    var view2: Body

    /// Initialize an either view.
    /// - Parameters:
    ///   - condition: The condition.
    ///   - view1: The first view.
    ///   - view2: The second view.
    public init(_ condition: Bool, @ViewBuilder view1: () -> Body, @ViewBuilder else view2: () -> Body) {
        self.condition = condition
        self.view1 = view1()
        self.view2 = view2()
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let view = TermKit.View()
        let storage = ViewStorage(view)
        update(storage, data: data, updateProperties: true, type: type)
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
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        guard let parent = storage.pointer as? TermKit.View else {
            return
        }
        let view: TermKit.View?
        let body = condition ? view1 : view2
        if let content = storage.content[condition.description]?.first {
            body.updateStorage(content, data: data, updateProperties: updateProperties, type: type)
            view = content.pointer as? TermKit.View
        } else {
            let content = body.storage(data: data, type: type)
            storage.content[condition.description] = [content]
            view = content.pointer as? TermKit.View
        }
        if let view, (storage.previousState as? Self)?.condition != condition {
            parent.removeAllSubviews()
            parent.addSubview(view)
        }
        storage.previousState = self
    }

}
