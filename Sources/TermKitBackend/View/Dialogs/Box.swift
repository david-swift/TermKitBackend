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
    var buttons: Body
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
    /// - Returns: The view storage.
    func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(nil)
        let contentStorage = content.storage(data: data, type: type)
        storage.pointer = contentStorage.pointer
        return .init(contentStorage.pointer, content: [.mainContent: [contentStorage]])
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        guard let storage = storage.content[.mainContent]?.first else {
            return
        }
        content.updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        let buttons = ButtonCollection { self.buttons }
            .storage(data: data, type: ButtonContext.self).pointer as? [Button] ?? []
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

/// Extend `AnyView`,
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
        @ViewBuilder buttons: @escaping () -> Body
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
        @ViewBuilder buttons: @escaping () -> Body
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
