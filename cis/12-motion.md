> Pocket 設計規範 v1.1 新章(2026-11-14)。時值與曲線抄自 SDS 與 app repo token 定義(`PocketDuration`/`PocketAnimation`);門檻值抄自出貨實作;【歸納】處為現頻統計。全章索引見 [cis/README.md](README.md)。

## 12. 動態 Motion

Pocket 的動態哲學:**動畫是狀態的影子,不是表演。** 真的在動才動(shimmer 掃的是
真實活動文字)、短到看不見就不動(delayed-status)、沒事就安靜(無固定 tick)。

### 12.1 時值與曲線(token)

| token | 值 | 用在 |
|---|---|---|
| 曲線 | `cubic-bezier(.2, 0, 0, 1)`(SDS 標準曲線) | 一切 transition |
| fast | 0.12s | 微互動(少用) |
| **base** | **0.20s** | **預設檔**:顯隱、狀態切換【歸納:最高頻】 |
| **slow** | **0.25s** | 進出場、snackbar【歸納:次高頻】 |
| smooth | spring(response .35, damping .85) | 拖曳回彈等物理感場合(= 標準曲線的物理近似) |

- iOS 以 `Animation.timingCurve(0.2, 0, 0, 1, duration:)` 實作三檔;
  web 用 `--ease-standard` + `--duration-base/.slow`;Android 對位同曲線。
- 兩檔主力 = base/slow;fast 與裸 spring 是例外,要有理由。
- 長時值(0.55–1.3s)只准出現在**循環裝飾動畫**(呼吸/脈動),且受 12.4/12.5 管。

### 12.2 delayed-status 門檻(狀態顯隱的防抖,鐵則)

弱資訊狀態指示(WorkingBar、狀態膠囊的非緊急態)一律過 `DelayedStatusGate`:

| 參數 | 值 | 語意 |
|---|---|---|
| showDelay | **1.5s** | busy 連續撐滿 1.5s 才顯示 —— 短操作不閃 bar |
| hideDelay | **0.3s** | busy 掉後再撐 0.3s 才收;0.3s 內毛刺翻回則原地復活 |
| force | — | 緊急態(停止流程、審批、連線異常)無視門檻直亮 |

**「不顯示也是設計」**:2 秒內做完的事不值得一次視覺打斷。

### 12.3 「無打字機動畫、無固定 tick」鐵則

- **禁止**打字機逐字動畫:串流文字直接增量渲染,新區塊一次性 opacity fade-in,
  不動 layout。
- **禁止**固定頻率 tick 空轉:計時器用平台排程(TimelineView periodic / rAF),
  相對時間戳只排在**下一次顯示會變的時刻**重繪(日界翻面;前天以前零喚醒)。
  「沒內容也頓」的卡頓病原就是固定頻率動畫。
- 循環動畫(shimmer、脈動、呼吸)**只准綁在「正在發生的事」上**,事停畫停;
  滾出視窗即暫停(skeleton 現行做法)。

### 12.4 標準動效語彙(現行實作定值)

| 動效 | 規格 |
|---|---|
| shimmer 掃字 | 底字 tint@45% + 全彩字遮罩;亮帶 = 文字寬 × 0.6,linear 1.4s 單向循環;**掃真實活動文字,不掃裝飾** |
| skeleton 呼吸 | opacity 1.0→0.82→0.64→0.82,steps(4)、0.35s/格、一輪 1.4s(詳 §14.5) |
| snackbar/bar 進出場 | move(bottom) + opacity,slow 檔 |
| banner 進出場 | move(top) + opacity,base 檔 |
| 列表插入 | **無 FLIP、無 matchedGeometry**(現行 0 處)—— move(bottom)+opacity 為主;列表移動靠資料排序 + 預設轉場 |
| 計時字 | 每秒重畫但 `monospacedDigit()` 等寬,寬度穩定不觸發重排 |
| 複製回饋 | 「已複製」opacity transition,1.2s 後復位 |

### 12.5 reduced-motion 尊重

`prefers-reduced-motion` / `accessibilityReduceMotion` 開啟時:

- **必關**:shimmer、脈動點、skeleton 呼吸、spark 等全部循環動畫
  (iOS 統一走 `PocketMotion.suppressed` 旗標,UITest 同路)。
- 轉場降級為淡入淡出或跳切。
- 規範要求**全域尊重**;現行 iOS 覆蓋面只到循環動畫與聊天換頁位移,
  其餘 transition 補齊列入待辦(見 ROADMAP)【歸納自現行實作的落差盤點】。

### 12.6 驗收

1. 新動畫先問:這在反映哪個真實狀態?答不出來 → 砍。
2. duration 只准引用 token 三檔;曲線只准標準曲線(或 smooth spring)。
3. 弱資訊指示過 1.5s/0.3s 門檻;緊急態 force。
4. reduced-motion 開啟跑一輪:無循環動畫殘留。
5. Instruments/DevTools 看一眼:畫面靜止時 **零重繪**。
