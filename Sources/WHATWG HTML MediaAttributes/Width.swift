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

@_exported public import Geometry
public import WHATWG_HTML_Shared

// Required protocol conformances for StringAttribute
/// Extends `Geometry<Int>.Width` to serve as an HTML width attribute.
///
/// The `width` attribute defines the width of an element in pixels (for images, videos, and similar)
/// or in other units when combined with CSS. It is primarily used with media elements to ensure proper
/// layout before the media is loaded, preventing layout shifts.
///
/// ## Usage Notes
///
/// - Common on `<img>`, `<input type="image">`, `<video>`, `<canvas>`, and `<iframe>` elements
/// - For images, specifies the intrinsic width in CSS pixels
/// - For canvas, specifies the width in CSS pixels for the coordinate system
/// - Using both height and width helps prevent layout shifts during page load
///
/// ## Examples
///
/// ```swift
/// let width: Geometry<Int>.Width = 400
/// img.width(width)
///
/// // Or directly with integer literal
/// img.width(400)
/// ```
extension Geometry<Int>.Width: @retroactive ExpressibleByUnicodeScalarLiteral {
    @inlinable
    public init(unicodeScalarLiteral value: String) {
        self.init(Int(value) ?? 0)
    }
}

extension Geometry<Int>.Width: @retroactive ExpressibleByExtendedGraphemeClusterLiteral {
    @inlinable
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(Int(value) ?? 0)
    }
}

extension Geometry<Int>.Width: @retroactive ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral value: String) {
        self.init(Int(value) ?? 0)
    }
}

extension Geometry<Int>.Width: @retroactive ExpressibleByStringInterpolation {}

extension Geometry<Int>.Width: @retroactive CustomStringConvertible {
    @inlinable
    public var description: String { String(value) }
}

extension Geometry<Int>.Width: @retroactive RawRepresentable {
    @inlinable
    public var rawValue: String { String(value) }

    @inlinable
    public init?(rawValue: String) {
        guard let intValue = Int(rawValue) else { return nil }
        self.init(intValue)
    }
}

extension Geometry<Int>.Width: WHATWG_HTML.Attribute {
    /// The name of the HTML attribute
    @inlinable
    public static var attribute: String { "width" }
}

extension Geometry<Int>.Width: WHATWG_HTML.StringAttribute {
    /// Initialize with a string value
    @inlinable
    public init(value: String) {
        self.init(Int(value) ?? 0)
    }
}

/// Typealias for convenience - use `Width` as shorthand for `Geometry<Int>.Width`
public typealias Width = Geometry<Int>.Width
