//
//  File.swift
//  swift-whatwg-html
//
//  Created by Coen ten Thije Boonkkamp on 05/12/2025.
//

extension WHATWG_HTML.Element.Content.Category {
    /// Elements that unconditionally belong to this category.
    var elements: Set<String> {
        switch self {
        case .metadata:
            return ["base", "link", "meta", "noscript", "script", "style", "template", "title"]

        case .flow:
            return [
                "a", "abbr", "address", "article", "aside", "audio", "b", "bdi", "bdo",
                "blockquote", "br", "button", "canvas", "cite", "code", "data", "datalist", "del",
                "details", "dfn", "dialog", "div", "dl", "em", "embed", "fieldset", "figure",
                "footer", "form", "h1", "h2", "h3", "h4", "h5", "h6", "header", "hgroup", "hr", "i",
                "iframe", "img", "input", "ins", "kbd", "label", "main", "map", "mark", "menu",
                "meter", "nav", "noscript", "object", "ol", "output", "p", "picture", "pre",
                "progress", "q", "ruby", "s", "samp", "script", "search", "section", "select",
                "slot", "small", "span", "strong", "sub", "sup", "table", "template", "textarea",
                "time", "u", "ul", "var", "video", "wbr",
            ]

        case .sectioning: return ["article", "aside", "nav", "section"]

        case .heading: return ["h1", "h2", "h3", "h4", "h5", "h6"]

        case .phrasing:
            return [
                "a", "abbr", "audio", "b", "bdi", "bdo", "br", "button", "canvas", "cite", "code",
                "data", "datalist", "del", "dfn", "em", "embed", "i", "iframe", "img", "input",
                "ins", "kbd", "label", "map", "mark", "meter", "noscript", "object", "output",
                "picture", "progress", "q", "ruby", "s", "samp", "script", "select", "slot",
                "small", "span", "strong", "sub", "sup", "template", "textarea", "time", "u", "var",
                "video", "wbr",
            ]

        case .embedded:
            return ["audio", "canvas", "embed", "iframe", "img", "object", "picture", "video"]

        case .interactive:
            return ["button", "details", "embed", "iframe", "label", "select", "textarea"]

        case .palpable:
            return [
                "a", "abbr", "address", "article", "aside", "b", "bdi", "bdo", "blockquote",
                "button", "canvas", "cite", "code", "data", "del", "details", "dfn", "div", "em",
                "embed", "fieldset", "figure", "footer", "form", "h1", "h2", "h3", "h4", "h5", "h6",
                "header", "hgroup", "i", "iframe", "img", "ins", "kbd", "label", "main", "map",
                "mark", "meter", "nav", "object", "output", "p", "picture", "pre", "progress", "q",
                "ruby", "s", "samp", "search", "section", "select", "small", "span", "strong",
                "sub", "sup", "table", "textarea", "time", "u", "var", "video",
            ]

        case .`script-supporting`: return ["script", "template"]

        case .`select element inner content`:
            return ["option", "optgroup", "hr", "script", "template", "noscript", "div"]

        case .`optgroup element inner content`:
            return ["option", "script", "template", "noscript", "div"]

        case .`option element inner content`:
            // div plus phrasing content (exclusions handled separately)
            return ["div"]
        }
    }
}
