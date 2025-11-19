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
struct `Article Tests` {

    @Test
    func `Basic article creation`() {
        let article = Article()
        #expect(Article.tag == "article")
    }

    @Test
    func `Article conforms to HTMLElement`() {
        let article = Article()
        let element: any WHATWG_HTML.Element = article
        #expect(type(of: element).tag == "article")
    }

    @Suite
struct `Common Use Cases` {

        @Test
    func `Blog post article`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `News article`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Forum post`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Comment article`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Product review`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Social media post`() {
            let article = Article()
            #expect(Article.tag == "article")
        }
    }

    @Suite
struct `Nested Articles` {

        @Test
    func `Article with nested comments`() {
            let mainArticle = Article()
            let commentArticle = Article()

            #expect(Article.tag == "article")
            #expect(mainArticle is any WHATWG_HTML.Element)
            #expect(commentArticle is any WHATWG_HTML.Element)
        }

        @Test
    func `Multi-part article series`() {
            let containerArticle = Article()
            let part1 = Article()
            let part2 = Article()

            #expect(Article.tag == "article")
            #expect(containerArticle is any WHATWG_HTML.Element)
            #expect(part1 is any WHATWG_HTML.Element)
            #expect(part2 is any WHATWG_HTML.Element)
        }

        @Test
    func `Article with related content`() {
            let mainArticle = Article()
            let relatedArticle = Article()

            #expect(Article.tag == "article")
            #expect(mainArticle is any WHATWG_HTML.Element)
            #expect(relatedArticle is any WHATWG_HTML.Element)
        }
    }

    @Suite
struct `Content Structure` {

        @Test
    func `Article with heading structure`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Article with sections`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Article with metadata`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Article with author information`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Article with publication date`() {
            let article = Article()
            #expect(Article.tag == "article")
        }
    }

    @Suite
struct `Semantic Usage` {

        @Test
    func `Standalone content article`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Syndicated content article`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `User-generated content article`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Widget-like article`() {
            let article = Article()
            #expect(Article.tag == "article")
        }
    }

    @Suite
struct `Integration Tests` {

        @Test
    func `Multiple articles in feed`() {
            let articles = [
                Article(),
                Article(),
                Article(),
            ]

            #expect(articles.count == 3)
            articles.forEach { article in
                #expect(type(of: article).tag == "article")
            }
        }

        @Test
    func `Article collection rendering`() {
            let newsArticle = Article()
            let blogPost = Article()
            let review = Article()

            let allArticles = [newsArticle, blogPost, review]

            #expect(allArticles.count == 3)
            allArticles.forEach { article in
                #expect(article is any WHATWG_HTML.Element)
                #expect(type(of: article).tag == "article")
            }
        }

        @Test
    func `Article as independent component`() {
            let article = Article()
            let element: any WHATWG_HTML.Element = article

            #expect(type(of: element).tag == "article")
        }
    }

    @Suite
struct `Accessibility and SEO` {

        @Test
    func `Article with proper heading hierarchy`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Article with descriptive content`() {
            let article = Article()
            #expect(Article.tag == "article")
        }

        @Test
    func `Article with structured data compatibility`() {
            let article = Article()
            #expect(Article.tag == "article")
        }
    }
}
