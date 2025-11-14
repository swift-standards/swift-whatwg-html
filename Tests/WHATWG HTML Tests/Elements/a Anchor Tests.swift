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

@Suite("Anchor Tests")
struct AnchorTests {

    @Test("Basic anchor creation")
    func basicAnchorCreation() {
        let anchor = Anchor()
        #expect(Anchor.tag == "a")
        #expect(anchor.href == nil)
        #expect(anchor.target == nil)
        #expect(anchor.rel == nil)
    }

    @Test("Anchor with href")
    func anchorWithHref() {
        let href = Href("https://example.com")
        let anchor = Anchor(href: href)
        #expect(anchor.href == href)
    }

    @Test("Anchor with target")
    func anchorWithTarget() {
        let target = Target.blank
        let anchor = Anchor(target: target)
        #expect(anchor.target == target)
    }

    @Test("Anchor with rel")
    func anchorWithRel() {
        let rel = Rel("noopener noreferrer")
        let anchor = Anchor(rel: rel)
        #expect(anchor.rel == rel)
    }

    @Test("Anchor with download")
    func anchorWithDownload() {
        let download = Download("filename.pdf")
        let anchor = Anchor(download: download)
        #expect(anchor.download == download)
    }

    @Test("Anchor with hreflang")
    func anchorWithHreflang() {
        let hreflang = Hreflang("en")
        let anchor = Anchor(hreflang: hreflang)
        #expect(anchor.hreflang == hreflang)
    }

    @Test("Anchor with ping")
    func anchorWithPing() {
        let ping = Ping("https://analytics.example.com/ping")
        let anchor = Anchor(ping: ping)
        #expect(anchor.ping == ping)
    }

    @Test("Anchor with referrer policy")
    func anchorWithReferrerPolicy() {
        let policy = ReferrerPolicy.noReferrer
        let anchor = Anchor(referrerpolicy: policy)
        #expect(anchor.referrerpolicy == policy)
    }

    @Test("Anchor with attribution source")
    func anchorWithAttributionSrc() {
        let attributionsrc = AttributionSrc()
        let anchor = Anchor(attributionsrc: attributionsrc)
        #expect(anchor.attributionsrc == attributionsrc)
    }

    @Test("Complete anchor configuration")
    func completeAnchorConfiguration() {
        let href = Href("https://example.com")
        let target = Target.blank
        let rel = Rel("noopener noreferrer")
        let download = Download("document.pdf")
        let hreflang = Hreflang("en")
        let ping = Ping("https://analytics.example.com/ping")
        let referrerpolicy = ReferrerPolicy.noReferrer
        let attributionsrc = AttributionSrc()

        let anchor = Anchor(
            attributionsrc: attributionsrc,
            download: download,
            href: href,
            hreflang: hreflang,
            ping: ping,
            referrerpolicy: referrerpolicy,
            rel: rel,
            target: target
        )

        #expect(anchor.attributionsrc == attributionsrc)
        #expect(anchor.download == download)
        #expect(anchor.href == href)
        #expect(anchor.hreflang == hreflang)
        #expect(anchor.ping == ping)
        #expect(anchor.referrerpolicy == referrerpolicy)
        #expect(anchor.rel == rel)
        #expect(anchor.target == target)
    }

    @Suite("Common Use Cases")
    struct CommonUseCases {

        @Test("Email link")
        func emailLink() {
            let href = Href("mailto:contact@example.com")
            let anchor = Anchor(href: href)
            #expect(anchor.href == href)
        }

        @Test("Telephone link")
        func telephoneLink() {
            let href = Href("tel:+15555555555")
            let anchor = Anchor(href: href)
            #expect(anchor.href == href)
        }

        @Test("In-page navigation")
        func inPageNavigation() {
            let href = Href("#section-id")
            let anchor = Anchor(href: href)
            #expect(anchor.href == href)
        }

        @Test("External link with security")
        func externalLinkWithSecurity() {
            let href = Href("https://external-site.com")
            let target = Target.blank
            let rel = Rel("noopener noreferrer")

            let anchor = Anchor(
                href: href,
                rel: rel,
                target: target
            )

            #expect(anchor.href == href)
            #expect(anchor.target == target)
            #expect(anchor.rel == rel)
        }

        @Test("Download link")
        func downloadLink() {
            let href = Href("/files/document.pdf")
            let download = Download("important-document.pdf")

            let anchor = Anchor(
                download: download,
                href: href
            )

            #expect(anchor.href == href)
            #expect(anchor.download == download)
        }

        @Test("Multilingual link")
        func multilingualLink() {
            let href = Href("https://example.fr")
            let hreflang = Hreflang("fr")

            let anchor = Anchor(
                href: href,
                hreflang: hreflang
            )

            #expect(anchor.href == href)
            #expect(anchor.hreflang == hreflang)
        }

        @Test("Tracked link")
        func trackedLink() {
            let href = Href("https://example.com")
            let ping = Ping(
                "https://analytics.example.com/ping https://tracking.example.com/click"
            )

            let anchor = Anchor(
                href: href,
                ping: ping
            )

            #expect(anchor.href == href)
            #expect(anchor.ping == ping)
        }
    }

    @Suite("Target Attribute Tests")
    struct TargetAttributeTests {

        @Test("Target self")
        func targetSelf() {
            let target = Target.`self`
            let anchor = Anchor(target: target)
            #expect(anchor.target == target)
        }

        @Test("Target blank")
        func targetBlank() {
            let target = Target.blank
            let anchor = Anchor(target: target)
            #expect(anchor.target == target)
        }

        @Test("Target parent")
        func targetParent() {
            let target = Target.parent
            let anchor = Anchor(target: target)
            #expect(anchor.target == target)
        }

        @Test("Target top")
        func targetTop() {
            let target = Target.top
            let anchor = Anchor(target: target)
            #expect(anchor.target == target)
        }

        @Test("Custom target")
        func customTarget() {
            let target = Target("myframe")
            let anchor = Anchor(target: target)
            #expect(anchor.target == target)
        }
    }

    @Suite("Referrer Policy Tests")
    struct ReferrerPolicyTests {

        @Test("No referrer")
        func noReferrer() {
            let policy = ReferrerPolicy.noReferrer
            let anchor = Anchor(referrerpolicy: policy)
            #expect(anchor.referrerpolicy == policy)
        }

        @Test("Origin")
        func origin() {
            let policy = ReferrerPolicy.origin
            let anchor = Anchor(referrerpolicy: policy)
            #expect(anchor.referrerpolicy == policy)
        }

        @Test("Same origin")
        func sameOrigin() {
            let policy = ReferrerPolicy.sameOrigin
            let anchor = Anchor(referrerpolicy: policy)
            #expect(anchor.referrerpolicy == policy)
        }

        @Test("Strict origin")
        func strictOrigin() {
            let policy = ReferrerPolicy.strictOrigin
            let anchor = Anchor(referrerpolicy: policy)
            #expect(anchor.referrerpolicy == policy)
        }
    }
}
