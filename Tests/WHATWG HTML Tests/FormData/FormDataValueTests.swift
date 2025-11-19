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

import Testing
import WHATWG_HTML_Forms
@testable import WHATWG_HTML_FormData

@Suite("FormData Value Tests")
struct FormDataValueTests {

    @Test("Value string case stores value")
    func valueString() {
        let value = Form.Data.Value.string("hello")

        #expect(value.stringValue == "hello")
        #expect(value.fileValue == nil)
        #expect(value.isString == true)
        #expect(value.isFile == false)
    }

    @Test("Value file case stores file")
    func valueFile() {
        let file = Form.Data.File(
            name: "test.txt",
            type: "text/plain",
            body: Data([1, 2, 3])
        )
        let value = Form.Data.Value.file(file)

        #expect(value.stringValue == nil)
        #expect(value.fileValue == file)
        #expect(value.isString == false)
        #expect(value.isFile == true)
    }

    @Test("Value ExpressibleByStringLiteral creates string value")
    func valueStringLiteral() {
        let value: Form.Data.Value = "test string"

        #expect(value.stringValue == "test string")
        #expect(value.isString == true)
    }

    @Test("Value description for string returns the string")
    func valueStringDescription() {
        let value = Form.Data.Value.string("hello world")
        #expect(value.description == "hello world")
    }

    @Test("Value description for file includes file info")
    func valueFileDescription() {
        let file = Form.Data.File(
            name: "image.png",
            type: "image/png",
            body: Data([1, 2, 3])
        )
        let value = Form.Data.Value.file(file)

        let description = value.description
        #expect(description.contains("image.png"))
        #expect(description.contains("image/png"))
        #expect(description.contains("3"))
    }

    @Test("Value conforms to Hashable")
    func valueHashable() {
        let value1 = Form.Data.Value.string("test")
        let value2 = Form.Data.Value.string("test")

        #expect(value1 == value2)
        #expect(value1.hashValue == value2.hashValue)
    }

    @Test("Different string values are not equal")
    func valueDifferentStrings() {
        let value1 = Form.Data.Value.string("hello")
        let value2 = Form.Data.Value.string("world")

        #expect(value1 != value2)
    }

    @Test("String and file values are not equal")
    func valueStringAndFile() {
        let stringValue = Form.Data.Value.string("test")
        let fileValue = Form.Data.Value.file(
            Form.Data.File(
                name: "test.txt",
                type: "text/plain",
                body: Data()
            )
        )

        #expect(stringValue != fileValue)
    }

    @Test("Value conforms to Sendable")
    func valueSendable() {
        // Compile-time check that Value is Sendable
        func acceptSendable<T: Sendable>(_: T) {}
        let value = Form.Data.Value.string("test")
        acceptSendable(value)
    }
}
