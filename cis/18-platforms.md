> Pocket 設計規範 v1.1 新章(2026-11-14)。各端現況抄自出貨實作與 token 檔;【歸納】處為對位建議。全章索引見 [cis/README.md](README.md)。

## 18. 平台落地 Platforms

總則:**一份語意,各端原生。** 色與狀態語言跨端一字不差(53-role JSON +
phase 表 + 10 態膠囊);視覺容器與手勢讓給平台慣例。iOS 為參考實作正典;
各端是獨立原生 code base(**不是**條件編譯單碼多端)。

### 18.1 iOS(SwiftUI / PocketDesign)

| 項 | 規格 |
|---|---|
| token 來源 | 設計 package:`PocketColor`(53-role 消費)、`PocketSpace`、`PocketRadius`、`PocketShadow`、`PocketDuration/Animation`、`PocketFont` |
| 字體棧 | display=粉圓(custom font 掛 text style metrics,隨 Dynamic Type)/ body=系統(SF/PingFang)/ mono=系統 mono 固定尺寸;locale 規則 §4.1 |
| 讓(平台慣例) | swipeActions(leading 釘選/trailing 封存刪除,`allowsFullSwipe: false`)、原生文字選取、sheet/confirmationDialog、`.searchable`、SF Symbols |
| 不讓 | 狀態語言 union 與文案、phase 表、對比線、Undo 範式、紅的紀律 |
| 手勢仲裁 | 列上有 swipeActions → 換頁水平手勢**讓路**(從 pager 端做,互斥行為成對釘測試);不靠「剛好哪頁沒 swipe」當條件 |
| Live Activity | 「安靜設計」:純 working 時島上**只一 glyph**;`startedAt` 配 `Text(style:.timer)` 讓系統自跑 elapsed(app 凍結也活);顯示字串 app 端組好塞入,widget 原樣渲染;wire 欄位全 optional + seq 單調遞增(向後相容契約);provider icon 傳 SF Symbol 名,缺席回落通用終端機 |
| 通知 | 雙 channel 分級:done=柔和、needsYou=鈴聲級(§13.7);聚焦靜音 |

### 18.2 Android(Compose)

| 項 | 規格 |
|---|---|
| token 來源 | 照跨端 THEME_SPEC(53-role JSON)**手動 1:1 port** 的 Kotlin 對位(L1 色階照抄 → L2 語意由 hue×appearance 算出 → 派生 token 同配方:border=base×0.10、strong×0.16、accentTint×0.12);有單元測試守 spec 一致;**codegen 化是 ROADMAP 項** |
| 接法 | 語意色灌 Material3 `ColorScheme`(primary=accent、surface=canvas…);字體灌 `Typography`;形狀灌 `Shapes`(XS 10/S 12/M 14/L 16/XL 24) |
| 字體棧 | display=Huninn(粉圓)semibold 負 tracking / body=系統(null);`labelLarge` 釘 Huninn 防掉回 Roboto;品牌=LuckiestGuy |
| 讓 | Material 元件殼(Snackbar/DropdownMenu/NavigationBar)、返回手勢、Compose Material Icons(語意對映表 §11.5) |
| **不讓:Material You** | **動態取色關閉** —— Pocket 主題色由 53-role spec 定,不吃桌布取色;狀態色 SDS 固定 |
| Live Updates | 對位 iOS LA:同一份 live-update 契約(busy/phaseLabel/seq…),Android 通知/Live Updates 消費同 payload【歸納:契約已為此設計】 |
| 已知欠帳 | body 14 vs iOS 16(§9 #10 同族);間距 token 未抽檔;列入 ROADMAP |

### 18.3 Web Console

| 項 | 規格 |
|---|---|
| token 來源 | `tokens/css/pocket-tokens.css`(L1 品牌常數 + L2 `--color-*`),`data-theme="pocket|white|dark"` 切膚;未來由 53-role JSON 生成(ROADMAP) |
| 字體棧 | 系統堆疊(`-apple-system…"PingFang TC"…`);粉圓 woff2 載入待品牌層補;mono=`ui-monospace…` |
| 版型 | 側欄(surface-sunken)+ 單欄內容 `min(760px, 92%)`;sticky 頂欄 + shadow-1 |
| 讓 | hover 態(surface-hover/brightness)、`:focus-visible`、⌘K 面板、連結語彙(action-link `#C42320`) |
| 不讓 | 狀態語言、對比線、reduced-motion、紅的紀律 |

### 18.4 macOS(桌面 / 主機模式)

| 項 | 規格 |
|---|---|
| 結構 | `NavigationSplitView` 三欄:Sidebar 展開 ~200pt(收合 56)/ 內容列 / Inspector 280pt(min 240);列高 36pt(桌面密度例外,§10.3)、toolbar 36pt |
| 材質三階 | Tier A Chrome Glass / B Floating Glass(slide-in detail 400–500pt)/ C Content Plate —— **長文/清單/表單絕不直接放玻璃上**,一律包 Tier C 不透明 plate;尊重 Reduce Transparency(玻璃轉不透明) |
| 慣例 | Settings 走 ⌘, Settings scene(非 sidebar 項);`.searchable`/`.inspector`/`.confirmationDialog`;六態互動(含 focus ring、Increase Contrast) |
| 主機模式 | 桌面端身兼 host:配對 QR、引擎安裝/登入(AgentLockedCover 指路的目的地);手機端文案「在你的 Mac 打開 Pocket 桌面控制台…」與此對齊 |

### 18.5 官網

| 項 | 規格 |
|---|---|
| 識別 | CIS 鎖定面(不跟主題):白/奶油底、Pocket Red as signal、ink 字、圓角 14、自然大小寫 |
| 字體 | hero/標題可上粉圓(webfont)與 wordmark(Luckiest Guy,品牌時刻);正文系統堆疊 |
| token | 引 `tokens/css/pocket-tokens.css`,不自創色值 |
| 元件語彙 | 膠囊 CTA、卡片 14、pricing 卡照 §17.22;狀態色只做狀態 |
| 活樣本 | design 頁(`design/pocket.html`)三鏡像同源,是官網的設計規範分頁 |

### 18.6 PWA / icon 規範(教訓成規則)

| 資產 | 規則 |
|---|---|
| `icon-512.png` / `icon-maskable-512.png` | **平台 icon 專用,無透明度**(平台規定)。放到非深色底會出現烤死的邊 —— **永遠不當 logo 用** |
| `pocket-mark.png` | 標準 logo(1024,透明底)—— 網頁/文件引用一律用這顆 |
| maskable | safe-zone padded 版本,manifest `purpose: maskable` 專用 |
| PWA 主題 | `background_color` 對齊 launch 底 `#D50F10`、`theme_color` 走 canvas【歸納對位】 |
| App icon | 上架規格見 [19-brand-in-use.md](19-brand-in-use.md) §19.3 |

### 18.7 跨端驗收(加新端/新 provider 都走)

1. 53-role 色全對(跑 14 組對比配對斷言)。
2. phase 表 + 10 態膠囊 + 佇列 + 限額文案一字不差(§13.11)。
3. 字階語意對位(含 CJK 行高 ≥1.7)、Dynamic Type/sp/rem 縮放。
4. l10n 三語過守門 script。
5. reduced-motion 全關循環動畫。
6. 「管線存在 ≠ 端到端通」:每條狀態實際演練到 UI 亮起來才算通。
