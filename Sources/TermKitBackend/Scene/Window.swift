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
        let storage = SceneStorage(id: id, pointer: win) {
            win.ensureFocus()
        }
        let viewStorage = content.storage(
            data: .init(sceneStorage: storage, appStorage: app),
            type: TermKitMainView.self
        )
        if let pointer = viewStorage.pointer as? TermKit.View {
            win.addSubview(pointer)
        }
        storage.content = [.mainContent: [viewStorage]]
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - app: The app storage.
    ///     - updateProperties: Whether to update the view's properties.
    public func update<Storage>(
        _ storage: SceneStorage,
        app: Storage,
        updateProperties: Bool
    ) where Storage: AppStorage {
        guard let viewStorage = storage.content[.mainContent]?.first else {
            return
        }
        content
            .updateStorage(
                viewStorage,
                data: .init(sceneStorage: storage, appStorage: app),
                updateProperties: updateProperties,
                type: TermKitMainView.self
            )
        Application.refresh()
    }

    /// Add a menubar to the app.
    /// - Parameter content: The mnu bar's content.
    @SceneBuilder
    public func menuBar(@ViewBuilder content: @escaping () -> Body) -> Scene {
        self
        MenuBar(content: content)
    }

}
