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
/// Extends `Geometry<Int>.Height` to serve as an HTML height attribute.
///
/// The `height` attribute defines the height of an element in pixels (for images, videos, and similar)
/// or in other units when combined with CSS. It is primarily used with media elements to ensure proper
/// layout before the media is loaded, preventing layout shifts.
///
/// ## Usage Notes
///
/// - Common on `<img>`, `<input type="image">`, `<video>`, `<canvas>`, and `<iframe>` elements
/// - For images, specifies the intrinsic height in CSS pixels
/// - For canvas, specifies the height in CSS pixels for the coordinate system
/// - Using both height and width helps prevent layout shifts during page load
///
/// ## Examples
///
/// ```swift
/// let height: Geometry<Int>.Height = 300
/// img.height(height)
///
/// // Or directly with integer literal
/// img.height(300)
/// ```
extension Geometry<Int>.Height: @retroactive ExpressibleByUnicodeScalarLiteral {
    @inlinable
    public init(unicodeScalarLiteral value: String) {
        self.init(Int(value) ?? 0)
    }
}

extension Geometry<Int>.Height: @retroactive ExpressibleByExtendedGraphemeClusterLiteral {
    @inlinable
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(Int(value) ?? 0)
    }
}

extension Geometry<Int>.Height: @retroactive ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral value: String) {
        self.init(Int(value) ?? 0)
    }
}

extension Geometry<Int>.Height: @retroactive ExpressibleByStringInterpolation {}

extension Geometry<Int>.Height: @retroactive CustomStringConvertible {
    @inlinable
    public var description: String { String(value) }
}

extension Geometry<Int>.Height: @retroactive RawRepresentable {
    @inlinable
    public var rawValue: String { String(value) }

    @inlinable
    public init?(rawValue: String) {
        guard let intValue = Int(rawValue) else { return nil }
        self.init(intValue)
    }
}

extension Geometry<Int>.Height: WHATWG_HTML.Attribute {
    /// The name of the HTML attribute
    @inlinable
    public static var attribute: String { "height" }
}

extension Geometry<Int>.Height: WHATWG_HTML.StringAttribute {
    /// Initialize with a string value
    @inlinable
    public init(value: String) {
        self.init(Int(value) ?? 0)
    }
}

/// Typealias for convenience - use `Height` as shorthand for `Geometry<Int>.Height`
public typealias Height = Geometry<Int>.Height
