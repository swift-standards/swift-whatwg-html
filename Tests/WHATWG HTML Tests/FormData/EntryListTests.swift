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

@Suite("EntryList Tests")
struct EntryListTests {

    @Test("EntryList empty initialization")
    func entryListEmpty() {
        let list = Form.Data.Entry.List()

        #expect(list.count == 0)
        #expect(list.isEmpty == true)
    }

    @Test("EntryList initialization with entries")
    func entryListWithEntries() {
        let entries = [
            Form.Data.Entry(name: "field1", stringValue: "value1"),
            Form.Data.Entry(name: "field2", stringValue: "value2")
        ]
        let list = Form.Data.Entry.List(entries: entries)

        #expect(list.count == 2)
        #expect(list.isEmpty == false)
    }

    @Test("EntryList append entry")
    func entryListAppend() {
        var list = Form.Data.Entry.List()
        let entry = Form.Data.Entry(name: "test", stringValue: "value")

        list.append(entry)

        #expect(list.count == 1)
        #expect(list[0].name == "test")
    }

    @Test("EntryList append with name and value")
    func entryListAppendNameValue() {
        var list = Form.Data.Entry.List()
        list.append(name: "username", value: .string("alice"))

        #expect(list.count == 1)
        #expect(list[0].name == "username")
        #expect(list[0].value.stringValue == "alice")
    }

    @Test("EntryList append string convenience")
    func entryListAppendString() {
        var list = Form.Data.Entry.List()
        list.append(name: "email", value: "alice@example.com")

        #expect(list.count == 1)
        #expect(list[0].value.stringValue == "alice@example.com")
    }

    @Test("EntryList append file convenience")
    func entryListAppendFile() {
        var list = Form.Data.Entry.List()
        let file = Form.Data.File(
            name: "photo.jpg",
            type: "image/jpeg",
            body: Data([1, 2, 3])
        )
        list.append(name: "photo", file: file)

        #expect(list.count == 1)
        #expect(list[0].value.fileValue == file)
    }

    @Test("EntryList subscript by name returns all values")
    func entryListSubscript() {
        var list = Form.Data.Entry.List()
        list.append(name: "interests", value: "swift")
        list.append(name: "interests", value: "webdev")
        list.append(name: "username", value: "alice")

        let interests = list["interests"]
        let username = list["username"]

        #expect(interests?.count == 2)
        #expect(interests?[0].stringValue == "swift")
        #expect(interests?[1].stringValue == "webdev")
        #expect(username?.count == 1)
        #expect(username?[0].stringValue == "alice")
    }

    @Test("EntryList subscript returns nil for missing name")
    func entryListSubscriptMissing() {
        let list = Form.Data.Entry.List()
        #expect(list["nonexistent"] == nil)
    }

    @Test("EntryList first named returns first value")
    func entryListFirst() {
        var list = Form.Data.Entry.List()
        list.append(name: "field", value: "first")
        list.append(name: "field", value: "second")

        let first = list.first(named: "field")

        #expect(first?.stringValue == "first")
    }

    @Test("EntryList first named returns nil for missing")
    func entryListFirstMissing() {
        let list = Form.Data.Entry.List()
        #expect(list.first(named: "missing") == nil)
    }

    @Test("EntryList all named returns all values")
    func entryListAll() {
        var list = Form.Data.Entry.List()
        list.append(name: "tags", value: "swift")
        list.append(name: "tags", value: "web")
        list.append(name: "tags", value: "server")

        let tags = list.all(named: "tags")

        #expect(tags.count == 3)
        #expect(tags[0].stringValue == "swift")
        #expect(tags[1].stringValue == "web")
        #expect(tags[2].stringValue == "server")
    }

    @Test("EntryList all named returns empty array for missing")
    func entryListAllMissing() {
        let list = Form.Data.Entry.List()
        let values = list.all(named: "missing")

        #expect(values.isEmpty == true)
    }

    @Test("EntryList contains name")
    func entryListContains() {
        var list = Form.Data.Entry.List()
        list.append(name: "username", value: "alice")

        #expect(list.contains(name: "username") == true)
        #expect(list.contains(name: "email") == false)
    }

    @Test("EntryList remove by name")
    func entryListRemove() {
        var list = Form.Data.Entry.List()
        list.append(name: "field1", value: "value1")
        list.append(name: "field2", value: "value2")
        list.append(name: "field1", value: "value3")

        let removed = list.remove(name: "field1")

        #expect(removed == 2)
        #expect(list.count == 1)
        #expect(list[0].name == "field2")
    }

    @Test("EntryList names returns unique names in order")
    func entryListNames() {
        var list = Form.Data.Entry.List()
        list.append(name: "username", value: "alice")
        list.append(name: "email", value: "alice@example.com")
        list.append(name: "username", value: "bob")
        list.append(name: "age", value: "30")
        list.append(name: "email", value: "bob@example.com")

        let names = list.names

        #expect(names.count == 3)
        #expect(names == ["username", "email", "age"])
    }

    @Test("EntryList conforms to Collection")
    func entryListCollection() {
        var list = Form.Data.Entry.List()
        list.append(name: "field1", value: "value1")
        list.append(name: "field2", value: "value2")

        let first = list[list.startIndex]
        let second = list[list.index(after: list.startIndex)]

        #expect(first.name == "field1")
        #expect(second.name == "field2")
    }

    @Test("EntryList can be iterated")
    func entryListIteration() {
        var list = Form.Data.Entry.List()
        list.append(name: "a", value: "1")
        list.append(name: "b", value: "2")
        list.append(name: "c", value: "3")

        var names: [String] = []
        for entry in list {
            names.append(entry.name)
        }

        #expect(names == ["a", "b", "c"])
    }

    @Test("EntryList array literal initialization")
    func entryListArrayLiteral() {
        let list: Form.Data.Entry.List = [
            Form.Data.Entry(name: "field1", stringValue: "value1"),
            Form.Data.Entry(name: "field2", stringValue: "value2")
        ]

        #expect(list.count == 2)
        #expect(list[0].name == "field1")
        #expect(list[1].name == "field2")
    }

    @Test("EntryList conforms to Equatable")
    func entryListEquatable() {
        let list1: Form.Data.Entry.List = [
            Form.Data.Entry(name: "a", stringValue: "1"),
            Form.Data.Entry(name: "b", stringValue: "2")
        ]
        let list2: Form.Data.Entry.List = [
            Form.Data.Entry(name: "a", stringValue: "1"),
            Form.Data.Entry(name: "b", stringValue: "2")
        ]

        #expect(list1 == list2)
    }

    @Test("EntryList different entries not equal")
    func entryListNotEqual() {
        let list1: Form.Data.Entry.List = [
            Form.Data.Entry(name: "a", stringValue: "1")
        ]
        let list2: Form.Data.Entry.List = [
            Form.Data.Entry(name: "b", stringValue: "2")
        ]

        #expect(list1 != list2)
    }

    @Test("EntryList conforms to Hashable")
    func entryListHashable() {
        let list1: Form.Data.Entry.List = [
            Form.Data.Entry(name: "a", stringValue: "1")
        ]
        let list2: Form.Data.Entry.List = [
            Form.Data.Entry(name: "a", stringValue: "1")
        ]

        #expect(list1.hashValue == list2.hashValue)
    }

    @Test("EntryList description")
    func entryListDescription() {
        var list = Form.Data.Entry.List()
        list.append(name: "username", value: "alice")
        list.append(name: "email", value: "alice@example.com")

        let description = list.description

        #expect(description.contains("username"))
        #expect(description.contains("alice"))
        #expect(description.contains("email"))
        #expect(description.contains("alice@example.com"))
    }

    @Test("EntryList debug description")
    func entryListDebugDescription() {
        var list = Form.Data.Entry.List()
        list.append(name: "test", value: "value")

        let debugDescription = list.debugDescription

        #expect(debugDescription.contains("Entry.List"))
        #expect(debugDescription.contains("count: 1"))
        #expect(debugDescription.contains("test"))
    }

    @Test("EntryList preserves insertion order")
    func entryListOrder() {
        var list = Form.Data.Entry.List()
        list.append(name: "third", value: "3")
        list.append(name: "first", value: "1")
        list.append(name: "second", value: "2")

        #expect(list[0].name == "third")
        #expect(list[1].name == "first")
        #expect(list[2].name == "second")
    }

    @Test("EntryList supports multiple values for same name")
    func entryListMultipleValues() {
        var list = Form.Data.Entry.List()
        list.append(name: "checkbox", value: "option1")
        list.append(name: "checkbox", value: "option2")
        list.append(name: "checkbox", value: "option3")

        let values = list.all(named: "checkbox")

        #expect(values.count == 3)
        #expect(values[0].stringValue == "option1")
        #expect(values[1].stringValue == "option2")
        #expect(values[2].stringValue == "option3")
    }

    @Test("EntryList conforms to Sendable")
    func entryListSendable() {
        // Compile-time check that EntryList is Sendable
        func acceptSendable<T: Sendable>(_: T) {}
        let list = Form.Data.Entry.List()
        acceptSendable(list)
    }
}
