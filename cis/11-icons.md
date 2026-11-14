> Pocket 設計規範 v1.1 新章(2026-11-14)。對照表逐條抄自 app repo 參考實作(`PocketPhaseStyle` / `PocketToolIcon`);Android 對應件照現行 Compose 實作;Material Symbols 映射為對位建議【歸納自現行實作】。全章索引見 [cis/README.md](README.md)。

## 11. 圖示 Icons

### 11.1 正典:SF Symbols

- iOS/macOS **只用 SF Symbols**,不自繪 UI icon;品牌專屬圖(logo、persona 頭像、
  工具品牌標)走 asset,不混入 icon 體系。
- 權重跟字:icon 與相鄰文字同字級同權重(例:狀態膠囊 icon = 12 semibold)。
- 著色走語意 token(phase 色、muted、accent),不寫死 hex。

### 11.2 Phase 符號表(狀態 → 色 + 符號,單一真相)

**全系統復用、不准自己配**(§6.4 同表,此處為正典全文):

| phase | SF Symbol | tint 角色 | wire 別名(小寫比對) |
|---|---|---|---|
| running | `play.circle.fill` | success | running/run/streaming/working/busy/connecting |
| approval | `hand.raised.fill` | warning(琥珀) | approval/waiting_approval/permission |
| input | `questionmark.circle.fill` | info(靛) | input/waiting_user/waiting_input/blocked/prompt |
| failed | `exclamationmark.triangle.fill` | danger | failed/error |
| done | `checkmark.circle.fill` | success | done/completed/complete/idle/stopped |
| queued | `hourglass` | muted | queued/queue |
| reconnecting | `wifi.exclamationmark` | warning | reconnecting/disconnected/offline |

tint 角色 → 色值吃 SDS 狀態色(§2.5);`muted` → foregroundMuted。
未知 wire 字串 → 不顯示(不裝懂)。

### 11.3 工具語意表(PocketToolIcon)

工具名 → icon 走**關鍵詞歸族**(正規化小寫 contains,非精確表),
**判定順序要緊**(web 族先於「讀」,否則 web_search 會被判成讀):

| 順位 | 語意族 | SF Symbol | 命中關鍵詞 |
|---|---|---|---|
| 1 | 網 | `globe` | web / fetch / http / browser / curl |
| 2 | 腦(推理) | `brain` | think / reason / plan / todo |
| 3 | 終端 | `terminal` | bash / shell / exec / command / terminal、== run |
| 4 | 寫 | `pencil` | write / edit / patch / create |
| 5 | 讀 | `eye` | read / grep / glob / search / cat / view / list / find、== ls |
| — | fallback | `wrench.and.screwdriver.fill` | 其餘全部 |

**「不用統一齒輪」原則**:工具活動不是一顆通用 ⚙ —— 讀寫腦網終端各有語意符號,
使用者掃一眼就知道 agent 在幹哪類事。新 provider 的工具名進來,先讓歸族表吃,
吃不到才落 fallback 扳手;**不為單一 provider 發明新 icon**。

### 11.4 高頻功能符號(現行慣例,沿用勿換)

| 語意 | SF Symbol |
|---|---|
| 搜尋 / 無結果 | `magnifyingglass` |
| 重試(inline) | `arrow.clockwise` |
| 同步中 | `arrow.triangle.2.circlepath` |
| 連線死 | `wifi.slash`;連線抖 `wifi.exclamationmark` |
| 停止 | `stop.circle`(鈕用 `stop.circle.fill`);強停 `exclamationmark.octagon.fill` |
| 鎖 | `lock.fill`;整頁鎖 cover `lock.circle.fill` |
| 稍後 / snooze | `clock`;背景執行 `moon.zzz.fill` |
| 子程序 | `person.2.fill`(空態 `person.2.slash`) |
| 封存 | `archivebox`;釘選 `pin` |
| 限額 | `gauge.with.needle.fill` |
| 正向空狀態 | `checkmark.seal` |
| 訊息動作 | 回覆 `arrowshape.turn.up.left` / 複製 `doc.on.doc`(→`checkmark`) / 分享 `square.and.arrow.up` / 轉發 `arrowshape.turn.up.right` / 刪除 `trash` |
| 佇列卡動作 | 編輯 `pencil` / 立即送 `paperplane.fill` / 取消 `xmark.circle` |
| 更多 | `ellipsis`(訊息動作列觸發器) |
| QR 配對 | `qrcode.viewfinder` |

### 11.5 Android / web 對應件

Android 現行用 **Compose Material Icons 向量**(`Icons.Filled` /
`Icons.AutoMirrored.Filled`)+ 少量品牌 drawable,**不是** Material Symbols
字型方案。對映原則:**對語意不對字形** —— 每個 SF Symbol 語意找 Material 最近親,
下表為對位建議【歸納自現行實作 + 語意對映】:

| 語意 | SF Symbols | Material(Compose) |
|---|---|---|
| running | `play.circle.fill` | `PlayCircle` |
| approval | `hand.raised.fill` | `PanTool`(現行已用) |
| input | `questionmark.circle.fill` | `Help` |
| failed | `exclamationmark.triangle.fill` | `Warning`(現行已用) |
| done | `checkmark.circle.fill` | `CheckCircle` |
| queued | `hourglass` | `HourglassEmpty` |
| reconnecting | `wifi.exclamationmark` | `SignalWifiStatusbarConnectedNoInternet4` / `WifiOff` 族 |
| 讀/寫/腦/終端/網 | `eye`/`pencil`/`brain`/`terminal`/`globe` | `Visibility`/`Edit`/`Psychology`/`Terminal`/`Language` |

web console 用 inline SVG(同語意自選一致字形);**三端驗收點是 11.2/11.3 的
語意表齊不齊,不是像素長一樣**。

### 11.6 尺寸

- 行內 icon:跟字級(12–13 配 caption、16 配 body)。
- 狀態點:8–9pt 實心(視覺小、命中區照 §16.4 補到 44pt)。
- 空狀態/cover 大圖示:54pt(cover 現值)或系統 ContentUnavailable 預設。
- Android icon 鈕:44dp 方(現行 `PocketPlainIconButton` 定值)。
