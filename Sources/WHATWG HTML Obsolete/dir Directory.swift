// dir Directory.swift
// WHATWG HTML Obsolete
//
// Defines the directory element (<dir>)

public import WHATWG_HTML_GlobalAttributes
public import WHATWG_HTML_Shared

/// Represents the obsolete `<dir>` element that was used for directory listings.
///
/// **Deprecated**: Use `<ul>` instead.
@available(*, deprecated, message: "Use <ul> instead.")
public struct Directory: WHATWG_HTML.Element.`Protocol` {
    @inlinable public static var tag: String { "dir" }

    /// Boolean attribute that hints the list should be rendered in a compact style
    public var compact: Compact?

    public init(compact: Compact? = nil) { self.compact = compact }
}
