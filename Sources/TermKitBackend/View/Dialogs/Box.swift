//
//  Box.swift
//  TermKitBackend
//
//  Created by david-swift on 10.07.2024.
//

import TermKit

/// A dialog box, either a query, error, or info box.
struct Box: TermKitWidget {

    /// The title.
    var title: String
    /// The message.
    var message: String
    /// The signal.
    var signal: Signal
    /// The buttons (info box if none).
    var buttons: [Button]
    /// The content behind the box.
    var content: AnyView
    /// Whether it is an error box.
    var error = false

    /// The identifier for the buttons of a box.
    let boxButtonsID = "box-buttons"

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    func container<Storage>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Storage.Type
    ) -> ViewStorage where Storage: AppStorage {
        let storage = ViewStorage(nil)
        let contentStorage = content.storage(modifiers: modifiers, type: type)
        storage.pointer = contentStorage.pointer
        storage.content = [.mainContent: [contentStorage]]
        storage.fields[boxButtonsID] = buttons
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    func update<Storage>(
        _ storage: ViewStorage,
        modifiers: [(any AnyView) -> any AnyView],
        updateProperties: Bool,
        type: Storage.Type
    ) where Storage: AppStorage {
        guard let storage = storage.content[.mainContent]?.first else {
            return
        }
        content.updateStorage(storage, modifiers: modifiers, updateProperties: updateProperties, type: type)
        storage.fields[boxButtonsID] = buttons
        if signal.update {
            if buttons.isEmpty {
                MessageBox.info(title, message: message)
            } else if error {
                MessageBox.error(title, message: message, buttons: buttons.map { $0.label }) { selection in
                    (storage.fields[boxButtonsID] as? [Button])?[safe: selection]?.action()
                }
            } else {
                MessageBox.query(title, message: message, buttons: buttons.map { $0.label }) { selection in
                    (storage.fields[boxButtonsID] as? [Button])?[safe: selection]?.action()
                }
            }
        }
    }

}

extension AnyView {

    /// Add a query box.
    /// - Parameters:
    ///     - title: The title.
    ///     - message: The message.
    ///     - signal: The box appears when the signal is emitted.
    ///     - buttons: The buttons.
    /// - Returns: The view.
    public func queryBox(
        _ title: String,
        message: String,
        signal: Signal,
        @Builder<Button> buttons: @escaping () -> [Button]
    ) -> AnyView {
        Box(title: title, message: message, signal: signal, buttons: buttons(), content: self)
    }

    /// Add an error box.
    /// - Parameters:
    ///     - title: The title.
    ///     - message: The message.
    ///     - signal: The box appears when the signal is emitted.
    ///     - buttons: The buttons.
    /// - Returns: The view.
    public func errorBox(
        _ title: String,
        message: String,
        signal: Signal,
        @Builder<Button> buttons: @escaping () -> [Button]
    ) -> AnyView {
        Box(title: title, message: message, signal: signal, buttons: buttons(), content: self, error: true)
    }

    /// Add an info box.
    /// - Parameters:
    ///     - title: The title.
    ///     - message: The message.
    ///     - signal: The box appears when the signal is emitted.
    /// - Returns: The view.
    public func infoBox(_ title: String, message: String, signal: Signal) -> AnyView {
        Box(title: title, message: message, signal: signal, buttons: [], content: self)
    }

}
