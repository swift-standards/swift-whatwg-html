//
//  HTML.swift
//  swift-whatwg-html
//
//  User-facing namespace for HTML geometry types.
//
//  RECOMMENDED: Use the HTML namespace for geometry types:
//  - HTML.Width, HTML.Height for element dimensions
//  - HTML.Rectangle for element bounds
//  - HTML.Point for coordinates
//

// Note: We don't use @_exported to avoid polluting the namespace.
// Users who need Geometry types can access them through HTML.* or import Geometry directly.
public import Geometry

// MARK: - HTML Namespace

/// User-facing namespace for HTML geometry types.
///
/// HTML element dimensions are typically expressed as integer pixel values.
/// This namespace provides geometry types backed by `Geometry<Int, WHATWG_HTML.Space>`.
public enum HTML {}

// MARK: - Space Type Alias

extension HTML {
    /// HTML coordinate space geometry with integer scalar type.
    ///
    /// HTML dimensions are typically integers representing CSS pixels.
    public typealias Space = Geometry<Int, WHATWG_HTML.Space>
}

// MARK: - Dimension Type Aliases

extension HTML {
    /// Width in HTML space (CSS pixels).
    public typealias Width = Space.Width

    /// Height in HTML space (CSS pixels).
    public typealias Height = Space.Height

    /// A 2D point in HTML coordinate space.
    public typealias Point = Space.Point<2>

    /// A rectangle in HTML coordinate space.
    public typealias Rectangle = Space.Rectangle
}

// MARK: - Double-Precision Geometry

extension HTML {
    /// HTML coordinate space geometry with double-precision scalar type.
    ///
    /// Use this for sub-pixel precision when needed (e.g., animations, transforms).
    public typealias DoubleSpace = Geometry<Double, WHATWG_HTML.Space>

    /// A 2D point with sub-pixel precision.
    public typealias DoublePoint = DoubleSpace.Point<2>

    /// A rectangle with sub-pixel precision.
    public typealias DoubleRectangle = DoubleSpace.Rectangle
}
