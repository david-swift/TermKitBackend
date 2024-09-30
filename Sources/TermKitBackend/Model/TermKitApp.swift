//
//  TermKitSceneElement.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

@_exported import Meta
@preconcurrency import TermKit

/// The Meta app storage for the TermKit backend.
public actor TermKitApp: AppStorage {

    /// The scene element type of the TermKit backend.
    public typealias SceneElementType = TermKitSceneElement
    /// The widget type of the TermKit backend.
    public typealias WidgetType = TermKitWidget
    /// The wrapper type of the TermKit backend.
    public typealias WrapperType = VStack

    /// The app storage.
    public var storage: StandardAppStorage = .init()

    /// Initialize the app storage.
    /// - Parameter id: The identifier.
    public init(id: String) { }

    /// Execute the app.
    /// - Parameter setup: Set the scene elements up.
    nonisolated public func run(setup: @Sendable @escaping () -> Void) {
        Application.prepare()
        setup()
        Application.run()
    }

    /// Quit the app.
    nonisolated public func quit() {
        Application.shutdown()
    }

}
