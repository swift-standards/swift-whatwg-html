import Foundation

/// WHATWG HTML Living Standard namespace
///
/// This module provides namespace types for the WHATWG HTML Living Standard.
/// Parser implementations (e.g., swift-url-routing) extend these types to provide
/// parsing and printing functionality.
///
/// ## Reference
///
/// WHATWG HTML Living Standard:
/// https://html.spec.whatwg.org/
public enum WHATWG_HTML {
  /// FormData API namespace for parser implementations
  ///
  /// This namespace type is extended by parser libraries (e.g., swift-url-routing)
  /// to provide parsing and printing functionality for application/x-www-form-urlencoded
  /// data as defined in the WHATWG HTML Standard.
  ///
  /// The underlying encoding/decoding uses the WHATWG URL Standard's
  /// application/x-www-form-urlencoded serialization algorithm.
  ///
  /// ## Reference
  ///
  /// WHATWG HTML Living Standard - Form submission:
  /// https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#form-submission-algorithm
  public enum FormData {}
}
