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

/// Represents the HTML `colspan` attribute, which specifies the number of columns a table cell should span.
///
/// Uses `Geometry<Int>.Width` as the underlying type since colspan represents a horizontal span.
///
/// ## Usage Notes
///
/// - Use this attribute with `<th>` and `<td>` elements to create cells that span multiple columns
/// - The value must be a positive integer
/// - Default value is 1 if not specified
///
/// ## Examples
///
/// ```swift
/// let colSpan: ColSpan = 2
/// td.colspan(colSpan)
/// ```
///
/// ```html
/// <td colspan="2">Cell spans two columns</td>
/// ```

extension Geometry<Int>.Width {
    /// A wrapper to use Geometry<Int>.Width as an HTML colspan attribute.
    ///
    /// Since colspan represents horizontal spanning across columns,
    /// it semantically aligns with width.
    public struct Span: WHATWG_HTML.StringAttribute {
        /// The underlying width value representing column span count
        public var width: Geometry<Int>.Width

        /// The name of the HTML attribute
        @inlinable public static var attribute: String { "colspan" }

        /// The raw string value
        @inlinable public var rawValue: String { String(width.value) }

        /// Initialize with a width value
        @inlinable public init(_ width: Geometry<Int>.Width) { self.width = width }

        /// Initialize with a string value
        @inlinable public init(value: String) { self.width = Geometry<Int>.Width(Int(value) ?? 1) }

        /// Initialize with an integer value
        @inlinable public init(_ value: Int) { self.width = Geometry<Int>.Width(value) }
    }
}

extension Geometry<Int>.Width.Span: ExpressibleByIntegerLiteral {
    @inlinable public init(integerLiteral value: IntegerLiteralType) { self.init(value) }
}

extension Geometry<Int>.Width.Span: CustomStringConvertible {
    @inlinable public var description: String { rawValue }
}

extension Geometry<Int>.Width.Span: Sendable {}
extension Geometry<Int>.Width.Span: Equatable {}
extension Geometry<Int>.Width.Span: Hashable {}

/// Typealias for convenience - use `ColSpan` as shorthand for `Geometry<Int>.Width.Span`
public typealias ColSpan = Geometry<Int>.Width.Span
