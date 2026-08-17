[![Deploy to Cloudflare Pages](https://github.com/TheDataMine/the-examples-book/actions/workflows/deploy.yml/badge.svg)](https://github.com/TheDataMine/the-examples-book/actions/workflows/deploy.yml)

---

**Website**: [https://the-examples-book.com](https://the-examples-book.com) (`main` branch)

---

# The Examples Book

## Build

This book is written using [AsciiDoc](https://asciidoc.org/). AsciiDoc is an open and powerful format for writing notes, text documents, books, etc. It is easy to write technical documentation in AsciiDoc, and quickly convert the text to various mediums like websites, ebooks, pdfs, etc.

## Search index

Search is handled by [Meilisearch](https://www.meilisearch.com/). For this repository -- the core book -- the following GitHub Action job automatically builds, deploys, and updates the search index. There is _no_ additional work that must be done when a change is made to this repository. 

```yaml
on: 
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-20.04
    steps:
    - uses: actions/checkout@v2
    - name: Wait for CF Pages
      id: cf-pages
      uses: WalshyDev/cf-pages-await@v1
      with:
        accountEmail: ${{ secrets.CLOUDFLARE_ACCOUNT_EMAIL }}
        apiKey: ${{ secrets.CLOUDFLARE_GLOBAL_API_KEY  }}
        accountId: 'c07da5a4aa8d50689311ae57df77e3a6'
        project: 'the-examples-book'
        # Add this if you want GitHub Deployments (see below)
        githubToken: ${{ secrets.GITHUB_TOKEN }}

  run-scraper:
    needs: build
    runs-on: ubuntu-20.04
    steps:      
    - name: Clone TheDataMine/docs-scraper
      uses: actions/checkout@v2
      with: 
        repository: TheDataMine/docs-scraper
    - name: Install pipenv
      run: |
        python3 -m pip install --upgrade pipenv wheel
    - id: cache-pipenv
      uses: actions/cache@v1
      with:
        path: ~/.local/share/virtualenvs
        key: ${{ runner.os }}-pipenv-${{ hashFiles('**/Pipfile.lock') }}
    - name: Install dependencies
      if: steps.cache-pipenv.outputs.cache-hit != 'true'
      run: 
        pipenv install
    - name: Run docs-scraper
      env:
        MEILISEARCH_HOST_URL: ${{ secrets.MEILISEARCH_HOST_URL }}
        MEILISEARCH_API_KEY: ${{ secrets.MEILISEARCH_API_KEY }}
      run: |
        pipenv run ./docs_scraper ./the-examples-book.config.json
        
  purge-cf-cache:
    needs: build
    runs-on: ubuntu-20.04
    steps:
    - name: Purge Cloudflare cache
      uses: jakejarvis/cloudflare-purge-action@master
      env:
        CLOUDFLARE_ZONE: ${{ secrets.CLOUDFLARE_ZONE }}
        CLOUDFLARE_TOKEN: ${{ secrets.CLOUDFLARE_TOKEN }}

```

<p align="center">&mdash; # &mdash;</p>
<p align="center"><i></i></p>
