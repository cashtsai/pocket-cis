> 本章拆自 Pocket 設計規範 v1.0(正典:app repo `docs/POCKET_DESIGN_SPEC.md`,追版規則見規範 §10);全章索引與定位宣言出處見 [cis/README.md](README.md)。

## 4. 字體

### 4.1 三端字族對應

| 軌 | iOS/macOS | Android | web(SDS) |
|---|---|---|---|
| display(標題/chrome,品牌 voice) | jf open 粉圓 `jf-openhuninn-2.1`(OFL 1.1,bundled) | 同字檔(OFL 可隨附) | Inter + Noto Sans TC;console 現行用系統堆疊 `-apple-system … "PingFang TC","Microsoft JhengHei"`(粉圓 web 載入待品牌層補 woff2) |
| body(正文/閱讀) | 系統字(SF / PingFang) | Roboto / Noto Sans TC | 同上系統堆疊 |
| terminal(CC/CX 對話) | 粉圓(= display;nil 時退 body) | 同 | 同 body |
| mono(代碼/ID/路徑) | 系統 mono(SF Mono) | 系統 mono | `ui-monospace,SFMono-Regular,Menlo,monospace` |
| wordmark(品牌時刻限定) | Luckiest Guy(無 CJK,只給英文標) | 同 | 同(需自帶字檔) |

**Locale 規則**(三語定案):粉圓服務 zh-Hant 與全部拉丁語系;zh-Hans / ja 的 UI
整軌落系統字(粉圓部分覆蓋會拼貼);完全不覆蓋的文種(韓/泰/阿拉伯…)自然
cascade 到系統字。

### 4.2 字階四檔(SDS)與 iOS HIG 階對位

| SDS 檔 | web(px/行高) | iOS 對位(`PocketFont`) | 用途 |
|---|---|---|---|
| caption | 13 / 1.6 | `footnote` 13(次階 `caption` 12、`caption2` 10) | 時間戳、meta、狀態膠囊 |
| body | 16 / **1.75** | `subhead` 16(UI 慣用 `body` 14,見 §9 #10) | 正文、聊天、輸入框 |
| subtitle | 18 / 1.35 | `headline` 17 ≈ | 區段標題 |
| title | 20 / 1.3 | `title3` 20 | 頁標題 |

**CJK 行高鐵則:正文行高 ≥ 1.7**(caption 檔 1.6 為非正文豁免);標題行高 ≥ 1.2。
iOS 大階(largeTitle 34 / title1 28 / title2 22)為平台 HIG 延伸,不入 SDS 四檔。
