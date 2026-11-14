# Pocket 設計規範 v1.0 —— SDS 之上的品牌層

> 2026-11-13。活樣本:[`design/pocket.html`](../design/pocket.html)(單檔自包含,
> pocketone.app/design 與 design.shan.house/pocket 同步掛載)。
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

## 版本

- **v1.0**(2026-11-13):首版。對位 SDS v0.3。
- 追版規則:品牌識別文件升版、SDS 升版、或 §9 任一衝突裁決後,規範正文與
  `design/pocket.html` 同步改版並列入變更紀錄;本目錄隨之重切。
