// ===----------------------------------------------------------------------===//
//
// Copyright (c) 2025 Coen ten Thije Boonkkamp
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of project contributors
//
// SPDX-License-Identifier: Apache-2.0
//
// ===----------------------------------------------------------------------===//

extension WHATWG_HTML {
    /// Protocol for HTML elements
    ///
    /// Conforming types represent HTML elements as defined in the WHATWG HTML Living Standard.
    /// Each element has a unique tag name.
    ///
    /// ## Example
    ///
    /// ```swift
    /// extension WHATWG_HTML.Forms {
    ///     public struct Form: WHATWG_HTML.Element {
    ///         public static var tag: String { "form" }
    ///         // ...
    ///     }
    /// }
    /// ```
    public protocol Element: Sendable, Hashable {
        /// The HTML tag name for this element
        ///
        /// For example, `"div"`, `"form"`, `"input"`, etc.
        static var tag: String { get }
        static var flow: WHATWG_HTML.Flow { get }
        static var isVoid: Bool { get }
    }
}

extension WHATWG_HTML.Element {
    @inlinable public static var isVoid: Bool {
        WHATWG_HTML.isVoid(for: Self.tag)
    }
}

extension WHATWG_HTML.Element {
    @inlinable public static var flow: WHATWG_HTML.Flow {
        .init(Self.self)
    }
}

extension WHATWG_HTML {
    public enum Flow: String, Sendable, Hashable, Codable {
        case block
        case inline
    }
}

//extension Void {
//    public init<Element: WHATWG_HTML.Element>(
//        _ element: Element.Type
//    ){
//        switch Self.tag {
//        case "area", "base", "br", "col", "embed", "hr", "img", "input",
//            "link", "meta", "source", "track", "wbr":
//            return true
//        default:
//            return false
//        }
//    }
//}

extension WHATWG_HTML.Flow {
    /// Creates a Flow value for a typed element.
    public init<Element: WHATWG_HTML.Element>(
        _ element: Element.Type
    ) {
        self.init(for: Element.tag)
    }

    /// Creates a Flow value for a tag name string.
    /// Single source of truth for flow classification.
    public init(for tag: String) {
        switch tag {
        case "a", "abbr", "b", "bdi", "bdo", "br", "cite", "code", "data",
            "dfn", "em", "i", "kbd", "mark", "q", "rp", "rt", "ruby",
            "s", "samp", "small", "span", "strong", "sub", "sup", "time",
            "u", "var", "wbr",
            "button", "input", "label", "select", "textarea",
            "audio", "canvas", "embed", "iframe", "img", "object",
            "picture", "video",
            "script", "noscript", "slot", "template":
            self = .inline
        default:
            self = .block
        }
    }
}

extension WHATWG_HTML {
    /// Checks if a tag name represents a void element.
    /// Single source of truth for void element classification.
    @inlinable
    public static func isVoid(for tag: String) -> Bool {
        switch tag {
        case "area", "base", "br", "col", "embed", "hr", "img", "input",
            "link", "meta", "source", "track", "wbr":
            return true
        default:
            return false
        }
    }
}



extension WHATWG_HTML {
    /// Marker protocol for void (self-closing) HTML elements
    ///
    /// Void elements cannot have content and don't require closing tags.
    ///
    /// ## Void Elements
    ///
    /// - `<area>`, `<base>`, `<br>`, `<col>`, `<embed>`, `<hr>`, `<img>`,
    ///   `<input>`, `<link>`, `<meta>`, `<param>`, `<source>`, `<track>`, `<wbr>`
    public protocol VoidElement: Element {}
}
