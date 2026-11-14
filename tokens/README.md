# Pocket theme tokens

跨端換膚管線的機讀層:**一份 53-role JSON spec,三端消費**(iOS Swift /
Android Kotlin / web CSS)。

## Files

| File | What |
|---|---|
| `pocket-theme.schema.json` | 53-role spec 的 JSON Schema(draft 2020-12)。欄位語意與生成器行為的散文版在 app repo `docs/THEME_SPEC.md`;參考實作在 [`../swift/PocketThemeSpec.swift`](../swift/PocketThemeSpec.swift) |
| `themes/pocket.json` | 內建預設主題(奶油暖底 `#FFF2D6` + Pocket Red `#EE2D2A`) |
| `themes/white.json` | 中性純白主題(`#F5F5F7` 底,不帶暖調;accent 同 pocket) |
| `themes/dark.json` | 深色主題(`#131317` 底 + 提亮紅 `#FF4D4A`) |
| `css/pocket-tokens.css` | web 端 L1(品牌常數)+ L2(`--color-*` 語意變數)純變數檔,`@import` 後以 `<html data-theme="pocket|white|dark">` 切主題 |

## How the theme JSONs are built

每個 `themes/*.json` 是**完整 53-role spec**(過 schema 驗證、可被
`PocketTheme.init(spec:)` 直接還原):

1. 以該主題的種子(`seed.canvas` + `seed.accent`)跑
   `PocketThemeGenerator.generate` —— 和使用者自訂主題同一條 3 值生成管線
   (OKLCH 明度階梯 + 對比二分求解,各 Foreground/Surface 配對 ≥ 4.6:1)。
2. 把**手調正典值**蓋回去 —— 內建三主題的品牌定值(出自 iOS
   `PocketTheme.swift`、console `style.css`、設計規範 §2.5),清單在各檔
   `$meta.pinned`。`border` 是文件化的 alpha 配方(light:ink @ .14、
   dark:white @ .12)壓平到 canvas 上的實色。
3. 其餘 role 維持生成器輸出 —— 規範明言這些值「由生成器從種子導出,
   不另定死值」。改種子請重新生成,不要手改生成 role。

## Status colors are not yours to theme

`error` / `warning` / `update`(=info)的主值釘在 SDS 固定狀態色
(light:`#b42318` / `#775800` / `#1f6aa1`;dark 300 階:`#f59a90` /
`#eebc4a` / `#7cc0ec`)—— 品牌換皮不准動,詳見
[`../cis/01-positioning.md`](../cis/01-positioning.md) 與
[`../brief/POCKET_THEME_BRIEF.md`](../brief/POCKET_THEME_BRIEF.md)。
