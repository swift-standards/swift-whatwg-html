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

#if canImport(Foundation)
import Foundation
#endif

/// WHATWG HTML Living Standard namespace
///
/// This namespace contains types representing HTML elements and attributes
/// as defined in the WHATWG HTML Living Standard.
///
/// ## Specification
///
/// [WHATWG HTML Living Standard](https://html.spec.whatwg.org/)
///
/// ## Example
///
/// ```swift
/// import WHATWG_HTML_Forms
///
/// let form = WHATWG_HTML.Forms.Form(
///     action: .relative("/submit"),
///     method: .post
/// )
/// ```
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
    /// [Form submission algorithm](https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#form-submission-algorithm)
    public enum FormData {}
}
