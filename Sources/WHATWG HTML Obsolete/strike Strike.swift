// strike Strike.swift
// WHATWG HTML Obsolete
//
// Defines the strike element (<strike>)

public import WHATWG_HTML_Shared

/// Represents the obsolete `<strike>` element that renders strikethrough text.
///
/// **Deprecated**: Use `<s>` for generic strikethrough or `<del>` for deleted text.
@available(*, deprecated, message: "Use <s> for generic strikethrough or <del> for deleted text.")
public struct Strike: WHATWG_HTML.Element {
    @inlinable
    public static var tag: String { "strike" }

    public init() {}
}
