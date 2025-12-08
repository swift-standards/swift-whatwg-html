// center Centered Text.swift
// WHATWG HTML Obsolete
//
// Defines the center element (<center>)

public import WHATWG_HTML_Shared

/// Represents the `<center>` element for centering text horizontally (obsolete).
///
/// The `<center>` element is deprecated in HTML5. Use CSS `text-align: center` instead.
public struct Center: WHATWG_HTML.Element.`Protocol` {
    @inlinable
    public static var tag: String { "center" }

    public init() {}
}
