> Pocket 設計規範 v1.1 新章(2026-11-14)。全部規格與文案抄自出貨中的 app 實作(iOS 參考實作為正典,他端對位);全章索引見 [cis/README.md](README.md)。

## 13. 狀態語言 State language —— Pocket 的招牌章

Pocket 是看 agent 幹活的 app,**狀態就是內容**。本章是三問北極星的落地:
每個畫面只回答 —— **agent 在幹嘛?/卡在哪、為什麼?/下一步按什麼?**
回答不了三問的資訊降級或移除。

總原則:

1. **沒有壞消息就安靜** —— 閒置不畫點、弱資訊吃 1.5s 門檻(§12.2)。
2. **緊急態直亮不猶豫** —— 審批、停止異常、連線異常無視門檻。
3. **誠實** —— queued 就說 queued、stalled 就說疑似卡住,不借 running 綠裝忙。
4. **靜默失敗是最大病原** —— 每個壞狀態都要有臉(icon+文案)和出口(動作鈕)。

### 13.1 等待:WorkingBar 三件組

治「2 秒與 20 分鐘一樣」的答案不是動畫,是三件組:

```
┌ 上緣髮絲線 accent @20% ─────────────────────────────────┐
│ ◉ 活動點  〔編輯 foo.swift〕shimmer 掃字 · 2m 05s   ⏹ 停止 │
└ bg = accent @7%,padding 16/11 ──────────────────────────┘
```

| 件 | 規格 |
|---|---|
| **① elapsed 計時一等公民** | 格式升級制:`14s` → `2m 05s` → `1h 20m`(低位補零、`monospacedDigit()` 等寬,每秒重畫不重排);caption2、accent@70% |
| **② shimmer 掃真實活動字** | 活動字 = 真實 last_tool/phase 文案(「編輯 foo.swift」),shimmer 規格見 §12.4;lineLimit 1、中段截斷;停止中轉靜態字不掃 |
| **③ delayed-status** | busy 滿 1.5s 才現、消失 0.3s 防抖;停止流程 force 直亮(§12.2) |

預設 label「執行中」;running 態畫活動點(dots/spark),其他態畫 phase symbol。
停止鈕:`stop.circle.fill` + 「停止」,danger 色;按下轉「停止中…」muted + disabled。

### 13.2 佇列:誠實的 queued

兩個元件、一種措辭 —— 不管底層是伺服器排隊還是 app 端 busy 佇列,
對使用者是同一件事:

**(a) 虛線佇列卡**(本地草稿、可編輯):

```
╭┈ 虛線框 accent @65%,1.2pt,dash [5,4] ┈╮
┆ 訊息草稿內容…                            ┆   ← 底 = tray @60%,圓角 bubble 14
╰┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╯
 queuedNote(caption2 muted) 〔編輯〕〔立即送〕〔刪除〕
```

- **虛線 = 「這還是草稿,不是已送出的泡泡」**,一眼可辨(對比:已送 user 泡
  = accentSurface 實底 + accent@28% 實線)。
- 三動作:編輯(`pencil`,字回輸入框)/ 立即送(`paperplane.fill`,accent)/
  刪除(`trash`,danger)。伺服器端排隊(不可編輯)只給「取消」。

**(b) QueuedStrip 提示條**:`hourglass` + caption2 muted ——
單則「已排入下一輪 · 這輪執行完才處理」;多則「已排入下一輪 · N 則,執行完依序送出」。
可取消時給 danger「取消」。

### 13.3 斷線:連線狀態語言

| 元件 | 觸發 | 規格 |
|---|---|---|
| **ReconnectBanner** | 串流重連中 | 頂部細條:spinner(small)+「重新連線中…」,muted 字 / surface 底,padding 14/7,move(top)+opacity |
| **OfflineBanner** | 連不上主機,常駐 | `exclamationmark.triangle.fill` + **「離線 — 顯示快取內容,輸入會在恢復後送出」**,warning 色 —— 講清楚現在看到什麼、輸入去哪 |
| **膠囊 reconnecting 態** | 連線中斷重連中 | 「連線中斷,重新連線中…」+ 「重試」鈕(§13.7) |
| **膠囊 unavailable 態** | 串流連不上 | **「連不上即時串流,內容可能過時」**+「重試」—— 探活≠探串流,HTTP 通不代表 SSE 活,這態就是為此而生 |

**補接文案階梯**(失敗次數驅動,不逐次換措辭、是逐層加資訊):

1. 第 1 次失敗:安靜重試(指數退避 `min(30, 2^(n-1))` 秒 + 最多 30% 抖動;
   橫幅已亮時壓短至 ~2.3s,久斷 >10s 壓 5s 上限)。
2. 連續 ≥2 次失敗且過 2s 進場寬限:亮 connectionHint,文案依錯誤型別給**人話+下一步**:
   - 斷流:「連線中斷,正在重新連上…」
   - 無網路:「手機目前沒有網路,請確認連線後再試」
   - 找不到主機:「連不上桌面,請確認桌面端已啟動」/ 配對層加「與桌面在同一網路」「或重新掃描桌面 QR」
   - 認證失效(401/403):「認證失效,請重新配對」
   - 太頻繁(429):「操作太頻繁,請稍候再試」

### 13.4 限額:reset 時刻呈現

撞限額不再死在那 —— `UsageLimitResumeBar`:

| 件 | 規格 |
|---|---|
| 圖示 | `gauge.with.needle.fill`,warning 色;容器 warning@10% 底 + warning@35% 框,圓角 lg |
| 標題(已知 reset) | 「已達用量上限,**15:00** 可重試」—— 今日 `HH:mm`,跨日 `M/d HH:mm` |
| 標題(未知 reset) | 「已達用量上限,稍後可重試」—— **有意義的 nil,不編造時間** |
| 自動續跑 | 開關「到點自動續跑(15:00)」(僅 reset 已知且在未來時顯示) |
| 手動 | 「立即重試」膠囊鈕 |

reset 時刻偵測三層:狀態 phase `usage_limited` 附帶時刻 → 錯誤卡 meta →
文案解析;全無則問用量 API;仍無 → 只給手動重試。

### 13.5 鎖定

| 元件 | 情境 | 規格 |
|---|---|---|
| **AgentLockedCover**(整頁蓋版) | 引擎未登入/未安裝 | 大圖示 54pt muted(`lock.circle.fill` / 未安裝 `questionmark.circle.fill`);標題「「X」尚未在主機登入」/「主機尚未安裝「X」」;副標給**具體下一步**(去哪裡、按什麼、然後會發生什麼);鈕「在這裡登入」(prominent)+「重新檢查/檢查中…」。auth 未知(nil/檢查中)**不凍** —— 給載入中態,不讓人對著空白等輪詢 |
| **SessionLockBanner**(thread 寫入鎖) | 對話被另一端佔用 | `lock.fill` + warning;文案優先用後端 lock_message,缺則「這條對話正被另一端使用,輸入暫時無法送達」;warning@10% 底 + @35% 框 |

### 13.6 stalled 與自動結案

- **stalled 判定**:回合開著但超過 **5 分鐘(300s)** 沒有任何事件 → 疑似卡住。
- 呈現:**黃點(warning)+「疑似卡住:回合開著,但超過 5 分鐘沒有新事件」**;
  phase 回 nil —— **不借 running 綠裝忙**(活動 >N 分鐘標 stale 防謊報同理)。
- **自動結案**:閒置 **3 天**自動收進「已結案」;釘選與常駐對話豁免;
  收起**不無聲消失** —— 列表頂給「已自動收起 N 個閒置會話 · 查看」提示列
  (`archivebox` icon),配 Undo(§14.4)。
- 結案守門:執行中 →「執行中,完成後才能結案」;有待回應 →
  「有待回應的審批/提問,處理完才能結案」(審批優先於 busy)。

### 13.7 審批:琥珀/靛雙態 + 雙音效

「需要你」分兩種,**色就是分類**:

| 態 | 色 | 語意 |
|---|---|---|
| **審批 approval** | **琥珀(warning)**`hand.raised.fill` | 要你放行一個動作(權限/工具/派工) |
| **提問 input** | **靛(info)**`questionmark.circle.fill` | 要你回答一個問題/給輸入 |

同會話兩者都有 → 琥珀優先。列表左緣標記:3pt 寬 capsule 條,色走 phase。

**審批卡**:標頭 `hand.raised.fill` + 「待放行 · 需要你回應」(琥珀);
風險行 warning;到期用相對時間;失效明示「此請求已失效,無法回覆」(鈕灰 40%);
容器 surface 底 + warning@30% 框 + 圓角 xxl、padding 14。選項資料驅動
(provider 給什麼畫什麼),內建選項人話化(「自行輸入…」「與 Claude 討論」)。

**審批鈕三型**(整寬列、前導 icon、圓角 12、padding 14/11):

| kind | icon | 前景 | 底 | 框 |
|---|---|---|---|---|
| primary(允許) | `checkmark.circle.fill` | 白 | accent 實底 | — |
| secondary(軟允許) | `checkmark.circle` | accent | accent @12% | accent @25% |
| deny(拒絕) | `xmark.circle.fill` | danger | danger @12% | danger @28% |

**雙音效**(完成級 vs 需要你級,聲音就是分級):

| 級 | 通知音 | 前景提示音 |
|---|---|---|
| done(完成) | 系統預設(柔和) | 輕咻(mail-sent 級) |
| needsYou(審批/提問) | 鈴聲級(像來電) | 短促明確(alarm 級) |

### 13.8 底部狀態膠囊:10 態完整定義表

`SessionStatusCapsule` —— 把靜默失敗顯性化的總表。膠囊:底 tray@92% +
框 tint@35% 1pt、padding 12/6;icon 12 semibold 著 tint;字 captionStrong
(預設 muted,危急態轉 tint 色);動作鈕膠囊(accent 字 + tray 底;強停為白字 danger 底)。

| # | 態 | symbol | tint | 文案 | 動作 | 緊急 |
|---|---|---|---|---|---|---|
| 1 | working | `play.circle.fill` | success | 執行中 | — | — |
| 2 | syncing | `arrow.triangle.2.circlepath` | muted | 同步中… | — | — |
| 3 | waitingInput | `questionmark.circle.fill` | info | 等待你回應 | — | ● |
| 4 | childWaiting(n) | `person.2.fill` | info | 子程序在等你 / N 條子程序在等你 | — | ● |
| 5 | backgroundWork(n) | `moon.zzz.fill` | muted | 子程序在背景執行(N 條) | — | — |
| 6 | stopping | `stop.circle` | warning | 停止中… | — | ● |
| 7 | stopUnresponsive | `exclamationmark.octagon.fill` | danger | 停止沒有反應 | **強制停止** | ● |
| 8 | reconnecting | `wifi.exclamationmark` | warning | 連線中斷,重新連線中… | 重試 | ● |
| 9 | unavailable | `wifi.slash` | danger | 連不上即時串流,內容可能過時 | 重試 | ● |
| 10 | queued(n) | `hourglass` | muted | 已排入佇列 N 則,等待接手 | — | — |

規則:

- **優先序**(高→低):stopUnresponsive → stopping → unavailable → reconnecting
  → waitingInput(非 busy 時)→ childWaiting → queued(busy+phase queued)→
  working → queued(本地)→ backgroundWork → syncing → 無。
- **停止升級門檻**:按停止後伺服器仍 busy 超過 **8s** → 升 stopUnresponsive,
  亮「強制停止」——「Stop 沒反應」不准靜默。
- 緊急態(●)直亮;非緊急吃 1.5s/0.3s 門檻。
- **讓位規則**:宿主畫面已有同資訊 UI(WorkingBar/QueuedStrip 等)時,
  對應態設 quiet 不重複出聲(預設 quiet:working/stopping/queued/syncing/waitingInput)。

### 13.9 頂燈(SessionTopStatusDot)

列表/頂欄的一眼燈:8–9pt 實心點或 phase symbol,吃 phase 表取色;
**閒置不畫** ——「沒有壞消息」用安靜表達。細節全交給膠囊,頂燈只管一眼。

### 13.10 收件匣分層(Settle 語彙)

列表不是時間流水帳,是收件匣 —— 分層排序(單趟 O(n)):

**需要你 > 稍後(snoozed) > 進行中 > 一般 > 已結案**

| 層 | header | 判定 |
|---|---|---|
| 需要你 | `hand.raised.fill` 琥珀 +「需要你 · N」 | needsYou(審批琥珀/提問靛;snoozed/settled 一旦需要你立刻浮回) |
| 稍後 | `clock` +「稍後 · N」(折疊) | 使用者 snooze(1 小時後 / 明早 8 點);右上角 `clock` + 喚醒時間 info 角標 |
| 進行中 | `play.circle.fill` 綠 +「進行中 · N」 | busy;列 = 活動點 + 標題 + shimmer 活動字 + elapsed |
| 一般 | (呼叫端定) | 剛完成的浮到頂(右上 `checkmark.circle.fill` 綠角標「剛完成」),其餘照原排序 |
| 已結案 | `checkmark.circle` +「已結案 · N」(折疊) | 手動結案或閒置 3 天自動收(§13.6) |

settle-and-advance:結案即前進 —— 下一個「需要你」優先,否則「一般」首位。

### 13.11 三端對位

本章規格以 iOS 參考實作為正典;Android/web/macOS 落地時**狀態 union、文案、
門檻值、優先序一字不差**,視覺容器(膠囊/banner/snackbar)用各端元件庫對位件
(見 [17-components.md](17-components.md)、[18-platforms.md](18-platforms.md))。
新 provider 接入的驗收:10 態膠囊 + phase 表 + 佇列 + 限額四件全通,
「管線存在 ≠ 端到端通」。
