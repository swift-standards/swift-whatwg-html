# swift-whatwg-html Refactoring Plan

**Date**: 2025-11-14
**Purpose**: Align swift-whatwg-html with the swift-standards architectural pattern and WHATWG HTML specification structure

---

## Executive Summary

This document provides a comprehensive analysis and implementation plan for refactoring the swift-whatwg-html package to align with:

1. **The swift-standards architectural pattern** - Two-tier architecture with pure spec types in swift-standards and high-level APIs in coenttb
2. **The WHATWG HTML Living Standard structure** - Modular organization matching the specification's section breakdown
3. **The namespace pattern** - Following the RFC package convention of using namespaced types (e.g., `WHATWG_HTML.Forms.Form`)

### Goals

- ✅ **Maintain all current functionality** - No features removed, only reorganized
- ✅ **Spec-aligned structure** - Package organization mirrors WHATWG HTML specification
- ✅ **Modular architecture** - Import only what you need (e.g., just Forms, just Metadata)
- ✅ **Namespace pattern** - Use `WHATWG_HTML.*` namespace like RFC packages
- ✅ **Backward compatibility** - Provide migration path for existing users
- ✅ **Foundation for Tier 2** - Enable creation of high-level coenttb/swift-html package

---

## 1. Current State Analysis

### Package Overview

- **Repository**: `/Users/coen/Developer/swift-standards/swift-whatwg-html`
- **Current Name**: swift-html-types (though directory is swift-whatwg-html)
- **Purpose**: Type-safe domain model of HTML elements and attributes in Swift
- **License**: Apache 2.0
- **Swift Version**: 6.0+
- **Dependencies**: None (pure Swift)

### Current Module Structure

The package consists of **6 library products** organized into 3 main functional areas:

#### Core Modules

**1. HTMLTypes** (umbrella module)
- **Dependencies**: HTMLAttributeTypes, HTMLElementTypes
- **Contents**: Convenience functions, documentation
- **Key file**: `WHATWG_HTML.swift` - namespace type for parser implementations

**2. HTMLAttributeTypes** (core attributes)
- **Dependencies**: None
- **Structure**:
  - 125 attribute files in `/Attributes/`
  - 33 global attribute files in `/Attributes/Global/`
- **Base protocols**:
  - `HTMLAttribute` - protocol with `static var attribute: String`
  - `HTMLBooleanAttribute`
  - `HTMLStringAttribute`

**3. HTMLElementTypes** (core elements)
- **Dependencies**: HTMLAttributeTypes
- **Structure**:
  - 125 element files in `/Elements/`
  - 24 input type files in `/Elements/Input.Types/`
- **Base protocols**:
  - `HTMLElement` - protocol with `static var tag: String`
  - `HTMLVoidElement` - marker protocol for self-closing elements

#### Foundation Integration Modules

**4. HTMLTypesFoundation** (umbrella)
- **Dependencies**: HTMLElementTypesFoundation, HTMLAttributeTypesFoundation
- **Purpose**: Foundation.URL safety for URL-based attributes

**5. HTMLAttributeTypesFoundation**
- **Dependencies**: HTMLAttributeTypes
- **Purpose**: Foundation.URL integration for URL attributes

**6. HTMLElementTypesFoundation**
- **Dependencies**: HTMLElementTypes
- **Purpose**: Foundation.URL integration for elements

### Current Organization Philosophy

#### Flat Structure by Type

```
Sources/
├── HTMLTypes/
│   ├── WHATWG_HTML.swift
│   └── Convenience functions
│
├── HTMLAttributeTypes/
│   ├── Attributes/
│   │   ├── Accept.swift
│   │   ├── AcceptCharset.swift
│   │   ├── Action.swift
│   │   └── ... (125 files alphabetically)
│   └── Attributes/Global/
│       ├── Accesskey.swift
│       ├── Autocapitalize.swift
│       └── ... (33 global attributes)
│
└── HTMLElementTypes/
    ├── Elements/
    │   ├── A.swift
    │   ├── Abbr.swift
    │   ├── Address.swift
    │   └── ... (125 files alphabetically)
    └── Elements/Input.Types/
        ├── InputButton.swift
        ├── InputCheckbox.swift
        └── ... (24 input type variants)
```

**Characteristics**:
- All attributes in single flat directory (alphabetical)
- All elements in single flat directory (alphabetical)
- No organization by spec section or functional area
- Global attributes separated into subfolder
- Input types specialized with dedicated files

### Code Patterns

#### Element Structure Example

```swift
// Sources/HTMLElementTypes/Elements/Form.swift (184 lines)
public struct Form: HTMLElement {
    @inlinable public static var tag: String { "form" }

    // Only valid attributes for this element
    public var accept: Accept?
    public var acceptCharset: AcceptCharset?
    public var autocapitalize: Autocapitalize?
    public var autocomplete: Autocomplete?
    public var name: Name?
    public var rel: Rel?
    public var action: HTMLAttributeTypes.Action?
    public var enctype: HTMLAttributeTypes.EncType?
    public var method: HTMLAttributeTypes.Method?
    public var novalidate: HTMLAttributeTypes.Novalidate?
    public var target: HTMLAttributeTypes.Target?

    public init(
        accept: Accept? = nil,
        acceptCharset: AcceptCharset? = nil,
        // ... all attributes as optional parameters
    ) {
        self.accept = accept
        self.acceptCharset = acceptCharset
        // ...
    }
}
```

#### Attribute Structure Example

```swift
// Sources/HTMLAttributeTypes/Attributes/Accept.swift (281 lines)
public struct Accept: HTMLAttribute {
    @inlinable public static var attribute: String { "accept" }

    private let fileTypes: [FileType]

    public init(_ fileType: FileType) {
        self.fileTypes = [fileType]
    }

    public init(_ fileTypes: [FileType]) {
        self.fileTypes = fileTypes
    }

    public init(_ fileTypes: FileType...) {
        self.fileTypes = fileTypes
    }

    public init(rawValue: String) {
        self.fileTypes = [.init(rawValue)]
    }

    public struct FileType: Sendable, Hashable, CustomStringConvertible {
        public var value: String

        // Static convenience properties
        public static let image: Self = .init("image/*")
        public static let jpg: Self = .init("image/jpeg")
        public static let png: Self = .init("image/png")
        // ... etc.
    }
}
```

#### Input Type Specialization

```swift
// Different input types have specialized signatures
Input.search(name: "q", placeholder: "Search...")
Input.color(name: "color", value: "#ff0000")
Input.email(name: "email", required: true)
Input.file(name: "upload", accept: .image)
```

### Strengths of Current Approach

1. ✅ **Comprehensive coverage** - 125 elements, 125+ attributes
2. ✅ **Type safety** - Each element only has valid attributes
3. ✅ **Excellent documentation** - Each file thoroughly documented
4. ✅ **Input type specialization** - Type-specific parameters
5. ✅ **Foundation integration** - URL safety with Foundation.URL
6. ✅ **Pure type definitions** - No rendering/DSL concerns mixed in
7. ✅ **Zero dependencies** - Pure Swift implementation

### Weaknesses of Current Approach

1. ❌ **No spec alignment** - Flat structure doesn't match WHATWG organization
2. ❌ **No namespace pattern** - Not using `WHATWG_HTML.*` namespace
3. ❌ **Monolithic modules** - Can't import just "Forms" or "Sections"
4. ❌ **No separation by concern** - All elements grouped together regardless of purpose
5. ❌ **Package naming inconsistency** - Repo vs. README name mismatch
6. ❌ **No higher-level package** - Missing Tier 2 (coenttb) equivalent
7. ❌ **Difficult navigation** - Hard to find related elements (e.g., all form elements)
8. ❌ **All-or-nothing imports** - Must import entire module even for small subset

---

## 2. The Swift-Standards Architectural Pattern

### Two-Tier Architecture

The swift-standards organization uses a **two-tier architecture** for domain-specific packages:

#### Tier 1: swift-standards/* (Low-Level, Standard-Based)

**Purpose**: Minimal, spec-compliant type definitions

**Characteristics**:
- Pure standard implementation
- No opinions or high-level features
- Minimal dependencies
- Namespace pattern: `RFC_XXXX.*` or `WHATWG_HTML.*`
- Focus on correctness and spec fidelity

**Naming convention**:
- `swift-rfc-XXXX` for RFC-based standards
- `swift-{standard-name}-type` for composite standards

#### Tier 2: coenttb/* (High-Level, Feature-Rich)

**Purpose**: Developer-friendly APIs, DSLs, builders, integrations

**Characteristics**:
- Ergonomic APIs and convenience methods
- Result builders and DSLs
- Component libraries
- Integration with other packages
- Theme and styling support

**Naming convention**:
- `swift-{domain}` (e.g., swift-email, swift-html)

### Example: Email Ecosystem

This example demonstrates the pattern in practice:

#### Tier 1: Standards Layer (swift-standards/*)

**swift-rfc-5322** - RFC 5322 "Internet Message Format"

```
Package: swift-rfc-5322
└── Sources/
    └── RFC 5322/
        ├── RFC 5322.swift           # Namespace: public enum RFC_5322 {}
        ├── RFC 5322 Message.swift   # RFC_5322.Message
        ├── Header.swift              # RFC_5322.Header
        ├── RFC 5322 Date.swift      # RFC_5322.Date
        └── EmailAddress.swift        # RFC_5322.EmailAddress
```

Key pattern:
```swift
// Namespace enum
public enum RFC_5322 {}

// Types in extensions
extension RFC_5322 {
    public struct EmailAddress: Hashable, Sendable {
        public let displayName: String?
        public let localPart: LocalPart
        public let domain: RFC_1123.Domain

        // Pure standard implementation - no conveniences
    }
}
```

**swift-rfc-2045** - MIME Part One: Content types

```
Package: swift-rfc-2045
└── Sources/
    └── RFC 2045/
        ├── RFC_2045.swift              # Namespace + error types
        ├── ContentTransferEncoding.swift
        ├── ContentType.swift
        └── Charset.swift
```

**swift-emailaddress-standard** - Composite EmailAddress type

```
Package: swift-emailaddress-standard
Dependencies:
  - swift-rfc-2822
  - swift-rfc-5321
  - swift-rfc-5322
  - swift-rfc-6531
  - swift-domain-standard

└── Sources/
    └── EmailAddress/
        ├── EmailAddress.swift
        ├── EmailAddress+RFC2822.swift
        ├── EmailAddress+RFC5321.swift
        ├── EmailAddress+RFC5322.swift
        └── EmailAddress+RFC6531.swift
```

**swift-email-standard** - Application-level Email type

```
Package: swift-email-standard
Dependencies:
  - swift-emailaddress-standard
  - swift-rfc-2045
  - swift-rfc-2046
  - swift-rfc-5322

└── Sources/
    └── Email Type/
        ├── Email.swift
        └── Email+RFC5322.swift
```

#### Tier 2: High-Level Layer (coenttb/*)

**swift-email** - Developer-friendly email package

```
Package: swift-email (in coenttb org)
Dependencies:
  - swift-email-standard (standard)
  - swift-rfc-5322 (standard)
  - swift-html (high-level, also in coenttb)
  - swift-dependencies
  - swift-markdown

└── Sources/
    └── Email/
        ├── Email+HTML.swift       # @HTMLBuilder extensions
        ├── EmailDocument.swift    # Document templates
        ├── EmailMarkdown.swift    # Markdown support
        ├── AppleMail.swift        # Client-specific rendering
        ├── BaseStyles.swift       # Styling support
        └── exports.swift          # Re-exports
```

High-level features:
```swift
// Builder API with DSL integration
public init(
    to: [EmailAddress],
    from: EmailAddress,
    subject: String,
    @HTMLBuilder html: () -> any HTML,  // DSL!
    additionalHeaders: [RFC_5322.Header] = []
) throws

// Convenience rendering
email.renderForAppleMail()
email.renderWithMarkdown()
```

### Key Architectural Principles

1. **Namespace Pattern**: Use `public enum NameSpace {}` for organizing related types
2. **Extension-Based Organization**: Group functionality in extensions
3. **Minimal Dependencies** in Tier 1: Standards packages are self-contained
4. **Composition Over Monoliths**: Small, focused packages that compose
5. **Standards Fidelity**: Name types after spec sections (e.g., `RFC_5322.EmailAddress`)
6. **Separation of Concerns**: Pure types vs. builder APIs vs. rendering
7. **Module Names Use Spaces**: `"RFC 5322"` not `"RFC 5322"` or `"RFC5322"`

### How This Applies to HTML

**Current state**: Monolithic HTML package with no separation of concerns

**Desired Tier 1** (swift-standards/swift-whatwg-html):
- Modular structure matching WHATWG spec sections
- Namespace pattern: `WHATWG_HTML.Forms.Form`
- Pure type definitions
- Section-based imports: `import WHATWG_HTML_Forms`

**Future Tier 2** (coenttb/swift-html):
- `@HTMLBuilder` result builder
- Component library (Card, Navigation, etc.)
- Theme support
- Rendering engines
- Integration with swift-css, swift-tailwind, etc.

---

## 3. WHATWG HTML Specification Structure

The WHATWG HTML Living Standard is organized into major sections. Section 4 "The Elements of HTML" is the primary focus for our element types.

### Top-Level Sections

1. Introduction
2. Common Infrastructure
3. Semantics, Structure, and APIs of HTML Documents
4. **The Elements of HTML** ⭐ (primary focus for refactoring)
5. Microdata
6. User Interaction
7. Loading Web Pages
8. Web Application APIs
9. Communication
10. Web Workers
11. Worklets
12. Web Storage
13. The HTML Syntax
14. The XML Syntax
15. Rendering
16. Obsolete Features

### Section 4: The Elements of HTML (Detailed Breakdown)

This is our organizational blueprint:

#### 4.1 The document element
- `<html>`

#### 4.2 Document metadata
- `<head>` - Document metadata container
- `<title>` - Document title
- `<base>` - Base URL for relative URLs
- `<link>` - External resource links
- `<meta>` - Metadata
- `<style>` - Embedded style information

#### 4.3 Sections
- `<body>` - Document body
- `<article>` - Self-contained composition
- `<section>` - Thematic grouping
- `<nav>` - Navigation links
- `<aside>` - Tangentially related content
- `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>` - Headings
- `<hgroup>` - Heading group
- `<header>` - Introductory content
- `<footer>` - Footer
- `<address>` - Contact information

#### 4.4 Grouping content
- `<p>` - Paragraph
- `<hr>` - Thematic break
- `<pre>` - Preformatted text
- `<blockquote>` - Block quotation
- `<ol>` - Ordered list
- `<ul>` - Unordered list
- `<menu>` - Menu
- `<li>` - List item
- `<dl>` - Description list
- `<dt>` - Description term
- `<dd>` - Description details
- `<figure>` - Self-contained content (diagrams, illustrations)
- `<figcaption>` - Caption for figure
- `<main>` - Main content
- `<search>` - Search functionality
- `<div>` - Generic container

#### 4.5 Text-level semantics
- `<a>` - Hyperlink
- `<em>` - Stress emphasis
- `<strong>` - Strong importance
- `<small>` - Side comment
- `<s>` - Inaccurate/irrelevant content
- `<cite>` - Title of work
- `<q>` - Inline quotation
- `<dfn>` - Defining instance
- `<abbr>` - Abbreviation
- `<ruby>`, `<rt>`, `<rp>` - Ruby annotations
- `<data>` - Machine-readable equivalent
- `<time>` - Date/time
- `<code>` - Computer code
- `<var>` - Variable
- `<samp>` - Sample output
- `<kbd>` - User input
- `<sub>`, `<sup>` - Subscript/superscript
- `<i>` - Alternate voice/mood
- `<b>` - Draw attention
- `<u>` - Unarticulated annotation
- `<mark>` - Marked/highlighted text
- `<bdi>` - Bidirectional isolation
- `<bdo>` - Bidirectional override
- `<span>` - Generic inline container
- `<br>` - Line break
- `<wbr>` - Line break opportunity

#### 4.6 Links
- Link types and relationships
- Hyperlink processing model

#### 4.7 Edits
- `<ins>` - Inserted text
- `<del>` - Deleted text

#### 4.8 Embedded content
- `<picture>` - Image container with multiple sources
- `<source>` - Media source
- `<img>` - Image
- `<iframe>` - Nested browsing context
- `<embed>` - Plugin content
- `<object>` - External resource
- `<param>` - Object parameters
- `<video>` - Video
- `<audio>` - Audio
- `<track>` - Text tracks for media
- `<map>` - Image map
- `<area>` - Image map area
- Integration points for MathML and SVG

#### 4.9 Tabular data
- `<table>` - Table
- `<caption>` - Table caption
- `<colgroup>` - Column group
- `<col>` - Column
- `<tbody>` - Table body
- `<thead>` - Table header
- `<tfoot>` - Table footer
- `<tr>` - Table row
- `<td>` - Table data cell
- `<th>` - Table header cell

#### 4.10 Forms ⭐ (Largest and most complex section)

**Form elements**:
- `<form>` - User-submittable form
- `<label>` - Caption for form control
- `<input>` - Input control (21 type states!)
- `<button>` - Button
- `<select>` - Selection control
- `<datalist>` - Predefined options
- `<optgroup>` - Option group
- `<option>` - Option
- `<textarea>` - Multiline text input
- `<output>` - Calculation result
- `<progress>` - Progress indicator
- `<meter>` - Scalar measurement
- `<fieldset>` - Group of form controls
- `<legend>` - Caption for fieldset

**Input types** (21 states):
1. `hidden` - Hidden value
2. `text` - Text input
3. `search` - Search field
4. `tel` - Telephone number
5. `url` - URL input
6. `email` - Email address
7. `password` - Password
8. `date` - Date picker
9. `month` - Month picker
10. `week` - Week picker
11. `time` - Time picker
12. `datetime-local` - Local date-time picker
13. `number` - Numeric input
14. `range` - Range slider
15. `color` - Color picker
16. `checkbox` - Checkbox
17. `radio` - Radio button
18. `file` - File upload
19. `submit` - Submit button
20. `image` - Image button
21. `reset` - Reset button
22. `button` - Generic button

#### 4.11 Interactive elements
- `<details>` - Disclosure widget
- `<summary>` - Summary/caption for details
- `<dialog>` - Dialog box

#### 4.12 Scripting
- `<script>` - Embedded or referenced script
- `<noscript>` - Fallback for no script support
- `<template>` - HTML template
- `<slot>` - Shadow DOM slot
- `<canvas>` - Graphics canvas

#### 4.13 Custom elements
- Custom element infrastructure

#### 4.14 Common idioms without dedicated elements
- Usage patterns

#### 4.15 Disabled elements
- Disabling form controls

#### 4.16 Matching HTML elements using selectors
- Selector matching

### Attribute Organization in Spec

The specification organizes attributes in multiple ways:

#### Global Attributes (apply to all elements)

**Core global attributes**:
- `id` - Unique identifier
- `class` - Class names for CSS/JS
- `style` - Inline styles
- `title` - Advisory information
- `lang` - Language
- `dir` - Text directionality
- `hidden` - Hide element
- `tabindex` - Tab order
- `accesskey` - Keyboard shortcut
- `contenteditable` - Editable content
- `draggable` - Drag-and-drop
- `spellcheck` - Spell checking
- `translate` - Translation hint
- `data-*` - Custom data attributes

**Event handler attributes** (global):
- `onclick`, `ondblclick`, `onmousedown`, etc.
- `onload`, `onerror`, etc.

**ARIA attributes** (global):
- `role`, `aria-*`

#### Element-Specific Attributes

Documented in each element's section, examples:

**Form-related** (shared across form elements):
- `name` - Control name
- `disabled` - Disable control
- `form` - Associate with form
- `autocomplete` - Autocomplete behavior
- `required` - Required field
- `readonly` - Read-only field

**Link-related** (shared across link/anchor elements):
- `href` - Hyperlink reference
- `target` - Browsing context
- `rel` - Link relationship
- `download` - Download resource

**Media-related** (shared across video/audio):
- `src` - Resource URL
- `controls` - Show controls
- `autoplay` - Automatically play
- `loop` - Loop playback
- `muted` - Mute audio

---

## 4. Gap Analysis: Current vs. Desired State

### What We Have ✅

1. ✅ Comprehensive element coverage (125 elements)
2. ✅ Comprehensive attribute coverage (125+ attributes)
3. ✅ Type-safe attribute associations (elements only have valid attributes)
4. ✅ Excellent per-file documentation
5. ✅ Input type specialization (21 type variants)
6. ✅ Foundation integration (URL safety)
7. ✅ Pure type definitions (no rendering)
8. ✅ Zero dependencies

### What We're Missing ❌

1. ❌ **Spec alignment**: Structure doesn't mirror WHATWG organization
2. ❌ **Namespace pattern**: Not using `WHATWG_HTML.*` namespace
3. ❌ **Modular imports**: Can't import just Forms or Sections
4. ❌ **Section-based organization**: All elements mixed together alphabetically
5. ❌ **Grouped attributes**: Attributes not organized by usage pattern
6. ❌ **Package naming**: Inconsistency between repo/README
7. ❌ **Tier 2 package**: No high-level coenttb/swift-html package
8. ❌ **Discoverability**: Hard to find related elements

### Comparison Table

| Aspect | Current State | Desired State (Tier 1) | Future State (Tier 2) |
|--------|---------------|------------------------|----------------------|
| **Organization** | Flat (alphabetical) | Spec-aligned modules | Feature/component-based |
| **Namespace** | None | `WHATWG_HTML.*` | `HTML.*` |
| **Module count** | 6 (3 + 3 Foundation) | 20 section/attribute-based | Component-based |
| **Import granularity** | All or nothing | Per-section | Per-feature |
| **Package location** | swift-standards | swift-standards | coenttb |
| **Dependencies** | None | None (maybe url-type) | Many (DSLs, themes) |
| **Purpose** | Type definitions | Pure spec types | Developer productivity |
| **API style** | Struct initializers | Struct initializers | @Builders, DSLs |
| **Documentation** | Per-file excellent | Module + per-file | Usage examples |
| **Example import** | `import HTMLTypes` | `import WHATWG_HTML_Forms` | `import HTML` |

---

## 5. Refactoring Recommendations

This section outlines a phased approach to refactoring the package.

### Phase 1: Namespace and Core Structure

**Goal**: Establish the `WHATWG_HTML` namespace pattern

**Actions**:

1. Create core `WHATWG HTML` module with namespace enum
2. Define sub-namespaces for each spec section
3. Begin transforming types to use namespace pattern

**Example transformation**:

**Before**:
```swift
// Sources/HTMLElementTypes/Elements/Form.swift
public struct Form: HTMLElement {
    @inlinable public static var tag: String { "form" }
    // ...
}
```

**After**:
```swift
// Sources/WHATWG HTML Forms/Form.swift

// First, define the namespace
extension WHATWG_HTML {
    public enum Forms {}
}

// Then, define types in the namespace
extension WHATWG_HTML.Forms {
    public struct Form: WHATWG_HTML.Element {
        @inlinable public static var tag: String { "form" }
        // ...
    }
}
```

**Module structure**:
```
Sources/
└── WHATWG HTML/
    ├── WHATWG_HTML.swift                # Core namespace
    ├── Element.swift                     # Element protocol
    ├── Attribute.swift                   # Attribute protocol
    └── VoidElement.swift                 # VoidElement marker
```

**Core namespace**:
```swift
// WHATWG_HTML.swift
/// WHATWG HTML Living Standard
///
/// This namespace contains types representing HTML elements and attributes
/// as defined in the WHATWG HTML Living Standard.
///
/// Specification: https://html.spec.whatwg.org
public enum WHATWG_HTML {}

// Element protocol
extension WHATWG_HTML {
    public protocol Element {
        static var tag: String { get }
    }

    public protocol VoidElement: Element {}

    public protocol Attribute {
        static var attribute: String { get }
    }

    public protocol BooleanAttribute: Attribute {}
    public protocol StringAttribute: Attribute {}
}
```

### Phase 2: Module Reorganization by Spec Section

**Goal**: Split monolithic modules into spec-aligned sections

**Priority order**:

1. **Start with independent sections** (no cross-dependencies):
   - Document (just `<html>`)
   - Metadata (`<head>`, `<title>`, etc.)
   - Sections (`<article>`, `<section>`, etc.)

2. **Then medium-complexity sections**:
   - Grouping (`<p>`, `<div>`, `<ul>`, etc.)
   - Text Semantics (`<a>`, `<em>`, `<strong>`, etc.)
   - Edits (`<ins>`, `<del>`)

3. **Then Forms (largest section)**:
   - All form elements
   - All 21 input types
   - Form-specific attributes

4. **Then dependent sections**:
   - Interactive (`<details>`, `<dialog>`)
   - Scripting (`<script>`, `<template>`)
   - Embedded (`<img>`, `<video>`, `<iframe>`)
   - Tables (`<table>`, `<tr>`, `<td>`, etc.)

5. **Finally specialized sections**:
   - Links (link types, relationships)
   - Custom Elements
   - Obsolete Features

**Proposed module structure**:

```
swift-whatwg-html/
├── Package.swift
└── Sources/
    ├── WHATWG HTML/                     # Core namespace (required by all)
    │   ├── WHATWG_HTML.swift            # Namespace enum
    │   ├── Element.swift                # Element protocol
    │   ├── Attribute.swift              # Attribute protocol
    │   └── VoidElement.swift            # VoidElement marker protocol
    │
    ├── WHATWG HTML Document/             # 4.1 Document Element
    │   └── HTML.swift
    │
    ├── WHATWG HTML Metadata/             # 4.2 Document Metadata
    │   ├── Head.swift
    │   ├── Title.swift
    │   ├── Base.swift
    │   ├── Link.swift
    │   ├── Meta.swift
    │   └── Style.swift
    │
    ├── WHATWG HTML Sections/             # 4.3 Sections
    │   ├── Body.swift
    │   ├── Article.swift
    │   ├── Section.swift
    │   ├── Nav.swift
    │   ├── Aside.swift
    │   ├── Heading.swift                 # h1-h6
    │   ├── HGroup.swift
    │   ├── Header.swift
    │   ├── Footer.swift
    │   └── Address.swift
    │
    ├── WHATWG HTML Grouping/             # 4.4 Grouping Content
    │   ├── Paragraph.swift
    │   ├── HR.swift
    │   ├── Pre.swift
    │   ├── Blockquote.swift
    │   ├── OL.swift
    │   ├── UL.swift
    │   ├── Menu.swift
    │   ├── LI.swift
    │   ├── DL.swift
    │   ├── DT.swift
    │   ├── DD.swift
    │   ├── Figure.swift
    │   ├── FigCaption.swift
    │   ├── Main.swift
    │   ├── Search.swift
    │   └── Div.swift
    │
    ├── WHATWG HTML TextSemantics/        # 4.5 Text-Level Semantics
    │   ├── Anchor.swift                  # <a>
    │   ├── Em.swift
    │   ├── Strong.swift
    │   ├── Small.swift
    │   ├── S.swift
    │   ├── Cite.swift
    │   ├── Q.swift
    │   ├── DFN.swift
    │   ├── Abbr.swift
    │   ├── Ruby.swift
    │   ├── RT.swift
    │   ├── RP.swift
    │   ├── Data.swift
    │   ├── Time.swift
    │   ├── Code.swift
    │   ├── Var.swift
    │   ├── Samp.swift
    │   ├── Kbd.swift
    │   ├── Sub.swift
    │   ├── Sup.swift
    │   ├── I.swift
    │   ├── B.swift
    │   ├── U.swift
    │   ├── Mark.swift
    │   ├── BDI.swift
    │   ├── BDO.swift
    │   ├── Span.swift
    │   ├── BR.swift
    │   └── WBR.swift
    │
    ├── WHATWG HTML Links/                # 4.6 Links
    │   ├── LinkTypes.swift
    │   └── LinkRelationships.swift
    │
    ├── WHATWG HTML Edits/                # 4.7 Edits
    │   ├── Ins.swift
    │   └── Del.swift
    │
    ├── WHATWG HTML Embedded/             # 4.8 Embedded Content
    │   ├── Picture.swift
    │   ├── Source.swift
    │   ├── Img.swift
    │   ├── IFrame.swift
    │   ├── Embed.swift
    │   ├── Object.swift
    │   ├── Param.swift
    │   ├── Video.swift
    │   ├── Audio.swift
    │   ├── Track.swift
    │   ├── Map.swift
    │   └── Area.swift
    │
    ├── WHATWG HTML Tables/               # 4.9 Tabular Data
    │   ├── Table.swift
    │   ├── Caption.swift
    │   ├── ColGroup.swift
    │   ├── Col.swift
    │   ├── TBody.swift
    │   ├── THead.swift
    │   ├── TFoot.swift
    │   ├── TR.swift
    │   ├── TD.swift
    │   └── TH.swift
    │
    ├── WHATWG HTML Forms/                # 4.10 Forms
    │   ├── Form.swift
    │   ├── Label.swift
    │   ├── Input.swift
    │   ├── Input/                        # Input type states
    │   │   ├── InputHidden.swift
    │   │   ├── InputText.swift
    │   │   ├── InputSearch.swift
    │   │   ├── InputTel.swift
    │   │   ├── InputURL.swift
    │   │   ├── InputEmail.swift
    │   │   ├── InputPassword.swift
    │   │   ├── InputDate.swift
    │   │   ├── InputMonth.swift
    │   │   ├── InputWeek.swift
    │   │   ├── InputTime.swift
    │   │   ├── InputDateTimeLocal.swift
    │   │   ├── InputNumber.swift
    │   │   ├── InputRange.swift
    │   │   ├── InputColor.swift
    │   │   ├── InputCheckbox.swift
    │   │   ├── InputRadio.swift
    │   │   ├── InputFile.swift
    │   │   ├── InputSubmit.swift
    │   │   ├── InputImage.swift
    │   │   ├── InputReset.swift
    │   │   └── InputButton.swift
    │   ├── Button.swift
    │   ├── Select.swift
    │   ├── DataList.swift
    │   ├── OptGroup.swift
    │   ├── Option.swift
    │   ├── TextArea.swift
    │   ├── Output.swift
    │   ├── Progress.swift
    │   ├── Meter.swift
    │   ├── FieldSet.swift
    │   └── Legend.swift
    │
    ├── WHATWG HTML Interactive/          # 4.11 Interactive Elements
    │   ├── Details.swift
    │   ├── Summary.swift
    │   └── Dialog.swift
    │
    ├── WHATWG HTML Scripting/            # 4.12 Scripting
    │   ├── Script.swift
    │   ├── NoScript.swift
    │   ├── Template.swift
    │   ├── Slot.swift
    │   └── Canvas.swift
    │
    ├── WHATWG HTML CustomElements/       # 4.13 Custom Elements
    │   └── CustomElement.swift
    │
    └── WHATWG HTML Obsolete/             # Obsolete Features
        ├── Acronym.swift
        ├── Applet.swift
        ├── BaseFont.swift
        ├── BigText.swift
        ├── Blink.swift
        ├── Center.swift
        ├── Font.swift
        ├── Frame.swift
        ├── FrameSet.swift
        ├── Marquee.swift
        ├── NoFrames.swift
        └── Strike.swift
```

### Phase 3: Attribute Organization

**Goal**: Group attributes by usage pattern instead of alphabetically

**Rationale**: Attributes are shared across multiple elements. Organizing by usage pattern (global, form-related, link-related, media-related) makes more sense than a flat alphabetical list.

**Proposed attribute module structure**:

```
Sources/
├── WHATWG HTML GlobalAttributes/        # Global attributes (apply to all)
│   ├── Id.swift
│   ├── Class.swift
│   ├── Style.swift
│   ├── Title.swift
│   ├── Lang.swift
│   ├── Dir.swift
│   ├── Hidden.swift
│   ├── TabIndex.swift
│   ├── AccessKey.swift
│   ├── ContentEditable.swift
│   ├── Draggable.swift
│   ├── Spellcheck.swift
│   ├── Translate.swift
│   └── DataAttribute.swift              # data-* pattern
│
├── WHATWG HTML FormAttributes/          # Shared by form elements
│   ├── Name.swift
│   ├── Disabled.swift
│   ├── Form.swift                       # Associates with form
│   ├── Autocomplete.swift
│   ├── Required.swift
│   ├── Readonly.swift
│   ├── Placeholder.swift
│   ├── Value.swift
│   ├── Checked.swift
│   ├── Multiple.swift
│   ├── Pattern.swift
│   ├── Min.swift
│   ├── Max.swift
│   ├── Step.swift
│   └── etc.
│
├── WHATWG HTML LinkAttributes/          # Shared by link/anchor elements
│   ├── Href.swift
│   ├── Target.swift
│   ├── Rel.swift
│   ├── Download.swift
│   ├── Ping.swift
│   ├── ReferrerPolicy.swift
│   └── etc.
│
├── WHATWG HTML MediaAttributes/         # Shared by video/audio elements
│   ├── Src.swift
│   ├── Controls.swift
│   ├── Autoplay.swift
│   ├── Loop.swift
│   ├── Muted.swift
│   ├── Preload.swift
│   ├── Poster.swift                     # video only
│   └── etc.
│
├── WHATWG HTML TableAttributes/         # Shared by table elements
│   ├── ColSpan.swift
│   ├── RowSpan.swift
│   ├── Headers.swift
│   ├── Scope.swift
│   └── etc.
│
└── WHATWG HTML ScriptAttributes/        # Script/style related
    ├── Type.swift
    ├── Async.swift
    ├── Defer.swift
    ├── CrossOrigin.swift
    ├── Integrity.swift
    ├── Nonce.swift
    └── etc.
```

**Attribute namespace pattern**:

```swift
// Global attributes
extension WHATWG_HTML.GlobalAttributes {
    public struct Id: WHATWG_HTML.Attribute {
        @inlinable public static var attribute: String { "id" }
        public var value: String
        public init(_ value: String) { self.value = value }
    }
}

// Form attributes
extension WHATWG_HTML.FormAttributes {
    public struct Required: WHATWG_HTML.BooleanAttribute {
        @inlinable public static var attribute: String { "required" }
        public init() {}
    }
}
```

### Phase 4: Package.swift Update

**Goal**: Define section-based library products and targets

**Proposed Package.swift structure**:

```swift
// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "swift-whatwg-html",
    products: [
        // Core namespace (required by all)
        .library(name: "WHATWG HTML", targets: ["WHATWG HTML"]),

        // Element modules (section-based)
        .library(name: "WHATWG HTML Document", targets: ["WHATWG HTML Document"]),
        .library(name: "WHATWG HTML Metadata", targets: ["WHATWG HTML Metadata"]),
        .library(name: "WHATWG HTML Sections", targets: ["WHATWG HTML Sections"]),
        .library(name: "WHATWG HTML Grouping", targets: ["WHATWG HTML Grouping"]),
        .library(name: "WHATWG HTML TextSemantics", targets: ["WHATWG HTML TextSemantics"]),
        .library(name: "WHATWG HTML Links", targets: ["WHATWG HTML Links"]),
        .library(name: "WHATWG HTML Edits", targets: ["WHATWG HTML Edits"]),
        .library(name: "WHATWG HTML Embedded", targets: ["WHATWG HTML Embedded"]),
        .library(name: "WHATWG HTML Tables", targets: ["WHATWG HTML Tables"]),
        .library(name: "WHATWG HTML Forms", targets: ["WHATWG HTML Forms"]),
        .library(name: "WHATWG HTML Interactive", targets: ["WHATWG HTML Interactive"]),
        .library(name: "WHATWG HTML Scripting", targets: ["WHATWG HTML Scripting"]),
        .library(name: "WHATWG HTML CustomElements", targets: ["WHATWG HTML CustomElements"]),
        .library(name: "WHATWG HTML Obsolete", targets: ["WHATWG HTML Obsolete"]),

        // Attribute modules
        .library(name: "WHATWG HTML GlobalAttributes", targets: ["WHATWG HTML GlobalAttributes"]),
        .library(name: "WHATWG HTML FormAttributes", targets: ["WHATWG HTML FormAttributes"]),
        .library(name: "WHATWG HTML LinkAttributes", targets: ["WHATWG HTML LinkAttributes"]),
        .library(name: "WHATWG HTML MediaAttributes", targets: ["WHATWG HTML MediaAttributes"]),
        .library(name: "WHATWG HTML TableAttributes", targets: ["WHATWG HTML TableAttributes"]),
        .library(name: "WHATWG HTML ScriptAttributes", targets: ["WHATWG HTML ScriptAttributes"]),

        // Convenience umbrella products
        .library(
            name: "WHATWG HTML Elements",
            targets: [
                "WHATWG HTML Document",
                "WHATWG HTML Metadata",
                "WHATWG HTML Sections",
                "WHATWG HTML Grouping",
                "WHATWG HTML TextSemantics",
                "WHATWG HTML Links",
                "WHATWG HTML Edits",
                "WHATWG HTML Embedded",
                "WHATWG HTML Tables",
                "WHATWG HTML Forms",
                "WHATWG HTML Interactive",
                "WHATWG HTML Scripting"
            ]
        ),
        .library(
            name: "WHATWG HTML Attributes",
            targets: [
                "WHATWG HTML GlobalAttributes",
                "WHATWG HTML FormAttributes",
                "WHATWG HTML LinkAttributes",
                "WHATWG HTML MediaAttributes",
                "WHATWG HTML TableAttributes",
                "WHATWG HTML ScriptAttributes"
            ]
        ),

        // Note: Foundation integration uses #if canImport(Foundation) guards
        // within the modules themselves - no separate Foundation products needed
    ],
    dependencies: [
        // Consider: URL type package for URL safety without Foundation
        // .package(url: "https://github.com/swift-standards/swift-url-type", from: "1.0.0")
    ],
    targets: [
        // ============================================================
        // MARK: Core Namespace
        // ============================================================
        .target(
            name: "WHATWG HTML",
            dependencies: [],
            path: "Sources/WHATWG HTML"
        ),

        // ============================================================
        // MARK: Element Targets (Section-Based)
        // ============================================================
        .target(
            name: "WHATWG HTML Document",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes"
            ],
            path: "Sources/WHATWG HTML Document"
        ),
        .target(
            name: "WHATWG HTML Metadata",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes",
                "WHATWG HTML LinkAttributes",
                "WHATWG HTML ScriptAttributes"
            ],
            path: "Sources/WHATWG HTML Metadata"
        ),
        .target(
            name: "WHATWG HTML Sections",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes"
            ],
            path: "Sources/WHATWG HTML Sections"
        ),
        .target(
            name: "WHATWG HTML Grouping",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes"
            ],
            path: "Sources/WHATWG HTML Grouping"
        ),
        .target(
            name: "WHATWG HTML TextSemantics",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes",
                "WHATWG HTML LinkAttributes"  // For <a> element
            ],
            path: "Sources/WHATWG HTML TextSemantics"
        ),
        .target(
            name: "WHATWG HTML Links",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML LinkAttributes"
            ],
            path: "Sources/WHATWG HTML Links"
        ),
        .target(
            name: "WHATWG HTML Edits",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes"
            ],
            path: "Sources/WHATWG HTML Edits"
        ),
        .target(
            name: "WHATWG HTML Embedded",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes",
                "WHATWG HTML MediaAttributes"
            ],
            path: "Sources/WHATWG HTML Embedded"
        ),
        .target(
            name: "WHATWG HTML Tables",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes",
                "WHATWG HTML TableAttributes"
            ],
            path: "Sources/WHATWG HTML Tables"
        ),
        .target(
            name: "WHATWG HTML Forms",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes",
                "WHATWG HTML FormAttributes"
            ],
            path: "Sources/WHATWG HTML Forms"
        ),
        .target(
            name: "WHATWG HTML Interactive",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes"
            ],
            path: "Sources/WHATWG HTML Interactive"
        ),
        .target(
            name: "WHATWG HTML Scripting",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes",
                "WHATWG HTML ScriptAttributes"
            ],
            path: "Sources/WHATWG HTML Scripting"
        ),
        .target(
            name: "WHATWG HTML CustomElements",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes"
            ],
            path: "Sources/WHATWG HTML CustomElements"
        ),
        .target(
            name: "WHATWG HTML Obsolete",
            dependencies: [
                "WHATWG HTML",
                "WHATWG HTML GlobalAttributes"
            ],
            path: "Sources/WHATWG HTML Obsolete"
        ),

        // ============================================================
        // MARK: Attribute Targets (Usage-Based)
        // ============================================================
        .target(
            name: "WHATWG HTML GlobalAttributes",
            dependencies: ["WHATWG HTML"],
            path: "Sources/WHATWG HTML GlobalAttributes"
        ),
        .target(
            name: "WHATWG HTML FormAttributes",
            dependencies: ["WHATWG HTML"],
            path: "Sources/WHATWG HTML FormAttributes"
        ),
        .target(
            name: "WHATWG HTML LinkAttributes",
            dependencies: ["WHATWG HTML"],
            path: "Sources/WHATWG HTML LinkAttributes"
        ),
        .target(
            name: "WHATWG HTML MediaAttributes",
            dependencies: ["WHATWG HTML"],
            path: "Sources/WHATWG HTML MediaAttributes"
        ),
        .target(
            name: "WHATWG HTML TableAttributes",
            dependencies: ["WHATWG HTML"],
            path: "Sources/WHATWG HTML TableAttributes"
        ),
        .target(
            name: "WHATWG HTML ScriptAttributes",
            dependencies: ["WHATWG HTML"],
            path: "Sources/WHATWG HTML ScriptAttributes"
        ),

        // Note: Foundation integration is handled via #if canImport(Foundation)
        // guards within the modules themselves. No separate Foundation targets needed.
        // This approach:
        // - Avoids module duplication
        // - Automatically provides Foundation support when available
        // - Keeps related code together in the same files

        // ============================================================
        // MARK: Test Targets
        // ============================================================
        .testTarget(
            name: "WHATWG HTML".tests,
            dependencies: ["WHATWG HTML Elements", "WHATWG HTML Attributes"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
```

### Phase 5: Documentation Update

**Goal**: Ensure every module has comprehensive documentation

**Module-level documentation template**:

```swift
/// # WHATWG HTML Forms
///
/// This module implements the form elements defined in **Section 4.10 (Forms)**
/// of the WHATWG HTML Living Standard.
///
/// ## Specification
///
/// [WHATWG HTML Standard - Section 4.10 Forms](https://html.spec.whatwg.org/multipage/forms.html)
///
/// ## Overview
///
/// Forms enable user interaction through input controls. This module provides
/// type-safe representations of all form-related elements and their attributes.
///
/// ## Elements
///
/// - `Form` - The `<form>` element
/// - `Input` - The `<input>` element with 21 type variations
/// - `Button` - The `<button>` element
/// - `Select` - The `<select>` element
/// - `DataList` - The `<datalist>` element
/// - `OptGroup` - The `<optgroup>` element
/// - `Option` - The `<option>` element
/// - `TextArea` - The `<textarea>` element
/// - `Output` - The `<output>` element
/// - `Progress` - The `<progress>` element
/// - `Meter` - The `<meter>` element
/// - `FieldSet` - The `<fieldset>` element
/// - `Legend` - The `<legend>` element
///
/// ## Input Types
///
/// The `Input` element supports 21 type states as defined in the specification:
///
/// - Text input: `text`, `search`, `tel`, `url`, `email`, `password`
/// - Date/time: `date`, `month`, `week`, `time`, `datetime-local`
/// - Numeric: `number`, `range`
/// - Selection: `checkbox`, `radio`, `file`, `color`
/// - Buttons: `submit`, `image`, `reset`, `button`
/// - Hidden: `hidden`
///
/// ## Usage Examples
///
/// ### Basic Form
///
/// ```swift
/// import WHATWG_HTML_Forms
/// import WHATWG_HTML_GlobalAttributes
/// import WHATWG_HTML_FormAttributes
///
/// let loginForm = WHATWG_HTML.Forms.Form(
///     action: .relative("/login"),
///     method: .post
/// )
///
/// let emailInput = WHATWG_HTML.Forms.Input.email(
///     name: "email",
///     required: true,
///     placeholder: "you@example.com"
/// )
///
/// let submitButton = WHATWG_HTML.Forms.Button(
///     type: .submit,
///     content: "Sign In"
/// )
/// ```
///
/// ### Advanced Form with Validation
///
/// ```swift
/// let signupForm = WHATWG_HTML.Forms.Form(
///     action: .relative("/signup"),
///     method: .post,
///     novalidate: false
/// )
///
/// let passwordInput = WHATWG_HTML.Forms.Input.password(
///     name: "password",
///     required: true,
///     minLength: 8,
///     pattern: "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
/// )
///
/// let passwordMeter = WHATWG_HTML.Forms.Meter(
///     value: 0.7,
///     min: 0,
///     max: 1,
///     optimum: 1
/// )
/// ```
///
/// ## See Also
///
/// - `WHATWG_HTML.FormAttributes` - Attributes shared across form elements
/// - `WHATWG_HTML.GlobalAttributes` - Attributes applicable to all elements
///
public enum Forms {}
```

### Phase 6: Foundation Integration (Trait-Based)

**Goal**: Maintain Foundation.URL safety with new modular structure using inline conditional compilation and package traits

**Strategy**:
1. Declare a `Foundation` trait in Package.swift to document the integration
2. Use `#if canImport(Foundation)` guards to add Foundation support directly in source files
3. Keep Foundation extensions in the same files as the core types

**Package.swift trait declaration**:
```swift
let package = Package(
    name: "swift-whatwg-html",
    // ...
    traits: [
        .trait(
            name: "Foundation",
            description: "Foundation integration for WHATWG HTML"
        )
    ],
    // ...
)
```

**Source file pattern**:
```swift
// Sources/WHATWG HTML LinkAttributes/Href.swift

extension WHATWG_HTML.LinkAttributes {
    public struct Href: WHATWG_HTML.Attribute {
        @inlinable public static var attribute: String { "href" }

        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

// Foundation integration in same file
#if canImport(Foundation)

extension WHATWG_HTML.LinkAttributes.Href {
    /// Initialize with a Foundation URL
    public init(url: Foundation.URL) {
        self.init(rawValue: url.absoluteString)
    }

    /// Convert to Foundation URL if valid
    public var url: Foundation.URL? {
        Foundation.URL(string: self.rawValue)
    }
}
#endif
```

**Benefits of this approach**:
1. **No module duplication** - Foundation support lives alongside core types
2. **Automatic availability** - When Foundation is available, extensions are available
3. **Single source of truth** - No need to maintain parallel structures
4. **Clear separation** - `#if canImport(Foundation)` makes it obvious what's Foundation-specific
5. **Better IDE support** - All related code in one file
6. **Trait documentation** - Package.swift documents the Foundation integration capability
7. **Zero configuration** - No need to enable traits on individual targets

**Modules that need Foundation support**:
- `WHATWG HTML LinkAttributes` - For `href` URL conversion (e.g., `Href`, `Ping`)
- `WHATWG HTML MediaAttributes` - For `src` URL conversion (e.g., `Src`, `Poster`)
- `WHATWG HTML Forms` - For `action` URL conversion (e.g., `Action`)
- `WHATWG HTML Embedded` - For various URL attributes (img src, iframe src, video poster, etc.)
- `WHATWG HTML Metadata` - For `link` and `base` URLs (e.g., in Link and Base elements)

**Example usage**:
```swift
// When Foundation is available
import WHATWG_HTML_LinkAttributes

let href = WHATWG_HTML.LinkAttributes.Href(url: URL(string: "https://example.com")!)
print(href.url) // Optional(https://example.com)

// Without Foundation (works everywhere)
let href2 = WHATWG_HTML.LinkAttributes.Href(rawValue: "https://example.com")
print(href2.rawValue) // "https://example.com"
```

### Phase 7: Backward Compatibility (Typealiases)

**Goal**: Provide smooth migration path for existing users

**Strategy**: Add typealiases in a compatibility module

```swift
// Sources/HTMLTypes Compatibility/HTMLTypes.swift

@available(*, deprecated, message: "Use WHATWG_HTML.Forms.Form instead. Import 'WHATWG HTML Forms'.")
public typealias Form = WHATWG_HTML.Forms.Form

@available(*, deprecated, message: "Use WHATWG_HTML.Forms.Input instead. Import 'WHATWG HTML Forms'.")
public typealias Input = WHATWG_HTML.Forms.Input

@available(*, deprecated, message: "Use WHATWG_HTML.Sections.Article instead. Import 'WHATWG HTML Sections'.")
public typealias Article = WHATWG_HTML.Sections.Article

// ... etc for all types
```

**Package.swift addition**:
```swift
.library(
    name: "HTMLTypes",  // Legacy name
    targets: ["HTMLTypes Compatibility"]
),
.target(
    name: "HTMLTypes Compatibility",
    dependencies: ["WHATWG HTML Elements", "WHATWG HTML Attributes"],
    path: "Sources/HTMLTypes Compatibility"
),
```

**Migration timeline**:
1. **Version 1.0**: Introduce new structure with compatibility layer
2. **Version 1.x**: Compatibility layer remains, users migrate gradually
3. **Version 2.0**: Remove compatibility layer (major version bump)

---

## 6. Migration Path for Users

### Minimal Disruption Strategy

The refactoring should allow users to migrate at their own pace.

### Phase 1: No Changes Required (Compatibility Layer)

**Users can continue using old API**:

```swift
// Old code continues to work
import HTMLTypes

let form = Form(action: .relative("/submit"))
let button = Button(type: .submit)
let input = Input.email(name: "email", required: true)
```

**What happens**: Typealiases map old names to new namespaced types

**Timeline**: Available in version 1.0+

### Phase 2: Update Imports (Recommended)

**Users update to specific imports**:

```swift
// More specific, better compilation performance
import WHATWG_HTML_Forms
import WHATWG_HTML_GlobalAttributes

let form = Form(action: .relative("/submit"))  // Works the same
let button = Button(type: .submit)
let input = Input.email(name: "email", required: true)
```

**Benefits**:
- Faster compilation (smaller modules)
- Clearer dependencies
- Better IDE performance

**Timeline**: Available in version 1.0+

### Phase 3: Adopt Namespace Syntax (Optional)

**Users fully adopt new pattern**:

```swift
// Explicit namespace usage
import WHATWG_HTML

let form = WHATWG_HTML.Forms.Form(action: .relative("/submit"))
let button = WHATWG_HTML.Forms.Button(type: .submit)
let input = WHATWG_HTML.Forms.Input.email(name: "email", required: true)
```

**Benefits**:
- Explicit about what standard is being used
- No name conflicts with other types
- Matches RFC package pattern

**Timeline**: Available in version 1.0+, required in version 2.0+

### Version 2.0 Breaking Changes

**Changes in 2.0**:
- Remove compatibility layer (typealiases)
- Remove `HTMLTypes`, `HTMLElementTypes`, `HTMLAttributeTypes` modules
- Require explicit namespace or specific module imports

**Migration path**:
1. Update from 1.x to 1.latest
2. Fix deprecation warnings (use Xcode fix-its)
3. Update to 2.0

---

## 7. Future: Tier 2 High-Level Package (coenttb/swift-html)

Once the Tier 1 refactoring is complete, a new high-level package can be created in the coenttb organization.

### Package: coenttb/swift-html

**Purpose**: Developer-friendly HTML generation with builders and components

**Structure**:

```
swift-html/
├── Package.swift
├── README.md
└── Sources/
    ├── HTML/                            # Core builders and protocols
    │   ├── HTML.swift                   # Main protocol
    │   ├── HTMLBuilder.swift            # @resultBuilder
    │   ├── HTMLRenderer.swift           # Rendering engine
    │   ├── HTMLPrinter.swift            # Pretty printing
    │   └── HTMLDocument.swift           # Document wrapper
    │
    ├── HTML Elements/                   # Element extensions with builders
    │   ├── Form+Builder.swift
    │   ├── Table+Builder.swift
    │   ├── List+Builder.swift
    │   ├── Navigation+Builder.swift
    │   └── Media+Builder.swift
    │
    ├── HTML Components/                 # Higher-level components
    │   ├── Card.swift
    │   ├── Hero.swift
    │   ├── Navigation.swift
    │   ├── Breadcrumbs.swift
    │   ├── Pagination.swift
    │   ├── Alert.swift
    │   ├── Modal.swift
    │   └── Dropdown.swift
    │
    ├── HTML Themes/                     # Theming support
    │   ├── Theme.swift
    │   ├── DefaultTheme.swift
    │   └── ThemeContext.swift
    │
    └── HTML Integration/                # Integration with other packages
        ├── HTML+CSS.swift               # swift-css integration
        ├── HTML+Markdown.swift          # Markdown support
        └── HTML+SVG.swift               # SVG integration
```

**Dependencies**:
```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-whatwg-html", from: "1.0.0"),
    .package(url: "https://github.com/coenttb/swift-css", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
]
```

**Example usage**:

```swift
import HTML
import WHATWG_HTML

let page = HTMLDocument {
    Head {
        Title("My Page")
        Meta(charset: "utf-8")
        Link(rel: .stylesheet, href: "/styles.css")
    }
    Body {
        Header {
            Navigation {
                Link("Home", href: "/")
                Link("About", href: "/about")
                Link("Contact", href: "/contact")
            }
        }

        Main {
            Hero(
                title: "Welcome",
                subtitle: "Build modern websites with Swift"
            )

            Card {
                CardTitle("Features")
                CardContent {
                    List {
                        ListItem("Type-safe HTML")
                        ListItem("Swift DSL")
                        ListItem("Component library")
                    }
                }
            }
        }

        Footer {
            Text("© 2025 My Company")
        }
    }
}
.theme(.default)

print(page.render())
```

---

## 8. Benefits of Refactoring

### For Developers Using the Package

1. **Better Discoverability**
   - Elements grouped by purpose (Forms, Tables, Media)
   - Easy to find related elements
   - IDE autocomplete scoped to relevant section

2. **Import Only What You Need**
   - `import WHATWG_HTML_Forms` for form-heavy pages
   - `import WHATWG_HTML_Tables` for data tables
   - Smaller dependency graph

3. **Faster Compilation**
   - Smaller modules = faster incremental builds
   - Changes to Forms don't recompile Tables
   - Better build parallelization

4. **Clearer Mental Model**
   - Package structure matches spec structure
   - Easy to reference spec documentation
   - Learning HTML spec teaches package structure

5. **Better IDE Performance**
   - Smaller autocomplete scopes
   - Faster symbol resolution
   - Less memory usage

### For Maintainers

1. **Spec Alignment**
   - Easy to track spec changes section by section
   - Clear mapping: spec section → module
   - Spec updates are straightforward

2. **Parallel Development**
   - Different contributors can work on different sections
   - Less merge conflicts
   - Independent testing per section

3. **Targeted Testing**
   - Test modules in isolation
   - Easier to identify failing areas
   - Better test organization

4. **Clear Ownership**
   - Sections can have designated maintainers
   - Code review scoped to relevant modules
   - Expertise can be section-specific

5. **Release Flexibility**
   - Could version sections independently if needed
   - Experimental sections can be marked as such
   - Stable sections unaffected by experimental work

### For the Swift-Standards Ecosystem

1. **Consistent Pattern**
   - Matches RFC package architecture
   - Follows established conventions
   - Easy for users of other swift-standards packages

2. **Composability**
   - Other packages can depend on specific sections
   - Minimal dependency footprint
   - Clear separation of concerns

3. **Interoperability**
   - Foundation integration follows pattern
   - Easy to add other integrations (URL types, etc.)
   - Works with coenttb high-level packages

4. **Future-Proofing**
   - Easy to add new spec sections
   - Can deprecate obsolete features cleanly
   - Extensible architecture

### For the Broader Swift Community

1. **Educational Value**
   - Package teaches HTML spec structure
   - Reference implementation of WHATWG standard
   - Demonstrates swift-standards pattern

2. **Type Safety**
   - Compile-time validation of HTML structure
   - Catch errors before runtime
   - Self-documenting code

3. **Server-Side Swift**
   - Better foundation for SSR frameworks
   - Type-safe templating
   - Swift-first web development

---

## 9. Implementation Priority

### High Priority (Core Value Proposition) 🔴

These tasks provide immediate, significant value and should be completed first.

**P0 - Essential**:
1. ✅ Create `WHATWG HTML` namespace module with core protocols
2. ✅ Create `WHATWG HTML GlobalAttributes` module
3. ✅ Create `WHATWG HTML Forms` module (largest, most-used section)
4. ✅ Update Package.swift with new products and targets
5. ✅ Add backward compatibility layer (typealiases)

**Rationale**: These provide the foundation and most-used functionality. Forms are used in nearly every web application, and global attributes apply to all elements.

**Estimated effort**: 2-3 weeks for experienced contributor

### Medium Priority (Quality of Life) 🟡

These tasks improve usability and complete the refactoring.

**P1 - Important**:
6. ✅ Create remaining element section modules:
   - Sections, Grouping, TextSemantics
   - Embedded, Tables, Interactive, Scripting
   - Metadata, Document, Edits, Links
7. ✅ Create remaining attribute modules:
   - FormAttributes, LinkAttributes, MediaAttributes
   - TableAttributes, ScriptAttributes
8. ✅ Add module-level documentation to all modules
9. ✅ Update README with new import examples
10. ✅ Create MIGRATION_GUIDE.md

**Rationale**: Completes the refactoring and provides comprehensive documentation.

**Estimated effort**: 3-4 weeks for experienced contributor

### Low Priority (Nice to Have) 🟢

These tasks are valuable but not essential for the core refactoring.

**P2 - Optional**:
11. ⭕ Create Foundation integration modules
12. ⭕ Add comprehensive test coverage for new structure
13. ⭕ Create example projects demonstrating new API
14. ⭕ Performance benchmarking (compilation time comparison)
15. ⭕ Add DocC documentation bundle

**Rationale**: These add polish and additional features but aren't required for the refactoring to be complete.

**Estimated effort**: 2-3 weeks for experienced contributor

### Future Work (Separate Project) 🔵

**P3 - Post-Refactoring**:
16. ⭕ Create coenttb/swift-html package (Tier 2)
17. ⭕ Implement @HTMLBuilder result builder
18. ⭕ Create component library
19. ⭕ Add theming support
20. ⭕ Integration with swift-css, swift-tailwind

**Rationale**: This is a separate Tier 2 package that builds on the refactored foundation. Should be a separate project/repository.

**Estimated effort**: 4-6 weeks for experienced contributor

---

## 10. Success Criteria

The refactoring will be considered successful when:

### Functional Requirements ✅

- [ ] All current functionality is preserved
- [ ] All existing tests pass with new structure
- [ ] Backward compatibility layer works correctly
- [ ] All 125 elements are accessible in new structure
- [ ] All 125+ attributes are accessible in new structure
- [ ] Input type specialization is maintained
- [ ] Foundation integration is preserved

### Structural Requirements ✅

- [ ] Package structure matches WHATWG spec sections
- [ ] Namespace pattern is consistently applied
- [ ] Module dependencies are minimal and correct
- [ ] Attributes are organized by usage pattern
- [ ] Global attributes are in dedicated module
- [ ] Form elements are in dedicated module

### Documentation Requirements ✅

- [ ] Every module has comprehensive documentation
- [ ] Documentation references spec sections with links
- [ ] README is updated with new examples
- [ ] MIGRATION_GUIDE.md is created
- [ ] Deprecation messages guide users to new APIs

### Quality Requirements ✅

- [ ] No compiler warnings
- [ ] All code follows Swift 6 conventions
- [ ] Sendable conformances where appropriate
- [ ] Performance is equivalent or better than before
- [ ] Compilation time is equal or faster

### User Experience Requirements ✅

- [ ] Existing code continues to work (via typealiases)
- [ ] New imports are straightforward
- [ ] IDE autocomplete is improved
- [ ] Error messages are clear and helpful

---

## 11. Risk Mitigation

### Potential Risks

1. **Breaking existing users**: Mitigated by backward compatibility layer
2. **Incomplete migration**: Mitigated by phased approach with testing
3. **Specification changes**: Mitigated by spec alignment making updates easier
4. **Increased complexity**: Mitigated by clear documentation and examples
5. **Longer initial compilation**: Mitigated by modular imports allowing subset usage

### Testing Strategy

1. **Unit tests**: Test each module independently
2. **Integration tests**: Test cross-module dependencies
3. **Compatibility tests**: Verify typealiases work correctly
4. **Performance tests**: Benchmark compilation time before/after
5. **Documentation tests**: Verify examples compile and run

---

## 12. Timeline Estimate

**Phase 1 (Weeks 1-2)**: Foundation
- Create namespace module
- Create GlobalAttributes module
- Create Forms module
- Basic Package.swift updates

**Phase 2 (Weeks 3-4)**: Core Sections
- Create element section modules (Sections, Grouping, TextSemantics)
- Create additional attribute modules (FormAttributes, LinkAttributes)

**Phase 3 (Weeks 5-6)**: Remaining Sections
- Complete all element modules
- Complete all attribute modules
- Full Package.swift with all targets

**Phase 4 (Week 7)**: Compatibility & Documentation
- Add backward compatibility layer
- Module documentation
- README and MIGRATION_GUIDE

**Phase 5 (Week 8)**: Polish & Release
- Testing
- Performance validation
- Release preparation

**Total estimate**: 8 weeks for complete refactoring

---

## 13. Conclusion

This refactoring will transform swift-whatwg-html from a monolithic package into a **modular, spec-aligned, standard-compliant Swift package** that:

1. **Follows the swift-standards pattern** - Two-tier architecture with pure types in Tier 1
2. **Mirrors the WHATWG HTML specification** - Package structure matches spec structure
3. **Uses namespace pattern** - Consistent with RFC packages (`WHATWG_HTML.*`)
4. **Enables modular imports** - Import only Forms, or Tables, or what you need
5. **Maintains backward compatibility** - Existing code continues to work
6. **Sets foundation for Tier 2** - Enables future coenttb/swift-html package
7. **Improves developer experience** - Better discoverability, faster compilation, clearer structure

The refactoring should be done in **phases**, starting with the namespace and most-used modules (GlobalAttributes, Forms), then expanding to all sections, and finally adding documentation and polish.

The end result will be a **state-of-the-art Swift implementation of the WHATWG HTML standard** that serves as both a practical tool for Swift developers and a reference implementation of the specification.

---

## Appendix A: Namespace Pattern Examples

### Current Pattern (No Namespace)

```swift
import HTMLElementTypes

let form = Form(action: .relative("/submit"))
let input = Input.email(name: "email")
```

### New Pattern (With Namespace)

```swift
import WHATWG_HTML

let form = WHATWG_HTML.Forms.Form(action: .relative("/submit"))
let input = WHATWG_HTML.Forms.Input.email(name: "email")
```

### Convenience Typealias (User-Defined)

Users can create their own convenience typealiases:

```swift
import WHATWG_HTML

typealias HTML = WHATWG_HTML.Forms
typealias Attr = WHATWG_HTML.GlobalAttributes

let form = HTML.Form(action: .relative("/submit"))
let id = Attr.Id("my-form")
```

---

## Appendix B: Module Dependency Graph

```
WHATWG HTML (core namespace)
├── WHATWG HTML GlobalAttributes
│   └── (no dependencies except core)
├── WHATWG HTML FormAttributes
│   └── (no dependencies except core)
├── WHATWG HTML LinkAttributes
│   └── (no dependencies except core)
├── WHATWG HTML MediaAttributes
│   └── (no dependencies except core)
├── WHATWG HTML TableAttributes
│   └── (no dependencies except core)
├── WHATWG HTML ScriptAttributes
│   └── (no dependencies except core)
│
├── WHATWG HTML Document
│   └── depends on: GlobalAttributes
├── WHATWG HTML Metadata
│   └── depends on: GlobalAttributes, LinkAttributes, ScriptAttributes
├── WHATWG HTML Sections
│   └── depends on: GlobalAttributes
├── WHATWG HTML Grouping
│   └── depends on: GlobalAttributes
├── WHATWG HTML TextSemantics
│   └── depends on: GlobalAttributes, LinkAttributes
├── WHATWG HTML Links
│   └── depends on: LinkAttributes
├── WHATWG HTML Edits
│   └── depends on: GlobalAttributes
├── WHATWG HTML Embedded
│   └── depends on: GlobalAttributes, MediaAttributes
├── WHATWG HTML Tables
│   └── depends on: GlobalAttributes, TableAttributes
├── WHATWG HTML Forms
│   └── depends on: GlobalAttributes, FormAttributes
├── WHATWG HTML Interactive
│   └── depends on: GlobalAttributes
├── WHATWG HTML Scripting
│   └── depends on: GlobalAttributes, ScriptAttributes
└── WHATWG HTML CustomElements
    └── depends on: GlobalAttributes
```

---

## Appendix C: Complete File Reorganization Map

This appendix shows exactly where each existing file should move in the new structure.

### Elements Migration Map

**From**: `Sources/HTMLElementTypes/Elements/`
**To**: Various section modules

| Current File | New Location | Module |
|--------------|--------------|--------|
| A.swift | WHATWG HTML TextSemantics/Anchor.swift | TextSemantics |
| Abbr.swift | WHATWG HTML TextSemantics/Abbr.swift | TextSemantics |
| Address.swift | WHATWG HTML Sections/Address.swift | Sections |
| Area.swift | WHATWG HTML Embedded/Area.swift | Embedded |
| Article.swift | WHATWG HTML Sections/Article.swift | Sections |
| Aside.swift | WHATWG HTML Sections/Aside.swift | Sections |
| Audio.swift | WHATWG HTML Embedded/Audio.swift | Embedded |
| B.swift | WHATWG HTML TextSemantics/B.swift | TextSemantics |
| Base.swift | WHATWG HTML Metadata/Base.swift | Metadata |
| Bdi.swift | WHATWG HTML TextSemantics/BDI.swift | TextSemantics |
| Bdo.swift | WHATWG HTML TextSemantics/BDO.swift | TextSemantics |
| Blockquote.swift | WHATWG HTML Grouping/Blockquote.swift | Grouping |
| Body.swift | WHATWG HTML Sections/Body.swift | Sections |
| Br.swift | WHATWG HTML TextSemantics/BR.swift | TextSemantics |
| Button.swift | WHATWG HTML Forms/Button.swift | Forms |
| Canvas.swift | WHATWG HTML Scripting/Canvas.swift | Scripting |
| Caption.swift | WHATWG HTML Tables/Caption.swift | Tables |
| Cite.swift | WHATWG HTML TextSemantics/Cite.swift | TextSemantics |
| Code.swift | WHATWG HTML TextSemantics/Code.swift | TextSemantics |
| Col.swift | WHATWG HTML Tables/Col.swift | Tables |
| Colgroup.swift | WHATWG HTML Tables/ColGroup.swift | Tables |
| Data.swift | WHATWG HTML TextSemantics/Data.swift | TextSemantics |
| Datalist.swift | WHATWG HTML Forms/DataList.swift | Forms |
| Dd.swift | WHATWG HTML Grouping/DD.swift | Grouping |
| Del.swift | WHATWG HTML Edits/Del.swift | Edits |
| Details.swift | WHATWG HTML Interactive/Details.swift | Interactive |
| Dfn.swift | WHATWG HTML TextSemantics/DFN.swift | TextSemantics |
| Dialog.swift | WHATWG HTML Interactive/Dialog.swift | Interactive |
| Div.swift | WHATWG HTML Grouping/Div.swift | Grouping |
| Dl.swift | WHATWG HTML Grouping/DL.swift | Grouping |
| Dt.swift | WHATWG HTML Grouping/DT.swift | Grouping |
| Em.swift | WHATWG HTML TextSemantics/Em.swift | TextSemantics |
| Embed.swift | WHATWG HTML Embedded/Embed.swift | Embedded |
| Fieldset.swift | WHATWG HTML Forms/FieldSet.swift | Forms |
| Figcaption.swift | WHATWG HTML Grouping/FigCaption.swift | Grouping |
| Figure.swift | WHATWG HTML Grouping/Figure.swift | Grouping |
| Footer.swift | WHATWG HTML Sections/Footer.swift | Sections |
| Form.swift | WHATWG HTML Forms/Form.swift | Forms |
| H1.swift | WHATWG HTML Sections/Heading.swift | Sections |
| H2.swift | WHATWG HTML Sections/Heading.swift | Sections |
| H3.swift | WHATWG HTML Sections/Heading.swift | Sections |
| H4.swift | WHATWG HTML Sections/Heading.swift | Sections |
| H5.swift | WHATWG HTML Sections/Heading.swift | Sections |
| H6.swift | WHATWG HTML Sections/Heading.swift | Sections |
| Head.swift | WHATWG HTML Metadata/Head.swift | Metadata |
| Header.swift | WHATWG HTML Sections/Header.swift | Sections |
| Hgroup.swift | WHATWG HTML Sections/HGroup.swift | Sections |
| Hr.swift | WHATWG HTML Grouping/HR.swift | Grouping |
| Html.swift | WHATWG HTML Document/HTML.swift | Document |
| I.swift | WHATWG HTML TextSemantics/I.swift | TextSemantics |
| Iframe.swift | WHATWG HTML Embedded/IFrame.swift | Embedded |
| Img.swift | WHATWG HTML Embedded/Img.swift | Embedded |
| Input.swift | WHATWG HTML Forms/Input.swift | Forms |
| Ins.swift | WHATWG HTML Edits/Ins.swift | Edits |
| Kbd.swift | WHATWG HTML TextSemantics/Kbd.swift | TextSemantics |
| Label.swift | WHATWG HTML Forms/Label.swift | Forms |
| Legend.swift | WHATWG HTML Forms/Legend.swift | Forms |
| Li.swift | WHATWG HTML Grouping/LI.swift | Grouping |
| Link.swift | WHATWG HTML Metadata/Link.swift | Metadata |
| Main.swift | WHATWG HTML Grouping/Main.swift | Grouping |
| Map.swift | WHATWG HTML Embedded/Map.swift | Embedded |
| Mark.swift | WHATWG HTML TextSemantics/Mark.swift | TextSemantics |
| Menu.swift | WHATWG HTML Grouping/Menu.swift | Grouping |
| Meta.swift | WHATWG HTML Metadata/Meta.swift | Metadata |
| Meter.swift | WHATWG HTML Forms/Meter.swift | Forms |
| Nav.swift | WHATWG HTML Sections/Nav.swift | Sections |
| Noscript.swift | WHATWG HTML Scripting/NoScript.swift | Scripting |
| Object.swift | WHATWG HTML Embedded/Object.swift | Embedded |
| Ol.swift | WHATWG HTML Grouping/OL.swift | Grouping |
| Optgroup.swift | WHATWG HTML Forms/OptGroup.swift | Forms |
| Option.swift | WHATWG HTML Forms/Option.swift | Forms |
| Output.swift | WHATWG HTML Forms/Output.swift | Forms |
| P.swift | WHATWG HTML Grouping/Paragraph.swift | Grouping |
| Picture.swift | WHATWG HTML Embedded/Picture.swift | Embedded |
| Pre.swift | WHATWG HTML Grouping/Pre.swift | Grouping |
| Progress.swift | WHATWG HTML Forms/Progress.swift | Forms |
| Q.swift | WHATWG HTML TextSemantics/Q.swift | TextSemantics |
| Rp.swift | WHATWG HTML TextSemantics/RP.swift | TextSemantics |
| Rt.swift | WHATWG HTML TextSemantics/RT.swift | TextSemantics |
| Ruby.swift | WHATWG HTML TextSemantics/Ruby.swift | TextSemantics |
| S.swift | WHATWG HTML TextSemantics/S.swift | TextSemantics |
| Samp.swift | WHATWG HTML TextSemantics/Samp.swift | TextSemantics |
| Script.swift | WHATWG HTML Scripting/Script.swift | Scripting |
| Search.swift | WHATWG HTML Grouping/Search.swift | Grouping |
| Section.swift | WHATWG HTML Sections/Section.swift | Sections |
| Select.swift | WHATWG HTML Forms/Select.swift | Forms |
| Slot.swift | WHATWG HTML Scripting/Slot.swift | Scripting |
| Small.swift | WHATWG HTML TextSemantics/Small.swift | TextSemantics |
| Source.swift | WHATWG HTML Embedded/Source.swift | Embedded |
| Span.swift | WHATWG HTML TextSemantics/Span.swift | TextSemantics |
| Strong.swift | WHATWG HTML TextSemantics/Strong.swift | TextSemantics |
| Style.swift | WHATWG HTML Metadata/Style.swift | Metadata |
| Sub.swift | WHATWG HTML TextSemantics/Sub.swift | TextSemantics |
| Summary.swift | WHATWG HTML Interactive/Summary.swift | Interactive |
| Sup.swift | WHATWG HTML TextSemantics/Sup.swift | TextSemantics |
| Table.swift | WHATWG HTML Tables/Table.swift | Tables |
| Tbody.swift | WHATWG HTML Tables/TBody.swift | Tables |
| Td.swift | WHATWG HTML Tables/TD.swift | Tables |
| Template.swift | WHATWG HTML Scripting/Template.swift | Scripting |
| Textarea.swift | WHATWG HTML Forms/TextArea.swift | Forms |
| Tfoot.swift | WHATWG HTML Tables/TFoot.swift | Tables |
| Th.swift | WHATWG HTML Tables/TH.swift | Tables |
| Thead.swift | WHATWG HTML Tables/THead.swift | Tables |
| Time.swift | WHATWG HTML TextSemantics/Time.swift | TextSemantics |
| Title.swift | WHATWG HTML Metadata/Title.swift | Metadata |
| Tr.swift | WHATWG HTML Tables/TR.swift | Tables |
| Track.swift | WHATWG HTML Embedded/Track.swift | Embedded |
| U.swift | WHATWG HTML TextSemantics/U.swift | TextSemantics |
| Ul.swift | WHATWG HTML Grouping/UL.swift | Grouping |
| Var.swift | WHATWG HTML TextSemantics/Var.swift | TextSemantics |
| Video.swift | WHATWG HTML Embedded/Video.swift | Embedded |
| Wbr.swift | WHATWG HTML TextSemantics/WBR.swift | TextSemantics |

### Input Types Migration Map

**From**: `Sources/HTMLElementTypes/Elements/Input.Types/`
**To**: `Sources/WHATWG HTML Forms/Input/`

All input type files stay in the Forms module but in an Input subdirectory.

---

## Appendix D: Quick Reference Card

### Old API → New API

```swift
// OLD (works with compatibility layer)
import HTMLTypes
let form = Form(...)
let input = Input.email(...)

// NEW (specific module)
import WHATWG_HTML_Forms
let form = Form(...)  // Same syntax
let input = Input.email(...)  // Same syntax

// NEW (namespace)
import WHATWG_HTML
let form = WHATWG_HTML.Forms.Form(...)
let input = WHATWG_HTML.Forms.Input.email(...)
```

### Common Imports

```swift
// Just forms
import WHATWG_HTML_Forms

// Forms + global attrs
import WHATWG_HTML_Forms
import WHATWG_HTML_GlobalAttributes

// Everything
import WHATWG_HTML_Elements
import WHATWG_HTML_Attributes

// Just the namespace
import WHATWG_HTML
```

---

**End of Document**

This document should serve as a comprehensive guide for refactoring swift-whatwg-html to align with the WHATWG specification structure and the swift-standards architectural pattern. It can be used as both a planning document and an implementation reference.
