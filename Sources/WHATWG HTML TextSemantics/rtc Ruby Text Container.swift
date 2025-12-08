// rtc Ruby Text Container.swift
// WHATWG HTML TextSemantics
//
// Defines the ruby text container element (<rtc>)

public import WHATWG_HTML_Shared

/// Represents the `<rtc>` element that contains semantic annotations for ruby base text.
///
/// Note: The `<rtc>` element is not part of the WHATWG HTML Living Standard
/// but is included for compatibility with complex ruby annotation implementations.
public struct RubyTextContainer: WHATWG_HTML.Element.`Protocol` {
    @inlinable
    public static var tag: String { "rtc" }

    public init() {}
}
