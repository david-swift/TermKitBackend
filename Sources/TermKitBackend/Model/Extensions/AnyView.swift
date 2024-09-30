//
//  AnyView.swift
//  TermKitBackend
//
//  Created by david-swift on 07.07.2024.
//

@preconcurrency import TermKit

/// Extend `AnyView`.
extension AnyView {

    /// Set a view's width and height.
    /// - Parameters:
    ///     - width: The width.
    ///     - height: The height.
    /// - Returns: The view.
    public func frame(width: Int? = nil, height: Int? = nil) -> AnyView {
        inspect { storage, updateProperties in
            guard updateProperties, let pointer = await storage.pointer as? TermKit.View else {
                return
            }
            pointer.set(x: nil, y: nil, width: width, height: height)
        }
    }

    /// Center a view vertically.
    /// - Parameter center: Whether to center the view.
    /// - Returns: The view.
    public func vcenter(_ center: Bool = true) -> AnyView {
        inspect { storage, updateProperties in
            guard updateProperties, let pointer = await storage.pointer as? TermKit.View else {
                return
            }
            pointer.y = center ? .center() : nil
        }
    }

    /// Center a view horizontally.
    /// - Parameter center: Whether to center the view.
    /// - Returns: The view.
    public func hcenter(_ center: Bool = true) -> AnyView {
        inspect { storage, updateProperties in
            guard updateProperties, let pointer = await storage.pointer as? TermKit.View else {
                return
            }
            pointer.x = center ? .center() : nil
        }
    }

}
