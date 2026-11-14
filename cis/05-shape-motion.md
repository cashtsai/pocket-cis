> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 5. 形狀

### 5.1 圓角

| 檔 | 值 | 用在 | token |
|---|---|---|---|
| btn(SDS 簽名) | `9999` 膠囊 | 送出/繼續/中斷/mode 鈕/徽章/狀態膠囊 | `--btn-radius` / `PocketRadius.pill` |
| field | `10` | 輸入框、列表列、chip、代碼框、圖片 | `--field-radius` |
| dialog | `20` | 彈窗、⌘K 面板、toast、抽屜 | `--dialog-radius` |
| **泡泡(Pocket 自有語彙)** | `14` | 聊天泡、審批卡、卡片家族 | web `.card`/`.approval`;iOS 現值 20,見 §9 #2 |
| 文字級小裝飾 | 3–6 | inline code、mark、小標籤 | 不入檔 |

user 泡發話側缺角 6(web `border-bottom-right-radius:6px`),agent 泡對側同款
—— 泡泡的方向性語彙。

### 5.2 Editorial 性格(`PocketThemeStyle.editorial`)

pill 控件、卡片圓角 14、邊線 1px @ ink 10% alpha(強調 16%;web 14%,§9 #8)、
柔影、自然大小寫。對照組 utility(方盒 4 / 硬印章影 / 全大寫)保留給下游 fork,
Pocket 本體一律 editorial。

### 5.3 陰影四級(SDS;奶油底用暖灰基底)

| 級 | light(暖灰 `oklch(25% .04 55/α)`) | dark(純黑,層級靠「表面越高越亮」) | 用在 |
|---|---|---|---|
| 1 | `0 2px 6px /.12, 0 1px 2px /.08` | `0 1px 2px /.35, 0 1px 6px /.28` | 卡片、泡泡 |
| 2 | `0 8px 24px /.17, …` | `0 2px 8px /.45, 0 14px 40px /.55` | 浮層、選單 |
| 3 | `0 16px 48px /.23, …` | `0 16px 48px /.55, …` | toast、抽屜 |
| 4 | `0 28px 80px /.3, …` | `0 28px 80px /.6, …` | 對話框 + 遮罩 |

iOS `PocketShadow` sm/md/lg/xl 與此四級對位(值為平台近似,見 §9 #11)。

### 5.4 動效

SDS:`--ease-standard: cubic-bezier(.2,0,0,1)`;`--duration-base .2s` /
`--duration-slow .25s`。iOS 以 spring(response .35, damping .85)近似 +
fast .12 / base .20 / slow .30(§9 #9)。`prefers-reduced-motion: reduce`
必須停掉 shimmer、spinner、脈動點等循環動畫。
