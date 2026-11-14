> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 8. 落地對照(三端 token 名)

| 語意 | iOS(`PocketColor` / `PocketTheme`) | Android(THEME_SPEC JSON role) | web(console css L2) |
|---|---|---|---|
| 頁底 | `backgroundPrimary` | `canvas` | `--color-canvas` |
| 卡片 | `backgroundSecondary` | `surface` | `--color-surface` |
| 第三面 | `backgroundTertiary` | `surfaceRaised`† | `--color-surface-sunken`† |
| 正文 | `foregroundPrimary` | `text` | `--color-text` |
| 次文 | `foregroundMuted` | `textMuted` | `--color-text-muted` |
| 淡文 | `foregroundFaint` | `placeholder` | `--color-text-faint` |
| 邊線 | `border` / `borderStrong` / `cardBorder` | `border` | `--color-border` |
| 強調 | `accent`(+`Hover/Active/Tint`) | `accent` | `--color-accent` |
| 強調上字 | `onAccent` | `accentForeground` | `--color-accent-foreground` |
| 選取底 | `accentTint`(α)≈ | `accentSurface` | `--color-accent-surface` |
| 成功 | `success` | —(spec 無 success,平台自持)| `--color-success` |
| 危險 | `danger` | `error` | `--color-danger` |
| 警告 | `warning` | `warning` | `--color-warning` |
| 資訊 | `info` | `update` | `--color-info` / `--color-link` |
| 圓角 | `PocketRadius.*`(pill 999/bubble) | —(照本文件 §5) | `--btn/field/dialog-radius` |
| 間距 | `PocketSpace.s1–s10`(4…40) | 同階 | 4/8/12/16/20/24/32/40 |
| 影 | `PocketShadow.sm–xl` | 同四級 | `--shadow-1…4` |
| 動效 | `PocketDuration` + `PocketAnimation` | 同 | `--ease-standard` + `--duration-*` |
| 字 | `PocketFont.display/text/terminalText/mono` | 同三軌 | `--sans` / `--mono` |

† 第三面的角色兩端語意未合一(iOS=淺托盤、web=sunken 深一階),見 §9 #7。

跨端換膚管線:`PocketThemeSpec`(JSON,53-role)為單一真相 —— iOS
`PocketTheme.init(spec:)` 消費子集;Android 照 `docs/THEME_SPEC.md` 全量;
web 生成器未來把同一份 JSON 吐成 `--color-*`(console css L2 命名已對位)。
