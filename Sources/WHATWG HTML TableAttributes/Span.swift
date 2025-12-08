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

/// An attribute that specifies the number of columns a `<col>` or `<colgroup>` element should span.
///
/// Uses `Geometry<Int>.Width` as the underlying type since span represents horizontal column count.
///
/// The `span` attribute defines the number of consecutive columns the element spans.
/// This attribute is primarily used with `<col>` and `<colgroup>` elements to define
/// properties for a group of columns in a table.
///
/// ## Usage Notes
///
/// - Used with `<col>` and `<colgroup>` elements in tables
/// - Value must be a positive integer greater than 0
/// - Default value is 1 if not specified
/// - In `<colgroup>`, the `span` attribute specifies how many columns the group contains
/// - In `<col>`, the `span` attribute specifies how many consecutive columns should share the same properties
///
/// ## Best Practices
///
/// - Use `span` to efficiently apply styles to multiple table columns
/// - For complex layouts, consider using individual `<col>` elements for more precise control
/// - Verify the total columns spanned matches the actual table structure
///
/// ## Examples
///
/// ```swift
/// let span: Span = 3
/// col.span(span)
/// ```
///
/// ```html
/// <col span="3" style="background-color: yellow;" />
/// ```

extension Geometry<Int>.Width {
    /// A wrapper to use Geometry<Int>.Width as an HTML span attribute for col/colgroup elements.
    ///
    /// Since span on col/colgroup represents the number of columns (horizontal),
    /// it semantically aligns with width.
    public struct ColumnSpan: WHATWG_HTML.StringAttribute {
        /// The underlying width value representing column count
        public var width: Geometry<Int>.Width

        /// The name of the HTML attribute
        @inlinable public static var attribute: String { "span" }

        /// The raw string value
        @inlinable
        public var rawValue: String { String(width.value) }

        /// Initialize with a width value
        @inlinable
        public init(_ width: Geometry<Int>.Width) {
            precondition(width.value > 0, "Span value must be a positive integer")
            self.width = width
        }

        /// Initialize with a string value
        @inlinable
        public init(value: String) {
            let intValue = Int(value) ?? 1
            precondition(intValue > 0, "Span value must be a positive integer")
            self.width = Geometry<Int>.Width(intValue)
        }

        /// Initialize with an integer value
        @inlinable
        public init(_ value: Int) {
            precondition(value > 0, "Span value must be a positive integer")
            self.width = Geometry<Int>.Width(value)
        }
    }
}

extension Geometry<Int>.Width.ColumnSpan: ExpressibleByIntegerLiteral {
    @inlinable
    public init(integerLiteral value: IntegerLiteralType) {
        precondition(value > 0, "Span value must be a positive integer")
        self.init(value)
    }
}

extension Geometry<Int>.Width.ColumnSpan: CustomStringConvertible {
    @inlinable
    public var description: String { rawValue }
}

extension Geometry<Int>.Width.ColumnSpan: Sendable {}
extension Geometry<Int>.Width.ColumnSpan: Equatable {}
extension Geometry<Int>.Width.ColumnSpan: Hashable {}

/// Typealias for convenience - use `Span` as shorthand for `Geometry<Int>.Width.ColumnSpan`
public typealias Span = Geometry<Int>.Width.ColumnSpan
