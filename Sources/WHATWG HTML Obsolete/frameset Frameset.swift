// frameset Frameset.swift
// WHATWG HTML Obsolete
//
// Defines the frameset element (<frameset>)

public import WHATWG_HTML_Shared
public import WHATWG_HTML_TableAttributes

/// Represents the obsolete `<frameset>` element that contained a set of `<frame>` elements.
///
/// **Deprecated**: Use `<iframe>` and modern CSS layout instead.
@available(*, deprecated, message: "Use <iframe> and modern CSS layout instead.")
public struct Frameset: WHATWG_HTML.Element.`Protocol` {
    @inlinable public static var tag: String { "frameset" }

    /// Specifies the number and size of horizontal spaces in a frameset
    public var cols: Cols?

    /// Specifies the number and size of vertical spaces in a frameset
    public var rows: Rows?

    public init(cols: Cols? = nil, rows: Rows? = nil) {
        self.cols = cols
        self.rows = rows
    }
}
