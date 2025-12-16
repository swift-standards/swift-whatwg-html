//
//  HTML.Context.swift
//  swift-whatwg-html
//
//  Context wrappers that convert geometry types to HTML attribute strings.
//

import Geometry

// MARK: - HTML Geometry Conversion

/// Provides conversion utilities for HTML geometry types.
public enum HTMLGeometry {
    /// Convert a width value to an HTML attribute string.
    ///
    /// - Parameter width: The width in HTML space.
    /// - Returns: String representation for HTML attribute (e.g., "400").
    public static func attribute(width: HTML.Width) -> String {
        String(width._rawValue)
    }

    /// Convert a height value to an HTML attribute string.
    ///
    /// - Parameter height: The height in HTML space.
    /// - Returns: String representation for HTML attribute (e.g., "300").
    public static func attribute(height: HTML.Height) -> String {
        String(height._rawValue)
    }
}

// MARK: - Rectangle Context (Double precision)

/// Context wrapper for converting HTML rectangle to attribute strings.
public struct HTMLRectangleContext {
    let rectangle: Geometry<Double, WHATWG_HTML.Space>.Rectangle

    /// Initialize with a rectangle value.
    public init(_ rectangle: Geometry<Double, WHATWG_HTML.Space>.Rectangle) {
        self.rectangle = rectangle
    }

    /// Width attribute value (rounded to integer).
    public var width: String {
        String(Int(rectangle.width._rawValue))
    }

    /// Height attribute value (rounded to integer).
    public var height: String {
        String(Int(rectangle.height._rawValue))
    }
}

extension Geometry.Orthotope where N == 2, Space == WHATWG_HTML.Space, Scalar == Double {
    /// Access HTML-specific functionality for this rectangle.
    public var html: HTMLRectangleContext { HTMLRectangleContext(self) }
}
