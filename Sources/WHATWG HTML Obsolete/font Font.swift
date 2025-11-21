// font Font.swift
// WHATWG HTML Obsolete
//
// Defines the font element (<font>)

public import WHATWG_HTML_Shared
public import WHATWG_HTML_GlobalAttributes

/// Represents the obsolete `<font>` element that specified font properties.
///
/// **Deprecated**: Use CSS instead.
@available(*, deprecated, message: "Use CSS for font styling instead.")
public struct Font: WHATWG_HTML.Element {
    @inlinable
    public static var tag: String { "font" }

    /// The color of the text
    public var color: Color?

    /// The font face to use
    public var face: Face?

    /// The font size
    public var size: FontSize?

    public init(
        color: Color? = nil,
        face: Face? = nil,
        size: FontSize? = nil
    ) {
        self.color = color
        self.face = face
        self.size = size
    }
}
