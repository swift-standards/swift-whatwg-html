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

@Suite("Compact Test")
struct CompactTests {
    @Test("Compact attribute should be compact")
    func attribute() {
        #expect(Compact.attribute == "compact")
    }
}
