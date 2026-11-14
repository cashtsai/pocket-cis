> Pocket 設計規範 v1.1 新章(2026-11-14)。規格抄自出貨中的 app 實作與品牌產線既有規則,不發明新值;新歸納處逐條標注。全章索引見 [cis/README.md](README.md)。

## 19. 品牌應用 Brand in use

品牌識別資產(logo、標準字、吉祥物)**不屬於可換皮的 theme 層** —— 它們鎖定品牌識別,
不跟使用者主題走(分工見 [BRAND.md](BRAND.md)「Theme 與 CIS 的分工」)。
本章規定這些資產在 UI、官網、行銷物上的用法。

### 19.1 Logo × 標準字鎖定(lockup)

| 件 | 規格 |
|---|---|
| **logo(標準)** | `assets/pocket-mark.png`(1024px,**透明背景**)—— 網頁/文件引用一律用這顆 |
| **標準字 wordmark** | 「POCKET」以 Luckiest Guy(Apache 2.0)排印,字距 `.04em`、全大寫 |
| **標準字顏色** | **一律品牌紅**:淺底 `#EE2D2A`、深底 `#FF4D4A`;**只有紅底上才用白字**。不出現墨色/灰色標準字 |
| **鎖定關係** | logo 在左、標準字在右,水平置中對齊;間隙 = logo 寬的 ~0.36(styleguide 現值:28px logo + 10px gap,歸納自現行實作) |
| **web 簡化 logo** | styleguide 頂欄的 CSS 繪製版(28×28、radius 7、黃→紅 135° 漸層 + 白口袋形)只作網頁 chrome 用,不是正式 logo 資產 |

**留白(clearspace)**:lockup 四周保留 ≥ 標準字 x-height(字母 o 的高度)的淨空,
不可被其他元素侵入(沿用品牌產線既有規則)。

**最小尺寸**:wordmark/lockup 高 ≥ 20px(印刷 ≥ 6mm);logo 單獨出現 ≥ 24px(印刷 ≥ 5mm)。

### 19.2 誤用紅叉(don'ts)

| ✕ 禁 | 說明 / ✓ 正解 |
|---|---|
| **拿 `icon-512.png` 當 logo 用** | PWA/平台 icon **無透明度**(平台規定),放到非深色底會出現烤死的邊。網頁/文件一律用透明的 `pocket-mark.png` |
| 非等比拉伸、旋轉、變形 | 保持原比例;需要不同尺寸從 1024 母檔縮 |
| 重上色、加陰影/外框/光暈/自製漸層 | logo 保持原樣;標準字只准三態(紅/紅/白,見 19.1) |
| 標準字放低對比或花俏背景 | 必要時加色塊墊底;對比不足就換底,不改字色 |
| 手改 logo/icon 圖檔 | generated artwork,**never hand-edit** —— 再生請回品牌產線 |
| 暗示官方背書 | 第三方使用守 `assets/USAGE.md` 授權邊界 |

### 19.3 App icon 規格

- **主題**:牛仔口袋擬物 —— 紅內裡 + 白襯線 + 丹寧 + 金黃車線。口袋就是產品隱喻。
- **上架資產**:1024×1024、正方形、**不透明、無 alpha、不自己做圓角**(iOS 自動遮罩;
  Android maskable 用 `icon-maskable-512.png`,safe-zone padded)。
- **單一來源**:品牌產線生成;下游 repo 只收成品,不手修。
- 圓角預覽版只供簡報,**勿**當上架資產。

### 19.4 Launch 畫面(iOS 現行實作,規格抄自出貨版)

```
┌────────────────────────────┐
│                            │
│   LaunchArt(全幅插畫)      │  ← aspect-fill,centerX + top/bottom 釘滿
│   941 × 1672               │    width = canvas 寬(priority 999)
│                            │    width ≤ canvas 高(護字 constraint:
│                            │    超寬螢幕上寧可留邊,不讓標準字被裁)
│                            │
└────────────────────────────┘
 backgroundColor = LaunchBackground #D50F10(品牌紅深階,溢出區域的底)
```

- launch art 原檔即 `assets/launch-art.png`(與 app 的 `LaunchArt.imageset` 同源)。
- launch 畫面屬 **CIS 鎖定面**:不跟使用者主題走,dark mode 也不換圖。
- 其他平台對位:Android 用 Splash Screen API(品牌紅底 + 置中 icon,系統規格);
  web/PWA `background_color` 用 `#D50F10` 同款(歸納自現行實作的對位建議)。

### 19.5 品牌時刻的邊界

- 標準字(Luckiest Guy)**只在品牌時刻出場**:splash、關於頁、官網 hero、行銷物。
  不進 UI 正文、不做按鈕標籤。
- 吉祥物口袋與四隻 chibi persona 頭像(四色盤見 [02-color.md](02-color.md) §2.4)
  屬品牌資產,不授權給第三方主題使用(見 `brief/POCKET_THEME_BRIEF.md`)。
- governed 品牌頁(關於頁、onboarding 品牌頁、splash)鎖:Pocket Red as signal on
  white、ink 字、圓角 14、自然大小寫、粉圓 display —— 不吃主題切換。
