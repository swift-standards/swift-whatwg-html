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
    }
}

extension WHATWG_HTML.Element {
    /// Whether this element is a void element (self-closing)
    ///
    /// Void elements cannot have content and don't have closing tags.
    /// Examples: `<br>`, `<img>`, `<input>`, `<meta>`, etc.
    @inlinable public static var isVoid: Bool {
        Self.self is any WHATWG_HTML.VoidElement.Type
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
