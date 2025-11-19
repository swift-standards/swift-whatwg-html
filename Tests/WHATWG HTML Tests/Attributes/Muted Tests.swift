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

@Suite
struct `Muted Test` {
    @Test
    func `Muted attribute should be muted`() {
        #expect(Muted.attribute == "muted")
    }
}
