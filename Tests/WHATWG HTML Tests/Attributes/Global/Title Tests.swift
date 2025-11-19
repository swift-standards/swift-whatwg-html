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

@Suite("WHATWG_HTML_GlobalAttributes.Title Test")
struct TitleTests {
    @Test("WHATWG_HTML_GlobalAttributes.Title attribute should be title")
    func attribute() {
        #expect(WHATWG_HTML_GlobalAttributes.Title.attribute == "title")
    }

    @Test("WHATWG_HTML_GlobalAttributes.Title should store and return its value")
    func valueStorage() {
        let title = WHATWG_HTML_GlobalAttributes.Title("Helpful information")
        #expect(title.rawValue == "Helpful information")
    }

    @Test("WHATWG_HTML_GlobalAttributes.Title description should return its value")
    func description() {
        let title = WHATWG_HTML_GlobalAttributes.Title("Click to submit the form")
        #expect(title.description == "Click to submit the form")
    }

    @Test("WHATWG_HTML_GlobalAttributes.Title should be initializable with string literal")
    func stringLiteralInitialization() {
        let title: WHATWG_HTML_GlobalAttributes.Title = "Hover for more details"
        #expect(title.rawValue == "Hover for more details")
    }
}
