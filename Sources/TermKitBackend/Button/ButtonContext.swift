//
//  ButtonContext.swift
//  TermKitBackend
//
//  Created by david-swift on 18.07.2024.
//

import TermKit

/// The menu items view context.
public enum ButtonContext: ViewRenderData {

    /// The type of the widgets.
    public typealias WidgetType = Widget
    /// The wrapper type.
    public typealias WrapperType = ButtonCollection

    /// The type of the widgets.
    public protocol Widget: Meta.Widget { }

}
