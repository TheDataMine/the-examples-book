<p align="center">
  <a href="https://datamine.purdue.edu"><img width="100%" src="./banner.png" alt='Purdue University'></a>
</p>

[![Deploy to Netlify](https://github.com/TheDataMine/the-examples-book/actions/workflows/deploy.yml/badge.svg)](https://github.com/TheDataMine/the-examples-book/actions/workflows/deploy.yml)

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
- Think Summer: https://the-examples-book.com/think-summer

You can learn more about The Data Mine using the following links:

- [The Data Mine website](https://datamine.purdue.edu/)
- [Introducing The Data Mine at Purdue University](https://www.youtube.com/watch?v=R_kqpIMyhR4)
- [2021 poster symposium](https://datamine.purdue.edu/symposium/welcome.html)
- [2020 poster symposium](https://datamine.purdue.edu/symposium/welcome2020.html)
- [Our team](https://datamine.purdue.edu/about/welcome.html)

## Contribution

Thank you for those that have already contributed. If you have an ignored issue or pull request, please know we _are_ going to get to it and we really appreciate your patience.

[Here](https://the-examples-book.com/book/how-to-contribute) is our guide on how to contribute. Please feel free to start a [discussion](https://github.com/TheDataMine/the-examples-book/discussions) or open up an [issue](https://github.com/TheDataMine/the-examples-book/issues).

## Build

This book is written using [AsciiDoc](https://asciidoc.org/). AsciiDoc is an open and powerful format for writing notes, text documents, books, etc. It is easy to write technical documentation in AsciiDoc, and quickly convert the text to various mediums like websites, ebooks, pdfs, etc.

### Website

To build [the website](https://the-examples-book.com), we used [Antora](https://antora.org/). To build the website using Antora, you must first download and install [nodejs](https://nodejs.org/en/download/). You can test to make sure nodejs was properly installed by running:

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

### Search index

Search is handled by [Meilisearch](https://www.meilisearch.com/). For this repository -- the core book -- the following GitHub Action job automatically builds, deploys, and updates the search index. There is _no_ additional work that must be done when a change is made to this repository. 

```yaml
name: Deploy to Netlify

on:
  push:
    branches:
      - main

jobs:
  deploy:
    name: 'Deploy'
    runs-on: ubuntu-18.04

    steps:
      - uses: actions/checkout@v2
      - uses: jsmrcaga/action-netlify-deploy@master
        with:
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
          NETLIFY_DEPLOY_MESSAGE: '${{ github.event.head_commit.message }}'
          NETLIFY_DEPLOY_TO_PROD: true
          build_directory: 'build/site'
          install_command: npm i -g @antora/cli @antora/site-generator-default;
          build_command: antora antora-playbook.yml --stacktrace --fetch;

  run-scraper:
    needs: deploy
    runs-on: ubuntu-18.04
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
    needs: deploy
    runs-on: ubuntu-18.04
    steps:
    - name: Purge Cloudflare cache
      uses: jakejarvis/cloudflare-purge-action@master
      env:
        CLOUDFLARE_ZONE: ${{ secrets.CLOUDFLARE_ZONE }}
        CLOUDFLARE_TOKEN: ${{ secrets.CLOUDFLARE_TOKEN }}
```

<p align="center">&mdash; # &mdash;</p>
<p align="center"><i></i></p>