// rt Ruby Text.swift
// WHATWG HTML TextSemantics
//
// Defines the ruby text element (<rt>)

public import WHATWG_HTML_Shared

/// Represents the `<rt>` element that specifies the ruby text component of a ruby annotation.
///
/// The `<rt>` element contains pronunciation or translation information for the base text.
public struct RubyText: WHATWG_HTML.Element {
    @inlinable
    public static var tag: String { "rt" }

    public init() {}
}
