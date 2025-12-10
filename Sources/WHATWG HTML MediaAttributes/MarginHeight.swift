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

public import Geometry
public import WHATWG_HTML_Shared

// Required protocol conformances for StringAttribute
/// Extends `Geometry<Int>.Height` to serve as an HTML marginheight attribute.
///
/// The `marginheight` attribute specifies the vertical margin for frame elements.
/// This is a legacy attribute primarily used with `<iframe>` elements.
///
/// ## Usage Notes
///
/// - Used on `<iframe>` elements (legacy)
/// - Specifies vertical margin in CSS pixels
/// - Consider using CSS `padding` or `margin` instead for modern applications
///
/// ## Examples
///
/// ```swift
/// let marginHeight: MarginHeight = 10
/// iframe.marginheight(marginHeight)
/// ```
extension Geometry<Int>.Height {
    /// A wrapper to use Geometry<Int>.Height as an HTML marginheight attribute
    public struct Margin: WHATWG_HTML.StringAttribute {
        /// The underlying height value
        public var height: Geometry<Int>.Height

        /// The name of the HTML attribute
        @inlinable public static var attribute: String { "marginheight" }

        /// The raw string value
        @inlinable
        public var rawValue: String { String(height.value) }

        /// Initialize with a height value
        @inlinable
        public init(_ height: Geometry<Int>.Height) {
            self.height = height
        }

        /// Initialize with a string value
        @inlinable
        public init(value: String) {
            self.height = Geometry<Int>.Height(Int(value) ?? 0)
        }

        /// Initialize with an integer value
        @inlinable
        public init(_ value: Int) {
            self.height = Geometry<Int>.Height(value)
        }
    }
}

extension Geometry<Int>.Height.Margin: ExpressibleByIntegerLiteral {
    @inlinable
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

extension Geometry<Int>.Height.Margin: Sendable {}
extension Geometry<Int>.Height.Margin: Equatable {}
extension Geometry<Int>.Height.Margin: Hashable {}

/// Typealias for convenience - use `MarginHeight` as shorthand for `Geometry<Int>.Height.Margin`
public typealias MarginHeight = Geometry<Int>.Height.Margin
