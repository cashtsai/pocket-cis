> Pocket 設計規範 v1.1 新章(2026-11-14)。元件庫自 §6 八件擴編為 24 件;規格抄自出貨中的 app 實作與 §6 既有定義,【歸納】處為現行實作歸納。全章索引見 [cis/README.md](README.md)。

## 17. 元件庫 Components(24 件)

每件四欄:**結構 / token / 狀態 / 三端對位**。§6 原八件(按鈕、卡片、訊息泡、
狀態點、WorkingBar、列表列、輸入框、Toast)此處收錄升級版,原文仍在
[06-components.md](06-components.md)。通用規則:圓角查 §5.1、間距查 §10、
色查 §2.5、動效查 §12、狀態語言查 §13。

### 17.1 導航列(頂欄)

- **結構**:返回/標題(display 字族 headline)/右側恆定一顆 `…`(開會話控制面板,
  見 17.4)+ 微狀態燈(17.23 頂燈)。
- **token**:底 = canvas 或 surface + 底邊 border;標題 text、按鈕 accent。
- **狀態**:常態/大標收合(平台慣例);會話頁附頂燈(閒置不畫)。
- **對位**:iOS NavigationStack toolbar;Android TopAppBar(Compose);
  web console 頂欄(sticky + shadow-1);macOS toolbar 36pt。

### 17.2 頁籤(底欄 tab)

- **結構**:浮動膠囊式底欄【歸納:snackbar 讓位 72pt 即其高度域】,
  tab = icon + 短標。
- **token**:選中 = accent;未選 = muted;底 = surface + 影級 2。
- **狀態**:選中/未選/徽章(未讀紅點用 accent,數字徽章見 17.12)。
- **對位**:iOS 自訂浮動 tab;Android NavigationBar;web console 側欄取代底欄。

### 17.3 列表列(含收件匣分層)

- **結構**:名稱(16 semibold)+ 副標(caption 13 muted 單行省略);
  圓角 10(field 檔);**最小高度 44pt**;整列可點(`contentShape`)。
  分層列表照 §13.10:層 header(phase icon + 「需要你 · N」)、
  「需要你」列左緣 3pt phase 色條、剛完成右上綠勾角標、snoozed 右上 `clock` 角標。
- **token**:hover=surface-hover;選中=accentSurface 底 + 左緣 inset 3px accent 條
  + 名稱轉 accent;側欄底 surface-sunken。
- **狀態**:常態/hover/選中/needsYou(琥珀或靛條)/working(活動點+shimmer+elapsed)
  /snoozed/settled/剛完成。
- **對位**:iOS List row + swipeActions(leading 釘選/trailing 封存刪除,
  `allowsFullSwipe: false`);Android 同構列 + Material swipe;web 列 hover 態。

### 17.4 會話控制面板

- **結構**(單一面板,全 provider 同構):上段狀態(phase 色表/模型/workdir/
  context 用量)→ 中段動作格(改名/媒體/歷史/派工/diff/壓縮/分享/側聊)→
  下段危險區(退出/刪除)。頂欄右上 `…` 恆定入口。
- **token**:sheet 底 surface、圓角 dialog 20;動作格 icon 走 §11;危險區 danger。
- **狀態**:動作顯隱**吃 provider capabilities 宣告,不寫 if provider**;
  不可用=隱藏(不是灰)。
- **對位**:iOS sheet;Android bottom sheet;web console 右側 panel;macOS Inspector。

### 17.5 審批卡

- **結構**:標頭(`hand.raised.fill` +「待放行 · 需要你回應」)→ 請求內容 →
  風險行(warning)→ 到期(相對時間)→ 按鈕列(資料驅動,provider 給什麼畫什麼)。
- **token**:容器 surface 底 + warning@30% 框 1pt + 圓角 xxl 14 + padding 14;
  琥珀=審批、靛=提問(§13.7)。
- **狀態**:待回應/失效(「此請求已失效,無法回覆」+ 鈕 40% 灰)/busy(鈕 50% + disabled)。
- **對位**:三端同構卡;按鈕三型(primary/secondary/deny)規格見 §13.7 表。

### 17.6 狀態膠囊(SessionStatusCapsule)

- **結構**:icon(12 semibold, tint)+ 文案(captionStrong)+ 可選動作鈕。
- **token**:底 tray@92% Capsule + 框 tint@35% 1pt;padding 12/6;
  動作鈕 accent 字 + tray 底(強停:白字 danger 底),padding 10/4。
- **狀態**:**10 態完整表、優先序、quiet 讓位、8s 強停升級全查 §13.8**。
- **對位**:三端狀態 union 與文案一字不差;容器用各端膠囊件。

### 17.7 WorkingBar

- **結構/token/狀態**:三件組(elapsed/shimmer/delayed-status)全查 §13.1;
  容器 accent@7% 底 + 上緣 1pt accent@20%、padding 16/11。
- **對位**:web console 同款 bar(css token 同名);Android 同構;
  LA 島上只一 glyph(安靜設計,§18)。

### 17.8 訊息泡 + 動作列

- **結構**:泡 = §6.3(圓角 14、發話側缺角 6;agent=surface+border、
  user=accentSurface+accent@28% 邊);**動作列**掛在完稿 assistant 泡下方:
  時間標籤(caption2 tertiary)+「已複製」瞬時字 + `ellipsis` Menu。
- **token**:動作列 HStack spacing 8、觸發器命中區 minWidth 44 / minHeight 32。
- **狀態**:菜單項=回覆/複製全文(→`checkmark` 1.2s)/分享/轉發/置頂切換/刪除
  (destructive);長按 = 原生文字選取(**不做**自訂長按菜單);
  複製觸覺回饋 + 無障礙播報「已複製」。
- **對位**:Android 用 DropdownMenu 同項;web hover 浮出同動作列。

### 17.9 佇列卡(虛線)+ QueuedStrip

- 規格全查 §13.2:虛線框 accent@65% 1.2pt dash[5,4]、底 tray@60%、圓角 bubble 14;
  三動作 編輯/立即送/刪除;提示條 `hourglass` + 誠實文案。
- **對位**:三端同構;虛線=草稿的跨端共同語彙。

### 17.10 輸入框 + Composer

- **結構**:輸入框 = §6.7(圓角 10、padding 14/11、focus 例外款);
  composer = 輸入框 + 送出膠囊鈕 + 附件/模式鈕;placeholder 可教觸發字元
  (如「/」喚指令)【歸納自 UX 研究 B 級】。
- **token**:placeholder=text-faint;送出鈕 accent 膠囊。
- **狀態**:空(送出 disabled)/輸入中/busy(送出變排隊語意,見 §13.2)/
  鎖定(SessionLockBanner,輸入禁用)/離線(輸入保留,「恢復後送出」)。
- **紅線**:外部內容(分享、URL、捷徑)進 composer 前過 InputSanitizer ——
  剝零寬字元(0x200B–200F)、bidi 控制字(0x202A–202E、0x2066–2069)、
  C0/C1 控制碼與 DEL、BOM;**保留 \n 與 \t**;prompt link 永不自動執行。
- **對位**:三端同紅線(清洗表一字不差)。

### 17.11 按鈕族

- **結構/token**:primary/secondary/ghost/danger 四型查 §6.1(膠囊、semibold);
  膠囊內距 16/8;審批鈕三型查 §13.7。
- **狀態**:常態/hover(accentHover / brightness 1.08)/active(accentActive)/
  disabled(50% + 禁點)/**進行中**(現在分詞文案「停止中…」+ muted + disabled,§15.3)。
- **對位**:iOS buttonStyle;Android FilledButton/TonalButton 對位四型;web `.btn` 類。

### 17.12 徽章 Badge

- **結構**:膠囊,caption2;數字徽章或字標。
- **token**:內距 8/3;語意色@12% 底 + 語意色字(info 角標範式);
  未讀點 = accent 實心;黃(Star Yellow)徽章 = 高亮點綴,節制。
- **狀態**:數字/點/字標;上限顯示「99+」【歸納:慣例】。
- **對位**:三端同構小件。

### 17.13 Toast / Snackbar

- **結構**:§6.8 toast(危急,danger 底、圓角 20、影級 3)+ **Undo snackbar**
  (黑@82% 底、白 caption、「復原」warning 字、圓角 20、影級 lg、
  padding 16/10、bottom 72 讓位頁籤,§14.4)。
- **狀態**:單則/聚合計數;5 秒自動過期;進出 move(bottom)+opacity slow。
- **對位**:Android Snackbar 同參數;web console 底部置中。

### 17.14 對話框 Dialog

- **結構**:標題(動作本身)+ 內文(具體後果)+ 動詞確認鈕(destructive 紅)
  + 取消;只用於不可 Undo 的操作(§14.6/§15.4)。
- **token**:圓角 dialog 20、影級 4 + 遮罩;底 surface。
- **對位**:iOS confirmationDialog/alert;Android AlertDialog;web dialog。

### 17.15 選單 Menu

- **結構**:icon + 文案項;destructive 項紅;分組用分隔線。
- **token**:浮層 surface、圓角 dialog 20(web)/系統(iOS)、影級 2。
- **狀態**:項 hover/disabled;checked 項打勾。
- **對位**:iOS Menu;Android DropdownMenu;web 浮層選單。

### 17.16 搜尋

- **結構**:搜尋框(輸入框同款)+ 結果清單 + **無結果三件套**(§14.2:
  交代範圍、收斂建議、一鍵清除)。
- **狀態**:空/輸入中/有結果/無結果。
- **對位**:iOS `.searchable`;Android SearchBar;web ⌘K 面板(圓角 20)。

### 17.17 色票 Swatch(主題選擇器)

- **結構**:主題色票 = canvas+accent 雙色樣 + 主題名;自訂主題走 3 值生成器
  (appearance/canvas/accent,見 `brief/`)。
- **狀態**:選中(accent 框 + 勾)/未選;hover 即試穿(web 方向)【歸納】。
- **對位**:三端吃同一份 53-role JSON;選擇器只是殼。

### 17.18 進度 Progress

- **結構**:不確定 = 系統 spinner(small);確定 = 細條進度;
  **長工作優先用 WorkingBar 語彙**(elapsed 計時)而非百分比假精確。
- **token**:tint = accent 或情境語意色;context 用量條 = muted→warning 階【歸納】。
- **狀態**:loading 三態範式(§14.3):spinner → 內容或錯誤,不無限轉。
- **對位**:ProgressView / CircularProgressIndicator / css spinner,reduced-motion 停轉改靜態。

### 17.19 Skeleton

- 參數全查 §14.5(量化呼吸 steps(4)、1.0↔0.64、1.4s/輪、視窗外暫停、
  reduced-motion 不播);套在 redacted placeholder 上,active 跟載入旗標。
- **對位**:web `steps(4)` CSS;Android 同參數。

### 17.20 頭像 Avatar

- **結構**:圓形;persona = 四隻 chibi(四色盤 §2.4);工具 provider =
  品牌標資產(CC/Codex/OpenClaw/Gemini,只在標示來源時出現);
  使用者 = 縮寫字母 fallback【歸納】。
- **token**:尺寸貼 4pt 階;邊 1pt border(淺底上防融底)。
- **對位**:三端 asset 同源;LA/通知用 SF Symbol 名傳遞(§18)。

### 17.21 QR 卡(配對)

- **結構**:QR 置中(白底卡,保 QR 靜區)+ 一句話說明 + 替代路徑
  (「也可以直接掃描桌面的配對 QR」句式);掃描端 CTA「掃描 QR 配對」
  (`qrcode.viewfinder`,prominent)。
- **token**:卡 = surface + 圓角 14 + 影級 1;QR 永遠黑碼白底(不品牌染色,掃得到優先)。
- **狀態**:等待配對/配對中/成功(done 語彙)/失敗(留痕+重試)。
- **對位**:iOS/Android/macOS 桌面端同構。

### 17.22 付費方案卡

- **結構**:方案名(display 字族)+ 價格 + 特性清單(勾號列)+ CTA 膠囊鈕;
  推薦方案一張為主(accent 框),不做紅底卡片海(「紅是訊號不是地毯」)。
- **token**:卡 surface + 圓角 14 + 影級 1;推薦框 accent;徽章 Star Yellow 點綴。
- **狀態**:可購/目前方案(badge)/處理中(現在分詞)/restore 連結。
- **對位**:iOS StoreKit paywall;web 官網 pricing 同語彙。

### 17.23 設定列

- **結構**:一列 = icon(可選)+ 標題 + 值/開關 + **一句人話 footer**(§15.6);
  三層化:4 大區、進階收 disclosure、危險區集中一處(三顆重置合併)。
- **token**:列高 ≥44、圓角 10 分組卡;危險區 danger 字。
- **狀態**:開關/導航/按鈕列;危險動作走 §14.6 確認。
- **對位**:iOS List grouped;Android PreferenceScreen 對位;macOS Settings scene(⌘,)。

### 17.24 空狀態

- 公式與三件套全查 §14.1/§14.2;icon 54pt 級或系統預設;CTA 只有可做時才給。
- **對位**:iOS ContentUnavailableView;Android 同構 composable;web 同構區塊。
