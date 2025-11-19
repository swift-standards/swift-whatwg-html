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

@Suite("Sizes Test")
struct SizesTests {
    @Test("Sizes attribute should be sizes")
    func attribute() {
        #expect(Sizes.attribute == "sizes")
    }
}
