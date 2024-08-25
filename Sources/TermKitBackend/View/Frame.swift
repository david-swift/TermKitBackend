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
    var label: String?
    /// The content.
    var view: Body

    /// Initialize a frame.
    /// - Parameters:
    ///     - label: The frame's label.
    ///     - content: The content.
    public init(_ label: String? = nil, @ViewBuilder content: @escaping () -> Body) {
        self.label = label
        self.view = content()
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
        let frame = TermKit.Frame(label)
        let subview = view.storage(modifiers: modifiers, type: type)
        if let pointer = subview.pointer as? TermKit.View {
            frame.addSubview(pointer)
        }
        return .init(frame, content: [.mainContent: [subview]], state: self)
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
        if let storage = storage.content[.mainContent]?.first {
            view.updateStorage(storage, modifiers: modifiers, updateProperties: updateProperties, type: type)
        }
        guard let pointer = storage.pointer as? TermKit.Frame,
              updateProperties,
              (storage.previousState as? Self)?.label != label else {
            return
        }
        pointer.title = label
        storage.previousState = self
    }

}
