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

import WHATWG_HTML_Shared

/// Represents the playsinline attribute for the video element.
@dynamicMemberLookup
public struct Playsinline: WHATWG_HTML.BooleanAttribute {
    /// The name of the HTML attribute
    @inlinable public static var attribute: String { "playsinline" }

    public var rawValue: Bool

    public init(value: Bool = true) {
        self.rawValue = value
    }
}
