//
//  MenuBar.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

import TermKit

/// The menu bar scene element adds a menu bar to the top of the app.
public struct MenuBar: TermKitSceneElement {

    /// The identifier of the menu bar.
    public var id: String
    /// The menu bar's content.
    var content: [Menu]

    /// Initialize the menu bar.
    /// - Parameters:
    ///     - id: The identifier of the menu bar.
    ///     - content: The menu bar's content.
    public init(id: String = "main-menu", @Builder<Menu> content: () -> [Menu]) {
        self.id = id
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
        let menubar = TermKit.MenuBar(
            menus: content.compactMap { $0.container(type: Menu.self, fields: [:]).pointer as? MenuBarItem }
        )
        Task {
            for element in Application.top.subviews {
                element.y = .bottom(of: menubar)
            }
            Application.top.addSubview(menubar)
        }
        return .init(id: id, pointer: menubar) {
            menubar.ensureFocus()
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
        Application.refresh()
    }

}
