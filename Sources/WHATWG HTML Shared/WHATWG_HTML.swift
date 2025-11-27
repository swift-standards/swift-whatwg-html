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

// Re-export shared dependencies
@_exported import Standards
@_exported import INCITS_4_1986

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
/// let form = Form(
///     action: .relative("/submit"),
///     method: .post
/// )
/// ```
public enum WHATWG_HTML {}
