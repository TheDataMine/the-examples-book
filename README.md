<p align="center">
  <a href="https://datamine.purdue.edu"><img width="100%" src="./banner.png" alt='Purdue University'></a>
</p>

[![Deploy to Cloudflare Pages](https://github.com/TheDataMine/the-examples-book/actions/workflows/deploy.yml/badge.svg)](https://github.com/TheDataMine/the-examples-book/actions/workflows/deploy.yml)

---

**Website**: [https://the-examples-book.com](https://the-examples-book.com) (`main` branch)

**Old website (being transferred)**: [https://thedatamine.github.io/the-examples-book](https://thedatamine.github.io/the-examples-book) (`master` branch)

---

# The Examples Book

Supplementary material for solving projects assigned in [The Data Mine](https://datamine.purdue.edu/), Purdue University's integrative data science initiative. The "core" book can be found at [https://the-examples-book.com](https://the-examples-book.com). Complementary materials are available as appendices at the following URLs:

- Containerization and Kubernetes Deployment: https://the-examples-book.com/k8s
- Data Science Book List: https://the-examples-book.com/book-list
- Prodigy Annotation Tool: https://the-examples-book.com/prodigy
- Geospatial Analytics: https://the-examples-book.com/geo
- Data Visualization: https://the-examples-book.com/data-viz
- Natural Language Processing: https://the-examples-book.com/nlp
- MATLAB: https://the-examples-book.com/matlab
- Time Series: https://the-examples-book.com/ts
- Projects Archive: https://the-examples-book.com/projects
- Corporate Partners Information: https://the-examples-book.com/crp
- RCAC Resources & Guides: https://the-examples-book.com/rcac
- Registration: https://the-examples-book.com/registration
- Think Summer: https://the-examples-book.com/think-summer

You can learn more about The Data Mine using the following links:

- [The Data Mine website](https://datamine.purdue.edu/)
- [Introducing The Data Mine at Purdue University](https://www.youtube.com/watch?v=R_kqpIMyhR4)
- [2022 poster symposium](https://datamine.purdue.edu/symposium/welcome.html)
- [2021 poster symposium](https://datamine.purdue.edu/symposium/welcome2021.html)
- [2020 poster symposium](https://datamine.purdue.edu/symposium/welcome2020.html)
- [Our team](https://datamine.purdue.edu/about/welcome.html)

## Contribution

Thank you for those that have already contributed. If you have an ignored issue or pull request, please know we _are_ going to get to it and we really appreciate your patience.

[Here](https://the-examples-book.com/book/how-to-contribute) is our guide on how to contribute. Please feel free to start a [discussion](https://github.com/TheDataMine/the-examples-book/discussions) or open up an [issue](https://github.com/TheDataMine/the-examples-book/issues).

## Build

This book is written using [AsciiDoc](https://asciidoc.org/). AsciiDoc is an open and powerful format for writing notes, text documents, books, etc. It is easy to write technical documentation in AsciiDoc, and quickly convert the text to various mediums like websites, ebooks, pdfs, etc.

### Search index

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
