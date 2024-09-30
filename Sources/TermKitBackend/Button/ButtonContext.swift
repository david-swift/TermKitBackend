//
//  ButtonContext.swift
//  TermKitBackend
//
//  Created by david-swift on 18.07.2024.
//

@preconcurrency import TermKit

/// The menu items view context.
public enum ButtonContext: ViewRenderData {

    /// The type of the widgets.
    public typealias WidgetType = ButtonWidget
    /// The wrapper type.
    public typealias WrapperType = ButtonCollection
    /// The either view type.
    public typealias EitherViewType = NotUpdatableEitherView

}

/// The type of the widgets.
public protocol ButtonWidget: Meta.Widget { }
