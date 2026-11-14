# Pocket CIS — Roadmap

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
