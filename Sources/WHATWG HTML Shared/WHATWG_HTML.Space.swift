//
//  WHATWG_HTML.Space.swift
//  swift-whatwg-html
//
//  HTML coordinate space marker for typed geometry operations.
//

/// HTML coordinate space marker.
///
/// HTML uses a coordinate system where:
/// - Origin (0,0) is at the top-left corner
/// - X-axis increases to the right
/// - Y-axis increases downward
/// - Dimensions are typically in CSS pixels (integers)
///
/// This space marker enables typed geometry operations that distinguish
/// between different coordinate systems.
extension WHATWG_HTML {
    /// HTML coordinate space marker.
    public enum Space {}
}
