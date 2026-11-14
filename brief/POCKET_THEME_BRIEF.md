# Pocket 主題作者 brief(給設計師/第三方,一頁)

> 你要交付的東西:**一份 53-role JSON**(schema:
> [`tokens/pocket-theme.schema.json`](../tokens/pocket-theme.schema.json))。
> 最省力的路:只挑 **3 個值**,其餘讓生成器算。

## 最短路徑:3 值生成器

給 `appearance`(light/dark)+ `canvas`(頁底色)+ `accent`(強調色),
`PocketThemeGenerator.generate` 會導出整套 53 roles:

- OKLCH 明度階梯:各面 = canvas 明度 ± Δ,色相借 accent;
- 對比自動保證(二分搜尋只動明度、保住色相):正文對 canvas 解到 **7:1**,
  各 Foreground 對其 Surface 解到 **4.6:1**(≥ WCAG AA);
- 超出 sRGB 色域的顏色收 chroma 入域,不剪 channel。

也就是說:**挑一個好看的底 + 一個有態度的 accent,可讀性是管線的事,
不是你手調的事。** App 內建的自訂主題編輯器走的就是這條路。
手調全部 53 值也行(`seed` 可省略),但下面的鐵則照樣適用。

## 不可覆寫(SDS 結構層,換皮不准動)

| 項 | 規則 |
|---|---|
| **狀態色** | success / danger / info / warning 跨品牌固定值 —— 不准調成你的品牌色。danger 必須與 accent 肉眼可辨(deny ≠ accent) |
| **對比底線** | 正文對 canvas ≥ 7:1;各前景對其底面 ≥ 4.5:1;faint/icon ≥ 3:1 |
| **Focus ring** | 統一 2px accent outline + 2px offset;文字輸入框例外(accent 邊 + 3px 光暈)。不准自己發明 focus 樣式 |
| **動效** | 一條曲線 `cubic-bezier(.2,0,0,1)`、兩檔時長(.2s/.25s);`prefers-reduced-motion` 必須關循環動畫 |
| **圓角三檔** | 按鈕 9999(膠囊)/ 欄位 10 / 彈窗 20;聊天泡 14 是 Pocket 自有檔 |
| **字階四檔** | caption 13/1.6 · body 16/1.75 · subtitle 18 · title 20;**CJK 正文行高 ≥ 1.7** |

## 禁例(會被退件的)

- **accent 大面積**(整版主色底、主色卡片海)—— accent 只做主按鈕、選取
  指示、focus ring、連結強調;選取底用 `accentSurface` 淡色面。
- accent 上白字當長文用 —— accent 上白字限 semibold 短標籤。
- 黑(文字色)大面積填色 —— 文字色只做文字與邊框。
- 正文行高 < 1.7(CJK 擠行)。
- 同一狀態三處三個色 —— 狀態的 icon/色一律查 phase 表,不自己配。
- 固定頻率動畫不設門檻 —— 弱資訊指示吃 1.5s 出現 / 0.3s 消失防抖。

完整禁例與元件規格:[`cis/07-forbidden.md`](../cis/07-forbidden.md)、
[`cis/06-components.md`](../cis/06-components.md);活樣本:
<https://pocketone.app/design>。

## 驗收

1. JSON 過 schema 驗證(53 roles 齊、全小寫 `#rrggbb`)。
2. 跑 app repo 的 `PocketThemeGeneratorTests` 種子斷言(或等效對比檢查):
   14 組前景/底面配對全數 ≥ 4.5:1。
3. 在 app 的自訂主題入口載入實測 light/dark 外觀各一輪。

品牌識別資產(logo/吉祥物)不屬於主題,也不授權給主題使用 —— 見
[`assets/USAGE.md`](../assets/USAGE.md)。
