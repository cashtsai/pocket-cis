> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 9. 衝突表(兩端現值分岔,待老闆裁)

規則:本規範不擅自挑。下表每行一個分岔,附實測對比與建議方向,**以裁決為準**。

| # | 項 | iOS 現值 | web console / SDS 現值 | 備註 |
|---|---|---|---|---|
| 1 | 狀態色(light) | success `#2AA876`(2.72:1✕)/ danger `#C62828` / warning `#F0AD4E` / info `#049CD8`(2.80:1✕) | `#1d7a4a`(4.81:1)/ `#b42318` / `oklch(48% .1 85)` / `#1f6aa1`(5.21:1) | SDS 規定狀態色固定;iOS 值在奶油底當文字不過 AA。**規範採 SDS 值**,iOS 待遷;iOS 的 info=品牌藍身兼兩職,web 已拆 link(品牌藍)/info(SDS) |
| 2 | 泡泡圓角 | `PocketRadius.bubble = 20` | `.card` = 14(+ 本次拍板 14) | 規範寫 14;iOS 20 待遷或裁「平台自有」 |
| 3 | user 泡填色 | 實心 accent 紅 + 白字(大面積 accent) | `accentSurface #FBDFD6` + ink 字(14.16:1)+ accent @28% 邊 | SDS accent 紀律禁大面積;web 做法合規。裁:iOS 跟進或豁免 |
| 4 | textMuted(light) | `#6E6A64`(4.84:1) | `#6B6760`(5.07:1) | 都 ≥4.5,差異小;挑一個 |
| 5 | faint(light) | `#B3AEA4`(**1.99:1**,<3 不合格) | `#8A847A`(3.34:1) | 建議採 web 值;iOS 現值在奶油底實質不可見 |
| 6 | faint(dark) | `#63636B`(3.11:1) | `#70707A`(3.78:1) | 都 ≥3;挑一個 |
| 7 | 第三面角色 | `backgroundTertiary #E9E6DF`(淺托盤) | `--color-surface-sunken #F7EACB`(暖紙深一階) | 不只值不同,語意也沒對上;需定義 sunken/tray 是一個 role 還是兩個 |
| 8 | 邊線 alpha | ink @ 0.10(strong 0.16) | ink @ 0.14 | 挑一檔或定兩檔(quiet/strong) |
| 9 | 動效參數 | fast .12 / base .20 / slow .30;spring 註解引 `cubic-bezier(0.32,.72,0,1)` | `cubic-bezier(.2,0,0,1)`;.2 / .25 | SDS 曲線為準;iOS spring 近似可接受,註解的舊曲線要改 |
| 10 | body 字級 | `PocketFont.body` = 14(HIG 慣例) | body 16/1.75 | 可能屬平台慣例(iOS 聊天正文實用 16 系 subhead);裁:iOS body 檔是否升 16 |
| 11 | 陰影值 | `PocketShadow` sm(y1 b2 .05)… xl(y16 b40 .14) | SDS 四級(§5.3,oklch 暖灰基底) | 平台近似值;裁是否逐值對齊 |
| 12 | toast | 無共用元件;就地黑膠囊(black @.78 + 白 caption) | danger 底、radius 20、影級 3 | 建議 iOS 補共用元件照 §6.8 |
| 13 | white 主題中性灰 | muted `#6B6B70` / faint `#B0B0B5` | muted `#68686D`(5.09:1)/ faint `#84848D`(3.40:1) | 同 #4/#5;iOS faint 同樣偏淡 |
| 14 | accentSurface(white 主題) | —(iOS 用 `accentTint` α 疊色) | `#FBDFDE`(pocket 主題為 `#FBDFD6`) | 末碼 D6/DE 是否刻意分流,待確認 |

---

## §9 裁決紀錄(2026-11-13,機主拍板「對齊」)
iOS 已向規範靠齊:#1-10/#12-14 共 13 條已落地(refactor/ios-spec-align,9 commits)。
唯 #11 陰影逐值對齊留裁 —— iOS PocketShadow 維持「平台近似、級別對位」,
要不要逐值換 oklch 暖灰基底待機主裁。品牌藍 #049CD8 保留於 PocketBrand.blue
(識別/連結),僅「狀態 info」語意改 SDS 固定值。
