//
//  ZStack.swift
//  TermKitBackend
//
//  Created by david-swift on 06.07.2024.
//

@preconcurrency import TermKit

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
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) async -> ViewStorage where Data: ViewRenderData {
        let storages = await content.reversed().storages(data: data, type: type)
        if storages.count == 1 {
            return await .init(storages[0].pointer, content: [.mainContent: storages])
        }
        let view = View()
        for storage in storages {
            if let pointer = await storage.pointer as? TermKit.View {
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
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) async where Data: ViewRenderData {
        let storages = await storage.getContent(key: .mainContent)
        await content.reversed().update(storages, data: data, updateProperties: updateProperties, type: type)
    }

}
