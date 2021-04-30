<p align="center">
  <a href="https://datamine.purdue.edu"><img width="100%" src="./header.png" alt='Purdue University'></a>
</p>

[![deployed](https://github.com/TheDataMine/the-examples-book/workflows/deployed/badge.svg)](https://thedatamine.github.io/the-examples-book/)


---

**Website**: [https://staging.the-examples-book.com](https://staging.the-examples-book.com)

---

# The Examples Book

Supplementary material for solving projects assigned in Purdue University's The Data Mine.

## Build

This book is written using [AsciiDoc](https://asciidoc.org/). AsciiDoc is an open and powerful format for writing notes, text documents, books, etc. It is easy to write technical documentation in AsciiDoc, and quickly convert the text to various mediums like websites, ebooks, pdfs, etc.

### Website

To build [the website](https://staging.the-examples-book.com), we used [Antora](https://antora.org/). To build the website using Antora, you must first download and install [nodejs](https://nodejs.org/en/download/). You can test to make sure nodejs was properly installed by running:

```bash
node --version
```

You should get a similar result to:

```bash
node --version
v15.12.0
```

To install Antora, simply run:

```bash
npm i -g @antora/cli @antora/site-generator-default
```

Once installed, you can confirm by running:

```bash
antora -v
```

Which should result in something similar to:

```bash
antora -v
2.3.4
```

### PDF, epub, mobi, etc.


<p align="center">&mdash; # &mdash;</p>
<p align="center"><i></i></p>