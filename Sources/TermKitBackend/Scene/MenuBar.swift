//
//  MenuBar.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

@preconcurrency import TermKit

/// The menu bar scene element adds a menu bar to the top of the app.
struct MenuBar: TermKitSceneElement {

    /// The identifier of the menu bar.
    var id: String
    /// The menu bar's content.
    var content: Body

    /// Initialize the menu bar.
    /// - Parameters:
    ///     - id: The identifier of the menu bar.
    ///     - content: The menu bar's content.
    init(id: String = "main-menu", @ViewBuilder content: () -> Body) {
        self.id = id
        self.content = content()
    }

    /// Set up the initial scene storages.
    /// - Parameter app: The app storage.
    func setupInitialContainers<Storage>(app: Storage) where Storage: AppStorage {
        Task {
            await app.appendScene(container(app: app))
        }
    }

    /// The scene storage.
    /// - Parameter app: The app storage.
    func container<Storage>(app: Storage) -> SceneStorage where Storage: AppStorage {
        let storage = SceneStorage(id: id, pointer: nil) { }
        Task {
            let items = await MenuCollection { content }.container(
                data: .init(sceneStorage: storage, appStorage: app),
                type: MenuContext.self
            )
            let menubar = TermKit.MenuBar(
                menus: await items.pointer as? [TermKit.MenuBarItem] ?? []
            )
            for element in Application.top.subviews {
                element.y = .bottom(of: menubar)
            }
            Application.top.addSubview(menubar)
            await storage.setPointer(menubar)
            await storage.setShow {
                menubar.ensureFocus()
            }
        }
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - app: The app storage.
    ///     - updateProperties: Whether to update the view's properties.
    func update<Storage>(
        _ storage: SceneStorage,
        app: Storage,
        updateProperties: Bool
    ) where Storage: AppStorage { }

}
