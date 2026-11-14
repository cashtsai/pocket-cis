> Pocket 設計規範 v1.1 新章(2026-11-14)。底線值承自 SDS 結構層與規範 §1.2/§3/§7,平台細則抄自出貨中的 app 實作;全章索引見 [cis/README.md](README.md)。

## 16. 無障礙 Accessibility

無障礙是 **SDS 結構層的不可覆寫項** —— 品牌換皮、平台移植都不准鬆動。
本章把散在 §1.2(不可覆寫表)、§3(對比實測)、§7(禁例)的底線集中成一頁驗收單。

### 16.1 對比度線(WCAG)

| 配對 | 底線 | 備註 |
|---|---|---|
| 正文 / canvas | **≥ 7:1**(AAA) | 3 值生成器以 7:1 求解正文 |
| 各 Foreground / 其 Surface | **≥ 4.5:1**(AA) | 生成器解到 4.6 留餘裕 |
| muted 次要文字 | ≥ 4.5:1 | |
| faint 淡文字 / icon / 邊界線索 | **≥ 3:1** | 非正文豁免檔 |
| disabled | 可 < 3:1 | **僅限禁用態**,不得拿來做「低調但可用」的元素 |
| accent 上白字 | 4.16:1(實測) | **只准 semibold 短標籤**(按鈕/徽章),不作長文 |
| 內文連結 | 用 action-link `#C42320`(5.24:1) | 不用裸 accent(3.75:1) |

pocket 三主題的逐對實測見 [03-contrast.md](03-contrast.md);
自訂主題由生成器的對比二分求解保證,驗收跑 14 組配對斷言(見 `brief/`)。

### 16.2 Dynamic Type 與語意字級

- 字級一律走**語意角色**(caption/body/subtitle/title 四檔,對位表見
  [04-typography.md](04-typography.md) §4.2),iOS 吃系統 text style 得到
  Dynamic Type 縮放;Android 對位 sp 單位;web 用 rem。
- **禁止**用固定 pt/px 寫死文字尺寸繞過縮放;自帶字型(粉圓)也要掛在
  text style 的 metrics 上隨級縮放。
- 數字跳動處(計時器、用量)用 tabular-nums 等寬數字,放大後仍不跳版。
- **唯一豁免**:mono 檔(代碼/ID/路徑)固定尺寸不隨級縮放 —— 等寬對齊優先
  (現行實作定案);其餘字級一律縮放。
- CJK 行高鐵則:正文 ≥ 1.7、標題 ≥ 1.2(§4.2),放大級距下同樣適用。

### 16.3 Focus ring(統一規格,不准自己發明)

| 情境 | 規格 |
|---|---|
| 所有互動元件 | **2px accent outline + 2px offset**(web `:focus-visible`) |
| 文字輸入框(唯一例外款) | accent 邊框 + **3px 光暈**(accent @18%) |

focus 樣式是 SDS 統一項:缺 focus ring 或自創樣式都是 §7 禁例。

### 16.4 觸控目標

- 觸控目標 **≥ 44pt**(iOS;列最小高度統一 `minHeight: 44` 守門)。
  Android 現行 icon 鈕定值 **44dp**;Material 建議 48dp,新元件取 44 為底線、48 為佳。
- 視覺可以小(例:狀態點 8–9pt),但命中區要補到 44pt
  (SwiftUI `contentShape` 擴大命中、web 用 padding 補)。
- 列表列整列可點,不做「只有小 icon 可點」的列。

### 16.5 Reduced motion

`prefers-reduced-motion: reduce`(web)/ `accessibilityReduceMotion`(iOS)
/ `ANIMATOR_DURATION_SCALE`(Android)必須尊重:

- **必關**:shimmer 掃字、spinner、脈動點、skeleton 呼吸等**循環動畫**。
- 保留:不連續的單次狀態轉場可降為淡入淡出或直接跳切。
- styleguide 參考實作:`@media(prefers-reduced-motion:reduce){*{animation:none;transition:none}}`。
- 動態的完整規格(含 delayed-status 門檻)見 [12-motion.md](12-motion.md)。

### 16.6 非色彩線索

- 狀態**不只靠色**:phase 表每態都是「色 + SF Symbol」成對出場
  (見 [11-icons.md](11-icons.md)),色盲情境靠符號仍可辨。
- 錯誤/警示除色外必附文字說明(見 [14-empty-error.md](14-empty-error.md))。

### 16.7 驗收清單(每個新畫面過一遍)

1. 全部文字過 16.1 對比線(含 dark)。
2. 字級全走語意角色;最大 Dynamic Type 級距下不截字、不疊字。
3. Tab/鍵盤可走完全部互動元件,focus ring 照 16.3。
4. 觸控目標 ≥ 44pt。
5. reduced-motion 開啟後無循環動畫殘留。
6. 把畫面轉灰階看一遍:狀態語意仍可讀。
