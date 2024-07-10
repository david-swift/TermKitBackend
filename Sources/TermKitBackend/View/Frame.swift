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
    public func container<Storage>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Storage.Type
    ) -> ViewStorage where Storage: AppStorage {
        let frame = TermKit.Frame(label)
        let subview = view.storage(modifiers: modifiers, type: type)
        if let pointer = subview.pointer as? TermKit.View {
            frame.addSubview(pointer)
        }
        return .init(frame, content: [.mainContent: [subview]])
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
        if let storage = storage.content[.mainContent]?.first {
            view.updateStorage(storage, modifiers: modifiers, updateProperties: updateProperties, type: type)
        }
        guard let storage = storage.pointer as? TermKit.Frame, updateProperties else {
            return
        }
        storage.title = label
    }

}
