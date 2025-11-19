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

public import WHATWG_HTML_Shared

@dynamicMemberLookup
public struct FormEncType: WHATWG_HTML.StringAttribute {
    /// The name of the HTML attribute
    @inlinable public static var attribute: String { "formenctype" }

    /// The attribute value
    public let rawValue: String

    /// Initialize with a value for the formenctype attribute
    public init(value: String) {
        self.rawValue = value
    }
}

extension FormEncType {
    /// Standard form encoding (default)
    @inlinable public static var urlEncoded: Self { "application/x-www-form-urlencoded" }

    /// Required for file uploads
    @inlinable public static var multipartFormData: Self { "multipart/form-data" }

    /// Minimal encoding, useful for debugging
    @inlinable public static var textPlain: Self { "text/plain" }
}
