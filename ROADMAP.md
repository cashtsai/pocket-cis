# Pocket CIS — Roadmap

## Shipped — v1.1 (2026-11-14)

| Piece | What | Where |
|---|---|---|
| **設計規範 v1.1 大擴編** | ten new chapters (§10–§19): spacing & grid, icons (phase + tool semantic tables), motion (delayed-status gates, no-typewriter/no-tick rules), **state language** (WorkingBar triad, 10-state capsule, queue/offline/limit/lock/stalled/approval), empty & error (empty-state formula, error-leaves-a-trace, 5s aggregated Undo, quantized skeleton), voice & tone (3-locale gate, day-boundary timestamps), accessibility, component library 8→24, platform landing (iOS/Android/Web/macOS/site, PWA icon rules), brand-in-use (lockup, misuse, app icon, launch screen). All values transcribed from the shipped app implementation; generalized values are marked | `cis/10–19` |
| **Site content handoff** | page-by-page content package for building the design site (structure, copy points, render directives) | `SITE_CONTENT_HANDOFF.md` |

## Shipped — v1.0 (2026-11)

| Piece | What | Where |
|---|---|---|
| **設計規範 v1.0** | brand layer on top of Studio Design System v0.3; §9 conflict table fully adjudicated (13/14 rulings landed in the app) | `cis/` |
| **53-role theme schema** | cross-platform semantic spec + 3-value generator (OKLCH ladder, contrast-solved ≥ 4.6:1) | `tokens/pocket-theme.schema.json`, `swift/` |
| **Three built-in themes** | pocket (cream) / white (neutral) / dark — full 53-role values | `tokens/themes/` |
| **Web tokens** | console L1/L2 CSS variables, importable | `tokens/css/pocket-tokens.css` |
| **Live styleguide** | self-contained single file, three mirrors online | `design/pocket.html` |

## Open

| # | Item | Notes |
|---|---|---|
| 1 | **Ruling #11 — shadow per-value alignment** | the one §9 conflict left open: iOS `PocketShadow` keeps "platform-approximate, tier-aligned" values; whether to adopt the SDS oklch warm-grey shadow values verbatim awaits a ruling. Doc: `cis/09-rulings.md` |
| 2 | **THEME_SPEC → CSS generator** | the console's L2 `--color-*` block is hand-maintained today (naming already role-aligned). Build the generator that emits `pocket-tokens.css` from the same 53-role JSON, so all three platforms consume one file |
| 3 | **Android codegen** | Kotlin consumption of the same JSON spec (port the generator test seeds + assertions so the two platforms can't drift — see `docs/THEME_SPEC.md` §3 in the app repo) |
| 4 | **Reduced-motion full coverage (iOS)** | the norm (`cis/12-motion.md` §12.5) requires it globally; shipped implementation covers looping animations + chat pager only. Extend to all transitions |
| 5 | **Spacing tokens on Android** | spacing distribution already matches iOS by convention, but values are written as `.dp` literals — extract a `PocketSpace`-equivalent token file (`cis/10-spacing-grid.md` §10.7) |
| 6 | **Android body size alignment** | Android `bodyMedium` is 14 while iOS body is 16 (ruling §9 #10 family) — align or rule it platform-idiomatic |
| 7 | **Un-tokenized corner radii sweep** | stray literal radii (7/12/16/20) on iOS and literal dp on Android — fold into `PocketRadius` tiers (`cis/17` audit note) |
