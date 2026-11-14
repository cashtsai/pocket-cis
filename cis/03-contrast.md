> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 3. 對比度(實測,WCAG)

| 配對 | 比值 | 判定 |
|---|---|---|
| ink `#17171A` / cream `#FFF2D6` | 16.12:1 | AAA |
| ink / accentSurface `#FBDFD6` | 14.16:1 | AAA |
| muted `#6B6760` / cream | 5.07:1 | ≥4.5 ✓ |
| faint `#8A847A` / cream | 3.34:1 | ≥3 ✓(非正文) |
| white / Pocket Red `#EE2D2A` | 4.16:1 | **大字 AA(≥3)**:accent 上白字僅限 semibold 短標籤(按鈕/徽章),不作長文 |
| action-link `#C42320` / cream | 5.24:1 | 內文連結用這個,不用裸 accent(3.75:1) |
| dark text `#F2F2F5` / `#131317` | 16.59:1 | AAA |
| dark accent `#FF4D4A` / `#131317` | 5.66:1 | ✓(300 提亮的理由) |
