# Pocket CIS

**Pocket 的品牌識別系統 —— CIS 文件 + 跨端 theme tokens + 參考實作。**
The [Pocket](https://pocketone.app) brand bundle: the corporate identity
system (CIS) documents, cross-platform theme tokens, and reference
implementations — maintained independently here so the brand can evolve
without touching the app.

A brand bundle = **CIS** (the written identity: palette story, type voice,
component grammar, forbidden moves) + **tokens** (the machine-readable theme
values every platform consumes) + **reference implementations** (Swift
snapshot, CSS variables, live styleguide).

## Live styleguide

- <https://pocketone.app/design>
- <https://design.pocketone.app>
- <https://design.shan.house/pocket>

All three serve the same self-contained page as `design/pocket.html`
(single source of truth: this repo).

## What's in here

```
cis/                          ── 設計規範 v1.1 chapters (§1–§19) + BRAND.md (brand narrative)
SITE_CONTENT_HANDOFF.md       ── design-site content package (page-by-page, build-ready)
tokens/pocket-theme.schema.json ── 53-role cross-platform theme spec (JSON Schema)
tokens/themes/{pocket,white,dark}.json ── the three built-in themes, full 53-role values
tokens/css/pocket-tokens.css  ── web L1/L2 variables, importable as-is
swift/PocketThemeSpec.swift   ── reference snapshot of the spec + 3-value generator
design/pocket.html            ── live styleguide (self-contained, zero external deps)
assets/                       ── app icon, maskable icon, launch art + USAGE.md
brief/POCKET_THEME_BRIEF.md   ── one-pager for designers / third-party theme authors
ROADMAP.md                    ── shipped vs open work
```

## Identity in one screen

- **五色 CIS v2**(2026-07-05 定調):near-Mario palette —— 紅是主訊號,
  黃藍是點綴,白是面,墨是字。
- **奶油底 `#FFF2D6`** —— 對話畫布的暖紙感,Pocket 主題的 canvas 種子。
- **「紅是訊號不是地毯」** —— accent 只做主按鈕/選取指示/focus/連結強調,
  禁大面積。
- **泡泡語彙** —— 聊天泡圓角 14、發話側缺角 6;膠囊鈕 + 柔影 editorial 性格。
- **吉祥物口袋** —— 牛仔口袋擬物 icon(紅內裡 + 白襯線 + 丹寧 + 金黃車線)。
- **字體 voice** —— display/聊天 = jf open 粉圓(OFL 1.1);wordmark =
  Luckiest Guy(品牌時刻限定);正文 = 系統字。

| Role | Light | Dark |
|---|---|---|
| Pocket Red (accent) | `#EE2D2A` | `#FF4D4A` |
| Overall Blue (link / identity) | `#049CD8` | `#2AA8E0` |
| Star Yellow (point accent) | `#FBD000` | `#FFD426` |
| Ink (text / border base) | `#17171A` | fg `#F2F2F5` |
| Canvas (cream paper) | `#FFF2D6` | `#131317` |
| Surface (cards / agent bubble) | `#FFFFFF` | `#1E1E25` |

Full palette, contrast measurements, and the SDS layer underneath:
see [`cis/`](cis/README.md).

## Maintaining / syncing

1. **CIS documents** (`cis/`): chapters §1–§9 track the app repo's
   `docs/POCKET_DESIGN_SPEC.md` — a spec version bump upstream re-syncs them here.
   Chapters §10–§19 (the v1.1 expansion: spacing, icons, motion, state language,
   empty & error, voice, accessibility, 24 components, platforms, brand-in-use)
   are canonical **in this repo**; their values are transcribed from the shipped
   app implementation, with newly generalized values marked as such.
2. **Theme values**: `swift/PocketThemeSpec.swift` is a snapshot; the canonical
   generator lives in the app repo (`Packages/PocketDesign`). The three theme
   JSONs pin the hand-tuned brand values and take everything else from the
   generator (see each file's `$meta`).
3. **CSS tokens** mirror the console stylesheet's L1/L2 layers; a real
   spec→CSS generator is roadmap work (`ROADMAP.md`).

## License

- **Code, tokens, and styles** (`tokens/`, `swift/`, `design/`): MIT — see
  [LICENSE](LICENSE).
- **Documents** (`cis/`, `brief/`, this README): [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
- **The Pocket name and logo (the denim-pocket icon) may be used freely in
  non-commercial contexts** — keep the mark unmodified and do not imply
  official endorsement. Launch art and persona avatars remain brand assets
  outside the licenses; commercial use of any mark requires contact. See
  [`assets/USAGE.md`](assets/USAGE.md) for the full boundary. Fonts: jf open 粉圓 is under OFL 1.1; Luckiest Guy under
  Apache 2.0 (neither is bundled here).
