// marquee Marquee.swift
// WHATWG HTML Obsolete
//
// Defines the marquee element (<marquee>)

public import WHATWG_HTML_Shared
public import WHATWG_HTML_GlobalAttributes
public import WHATWG_HTML_MediaAttributes

/// Represents the obsolete `<marquee>` element that created scrolling text.
///
/// **Deprecated**: Use CSS animations instead.
@available(*, deprecated, message: "Use CSS animations instead.")
public struct Marquee: WHATWG_HTML.Element {
    @inlinable
    public static var tag: String { "marquee" }

    public var behavior: Behavior?
    public var bgcolor: String?
    public var direction: Direction?
    public var height: Height?
    public var hspace: String?
    public var loop: Loop?
    public var scrollamount: String?
    public var scrolldelay: String?
    public var truespeed: Truespeed?
    public var vspace: String?
    public var width: Width?

    public init(
        behavior: Behavior? = nil,
        bgcolor: String? = nil,
        direction: Direction? = nil,
        height: Height? = nil,
        hspace: String? = nil,
        loop: Loop? = nil,
        scrollamount: String? = nil,
        scrolldelay: String? = nil,
        truespeed: Truespeed? = nil,
        vspace: String? = nil,
        width: Width? = nil
    ) {
        self.behavior = behavior
        self.bgcolor = bgcolor
        self.direction = direction
        self.height = height
        self.hspace = hspace
        self.loop = loop
        self.scrollamount = scrollamount
        self.scrolldelay = scrolldelay
        self.truespeed = truespeed
        self.vspace = vspace
        self.width = width
    }
}
