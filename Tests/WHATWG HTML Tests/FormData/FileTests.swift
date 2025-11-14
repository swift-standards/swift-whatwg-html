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
import WHATWG_HTML_Shared
@testable import WHATWG_HTML_FormData

@Suite("File Tests")
struct FileTests {

    @Test("File initialization stores properties correctly")
    func fileInitialization() {
        let data = Data([1, 2, 3, 4, 5])
        let file = WHATWG_HTML.FormData.File(
            name: "test.txt",
            type: "text/plain",
            body: data
        )

        #expect(file.name == "test.txt")
        #expect(file.type == "text/plain")
        #expect(file.body == data)
    }

    @Test("File size property returns correct byte count")
    func fileSize() {
        let data = Data([1, 2, 3, 4, 5])
        let file = WHATWG_HTML.FormData.File(
            name: "test.bin",
            type: "application/octet-stream",
            body: data
        )

        #expect(file.size == 5)
    }

    @Test("File isEmpty returns true for empty data")
    func fileEmpty() {
        let file = WHATWG_HTML.FormData.File(
            name: "empty.txt",
            type: "text/plain",
            body: Data()
        )

        #expect(file.isEmpty == true)
    }

    @Test("File isEmpty returns false for non-empty data")
    func fileNotEmpty() {
        let file = WHATWG_HTML.FormData.File(
            name: "data.txt",
            type: "text/plain",
            body: Data([1])
        )

        #expect(file.isEmpty == false)
    }

    @Test("File description includes name, type, and size")
    func fileDescription() {
        let data = Data([1, 2, 3])
        let file = WHATWG_HTML.FormData.File(
            name: "image.png",
            type: "image/png",
            body: data
        )

        let description = file.description
        #expect(description.contains("image.png"))
        #expect(description.contains("image/png"))
        #expect(description.contains("3"))
    }

    @Test("File conforms to Hashable")
    func fileHashable() {
        let data = Data([1, 2, 3])
        let file1 = WHATWG_HTML.FormData.File(
            name: "test.txt",
            type: "text/plain",
            body: data
        )
        let file2 = WHATWG_HTML.FormData.File(
            name: "test.txt",
            type: "text/plain",
            body: data
        )

        #expect(file1 == file2)
        #expect(file1.hashValue == file2.hashValue)
    }

    @Test("File with different data are not equal")
    func fileDifferentData() {
        let file1 = WHATWG_HTML.FormData.File(
            name: "test.txt",
            type: "text/plain",
            body: Data([1, 2, 3])
        )
        let file2 = WHATWG_HTML.FormData.File(
            name: "test.txt",
            type: "text/plain",
            body: Data([4, 5, 6])
        )

        #expect(file1 != file2)
    }

    @Test("MIME type constants are correct")
    func mimeTypeConstants() {
        #expect(WHATWG_HTML.FormData.File.MIMEType.plainText == "text/plain")
        #expect(WHATWG_HTML.FormData.File.MIMEType.html == "text/html")
        #expect(WHATWG_HTML.FormData.File.MIMEType.json == "application/json")
        #expect(WHATWG_HTML.FormData.File.MIMEType.pdf == "application/pdf")
        #expect(WHATWG_HTML.FormData.File.MIMEType.jpeg == "image/jpeg")
        #expect(WHATWG_HTML.FormData.File.MIMEType.png == "image/png")
        #expect(WHATWG_HTML.FormData.File.MIMEType.octetStream == "application/octet-stream")
    }

    @Test("File conforms to Sendable")
    func fileSendable() {
        // Compile-time check that File is Sendable
        func acceptSendable<T: Sendable>(_: T) {}
        let file = WHATWG_HTML.FormData.File(
            name: "test.txt",
            type: "text/plain",
            body: Data()
        )
        acceptSendable(file)
    }
}
