//
//  Window.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

import TermKit

/// The window scene elements holds views.
public struct Window: TermKitSceneElement {

    /// The identifier of the window.
    public var id: String
    /// The title of the window.
    var title: String?
    /// The window's content.
    var content: Body

    /// Initialize a window.
    /// - Parameters:
    ///     - title: The title of the window.
    ///     - id: The identifier of the window.
    ///     - content: The window's content.
    public init(_ title: String? = nil, id: String = "main", @ViewBuilder content: () -> Body) {
        self.id = id
        self.title = title
        self.content = content()
    }

    /// Set up the initial scene storages.
    /// - Parameter app: The app storage.
    public func setupInitialContainers<Storage>(app: Storage) where Storage: AppStorage {
        app.storage.sceneStorage.append(container(app: app))
    }

    /// The scene storage.
    /// - Parameter app: The app storage.
    public func container<Storage>(app: Storage) -> SceneStorage where Storage: AppStorage {
        let win = TermKit.Window(title)
        win.fill()
        Application.top.addSubview(win)
        let viewStorage = content.storage(modifiers: [], type: Storage.self)
        if let pointer = viewStorage.pointer as? TermKit.View {
            win.addSubview(pointer)
        }
        return .init(id: id, pointer: win, content: [.mainContent: [viewStorage]]) {
            win.ensureFocus()
        }
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - updateProperties: Whether to update the view's properties.
    public func update<Storage>(
        _ storage: SceneStorage,
        app: Storage,
        updateProperties: Bool
    ) where Storage: AppStorage {
        guard let viewStorage = storage.content[.mainContent]?.first else {
            return
        }
        content.updateStorage(viewStorage, modifiers: [], updateProperties: updateProperties, type: Storage.self)
        Application.refresh()
    }

}
