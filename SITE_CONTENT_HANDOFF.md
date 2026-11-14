# SITE_CONTENT_HANDOFF — Pocket 設計規範站 建站內容包

> 給建站 agent 的分頁內容包(對應 Pocket 設計規範 v1.1,2026-11-14)。
> 每頁:標題 + 導言一句 + 內容要點(含具體數值,可直接照蓋)+ 示例指示(哪些要實渲染)。
> 規範正文在本 repo `cis/`;本包已把建站所需數值抄齊,**不用再翻 repo**。
>
> 全站通則:
> - 站本身就要吃 Pocket tokens(`tokens/css/pocket-tokens.css`,`data-theme="pocket|white|dark"` 三主題切換器放頂欄)。
> - 字:標題可用粉圓(jf open 粉圓 woff2,無則系統堆疊 `-apple-system,"PingFang TC"…`);正文系統字;代碼 `ui-monospace`。
> - 版型:側欄導航(surface-sunken 底)+ 單欄內容 `min(760px, 92%)`;頂欄 sticky + shadow-1 + lockup(左 logo `assets/pocket-mark.png` 透明版 + 右「POCKET」紅字)。
> - 正文行高 ≥ 1.7(CJK 鐵則);focus ring = 2px accent outline + 2px offset;`prefers-reduced-motion` 關全部循環動畫。
> - 禁:紅大面積、黑大面積、accent 上白長文、`icon-512.png` 當 logo(無透明,會烤邊 —— logo 一律 `pocket-mark.png`)。
> - 繁中為主;頁內小節錨點導航。

---

## 頁 0:首頁

**標題**:Pocket 設計規範
**導言**:你口袋裡的 AI agent —— 直接、可靠、隨叫隨到;紅是訊號不是地毯。

要點:
- Hero:lockup(logo + POCKET 紅標準字)+ 一句定位 + 版本徽章「v1.1 · SDS v0.3 品牌層」。
- 分層圖(要渲染):上層「Pocket 品牌層」(五色 L1、奶油底、泡泡語彙、吉祥物、粉圓 voice、膠囊鈕)疊在下層「Studio Design System v0.3」(token 三層制、狀態色固定、字階四檔、圓角三檔、陰影四級、一曲線兩時長、無障礙底線)。
- 五色速覽卡(要渲染色票):Pocket Red `#EE2D2A`(主訊號)/ Overall Blue `#049CD8`(第二識別)/ White `#FFFFFF`(面)/ Star Yellow `#FBD000`(點綴)/ Ink `#17171A`(字與邊)+ 奶油底 `#FFF2D6`(canvas)。
- 三問北極星引言卡:每個畫面只回答 —— **agent 在幹嘛?/卡在哪、為什麼?/下一步按什麼?**
- 章節導覽格(連到各頁)。
- 品牌敘事短段(從 `cis/BRAND.md`):五色故事(近瑪利歐配色,玩具感有紀律)、吉祥物口袋(牛仔口袋擬物 icon)、三聲 voice。

示例指示:分層圖與五色卡實渲染;吉祥物區放 `assets/icon-512.png`(深色卡上)與 `assets/pocket-mark.png` 並列,標注用途差。

---

## 頁 1:Foundations / 色彩

**標題**:色彩
**導言**:五色 L1 + 奶油底階,L2 語意對照;所有值出自三個真相源,不發明新值。

要點(全部要渲染成色票表,每格:色塊 + token 名 + hex):
- 品牌常數 light/dark:pocket-red `#EE2D2A`/`#FF4D4A`(hover `#D11F1C`/`#FF6360`、active `#B01A18`/`#E0403D`、deep `#B01A18`/`#C42E26`);overall-blue `#049CD8`/`#2AA8E0`;star-yellow `#FBD000`/`#FFD426`;white `#FFFFFF`;ink `#17171A`(dark 前景轉 `#F2F2F5`)。
- 奶油底階:canvas `#FFF2D6`/`#131317`;surface `#FFFFFF`/`#1E1E25`;surface-sunken `#F7EACB`/`#0E0E12`;tray `#E9E6DF`/`#2A2A33`;accentSurface `#FBDFD6`/`#4A2B2C`;漸層 soft `#FFD9D4→#FFB3AC`;漸層 brand `#FBD000→#EE2D2A→#B01A18`。
- White 主題:canvas `#F5F5F7`、surface `#FFFFFF`、sunken `#E9E9EC`、muted `#68686D`、faint `#84848D`、accentSurface `#FBDFDE`。
- 狀態色(SDS 固定,品牌不可覆寫)light:success `#1d7a4a` / danger `#b42318` / info `#1f6aa1` / warning `#775800`;dark(300 階):`#6fd39d` / `#f59a90` / `#7cc0ec` / `#eebc4a`。
- L2 語意表核心:text muted light `#6B6760`、faint `#8A847A`、disabled `#A89F93`、border = ink @ .14(dark white @ .12)、link/action-link `#049CD8` / 內文 `#C42320`。
- 輔助色:Luigi green `#43B14A`(第六色,不進主識別);persona 四色盤 `#DD3126`/`#2E9E43`/`#C98A12`/`#DE5C95`;工具品牌 CC `≈#D47345`/Codex `≈#338C80`/OpenClaw `#C41E30`/Gemini `#4285F4`。
- 對比實測表(文字呈現):ink/cream 16.12:1 AAA;ink/accentSurface 14.16:1;muted/cream 5.07:1;faint/cream 3.34:1;white/red 4.16:1(大字 AA,僅限 semibold 短標籤);action-link/cream 5.24:1;dark text 16.59:1;dark accent 5.66:1。
- 紀律:「紅是訊號不是地毯」—— accent 只做主按鈕/選取/focus/連結強調;選取底用 accentSurface。

示例指示:色票全實渲染且隨主題切換;對比表每行放實字樣本(前景色字壓底色塊)。

---

## 頁 2:Foundations / 字體

**標題**:字體
**導言**:三軌字族 —— display 粉圓講品牌、正文系統字講舒適、mono 固定寬講精確。

要點:
- 三端字族表:display = jf open 粉圓(OFL 1.1)/ body = 系統字(SF/PingFang、Roboto/Noto)/ terminal = 粉圓(nil 退 body)/ mono = 系統 mono / wordmark = Luckiest Guy(無 CJK,品牌時刻限定)。
- 字階四檔(SDS):caption 13/1.6 · body 16/1.75 · subtitle 18/1.35 · title 20/1.3;iOS 對位 footnote 13/subhead 16/headline 17/title3 20;大階(34/28/22)為平台延伸。
- CJK 鐵則:正文行高 ≥ 1.7(caption 1.6 豁免)、標題 ≥ 1.2。
- Locale 規則:粉圓服務 zh-Hant + 拉丁語系;zh-Hans/ja 整軌落系統字;其餘文種自然 cascade。
- Dynamic Type:語意角色必縮放;mono 唯一豁免(固定寬優先);計時數字 tabular-nums。
- display 軌全 semibold + 負 tracking(iOS/Android 已對齊)。

示例指示:四檔字階實渲染(各檔實字,繁中+英文混排);粉圓 vs 系統字對照段;wordmark 樣本(紅字)。

---

## 頁 3:Foundations / 間距與格線

**標題**:間距與格線
**導言**:4pt 基準階,主力 8/12/16;列有 44pt 行高箱,版面是單欄內容流不是雜誌格線。

要點:
- 間距階(s1–s10):4 / 8 / 12 / 16 / 20 / 24 / 32 / 40;主力 8(元件內)、12(群)、16(卡片內距/頁邊);4 微距、20/24/32 區段、40 hero。
- 頁邊距:14 或 16(14 = 略窄的 editorial 感,擇一整頁一致);清單內縮 10/12;區段 header 24/20/16(水平/上/下)。
- 半檔值(6/10/14):承認為元件內部光學修正,不入階;版面級禁用。
- 列表行高箱:最小 44pt(= 觸控下限);列垂直 padding 6–10;整列可點。macOS 例外 36pt。
- 元件內距定值:膠囊鈕 16/8、輸入框 14/11、badge 8/3、卡片 16、狀態膠囊 12/6、WorkingBar 16/11。
- 版型:行動單欄;web 側欄 + `min(760px,92%)`;macOS 三欄(Sidebar ~200 / 內容 / Inspector 280)。

示例指示:間距階尺渲染(色塊階梯);44pt 行高箱圖解(視覺小點 + 命中區外框)。

---

## 頁 4:Foundations / 形狀與陰影

**標題**:形狀與陰影
**導言**:圓角三檔 + Pocket 自有泡泡檔 14;陰影四級,奶油底用暖灰、深色靠表面變亮。

要點:
- 圓角:btn `9999` 膠囊(SDS 簽名)/ field `10` / dialog `20` / **泡泡 14(Pocket 自有:聊天泡、審批卡、卡片家族)** / 文字級小裝飾 3–6 不入檔;iOS token 階 sm4/md6/lg8/xl12/xxl14/bubble14/pill999。
- 泡泡方向性:user 泡缺右下角 6、agent 泡對側同款。
- Editorial 性格:pill 控件、卡片 14、邊 1px @ ink 14%(strong 16%)、柔影、自然大小寫。
- 陰影四級(light 暖灰 `oklch(25% .04 55/α)`):級1 `0 2px 6px /.12, 0 1px 2px /.08`(卡片/泡)、級2 `0 8px 24px /.17`(浮層/選單)、級3 `0 16px 48px /.23`(toast/抽屜)、級4 `0 28px 80px /.3`(對話框+遮罩);dark 改純黑 + 表面越高越亮。

示例指示:圓角四檔實渲染(膠囊鈕/輸入框/泡泡/對話框各一);陰影四級卡片階梯實渲染(light/dark 都要)。

---

## 頁 5:Foundations / 圖示

**標題**:圖示
**導言**:SF Symbols 為正典,狀態與工具各有語意表 —— 不用統一齒輪,掃一眼就知道 agent 在幹哪類事。

要點(表全渲染,每行:icon 字形示意 + 名稱 + 色):
- phase 符號表(單一真相,不准自己配):running `play.circle.fill` success / approval `hand.raised.fill` warning琥珀 / input `questionmark.circle.fill` info靛 / failed `exclamationmark.triangle.fill` danger / done `checkmark.circle.fill` success / queued `hourglass` muted / reconnecting `wifi.exclamationmark` warning。
- 工具語意表(關鍵詞歸族,順序:網→腦→終端→寫→讀→fallback):globe(web/fetch/http/browser/curl)/ brain(think/reason/plan/todo)/ terminal(bash/shell/exec/command)/ pencil(write/edit/patch/create)/ eye(read/grep/glob/search/cat/view/list/find)/ 扳手 fallback。
- 高頻功能符號:搜尋 magnifyingglass、重試 arrow.clockwise、同步 arrow.triangle.2.circlepath、斷線 wifi.slash、停止 stop.circle、強停 exclamationmark.octagon.fill、鎖 lock.fill、snooze clock、背景 moon.zzz.fill、子程序 person.2.fill、封存 archivebox、限額 gauge.with.needle.fill、正向空 checkmark.seal、更多 ellipsis、QR qrcode.viewfinder。
- Android 對位原則:對語意不對字形(Compose Material Icons:PanTool/Warning/CheckCircle/Psychology/Visibility/Edit/Terminal/Language…);web 用 inline SVG;驗收 = 語意表齊,不是像素同。
- 尺寸:行內跟字級(12–13/16);狀態點 8–9pt(命中補 44);大圖示 54pt。

示例指示:兩張語意表用等效 SVG/emoji 近似渲染即可(站上無 SF Symbols 字型),標注「iOS 實際為 SF Symbols」。

---

## 頁 6:Foundations / 動態

**標題**:動態 Motion
**導言**:動畫是狀態的影子,不是表演 —— 真的在動才動,短到看不見就不動,沒事就安靜。

要點:
- token:曲線 `cubic-bezier(.2,0,0,1)`;fast .12s / **base .20s** / **slow .25s**;smooth = spring(response .35, damping .85) 僅物理場合。
- delayed-status 門檻(鐵則):弱資訊指示 busy 滿 **1.5s** 才現、消失 **0.3s** 防抖;緊急態(停止/審批/連線異常)force 直亮。「不顯示也是設計」。
- 鐵則:**無打字機動畫**(串流增量渲染,新塊一次 fade-in 不動 layout)、**無固定 tick**(計時用平台排程;相對時間只排在日界翻面時重繪,前天以前零喚醒)。
- 標準語彙:shimmer(亮帶 = 文字寬×0.6,linear 1.4s 單向,掃**真實活動文字**)、skeleton 呼吸(opacity 1.0→0.82→0.64→0.82,steps(4)、0.35s/格、1.4s/輪、滾出視窗停)、snackbar move(bottom)+opacity slow、banner move(top)+opacity base、列表插入 move(bottom)+opacity(無 FLIP/matchedGeometry)。
- reduced-motion:必關 shimmer/脈動/呼吸全部循環動畫;轉場降級淡入淡出。
- 驗收:新動畫答不出「反映哪個真實狀態」→ 砍;畫面靜止時零重繪。

示例指示:**實渲染互動 demo 三個** —— ① delayed-status 模擬器(按「跑 0.8s」不出 bar、按「跑 3s」1.5s 後出);② shimmer 掃字樣本;③ skeleton 量化呼吸 vs 平滑呼吸對照。全部尊重 prefers-reduced-motion。

---

## 頁 7:Tokens

**標題**:Tokens
**導言**:一份 53-role JSON,三端消費 —— 挑一個好看的底 + 一個有態度的 accent,可讀性是管線的事。

要點:
- 三層制:L1 palette → L2 語意 → L3 元件;web 檔 `tokens/css/pocket-tokens.css`,`data-theme` 切膚。
- 三內建主題:pocket(奶油 `#FFF2D6` + 紅 `#EE2D2A`)/ white(`#F5F5F7` 中性)/ dark(`#131317` + 提亮紅 `#FF4D4A`);JSON 在 `tokens/themes/`。
- 3 值生成器:appearance + canvas + accent → 整套 53 roles;OKLCH 明度階梯、對比二分求解(正文對 canvas 7:1、各 Foreground 對 Surface 4.6:1)、超域收 chroma。
- 跨端對照表(渲染精簡版):頁底 backgroundPrimary/canvas/`--color-canvas`;卡片 backgroundSecondary/surface/`--color-surface`;正文 foregroundPrimary/text/`--color-text`;強調 accent;選取底 accentTint/accentSurface/`--color-accent-surface`;危險 danger/error/`--color-danger`…(全表見 `cis/08-token-mapping.md`)。
- 不可覆寫:狀態色固定值、對比底線、focus ring、動效曲線時長、圓角三檔、字階四檔。
- 主題作者驗收:schema 過(53 roles 齊、小寫 `#rrggbb`)、14 組對比配對 ≥4.5:1、light/dark 實測各一輪。

示例指示:三主題即時切換 demo(整頁就是 demo);3 值生成器概念圖(種子 → 階梯 → 整套色票)。

---

## 頁 8:State Language(招牌頁,給最大版面)

**標題**:狀態語言
**導言**:Pocket 是看 agent 幹活的 app,狀態就是內容 —— 每個畫面只回答:agent 在幹嘛?卡在哪?下一步按什麼?

要點:
- 四總則:沒有壞消息就安靜(閒置不畫、1.5s 門檻)/ 緊急態直亮 / 誠實(queued 就說 queued,stalled 不借綠裝忙)/ 靜默失敗是最大病原(每個壞狀態有臉有出口)。
- **WorkingBar 三件組**(要實渲染):accent@7% 底 + 上緣 1pt accent@20%;① elapsed 計時 `14s → 2m 05s → 1h 20m`(等寬數字);② shimmer 掃真實活動字(「編輯 foo.swift」);③ 1.5s/0.3s 門檻;停止鈕 danger → 「停止中…」muted disabled。
- **10 態膠囊完整表**(要渲染成表,每行實樣膠囊):working 執行中 / syncing 同步中… / waitingInput 等待你回應● / childWaiting 子程序在等你● / backgroundWork 子程序在背景執行 / stopping 停止中…● / stopUnresponsive **停止沒有反應 + 強制停止鈕**● / reconnecting 連線中斷,重新連線中…+重試● / unavailable 連不上即時串流,內容可能過時+重試● / queued 已排入佇列 N 則,等待接手。(● = 緊急直亮)膠囊:tray@92% 底 + tint@35% 框、12/6 padding。停止 >8s 沒反應自動升強停。
- 佇列:虛線卡(accent@65% 1.2pt dash[5,4] = 「還是草稿」)+ 編輯/立即送/刪除;QueuedStrip「已排入下一輪 · 這輪執行完才處理」。
- 斷線:ReconnectBanner「重新連線中…」/ OfflineBanner「離線 — 顯示快取內容,輸入會在恢復後送出」/ 補接階梯(指數退避 `min(30,2^(n-1))s`,≥2 次失敗才亮 hint,文案依錯誤給人話+下一步)。
- 限額:「已達用量上限,15:00 可重試」(今日 HH:mm / 跨日 M/d HH:mm;不知道就說「稍後」不編造)+ 到點自動續跑開關 + 立即重試。
- 鎖定:整頁 cover(未登入/未安裝,54pt 圖示 + 具體下一步 + 「在這裡登入」)/ thread 鎖 banner「這條對話正被另一端使用,輸入暫時無法送達」。
- stalled:5 分鐘無事件 → 黃點「疑似卡住:回合開著,但超過 5 分鐘沒有新事件」。
- 審批雙態:**琥珀 = 審批(hand.raised.fill)、靛 = 提問(questionmark.circle.fill)**,並存琥珀優先;列左緣 3pt phase 色條;審批卡(warning@30% 框、到期相對時間、失效明示);審批鈕三型(允許 accent 實底 / 軟允許 accent@12% / 拒絕 danger@12%);雙音效(done 柔和 vs needsYou 鈴聲級)。
- 收件匣分層:**需要你 > 稍後 > 進行中 > 一般 > 已結案**;閒置 3 天自動結案(釘選豁免)+ 「已自動收起 N 個 · 查看」+ Undo;結案守門文案;settle-and-advance。
- 頂燈:8–9pt 點,閒置不畫。

示例指示:這頁是展示重頭 —— WorkingBar 實動 demo、10 態膠囊全渲染、虛線佇列卡實樣、審批卡琥珀/靛對照實樣、分層收件匣 mock 列表。

---

## 頁 9:Patterns(Empty · Error · Voice)

**標題**:Patterns —— 空、錯、文案
**導言**:空要說東西什麼時候會來,錯要留痕可重試,話要人話短句給下一步。

要點:
- 空狀態公式(渲染公式圖 + 實例):人話標題(「沒有 X」「還沒看到 X」)+ 副標(「X 會出現在這裡」+ 下一步/觸發條件)+ CTA(有可做才給)。實例:「沒有錯誤記錄/發生錯誤時會自動記在這裡,並同步到後端供檢查。」「還沒看到你的 Mac/…約一分鐘內會出現在這裡…+ 掃描 QR 配對」。
- 搜尋無結果三件套:magnifyingglass + 「沒有符合的結果」+ 「已搜尋〔範圍〕,找不到「〔字〕」。試試更短的關鍵字,或拆開詞彙再搜。」+ 「清除搜尋」。
- 錯誤留痕範式:wifi.exclamationmark + 「X 暫時無法取得」+ **原始錯誤原文**(不吞不改寫)+ 「重試」;inline 款 arrow.clockwise「最新訊息尚未同步,重試」;「發生錯誤」通用句 = 禁例。
- Undo 範式:5 秒後悔窗、同類聚合計數(「已結案 N 個」)、換類即過期、LIFO 復原;snackbar 黑@82%/圓角20/「復原」warning 字/bottom 72。
- 破壞性分流:可後悔 → 不擋直接做 + Undo;不可後悔 → 對話框講清楚失去什麼 + 動詞確認鈕(不用「確定」)。
- Voice 三聲:字(粉圓親切/系統舒適)、形(膠囊、泡泡 14、缺角 6、柔影)、話(直接可靠不囉嗦)。
- 文案規則:三語(繁中為源,en/zh-Hans 跟上,守門 script 出貨強制);進行態「停止中…/檢查中…」;相對時間日界規則(今天 HH:mm / 昨天 HH:mm / 今年 月日 / 跨年 年月日,**不用「3 小時前」**);人話 footer(「帳號只存在主機上,我們不經手。」);禁語(通用錯誤句、「確定」、技術行話、驚嘆號堆疊)。
- 文案句式庫表(渲染):等待/離線/限額/疑似異常/指路/Undo 各一句範式(抄 `cis/15` §15.7 表)。

示例指示:空狀態與搜尋無結果實渲染各一;Undo snackbar 實動 demo(按三次「結案」看聚合);句式庫做成可複製的表。

---

## 頁 10:Components(24 件)

**標題**:元件庫
**導言**:24 件,每件結構 + token + 狀態 + 三端對位;狀態與文案跨端一字不差,容器讓給平台。

要點(每件一卡,卡內:名稱 + 一句話 + 關鍵值;詳規格照 `cis/17`):
1. 導航列(返回/display 標題/恆定 `…` + 頂燈)
2. 頁籤(浮動膠囊底欄;選中 accent/未選 muted)
3. 列表列(16 semibold + 13 muted;minHeight 44;選中 accentSurface + 左緣 3px accent 條;分層:needsYou 3pt 琥珀/靛條、剛完成綠勾角標、snoozed clock 角標)
4. 會話控制面板(上狀態/中動作格/下危險區;動作顯隱吃 capabilities,不寫 if provider)
5. 審批卡(warning@30% 框、圓角 14、琥珀/靛、失效明示)
6. 狀態膠囊(10 態;tray@92% + tint@35%;8s 強停升級)
7. WorkingBar(三件組;accent@7% 底)
8. 訊息泡 + 動作列(泡 14 缺角 6;完稿 assistant 卡掛 ellipsis Menu:回覆/複製/分享/轉發/置頂/刪除;長按=原生選取)
9. 佇列卡 + QueuedStrip(虛線 dash[5,4];編輯/立即送/刪除)
10. 輸入框 + Composer(圓角 10、14/11;focus 例外款;InputSanitizer 紅線:剝零寬/bidi/控制碼,保 \n \t;prompt link 永不自動執行)
11. 按鈕族(primary/secondary/ghost/danger 膠囊;進行中=現在分詞+disabled)
12. 徽章(8/3;語意色@12% 底;未讀=accent 點;黃=節制點綴)
13. Toast/Snackbar(danger toast 圓角 20 影 3;Undo snackbar 黑@82%)
14. 對話框(圓角 20 影 4;只給不可 Undo;動詞確認鈕)
15. 選單(icon+文案;destructive 紅;浮層影 2)
16. 搜尋(⌘K 面板;無結果三件套)
17. 色票 Swatch(canvas+accent 雙色樣;hover 試穿;3 值生成器入口)
18. 進度(spinner small/細條;長工作用 elapsed 不用假百分比)
19. Skeleton(量化呼吸 steps(4) 1.4s;視窗外停)
20. 頭像(圓形;persona 四色盤;工具品牌標只標來源)
21. QR 卡(白底保靜區、QR 永遠黑碼白底;CTA「掃描 QR 配對」)
22. 付費方案卡(推薦一張 accent 框;不做紅卡海)
23. 設定列(一列一句人話 footer;危險區集中;三層化)
24. 空狀態(公式照 Patterns 頁)

示例指示:至少實渲染 8 件:按鈕族全態、訊息泡對(agent/user)、狀態膠囊三態(working/stopUnresponsive/queued)、WorkingBar、審批卡、虛線佇列卡、輸入框 focus 態、Undo snackbar。其餘可線框示意。

---

## 頁 11:Platforms

**標題**:平台落地
**導言**:一份語意,各端原生 —— 色與狀態語言跨端一字不差,視覺容器與手勢讓給平台。

要點(每端一節):
- **iOS**(參考實作正典):token = 設計 package;粉圓掛 text style metrics 隨 Dynamic Type;讓 = swipeActions(leading 釘選/trailing 封存,禁 fullSwipe)、原生文字選取、SF Symbols;手勢仲裁 = 列上有 swipe 則換頁手勢讓路;Live Activity 安靜設計(島上只一 glyph、`Text(style:.timer)` 系統自跑、字串 app 端組好、wire 欄位全 optional + seq 遞增);通知雙 channel(done 柔和/needsYou 鈴聲級)。
- **Android**:53-role spec 手動 1:1 port(codegen 是 roadmap);語意色灌 Material3 ColorScheme、Shapes XS10/S12/M14/L16/XL24;Huninn display 軌 + labelLarge 釘字防掉 Roboto;**不讓 Material You 動態取色**;Live Updates 吃同一份 live-update 契約;已知欠帳:body 14 vs iOS 16、間距未 token 化。
- **Web Console**:`pocket-tokens.css` + `data-theme`;系統字堆疊(粉圓 woff2 待補);側欄 + `min(760px,92%)`;讓 hover/:focus-visible/⌘K;連結用 action-link `#C42320`。
- **macOS**:三欄 NavigationSplitView(Sidebar ~200/收合 56、Inspector 280、列高 36、toolbar 36);材質三階(長文/清單/表單絕不直接放玻璃,包不透明 plate;尊重 Reduce Transparency);Settings 走 ⌘,;身兼主機模式(配對 QR、引擎登入的目的地)。
- **官網**:CIS 鎖定面(不跟主題)——白/奶油底、紅只做訊號、圓角 14;token 引同一份 css;design 頁三鏡像同源。
- **PWA/icon 規則**(教訓成規則,渲染成對照卡):`icon-512.png` 無透明 = 平台 icon 專用,放非深色底會烤邊,**永遠不當 logo**;`pocket-mark.png` 透明 = 唯一 logo 引用;maskable 版 manifest 專用;PWA `background_color #D50F10`。
- 跨端驗收六條:53-role 全對(14 組對比斷言)/ 狀態文案一字不差 / 字階+行高 / l10n 三語守門 / reduced-motion / 「管線存在 ≠ 端到端通」。

示例指示:icon 對照卡實渲染(icon-512 放白底示範烤邊 vs pocket-mark 透明正確);平台表格化。

---

## 頁 12:Brand

**標題**:品牌應用
**導言**:品牌資產不屬於可換皮的 theme 層 —— logo、標準字、launch 畫面鎖定識別,不跟使用者主題走。

要點:
- Lockup:logo(`pocket-mark.png` 透明 1024)左 + 「POCKET」右(Luckiest Guy,字距 .04em 全大寫);**標準字一律品牌紅**(淺 `#EE2D2A`/深 `#FF4D4A`,**只有紅底上才用白**,無墨色/灰色標準字);間隙 ≈ logo 寬 0.36;留白 ≥ x-height;最小尺寸 wordmark 高 20px / logo 24px。
- 誤用紅叉(渲染成 ✕ 對照格):icon-512 當 logo(烤邊)/ 非等比變形旋轉 / 重上色加陰影光暈 / 低對比花俏背景 / 手改圖檔(generated,never hand-edit)/ 暗示官方背書。
- App icon:牛仔口袋擬物(紅內裡+白襯線+丹寧+金黃車線);上架 1024 正方形不透明無圓角(iOS 自動遮罩);圓角預覽版勿上架。
- Launch 畫面:全幅插畫 941×1672 aspect-fill、centerX+top/bottom 釘滿、width=canvas(999)+ width≤canvas 高(護字 constraint);底色 `#D50F10`;CIS 鎖定,dark 不換圖;Android 用 Splash Screen API 對位(紅底+置中 icon)。
- 品牌時刻邊界:Luckiest Guy 只在 splash/關於頁/官網 hero/行銷物,不進 UI 正文;吉祥物與 persona 頭像不授權第三方主題;governed 品牌頁鎖(紅 on white、ink 字、圓角 14、自然大小寫、粉圓 display)。
- 授權:tokens/code MIT、文件 CC BY 4.0;名稱與 logo 非商業可用(保持原樣、不暗示背書),商業先聯絡。

示例指示:lockup 實渲染(淺/深/紅底三態);誤用紅叉格實渲染(正確 ✓ vs 錯誤 ✕ 並排);launch 畫面用 `assets/launch-art.png` 示意。

---

## 附:資產清單(站要用的檔,全在本 repo)

| 檔 | 用途 |
|---|---|
| `assets/pocket-mark.png` | logo(透明,一切引用) |
| `assets/icon-512.png` | App icon 展示(只放深色/紅底卡上) |
| `assets/icon-maskable-512.png` | maskable 說明用 |
| `assets/launch-art.png` | launch 畫面示意 |
| `tokens/css/pocket-tokens.css` | 全站樣式底(L1+L2 變數) |
| `tokens/themes/{pocket,white,dark}.json` | 主題 JSON(tokens 頁可下載/展示) |
| `tokens/pocket-theme.schema.json` | schema(tokens 頁連結) |
| `design/pocket.html` | v1.0 活樣本(參照,不直接嵌) |
