//
//  ZStack.swift
//  TermKitBackend
//
//  Created by david-swift on 06.07.2024.
//

import TermKit

/// Arrange multiple views behind each other.
public struct ZStack: Wrapper, TermKitWidget {

    /// The content.
    var content: Body

    /// Initialize the container.
    /// - Parameter content: The content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content()
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    public func container<Storage>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Storage.Type
    ) -> ViewStorage where Storage: AppStorage {
        let storages = content.reversed().storages(modifiers: modifiers, type: type)
        if storages.count == 1 {
            return .init(storages[0].pointer, content: [.mainContent: storages])
        }
        let view = View()
        for storage in storages {
            if let pointer = storage.pointer as? TermKit.View {
                view.addSubview(pointer)
            }
        }
        return .init(view, content: [.mainContent: storages])
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
        guard let storages = storage.content[.mainContent] else {
            return
        }
        content.reversed().update(storages, modifiers: modifiers, updateProperties: updateProperties, type: type)
    }

}
