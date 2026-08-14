# Changelog

## rchess 0.1.1

### Modern R compatibility

- Replaced the remaining `plyr` internals with modern `dplyr` operations
  and explicit data-mask pronouns.
- Set R 4.1.0 as the minimum supported version and adopted the native
  `|>` pipe throughout the package.
- Modernized ggplot2 mappings and removed deprecated API usage.
- Added smoke and compatibility tests for the core `Chess` API,
  captures, castling, and detailed history tibbles.

### Documentation and infrastructure

- Refreshed package metadata, README, examples, dataset documentation,
  and the complete R6 method reference.
- Added a Bootstrap 5 pkgdown site with a curated reference index and a
  Markdown-first home page.
- Simplified the R CMD check and pkgdown GitHub Actions workflows and
  added a WebAssembly package check.
- Updated canonical project URLs and resumed maintenance after the CRAN
  archival.
