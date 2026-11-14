> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 6. 元件八件

每件:結構圖 + token 標注。活樣本見 `design/pocket.html`。

### 6.1 按鈕

```
 ┌──────────────────────────┐
 (        送出  ▸            )   ← 膠囊 --btn-radius
 └──────────────────────────┘
 primary   : bg=accent        fg=accentForeground(白)  semibold
 secondary : bg=surface       fg=text   邊=border(ink @ style.borderOpacity)
 ghost     : bg=transparent   fg=text   hover=surface-hover
 danger    : bg=transparent   fg=danger 邊=danger(細邊膠囊)
 hover=accentHover / brightness(1.08);active=accentActive
 審批鈕(ApprovalButton):整寬列、前導 icon、圓角 12;
   允許=accent 實底、軟允許=accent @12% 底+accent 字、拒絕=danger @12% 底
```

### 6.2 卡片

```
 ┌─ radius 14(泡泡/卡片家族)────────────┐
 │ bg=surface(白)                        │
 │ 邊=cardBorder(ink @ 0.10)   影=級1    │
 └───────────────────────────────────────┘
```

### 6.3 訊息泡

```
 agent 泡(靠左)                       user 泡(靠右)
 ┌─ radius 14,缺左下角 6 ─┐              ┌─ radius 14,缺右下角 6 ─┐
 │ bg=surface  邊=border    │             │ bg=accentSurface          │
 │ fg=text    影=級1        │             │ 邊=accent @28%  fg=text   │
 └─────────────────────────┘              └──────────────────────────┘
 正文=body 16/1.75;代碼卡才轉 mono 13/1.6
 max-width: min(760px, 92%)(web)/ 540pt(iOS)
 ⚠ user 泡填色兩端現值分岔(iOS 實心紅),見 §9 #3
```

### 6.4 狀態點(吃 phase 表,單一真相)

`PocketPhaseStyle` 七態 →(SF Symbol, 語意色)全系統復用,**不准自己配**:

| phase | symbol | tint(SDS 狀態色) |
|---|---|---|
| running | `play.circle.fill` | success |
| approval | `hand.raised.fill` | warning |
| input | `questionmark.circle.fill` | info |
| failed | `exclamationmark.triangle.fill` | danger |
| done | `checkmark.circle.fill` | success |
| queued | `hourglass` | muted |
| reconnecting | `wifi.exclamationmark` | warning |

衍生容器同表取色:頂燈五態(`SessionTopStatusDot`,8–9pt 實心點或 symbol,
閒置不畫 ——「沒有壞消息」用安靜表達)、底部狀態膠囊十態
(`SessionStatusCapsule`:膠囊底=tray @92%、邊=tint @35%、caption 字 +
可選動作鈕;緊急態直亮,弱資訊吃 1.5s 門檻)。

### 6.5 WorkingBar

```
 ┌ 上緣髮絲線 accent @20% ──────────────────────────────┐
 │ ◉ 脈動點  編輯 foo.swift〔shimmer 亮帶掃字〕 · 2m 05s   ⏹ 停止 │
 └ bg = accent @7% ─────────────────────────────────────┘
 · 活動字 = 真實 last_tool/phase 文案,shimmer 掃字不掃點
 · 計時格式升級制:14s → 2m 05s → 1h 20m(tabular-nums,寬度穩定)
 · delayed-status:busy 滿 1.5s 才現、消失延遲 0.3s 防抖;停止流程 force 直亮
 · 停止鈕 fg=danger;stopping 時停用轉 muted
```

### 6.6 列表列(session 列)

```
 ┌ radius 10(field 檔)────────────────────┐
 │ 名稱(16/semibold)                        │
 │ 副標(caption 13 muted,單行省略)           │
 └──────────────────────────────────────────┘
 hover=surface-hover;選中=accentSurface 底 + 左緣 inset 3px accent 條
 + 名稱轉 accent;側欄底=surface-sunken(比頁底深一階)
```

### 6.7 輸入框

```
 ┌ radius 10 ──────────────────────────────┐
 │ bg=panel-2/surface  邊=border  fg=text   │ ← body 16
 └──────────────────────────────────────────┘
 focus:邊=accent + 3px 光暈(accent @18%)—— 文字框的 focus 例外款
 placeholder=text-faint
```

### 6.8 Toast

```
   ┌ radius 20(dialog 檔)· 影=級3 ┐
   (  ⚠ 錯誤訊息(caption 13)      )
   └ bg=danger  fg=danger-foreground ┘
 位置:底部置中浮起;dark 的 danger-foreground=#2A1210(淡紅底深字)
 iOS 現無共用 toast 元件(就地黑膠囊),收斂方向照本節,見 §9 #12
```
