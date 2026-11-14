> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 7. 禁例

| ✕ 禁 | ✓ 正解 |
|---|---|
| **accent 大面積**(整版紅底、紅色卡片海)——「紅是訊號不是地毯」 | accent 只用於:主按鈕、選取指示、focus ring、連結強調;選取底用 accentSurface 淡紅 |
| **品牌覆寫狀態色**(把 success 調成品牌綠、danger 調成品牌紅) | 狀態色吃 SDS 固定值;品牌紅與 danger 必須肉眼可辨(deny ≠ accent) |
| **正文行高 < 1.7**(CJK 擠行) | body 16/1.75;只有 caption 檔可 1.6 |
| **無 focus ring / 自己發明 focus 樣式** | 統一 2px accent outline + 2px offset;文字框用 accent 邊 + 3px 光暈 |
| accent 上白字作長文(4.16:1 不夠 AA 正文) | accent 上白字限 semibold 短標籤;內文連結用 action-link `#C42320` |
| 黑(ink)大面積填色 | ink 只做文字與邊框 |
| 黃搶紅(Star Yellow 大面積) | 黃=徽章/高亮點綴,節制使用 |
| phase 色各自配(同一狀態三處三個色) | 一律查 `PocketPhaseStyle` 表 |
| 固定頻率動畫不設門檻(短操作閃 bar、卡頓病原) | delayed-status 1.5s/0.3s;reduced-motion 全關 |
