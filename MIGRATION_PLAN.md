# Migration Plan: Old Structure → New Modular Structure

## Summary

We have a working implementation in the old flat structure that needs to be migrated to the new spec-aligned modular structure. **Nothing will be deleted** - just reorganized.

## Current Structure (Old)

```
Sources/
├── HTMLTypes/
│   ├── WHATWG_HTML.swift (namespace enum with FormData)
│   ├── exports.swift
│   ├── Conveniences/
│   └── Documentation.docc/
│
├── HTMLElementTypes/
│   ├── HTMLElement.swift (protocols)
│   └── Elements/ (126 files including Input.Types/)
│
├── HTMLAttributeTypes/
│   ├── HTMLAttribute.swift
│   ├── HTMLBooleanAttribute.swift
│   ├── HTMLStringAttribute.swift
│   └── Attributes/
│       ├── (125 attribute files)
│       └── Global/ (32 global attribute files)
│
├── HTMLTypesFoundation/
├── HTMLElementTypesFoundation/
└── HTMLAttributeTypesFoundation/
```

## Target Structure (New)

```
Sources/
├── WHATWG HTML Shared/           # Core namespace + protocols
│   ├── WHATWG_HTML.swift          # Namespace enum
│   ├── Element.swift              # HTMLElement protocol
│   ├── Attribute.swift            # HTMLAttribute protocol
│   ├── VoidElement.swift          # HTMLVoidElement protocol
│   ├── BooleanAttribute.swift     # HTMLBooleanAttribute
│   └── StringAttribute.swift      # HTMLStringAttribute
│
├── WHATWG HTML GlobalAttributes/  # 32 global attributes
├── WHATWG HTML FormAttributes/    # Form-specific attributes
├── WHATWG HTML LinkAttributes/    # Link-specific attributes
├── WHATWG HTML MediaAttributes/   # Media-specific attributes
├── WHATWG HTML TableAttributes/   # Table-specific attributes
├── WHATWG HTML ScriptAttributes/  # Script-specific attributes
│
├── WHATWG HTML Document/          # <html>
├── WHATWG HTML Metadata/          # <head>, <title>, <base>, <link>, <meta>, <style>
├── WHATWG HTML Sections/          # <body>, <article>, <section>, <nav>, <aside>, <h1-6>, <header>, <footer>, <address>
├── WHATWG HTML Grouping/          # <p>, <hr>, <pre>, <blockquote>, <ol>, <ul>, <li>, <dl>, <dt>, <dd>, <figure>, <main>, <div>
├── WHATWG HTML TextSemantics/     # <a>, <em>, <strong>, <small>, <s>, <cite>, <q>, <abbr>, <code>, <span>, <br>, etc.
├── WHATWG HTML Links/             # Link types and relationships
├── WHATWG HTML Edits/             # <ins>, <del>
├── WHATWG HTML Embedded/          # <img>, <iframe>, <embed>, <object>, <param>, <video>, <audio>, <source>, <track>, <map>, <area>, <picture>
├── WHATWG HTML Tables/            # <table>, <caption>, <colgroup>, <col>, <tbody>, <thead>, <tfoot>, <tr>, <td>, <th>
├── WHATWG HTML Forms/             # <form>, <label>, <input>, <button>, <select>, <textarea>, <fieldset>, <legend>, etc.
├── WHATWG HTML Interactive/       # <details>, <summary>, <dialog>
├── WHATWG HTML Scripting/         # <script>, <noscript>, <template>, <slot>, <canvas>
├── WHATWG HTML CustomElements/    # Custom element infrastructure
├── WHATWG HTML Obsolete/          # <big>, <center>, <font>, <marquee>, <frame>, <frameset>, etc.
│
├── WHATWG HTML Elements/          # Umbrella (re-exports all element modules)
├── WHATWG HTML Attributes/        # Umbrella (re-exports all attribute modules)
└── WHATWG HTML/                   # Main umbrella (everything)
```

## Migration Steps

### Phase 1: Core Shared Module ✅ READY TO START

Move protocols and namespace to `WHATWG HTML Shared/`:

1. **Copy** `HTMLTypes/WHATWG_HTML.swift` → `WHATWG HTML Shared/WHATWG_HTML.swift`
2. **Copy** `HTMLElementTypes/HTMLElement.swift` → `WHATWG HTML Shared/Element.swift`
   - Rename protocols to be inside WHATWG_HTML namespace
3. **Copy** `HTMLAttributeTypes/HTMLAttribute.swift` → `WHATWG HTML Shared/Attribute.swift`
4. **Copy** `HTMLAttributeTypes/HTMLBooleanAttribute.swift` → `WHATWG HTML Shared/BooleanAttribute.swift`
5. **Copy** `HTMLAttributeTypes/HTMLStringAttribute.swift` → `WHATWG HTML Shared/StringAttribute.swift`

### Phase 2: Global Attributes

Move `HTMLAttributeTypes/Attributes/Global/*` → `WHATWG HTML GlobalAttributes/`

32 files:
- Accesskey, Autocapitalize, Autofocus, Class, ContentEditable, ContextMenu, CustomData, Dir, Draggable, EnterKeyHint, ExportParts, Hidden, Id, Inert, InputMode, Is, ItemId, ItemProp, ItemRef, ItemScope, ItemType, Lang, Nonce, Part, Popover, Role, Slot, Spellcheck, Style, TabIndex, Title, Translate

### Phase 3: Element Modules (Spec-Aligned)

Map and move elements from `HTMLElementTypes/Elements/` to appropriate modules:

#### 4.1 Document → `WHATWG HTML Document/`
- `html Document.swift` → `HTML.swift`

#### 4.2 Metadata → `WHATWG HTML Metadata/`
- `head Document Head.swift` → `Head.swift`
- `title Document Title.swift` → `Title.swift`
- `base Document Base URL.swift` → `Base.swift`
- `link External Resource Link.swift` → `Link.swift`
- `meta Metadata.swift` → `Meta.swift`
- `style Embedded Style.swift` → `Style.swift`

#### 4.3 Sections → `WHATWG HTML Sections/`
- `body Document Body.swift` → `Body.swift`
- `article Article Contents.swift` → `Article.swift`
- `section Thematic Section.swift` → `Section.swift`
- `nav Navigation Links.swift` → `Nav.swift`
- `aside Aside.swift` → `Aside.swift`
- `h1 Heading.swift`, `h2 Heading.swift`, ... `h6 Heading.swift` → Combine into `Headings.swift`
- `hgroup Heading Group.swift` → `HGroup.swift`
- `header Introductory Content.swift` → `Header.swift`
- `footer Footer.swift` → `Footer.swift`
- `address Contact Address.swift` → `Address.swift`

#### 4.4 Grouping → `WHATWG HTML Grouping/`
- `p Paragraph.swift` → `Paragraph.swift`
- `hr Thematic Break.swift` → `ThematicBreak.swift` (HR)
- `pre Preformatted Text.swift` → `Pre.swift`
- `blockquote Block Quotation.swift` → `Blockquote.swift`
- `ol Ordered List.swift` → `OrderedList.swift` (OL)
- `ul Unordered List.swift` → `UnorderedList.swift` (UL)
- `menu Menu.swift` → `Menu.swift`
- `li List Item.swift` → `ListItem.swift` (LI)
- `dl Description List.swift` → `DescriptionList.swift` (DL)
- `dt Description Term.swift` → `DescriptionTerm.swift` (DT)
- `dd Description Details.swift` → `DescriptionDetails.swift` (DD)
- `figure Figure.swift` → `Figure.swift`
- `figcaption Figure Caption.swift` → `FigCaption.swift`
- `main Main Content.swift` → `Main.swift`
- `search Search.swift` → `Search.swift`
- `div Generic Container.swift` → `Div.swift`

#### 4.5 Text Semantics → `WHATWG HTML TextSemantics/`
- `a Anchor.swift` → `Anchor.swift`
- `em Emphasis.swift` → `Em.swift`
- `strong Strong Importance.swift` → `Strong.swift`
- `small Side Comment.swift` → `Small.swift`
- `s Strikethrough.swift` → `S.swift`
- `cite Citation.swift` → `Cite.swift`
- `q Inline Quotation.swift` → `Q.swift`
- `dfn Definition.swift` → `DFN.swift`
- `abbr Abbreviation.swift` → `Abbr.swift`
- `ruby Ruby Annotation.swift`, `rt Ruby Text.swift`, `rp Ruby Parenthesis.swift`
- `data Machine Readable.swift` → `Data.swift`
- `time Date Time.swift` → `Time.swift`
- `code Computer Code.swift` → `Code.swift`
- `var Variable.swift` → `Var.swift`
- `samp Sample Output.swift` → `Samp.swift`
- `kbd Keyboard Input.swift` → `Kbd.swift`
- `sub Subscript.swift`, `sup Superscript.swift`
- `i Alternate Voice.swift` → `I.swift`
- `b Bring Attention To.swift` → `B.swift`
- `u Unarticulated Annotation.swift` → `U.swift`
- `mark Marked Text.swift` → `Mark.swift`
- `bdi Bidirectional Isolate.swift` → `BDI.swift`
- `bdo Bidirectional Text Override.swift` → `BDO.swift`
- `span Generic Inline.swift` → `Span.swift`
- `br Line Break.swift` → `BR.swift`
- `wbr Line Break Opportunity.swift` → `WBR.swift`

#### 4.7 Edits → `WHATWG HTML Edits/`
- `ins Inserted Text.swift` → `Ins.swift`
- `del Deleted Text.swift` → `Del.swift`

#### 4.8 Embedded → `WHATWG HTML Embedded/`
- `picture Picture.swift` → `Picture.swift`
- `source Media Source.swift` → `Source.swift`
- `img Image.swift` → `Image.swift`
- `iframe Inline Frame.swift` → `IFrame.swift`
- `embed Embed External.swift` → `Embed.swift`
- `object External Object.swift` → `Object.swift`
- `param Object Parameter.swift` → `Param.swift`
- `video Embed Video.swift` → `Video.swift`
- `audio Embed Audio.swift` → `Audio.swift`
- `track Text Track.swift` → `Track.swift`
- `map Image Map.swift` → `Map.swift`
- `area Image Map Area.swift` → `Area.swift`

#### 4.9 Tables → `WHATWG HTML Tables/`
- `table Table.swift` → `Table.swift`
- `caption Table Caption.swift` → `Caption.swift`
- `colgroup Column Group.swift` → `ColGroup.swift`
- `col Table Column.swift` → `Col.swift` (TableColumn)
- `tbody Table Body.swift` → `TBody.swift`
- `thead Table Header Group.swift` → `THead.swift`
- `tfoot Table Footer Group.swift` → `TFoot.swift`
- `tr Table Row.swift` → `TR.swift`
- `td Table Data Cell.swift` → `TD.swift`
- `th Table Header Cell.swift` → `TH.swift`

#### 4.10 Forms → `WHATWG HTML Forms/`
- `form Form.swift` → `Form.swift`
- `label Form Label.swift` → `Label.swift`
- `input Input.swift` + `Input.Types/` → `Input.swift` + `Input/`
- `button Button.swift` → `Button.swift`
- `select Selection Control.swift` → `Select.swift`
- `datalist Data List.swift` → `DataList.swift`
- `optgroup Option Group.swift` → `OptGroup.swift`
- `option Option.swift` → `Option.swift`
- `textarea Text Area.swift` → `TextArea.swift`
- `output Calculation Output.swift` → `Output.swift`
- `progress Progress Indicator.swift` → `Progress.swift`
- `meter Scalar Measurement.swift` → `Meter.swift`
- `fieldset Form Field Set.swift` → `FieldSet.swift`
- `legend Field Set Legend.swift` → `Legend.swift`

#### 4.11 Interactive → `WHATWG HTML Interactive/`
- `details Disclosure Widget.swift` → `Details.swift`
- `summary Disclosure Summary.swift` → `Summary.swift`
- `dialog Dialog Box.swift` → `Dialog.swift`

#### 4.12 Scripting → `WHATWG HTML Scripting/`
- `script Embedded Script.swift` → `Script.swift`
- `noscript No Script Fallback.swift` → `NoScript.swift`
- `template Template.swift` → `Template.swift`
- `slot Shadow DOM Slot.swift` → `Slot.swift`
- `canvas Graphics Canvas.swift` → `Canvas.swift`

#### Obsolete → `WHATWG HTML Obsolete/`
- `big Bigger Text.swift` → `Big.swift`
- `center Centered Text.swift` → `Center.swift`
- `font Font.swift` → `Font.swift`
- `marquee Marquee.swift` → `Marquee.swift`
- `frame Frame.swift`, `frameset Frameset.swift`
- `strike Strikethrough.swift` → `Strike.swift`
- Any other deprecated elements

### Phase 4: Form Attributes

Move form-specific attributes to `WHATWG HTML FormAttributes/`:
- Autocomplete, Autofocus, Checked, Disabled, Form, FormAction, FormEncType, FormMethod, FormNoValidate, FormTarget, Max, MaxLength, Min, MinLength, Multiple, Name, Pattern, Placeholder, Readonly, Required, Size, Step, Value, etc.

### Phase 5: Link Attributes

Move link-specific attributes to `WHATWG HTML LinkAttributes/`:
- Href, HrefLang, Download, Ping, Rel, ReferrerPolicy, Target, Type (for links)

### Phase 6: Media Attributes

Move media-specific attributes to `WHATWG HTML MediaAttributes/`:
- Src, Autoplay, Controls, Loop, Muted, Preload, Poster (video), Width, Height, etc.

### Phase 7: Table Attributes

Move table-specific attributes to `WHATWG HTML TableAttributes/`:
- ColSpan, RowSpan, Headers, Scope

### Phase 8: Script Attributes

Move script-specific attributes to `WHATWG HTML ScriptAttributes/`:
- Async, Defer, CrossOrigin, Integrity, Nonce, ReferrerPolicy, Type (for scripts), Blocking

### Phase 9: Remaining Attributes

Categorize and place remaining ~93 attributes into appropriate modules or create new logical groupings if needed.

## Migration Approach

1. **Start with Phase 1 (Core Shared)** - This unblocks everything else
2. **Do Phase 2 (Global Attributes)** - Clear cut, easy to identify
3. **Pick one element module** (e.g., Forms) - Migrate completely including its specific attributes
4. **Iterate through remaining element modules** one by one
5. **Verify with `swift build`** after each phase
6. **Keep old structure intact** until new structure is complete and verified

## Next Steps

Would you like to:
1. Start with Phase 1 (Core Shared Module)?
2. Start with a specific element module (I recommend Forms as it's self-contained)?
3. Review and adjust the element→module mapping above?
