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
import Foundation
import WHATWG_HTML_Forms
@testable import WHATWG_HTML_FormData

@Suite("Entry Tests")
struct EntryTests {

    @Test("Entry initialization with name and value")
    func entryInit() {
        let value = Form.Data.Value.string("test value")
        let entry = Form.Data.Entry(
            name: "field_name",
            value: value
        )

        #expect(entry.name == "field_name")
        #expect(entry.value == value)
    }

    @Test("Entry convenience init with string value")
    func entryStringInit() {
        let entry = Form.Data.Entry(
            name: "username",
            stringValue: "alice"
        )

        #expect(entry.name == "username")
        #expect(entry.value.stringValue == "alice")
        #expect(entry.value.isString == true)
    }

    @Test("Entry convenience init with file")
    func entryFileInit() {
        let file = Form.Data.File(
            name: "avatar.png",
            type: "image/png",
            body: Data([1, 2, 3])
        )
        let entry = Form.Data.Entry(
            name: "avatar",
            file: file
        )

        #expect(entry.name == "avatar")
        #expect(entry.value.fileValue == file)
        #expect(entry.value.isFile == true)
    }

    @Test("Entry conforms to Hashable")
    func entryHashable() {
        let entry1 = Form.Data.Entry(
            name: "test",
            stringValue: "value"
        )
        let entry2 = Form.Data.Entry(
            name: "test",
            stringValue: "value"
        )

        #expect(entry1 == entry2)
        #expect(entry1.hashValue == entry2.hashValue)
    }

    @Test("Entries with different names are not equal")
    func entryDifferentNames() {
        let entry1 = Form.Data.Entry(
            name: "field1",
            stringValue: "value"
        )
        let entry2 = Form.Data.Entry(
            name: "field2",
            stringValue: "value"
        )

        #expect(entry1 != entry2)
    }

    @Test("Entries with different values are not equal")
    func entryDifferentValues() {
        let entry1 = Form.Data.Entry(
            name: "field",
            stringValue: "value1"
        )
        let entry2 = Form.Data.Entry(
            name: "field",
            stringValue: "value2"
        )

        #expect(entry1 != entry2)
    }

    @Test("Entry conforms to Sendable")
    func entrySendable() {
        // Compile-time check that Entry is Sendable
        func acceptSendable<T: Sendable>(_: T) {}
        let entry = Form.Data.Entry(
            name: "test",
            stringValue: "value"
        )
        acceptSendable(entry)
    }
}
