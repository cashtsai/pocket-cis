# Pocket 網頁互動延伸 v1

日期：2026-11-19。適用 Pocket 官網與 Pocket Design 設計站。

這是一層新增的網頁視覺規範，不是 CIS v1.1、53-role theme JSON 或
iOS / Android / Console 的自動升版。原生元件、執行狀態來源、timeout、
訂閱、產品供應狀態與配對流程均不在這次變更範圍。

## 設計取捨

參考 [Designed to Scale](https://designed-to-scale.vercel.app/) 的淺色分類塊、
細邊框、短距離實心陰影與等寬資訊排版。只吸收互動原則，不複製其
品牌、內容、插圖或程式。Pocket 紅、正式 Logo、標準字與中文閱讀字體保留。

## Tokens

匯入 [`pocket-web-interactions.css`](../tokens/css/pocket-web-interactions.css)，
使用 `<html data-theme="pocket|white|dark">`，也相容 `.dark` class。只有深色模式覆寫需要的值；
其他模式沿用根節點。切換回淺色時，移除深色 selector 即還原。

| 用途 | Token | 淺色 | 深色 |
|---|---|---|---|
| 薄荷色塊 | `--web-fill-mint` | `#E7F3EB` | `#193629` |
| 天藍色塊 | `--web-fill-sky` | `#E7F1FA` | `#183144` |
| 淡桃色塊 | `--web-fill-peach` | `#FCE8E2` | `#402820` |
| 淡黃色塊 | `--web-fill-amber` | `#FFF3CC` | `#3D3218` |
| 控制項細邊框 | `--web-control-edge` | `#323238` | `#A8A8B1` |
| 一般陰影 | `--web-control-shadow` | `0 2px 0 #323238` | `0 2px 0 #000000` |
| hover 陰影 | `--web-control-shadow-hover` | `0 3px 0 #323238` | `0 3px 0 #000000` |
| 按下陰影 | `--web-control-shadow-pressed` | `0 0 0 transparent` | 相同 |
| 動作按鈕底色 | `--web-action-fill` | `#D92926` | 相同 |
| 動作按鈕文字 | `--web-action-ink` | `#FFFFFF` | 相同 |

動作紅刻意比品牌紅 `#EE2D2A` 深，讓一般尺寸白字達到 4.89:1；
**不替換 Logo / 品牌色**。色塊用於分類與少量語意背景，白色、淺中性底
仍是主要閱讀面。不要把每個區塊做成浮卡，不在卡片內再嵌裝飾卡片。

## 按鈕

- 有明確動作的 primary / secondary / outline：細描邊、短實心底影，
  可加細內高光；不使用大範圍光暈。
- hover 向上 1px，active 向下 2px 並收掉陰影。尺寸與排版位置不變。
- ghost / link / 導覽不加立體影。disabled 無陰影、位移或 hover。
- 保留 Pocket 膠囊圓角；點擊範圍至少 44 × 44px，含圖示按鈕。
- `:focus-visible` 必須保留可辨識焦點框，不能只有滑鼠 hover 才看得到狀態。
- `prefers-reduced-motion: reduce` 關閉位移與動畫；使用靜態邊框、色彩、文字
  保持可辨識，不隱藏狀態。

## 狀態燈

沿用 CIS 固定 success / info / warning / danger 色，不重新定義執行狀態。
8px 燈號必須搭配文字與圖示或形狀，不能只靠顏色區分。
只有 working / reconnecting 可低頻柔和動態；完成、錯誤、閒置保持靜態。
輔助圖示 `aria-hidden`，意義由可讀文字提供；避免每幀更新 live region。

官網的供應狀態是靜態文案，不得畫出假的「已連線」燈。
設計站可互動範例必須標示為範例，不代表使用者的主機真的在線。

| 文字角色 / 底色 | 淺色對比 | 深色對比 |
|---|---:|---:|
| success / mint | 4.68:1 | 7.17:1 |
| info / sky | 5.05:1 | 6.79:1 |
| danger / peach | 5.57:1 | 6.42:1 |
| warning / amber | 5.96:1 | 7.15:1 |

以上是固定狀態色與實色背景的 WCAG 相對亮度計算；加透明度、疊其他背景或
改文字色後必須重測，不能沿用這張表宣稱合格。

## 字體

- 中文正文與標題維持系統中文字體；既有品牌字體用途不變。
- `--web-font-mono` 使用 JetBrains Mono，fallback 為 ui-monospace、
  SFMono-Regular、Menlo、monospace。只用於代碼、token、版本與數值資訊。
- 消費端本機託管 400 / 600 字重，`font-display: swap`，保留
  [JetBrains Mono 的 OFL 授權](https://github.com/JetBrains/JetBrainsMono/blob/master/OFL.txt)。
  不為了字體新增第三方執行時追蹤請求。
- 中文正文至少 16px；主要操作與狀態標籤至少 14px；letter-spacing 為 0，
  不依 viewport width 縮放字級。次要 metadata 可較小但不得承載主要動作。

## 驗收與採用邊界

1. 桌面 1440px、手機 390px / 320px 無水平溢出、截字、遮擋。
2. Pocket / White / Dark、中文 / 英文都可操作，主按鈕與新語意文字對比至少 4.5:1。
3. 鍵盤 focus、滑鼠 hover / active、disabled、reduced-motion 都有驗證。
4. 已發布的主題 JSON、圖文入門步驟、PDF 下載與產品供應文案保持不變。
5. 設計站公開的 tokens 與官網消費值一致；這不代表 native app 已採用。

目前網站由各自的 Lovable 專案建置，這個 repo 收錄可重用 tokens 與規範。
網頁互動延伸要移植到 Console 或原生 App 時，需另開實作與驗收，不可僅靠
更新這份文件宣稱完成。
