> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 1. 定位宣言

### 1.1 分層

```
┌─────────────────────────────────────────────┐
│  Pocket 品牌層(本文件)                       │
│  五色 L1、奶油底、泡泡語彙、吉祥物口袋、          │
│  粉圓字 voice、膠囊鈕簽名                      │
├─────────────────────────────────────────────┤
│  Studio Design System v0.3(design.shan.house)│
│  token 三層制(L1 palette → L2 語意 → L3 元件) │
│  狀態色固定值 · 字階四檔 · 圓角三檔 ·            │
│  陰影四級 · 動效一曲線兩時長 · 無障礙底線         │
└─────────────────────────────────────────────┘
```

### 1.2 跟 SDS 走、品牌**不可覆寫**的

| 項 | 規則 | 值 |
|---|---|---|
| **狀態色** | success / danger / info / warning 跨品牌固定,品牌換皮不准動 | light:`#1d7a4a` / `#b42318` / `#1f6aa1` / `oklch(48% .1 85)`;dark(300 階):`#6fd39d` / `#f59a90` / `#7cc0ec` / `oklch(82% .14 85)` |
| **對比度** | 正文對 canvas ≥ 7:1;各 Foreground 對其 Surface ≥ 4.5:1(生成器解到 4.6);muted ≥ 4.5:1;faint/icon ≥ 3:1;disabled 可 <3:1 但僅限禁用態 | 見 §3 各值實測 |
| **動效** | 一條曲線兩檔時長,全部 transition 只准引用 token | `cubic-bezier(.2,0,0,1)`;base `.2s`、slow `.25s`;`prefers-reduced-motion` 必須關循環動畫 |
| **無障礙** | focus ring 統一:2px accent outline + 2px offset,所有互動元件;文字輸入框例外(accent 邊框 + 3px 光暈)。CJK 正文行高 ≥ 1.7。觸控目標 ≥ 44pt | 見 §7 禁例 |
| **圓角三檔** | btn `9999`(膠囊)/ field `10` / dialog `20`;文字級小裝飾(inline code、mark)3–6px 不入檔 | §5 |
| **陰影四級** | 卡片 1 / 浮層選單 2 / toast 抽屜 3 / 對話框 4;深色改「表面越高越亮」為主、陰影為輔 | §5.3 |
| **字階四檔** | caption 13/1.6 · body 16/1.75 · subtitle 18/1.35 · title 20/1.3(標題行高 ≥1.2) | §4 |

### 1.3 Pocket **自有**的(品牌層)

- **五色 CIS v2**(2026-07-05 定調,近瑪利歐配色):Pocket Red `#EE2D2A`、
  Overall Blue `#049CD8`、White `#FFFFFF`、Star Yellow `#FBD000`、Ink `#17171A`。
- **奶油底** `#FFF2D6` —— 對話畫布的暖紙感,品牌拍板保留,是 Pocket 主題的
  canvas 種子。
- **泡泡語彙** —— 聊天泡圓角 14(介於 field 10 與 dialog 20 之間,Pocket 自有檔,
  不入 SDS 三檔);user 泡在發話側缺一角(web `border-bottom-right-radius:6px`)。
- **吉祥物口袋** —— app icon = 牛仔口袋擬物(紅內裡 + 白襯線 + 丹寧 + 金黃車線,
  generated,never hand-edit);四隻 chibi persona 頭像的四色盤(紅 `#DD3126` /
  綠 `#2E9E43` / 金 `#C98A12` / 粉 `#DE5C95`,`PocketColor.Persona`)。
- **字體 voice** —— display/聊天 = jf open 粉圓(OFL 1.1);wordmark = Luckiest Guy
  (只用於品牌時刻,無 CJK);正文 = 系統字(閱讀舒適)。
- **膠囊鈕 + 柔影 editorial 性格** —— `PocketThemeStyle.editorial`:pill 控件、
  細邊 10% alpha、柔影、自然大小寫。
- **口號紀律**:「紅是訊號不是地毯」(CIS voice)—— accent 只做訊號,見 §7。
