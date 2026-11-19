# Pocket 設計規範 v1.1 —— SDS 之上的品牌層

> v1.0 2026-11-13;v1.1 大擴編 2026-11-14(§10–§19 新章)。
> 活樣本：[Pocket Design](https://design.pocketone.app)；官網簡介在
> [pocketone.app/design](https://pocketone.app/design)。兩站目前分別以 Lovable 維護。
> [`design/pocket.html`](../design/pocket.html) 保留為舊版單檔參考，不是兩站部署來源。
>
> 定位:**Pocket 是 Studio Design System v0.3(design.shan.house)之上的品牌層。**
> SDS 管「結構」—— token 三層制、狀態色固定值、字階四檔、圓角三檔、陰影四級、
> 動效曲線;Pocket 規範管「品牌怎麼換皮」—— 五色、奶油底、泡泡語彙、吉祥物。
> app(iOS/Android/macOS)與網頁端(console、官網)一律照本規範走。
>
> 色值紀律:本規範**不發明新值**。所有色值逐一對過三個真相源 ——
> `PocketTheme.swift`(iOS 三主題)、`PocketThemeSpec.swift` + `THEME_SPEC.md`
> (53-role 跨端 schema)、console `style.css`(web L1/L2/L3,已對齊 SDS v0.3)。
> 兩端現值曾經分岔的地方全部列在 §9 衝突表;2026-11-13 已拍板裁決
> (13/14 落地,見 [09-rulings.md](09-rulings.md))。
>
> 本目錄為規範正文的拆章版;正典在 app repo `docs/POCKET_DESIGN_SPEC.md`,
> 升版時本目錄同步重切。

## 章節

網頁額外規範：[WEB_INTERACTIONS.md](WEB_INTERACTIONS.md)（2026-11-19）。
此延伸僅供官網與設計站，不改 v1.1 的跨端主題與原生實作狀態。

| 章 | 檔 | 內容 |
|---|---|---|
| — | [BRAND.md](BRAND.md) | CIS 敘事:五色故事、吉祥物口袋、voice(一頁) |
| §1 | [01-positioning.md](01-positioning.md) | 定位宣言:分層、SDS 不可覆寫項、Pocket 自有項 |
| §2 | [02-color.md](02-color.md) | 色彩 L1:五色 + 奶油底階 + L2 語意對照表 |
| §3 | [03-contrast.md](03-contrast.md) | 對比度實測(WCAG) |
| §4 | [04-typography.md](04-typography.md) | 字體:三端字族 + 字階四檔 + locale 規則 |
| §5 | [05-shape-motion.md](05-shape-motion.md) | 形狀:圓角、editorial 性格、陰影四級、動效 |
| §6 | [06-components.md](06-components.md) | 元件八件:按鈕/卡片/訊息泡/狀態點/WorkingBar/列表列/輸入框/Toast |
| §7 | [07-forbidden.md](07-forbidden.md) | 禁例 |
| §8 | [08-token-mapping.md](08-token-mapping.md) | 落地對照:三端 token 名 |
| §9 | [09-rulings.md](09-rulings.md) | 衝突表 + 裁決紀錄(2026-11-13) |
| §10 | [10-spacing-grid.md](10-spacing-grid.md) | 間距與格線:4pt 階、頁邊距、列表行高箱 |
| §11 | [11-icons.md](11-icons.md) | 圖示:SF Symbols 正典、phase 符號表、工具語意表、Material 對位 |
| §12 | [12-motion.md](12-motion.md) | 動態:兩檔時值一條曲線、delayed-status、無打字機/無固定 tick 鐵則 |
| §13 | [13-state-language.md](13-state-language.md) | **狀態語言(招牌章)**:WorkingBar 三件組、10 態膠囊、佇列/斷線/限額/鎖定/stalled/審批 |
| §14 | [14-empty-error.md](14-empty-error.md) | 空與錯:空狀態公式、搜尋無結果、錯誤留痕、Undo 範式、skeleton |
| §15 | [15-voice-tone.md](15-voice-tone.md) | 文案與語氣:三聲、三語守門、進行態、日界規則、人話 footer |
| §16 | [16-accessibility.md](16-accessibility.md) | 無障礙:對比線、Dynamic Type、focus ring、觸控目標、reduced-motion |
| §17 | [17-components.md](17-components.md) | 元件庫 24 件(§6 八件擴編):結構+token+狀態+三端對位 |
| §18 | [18-platforms.md](18-platforms.md) | 平台落地:iOS/Android/Web Console/macOS/官網、PWA/icon 規則 |
| §19 | [19-brand-in-use.md](19-brand-in-use.md) | 品牌應用:lockup、誤用紅叉、App icon、launch 畫面 |

## 版本

- **v1.1**(2026-11-14):大擴編。§10–§19 新章(間距/圖示/動態/狀態語言/空與錯/
  文案/無障礙/元件 24 件/平台落地/品牌應用),規格全數抄自出貨實作與既有品牌資產,
  新歸納值逐條標注「歸納自現行實作」。§1–§9 正典仍追 app repo 的
  `POCKET_DESIGN_SPEC.md`;**§10–§19 正典在本 repo**。另出
  [`SITE_CONTENT_HANDOFF.md`](../SITE_CONTENT_HANDOFF.md)(設計站建站內容包)。
- **v1.0**(2026-11-13):首版。對位 SDS v0.3。
- 追版規則:品牌識別文件升版、SDS 升版、或 §9 任一衝突裁決後,規範正文與
  `design/pocket.html` 同步改版並列入變更紀錄;本目錄隨之重切。
