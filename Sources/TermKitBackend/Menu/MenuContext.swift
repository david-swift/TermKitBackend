//
//  MenuContext.swift
//  TermKitBackend
//
//  Created by david-swift on 13.07.2024.
//

import TermKit

/// The menu items view context.
public enum MenuContext: ViewRenderData {

    /// The type of the widgets.
    public typealias WidgetType = Widget
    /// The wrapper type.
    public typealias WrapperType = MenuCollection

    /// The type of the widgets.
    public protocol Widget: Meta.Widget { }

}
