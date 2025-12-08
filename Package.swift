// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Target/Product Name Constants

extension String {
    // Core shared module (namespace + protocols)
    static let whatwgHTMLShared: Self = "WHATWG HTML Shared"

    // Data types module
    static let whatwgHTMLFormData: Self = "WHATWG HTML FormData"

    // Umbrella module
    static let whatwgHTML: Self = "WHATWG HTML"

    // Element modules (section-based, matching WHATWG spec structure)
    static let whatwgHTMLDocument: Self = "WHATWG HTML Document"
    static let whatwgHTMLMetadata: Self = "WHATWG HTML Metadata"
    static let whatwgHTMLSections: Self = "WHATWG HTML Sections"
    static let whatwgHTMLGrouping: Self = "WHATWG HTML Grouping"
    static let whatwgHTMLTextSemantics: Self = "WHATWG HTML TextSemantics"
    static let whatwgHTMLLinks: Self = "WHATWG HTML Links"
    static let whatwgHTMLEdits: Self = "WHATWG HTML Edits"
    static let whatwgHTMLEmbedded: Self = "WHATWG HTML Embedded"
    static let whatwgHTMLTables: Self = "WHATWG HTML Tables"
    static let whatwgHTMLForms: Self = "WHATWG HTML Forms"
    static let whatwgHTMLInteractive: Self = "WHATWG HTML Interactive"
    static let whatwgHTMLScripting: Self = "WHATWG HTML Scripting"
    static let whatwgHTMLCustomElements: Self = "WHATWG HTML CustomElements"
    static let whatwgHTMLObsolete: Self = "WHATWG HTML Obsolete"

    // Attribute modules (usage-based grouping)
    static let whatwgHTMLGlobalAttributes: Self = "WHATWG HTML GlobalAttributes"
    static let whatwgHTMLFormAttributes: Self = "WHATWG HTML FormAttributes"
    static let whatwgHTMLLinkAttributes: Self = "WHATWG HTML LinkAttributes"
    static let whatwgHTMLMediaAttributes: Self = "WHATWG HTML MediaAttributes"
    static let whatwgHTMLTableAttributes: Self = "WHATWG HTML TableAttributes"
    static let whatwgHTMLScriptAttributes: Self = "WHATWG HTML ScriptAttributes"

    // Convenience umbrella modules
    static let whatwgHTMLElements: Self = "WHATWG HTML Elements"
    static let whatwgHTMLAttributes: Self = "WHATWG HTML Attributes"
}

// MARK: - Target Dependency Helpers

extension Target.Dependency {
    // Core
    static var whatwgHTMLShared: Self { .target(name: .whatwgHTMLShared) }
    static var whatwgHTMLFormData: Self { .target(name: .whatwgHTMLFormData) }
    static var whatwgHTML: Self { .target(name: .whatwgHTML) }

    // Elements
    static var whatwgHTMLDocument: Self { .target(name: .whatwgHTMLDocument) }
    static var whatwgHTMLMetadata: Self { .target(name: .whatwgHTMLMetadata) }
    static var whatwgHTMLSections: Self { .target(name: .whatwgHTMLSections) }
    static var whatwgHTMLGrouping: Self { .target(name: .whatwgHTMLGrouping) }
    static var whatwgHTMLTextSemantics: Self { .target(name: .whatwgHTMLTextSemantics) }
    static var whatwgHTMLLinks: Self { .target(name: .whatwgHTMLLinks) }
    static var whatwgHTMLEdits: Self { .target(name: .whatwgHTMLEdits) }
    static var whatwgHTMLEmbedded: Self { .target(name: .whatwgHTMLEmbedded) }
    static var whatwgHTMLTables: Self { .target(name: .whatwgHTMLTables) }
    static var whatwgHTMLForms: Self { .target(name: .whatwgHTMLForms) }
    static var whatwgHTMLInteractive: Self { .target(name: .whatwgHTMLInteractive) }
    static var whatwgHTMLScripting: Self { .target(name: .whatwgHTMLScripting) }
    static var whatwgHTMLCustomElements: Self { .target(name: .whatwgHTMLCustomElements) }
    static var whatwgHTMLObsolete: Self { .target(name: .whatwgHTMLObsolete) }

    // Attributes
    static var whatwgHTMLGlobalAttributes: Self { .target(name: .whatwgHTMLGlobalAttributes) }
    static var whatwgHTMLFormAttributes: Self { .target(name: .whatwgHTMLFormAttributes) }
    static var whatwgHTMLLinkAttributes: Self { .target(name: .whatwgHTMLLinkAttributes) }
    static var whatwgHTMLMediaAttributes: Self { .target(name: .whatwgHTMLMediaAttributes) }
    static var whatwgHTMLTableAttributes: Self { .target(name: .whatwgHTMLTableAttributes) }
    static var whatwgHTMLScriptAttributes: Self { .target(name: .whatwgHTMLScriptAttributes) }

    // Umbrella
    static var whatwgHTMLElements: Self { .target(name: .whatwgHTMLElements) }
    static var whatwgHTMLAttributes: Self { .target(name: .whatwgHTMLAttributes) }

    // External dependencies
    static var rfc2045: Self { .product(name: "RFC 2045", package: "swift-rfc-2045") }
    static var iso8601: Self { .product(name: "ISO 8601", package: "swift-iso-8601") }
    static var standards: Self { .product(name: "Standards", package: "swift-standards") }
    static var incits41986: Self { .product(name: "INCITS 4 1986", package: "swift-incits-4-1986") }

    // Test dependencies
    static var standardsTestSupport: Self { .product(name: "StandardsTestSupport", package: "swift-standards") }
}

// MARK: - Package Definition

let package = Package(
    name: "swift-whatwg-html",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // ============================================================
        // MARK: Core Shared Module
        // ============================================================
        .library(
            name: .whatwgHTMLShared,
            targets: [.whatwgHTMLShared]
        ),

        // ============================================================
        // MARK: Data Types Module
        // ============================================================
        .library(
            name: .whatwgHTMLFormData,
            targets: [.whatwgHTMLFormData]
        ),

        // ============================================================
        // MARK: Element Modules (Section-Based)
        // ============================================================
        .library(
            name: .whatwgHTMLDocument,
            targets: [.whatwgHTMLDocument]
        ),
        .library(
            name: .whatwgHTMLMetadata,
            targets: [.whatwgHTMLMetadata]
        ),
        .library(
            name: .whatwgHTMLSections,
            targets: [.whatwgHTMLSections]
        ),
        .library(
            name: .whatwgHTMLGrouping,
            targets: [.whatwgHTMLGrouping]
        ),
        .library(
            name: .whatwgHTMLTextSemantics,
            targets: [.whatwgHTMLTextSemantics]
        ),
        .library(
            name: .whatwgHTMLLinks,
            targets: [.whatwgHTMLLinks]
        ),
        .library(
            name: .whatwgHTMLEdits,
            targets: [.whatwgHTMLEdits]
        ),
        .library(
            name: .whatwgHTMLEmbedded,
            targets: [.whatwgHTMLEmbedded]
        ),
        .library(
            name: .whatwgHTMLTables,
            targets: [.whatwgHTMLTables]
        ),
        .library(
            name: .whatwgHTMLForms,
            targets: [.whatwgHTMLForms]
        ),
        .library(
            name: .whatwgHTMLInteractive,
            targets: [.whatwgHTMLInteractive]
        ),
        .library(
            name: .whatwgHTMLScripting,
            targets: [.whatwgHTMLScripting]
        ),
        .library(
            name: .whatwgHTMLCustomElements,
            targets: [.whatwgHTMLCustomElements]
        ),
        .library(
            name: .whatwgHTMLObsolete,
            targets: [.whatwgHTMLObsolete]
        ),

        // ============================================================
        // MARK: Attribute Modules (Usage-Based)
        // ============================================================
        .library(
            name: .whatwgHTMLGlobalAttributes,
            targets: [.whatwgHTMLGlobalAttributes]
        ),
        .library(
            name: .whatwgHTMLFormAttributes,
            targets: [.whatwgHTMLFormAttributes]
        ),
        .library(
            name: .whatwgHTMLLinkAttributes,
            targets: [.whatwgHTMLLinkAttributes]
        ),
        .library(
            name: .whatwgHTMLMediaAttributes,
            targets: [.whatwgHTMLMediaAttributes]
        ),
        .library(
            name: .whatwgHTMLTableAttributes,
            targets: [.whatwgHTMLTableAttributes]
        ),
        .library(
            name: .whatwgHTMLScriptAttributes,
            targets: [.whatwgHTMLScriptAttributes]
        ),

        // ============================================================
        // MARK: Convenience Umbrella Products
        // ============================================================
        .library(
            name: .whatwgHTMLElements,
            targets: [.whatwgHTMLElements]
        ),
        .library(
            name: .whatwgHTMLAttributes,
            targets: [.whatwgHTMLAttributes]
        ),

        // ============================================================
        // MARK: Main Umbrella (Everything)
        // ============================================================
        .library(
            name: .whatwgHTML,
            targets: [.whatwgHTML]
        )
    ],
    traits: [
        .trait(
            name: "Foundation",
            description: "Foundation integration for WHATWG HTML"
        )
    ],
    dependencies: [
        .package(path: "../swift-rfc-2045"),
        .package(path: "../swift-iso-8601"),
        .package(path: "../swift-standards"),
        .package(path: "../swift-incits-4-1986"),
    ],
    targets: [
        // ============================================================
        // MARK: Core Shared Target (Namespace + Protocols)
        // ============================================================
        .target(
            name: .whatwgHTMLShared,
            dependencies: [
                .standards,
                .incits41986
            ]
        ),

        // ============================================================
        // MARK: Data Types Target
        // ============================================================
        .target(
            name: .whatwgHTMLFormData,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLForms
            ]
        ),

        // ============================================================
        // MARK: Attribute Targets (Usage-Based)
        // ============================================================
        .target(
            name: .whatwgHTMLGlobalAttributes,
            dependencies: [
                .whatwgHTMLShared,
                .iso8601
            ]
        ),
        .target(
            name: .whatwgHTMLFormAttributes,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .rfc2045,
                .iso8601
            ]
        ),
        .target(
            name: .whatwgHTMLLinkAttributes,
            dependencies: [
                .whatwgHTMLShared,
                .rfc2045,
                .whatwgHTMLMediaAttributes
            ]
        ),
        .target(
            name: .whatwgHTMLMediaAttributes,
            dependencies: [
                .whatwgHTMLShared,
                .rfc2045
            ]
        ),
        .target(
            name: .whatwgHTMLTableAttributes,
            dependencies: [.whatwgHTMLShared]
        ),
        .target(
            name: .whatwgHTMLScriptAttributes,
            dependencies: [
                .whatwgHTMLShared,
                .rfc2045
            ]
        ),

        // ============================================================
        // MARK: Element Targets (Section-Based, WHATWG Spec Aligned)
        // ============================================================

        // 4.1 The document element
        .target(
            name: .whatwgHTMLDocument,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLAttributes
            ]
        ),

        // 4.2 Document metadata
        .target(
            name: .whatwgHTMLMetadata,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLLinkAttributes,
                .whatwgHTMLScriptAttributes,
                .whatwgHTMLFormAttributes  // For link element
            ]
        ),

        // 4.3 Sections
        .target(
            name: .whatwgHTMLSections,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes
            ]
        ),

        // 4.4 Grouping content
        .target(
            name: .whatwgHTMLGrouping,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLFormAttributes  // For li element (Value)
            ]
        ),

        // 4.5 Text-level semantics
        .target(
            name: .whatwgHTMLTextSemantics,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLLinkAttributes,  // For <a> element
                .whatwgHTMLFormAttributes,  // For <a> element (Target), <data> element (Value)
                .whatwgHTMLMediaAttributes  // For <a> element (AttributionSrc)
            ]
        ),

        // 4.6 Links
        .target(
            name: .whatwgHTMLLinks,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLLinkAttributes
            ]
        ),

        // 4.7 Edits
        .target(
            name: .whatwgHTMLEdits,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes
            ]
        ),

        // 4.8 Embedded content
        .target(
            name: .whatwgHTMLEmbedded,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLMediaAttributes,
                .whatwgHTMLFormAttributes,
                .whatwgHTMLLinkAttributes,
                .whatwgHTMLScriptAttributes
            ]
        ),

        // 4.9 Tabular data
        .target(
            name: .whatwgHTMLTables,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLTableAttributes,
                .whatwgHTMLMediaAttributes
            ]
        ),

        // 4.10 Forms
        .target(
            name: .whatwgHTMLForms,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLFormAttributes,
                .whatwgHTMLTableAttributes,  // For textarea (Cols, Rows)
                .whatwgHTMLMediaAttributes,  // For input[type=image] (Src, Alt, Width, Height)
                .whatwgHTMLLinkAttributes  // For form element (Rel)
            ]
        ),

        // 4.11 Interactive elements
        .target(
            name: .whatwgHTMLInteractive,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLFormAttributes  // For details element (Name)
            ]
        ),

        // 4.12 Scripting
        .target(
            name: .whatwgHTMLScripting,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLScriptAttributes,
                .whatwgHTMLFormAttributes,  // For slot element (Name)
                .whatwgHTMLMediaAttributes,  // For script element (AttributionSrc)
                .whatwgHTMLLinkAttributes  // For script element (ReferrerPolicy, Integrity, Crossorigin)
            ]
        ),

        // 4.13 Custom elements
        .target(
            name: .whatwgHTMLCustomElements,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes
            ]
        ),

        // Obsolete features
        .target(
            name: .whatwgHTMLObsolete,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLTableAttributes,  // For Frameset (Cols, Rows)
                .whatwgHTMLFormAttributes,   // For Frame (Name)
                .whatwgHTMLMediaAttributes   // For Frame (Src, MarginHeight, MarginWidth)
            ]
        ),

        // ============================================================
        // MARK: Convenience Umbrella Targets
        // ============================================================

        // Umbrella for all elements
        .target(
            name: .whatwgHTMLElements,
            dependencies: [
                .whatwgHTMLDocument,
                .whatwgHTMLMetadata,
                .whatwgHTMLSections,
                .whatwgHTMLGrouping,
                .whatwgHTMLTextSemantics,
                .whatwgHTMLLinks,
                .whatwgHTMLEdits,
                .whatwgHTMLEmbedded,
                .whatwgHTMLTables,
                .whatwgHTMLForms,
                .whatwgHTMLInteractive,
                .whatwgHTMLScripting,
                .whatwgHTMLCustomElements,
                .whatwgHTMLObsolete
            ]
        ),

        // Umbrella for all attributes
        .target(
            name: .whatwgHTMLAttributes,
            dependencies: [
                .whatwgHTMLGlobalAttributes,
                .whatwgHTMLFormAttributes,
                .whatwgHTMLLinkAttributes,
                .whatwgHTMLMediaAttributes,
                .whatwgHTMLTableAttributes,
                .whatwgHTMLScriptAttributes
            ]
        ),

        // ============================================================
        // MARK: Main Umbrella Target (Everything)
        // ============================================================
        .target(
            name: .whatwgHTML,
            dependencies: [
                .whatwgHTMLShared,
                .whatwgHTMLFormData,
                .whatwgHTMLElements,
                .whatwgHTMLAttributes
            ]
        ),

        // ============================================================
        // MARK: Test Targets
        // ============================================================
        .testTarget(
            name: .whatwgHTML.tests,
            dependencies: [
                .whatwgHTML,
                .standardsTestSupport
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
    var foundation: Self { self + " Foundation" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility")
    ]
}
