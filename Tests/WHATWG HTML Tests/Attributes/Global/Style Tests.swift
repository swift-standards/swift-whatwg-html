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

import WHATWG_HTML
import Testing

#if canImport(FoundationEssentials)
    import FoundationEssentials
#elseif canImport(Foundation)
    #endif

@Suite("WHATWG_HTML_GlobalAttributes.Style Test")
struct StyleTests {
    @Test("WHATWG_HTML_GlobalAttributes.Style attribute should be style")
    func attribute() {
        #expect(WHATWG_HTML_GlobalAttributes.Style.attribute == "style")
    }

    @Test("WHATWG_HTML_GlobalAttributes.Style should store and return its value")
    func valueStorage() {
        let style = WHATWG_HTML_GlobalAttributes.Style("color: red; font-size: 14px;")
        #expect(style.rawValue == "color: red; font-size: 14px;")
    }

    @Test("WHATWG_HTML_GlobalAttributes.Style description should return its value")
    func description() {
        let style = WHATWG_HTML_GlobalAttributes.Style("margin: 10px; padding: 5px;")
        #expect(style.description == "margin: 10px; padding: 5px;")
    }

    @Test("WHATWG_HTML_GlobalAttributes.Style should be initializable with string literal")
    func stringLiteralInitialization() {
        let style: WHATWG_HTML_GlobalAttributes.Style = "background-color: blue;"
        #expect(style.rawValue == "background-color: blue;")
    }

    @Test("WHATWG_HTML_GlobalAttributes.Style should support dictionary-based initialization")
    func dictionaryInitialization() {
        let style = WHATWG_HTML_GlobalAttributes.Style([
            "color": "red",
            "font-size": "14px",
        ])

        #expect(style.description.contains("color: red"))
        #expect(style.description.contains("font-size: 14px"))
    }
}
