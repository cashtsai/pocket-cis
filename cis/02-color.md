> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 2. 色彩 L1 —— 五色 + 奶油底完整階

### 2.1 品牌常數(light / dark 兩套)

| L1 token | light | dark(300 提亮階) | 出處 |
|---|---|---|---|
| `pocket-red` | `#EE2D2A` | `#FF4D4A` | CIS / console `--pocket-red(-300)` / iOS accent |
| ├ hover | `#D11F1C` | `#FF6360` | iOS `accentHover` |
| ├ active | `#B01A18` | `#E0403D` | iOS `accentActive` |
| └ deep(漸層深端) | `#B01A18` | `#C42E26` | iOS `accentDeep` |
| `overall-blue` | `#049CD8` | `#2AA8E0` | console `--overall-blue(-300)` / iOS info |
| `star-yellow` | `#FBD000` | `#FFD426` | console `--star-yellow(-300)` / iOS amber |
| `white` | `#FFFFFF` | —(dark 無白面) | 卡片 / agent 泡 / onAccent |
| `ink` | `#17171A` | 前景轉 `#F2F2F5` | 文字 / 邊框基底 |

### 2.2 奶油底階(pocket 主題的 canvas 家族)

| 層 | light | dark | 出處 |
|---|---|---|---|
| canvas(頁底) | `#FFF2D6` | `#131317` | 雙端一致 |
| surface(卡片) | `#FFFFFF` | `#1E1E25` | 雙端一致 |
| surface-sunken(側欄/代碼框,比底深一階) | `#F7EACB`(web) | `#0E0E12`(web) | console;iOS 托盤見 §9 衝突 #7 |
| tray / backgroundTertiary | `#E9E6DF`(iOS) | `#2A2A33`(iOS) | iOS;角色對位待裁(§9 #7) |
| accentSurface(user 泡/選取底) | `#FBDFD6` | `#4A2B2C` | console(ink 字 14.16:1 實測) |
| 漸層 soft(空狀態/onboarding) | `#FFD9D4 → #FFB3AC` | `#3A2320 → #4A1E1C` | iOS `gradientSoftStops` |
| 漸層 brand(icon/hero) | `#FBD000 → #EE2D2A → #B01A18` | `#FFD426 → #FF4D4A → #C42E26` | iOS `gradientStops` |

### 2.3 White 主題(中性純白,無暖調)

canvas `#F5F5F7` / surface `#FFFFFF` / sunken `#E9E9EC` /
muted `#68686D`(web)·`#6B6B70`(iOS) / faint `#84848D`(web)·`#B0B0B5`(iOS) /
accentSurface `#FBDFDE`(web)。accent 與狀態色同 pocket。

### 2.4 輔助色(選物店層,非主識別)

espresso `#2A1D18`、kraft `#BE9663`、silver `#C6CACC`(多為實物材質,UI 少用)、
Luigi green `#43B14A`(第六色,slogan/角色點綴,不進主識別)。
Persona 四色盤:`#DD3126` / `#2E9E43` / `#C98A12` / `#DE5C95`;
工具品牌:CC `≈#D47345`、Codex `≈#338C80`、OpenClaw `#C41E30`、Gemini `#4285F4`。

### 2.5 L2 語意對照表(role 名 = PocketThemeSpec 53-role)

核心子集(pocket 主題正式值;完整 53-role 枚舉見 `docs/THEME_SPEC.md`,
自訂主題由 3 值生成器導出,內建三主題用下表定值):

| PocketThemeSpec role | SDS token 對位 | console var | iOS `PocketColor` | pocket light | dark |
|---|---|---|---|---|---|
| `canvas` | surface/canvas | `--color-canvas` | `backgroundPrimary` | `#FFF2D6` | `#131317` |
| `surface` | surface-raised | `--color-surface` | `backgroundSecondary` | `#FFFFFF` | `#1E1E25` |
| (sunken,53-role 外) | surface-sunken | `--color-surface-sunken` | `backgroundTertiary`* | `#F7EACB`* | `#0E0E12`* |
| `text` | text | `--color-text` | `foregroundPrimary` | `#17171A` | `#F2F2F5` |
| `textMuted` | text-muted | `--color-text-muted` | `foregroundMuted` | `#6B6760`* | `#9A9AA2` |
| `placeholder` / `iconMuted` | text-faint | `--color-text-faint` | `foregroundFaint` | `#8A847A`* | `#70707A`* |
| (disabled,v0.3 新) | text-disabled | `--color-text-disabled` | — | `#A89F93` | — |
| `border` | border | `--color-border` | `border(Strong)` | ink @ `.14`* | white @ `.12` |
| `accent` | theme-600/300 | `--color-accent` | `accent` | `#EE2D2A` | `#FF4D4A` |
| `accentForeground` | on-theme | `--color-accent-foreground` | `onAccent` | `#FFFFFF` | `#FFFFFF` |
| `accentSurface` | theme-surface | `--color-accent-surface` | `accentTint`≈ | `#FBDFD6` | `#4A2B2C` |
| `focus` | focus | `:focus-visible` outline | `accent` | = accent | = accent |
| (link) | action-link | `--color-link` / `--color-action-link` | `info` | `#049CD8` / 內文 `#C42320` | `#2AA8E0` |
| `error` 族 | danger | `--color-danger` | `danger` | `#b42318`* | `#f59a90`* |
| `warning` 族 | warning | `--color-warning` | `warning` | `oklch(48% .1 85)`* | `oklch(82% .14 85)`* |
| `update` 族 | info | `--color-info` | `info` | `#1f6aa1`* | `#7cc0ec`* |
| (success,SDS 有 / 53-role 無) | success | `--color-success` | `success` | `#1d7a4a`* | `#6fd39d`* |
| `messageSurface` | — 品牌層 | `.card.user` 底 | user 泡底 | §9 衝突 #3 | — |
| `codeBackground` | surface-sunken | `.md-code` 底 | `Terminal.bg` | `#15151b`(web 固定深) | 同 |

`*` = 兩端現值不一致,表中列 web/SDS 值,iOS 現值與裁決見 §9 衝突表。
53-role 其餘(toolbar 族、search 族、terminal 族、secondary/muted 族)目前只有
生成器路徑消費,值由 `PocketThemeGenerator.generate` 從種子
(`canvas #FFF2D6` + `accent #EE2D2A`)導出,不另定死值。
