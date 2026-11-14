# Pocket —— 品牌敘事(CIS 一頁)

> 你口袋裡的 AI agent。直接、可靠、隨叫隨到;**紅是訊號不是地毯。**
> Your AI agent, in your pocket — direct, dependable, always on call.

## 五色故事(CIS v2,2026-07-05 定調)

Pocket 的五色接近瑪利歐配色 —— 玩具感、高辨識、一眼記得住,但用法有紀律:

| 色 | 值 | 角色 |
|---|---|---|
| **Pocket Red** | `#EE2D2A` | 主訊號。主按鈕、選取指示、focus ring、連結強調 —— 只做訊號,禁大面積(「紅是訊號不是地毯」) |
| **Overall Blue** 吊帶褲藍 | `#049CD8` | 第二識別色。連結、識別點綴、丹寧材質面 |
| **White** | `#FFFFFF` | 面。卡片、agent 泡、accent 上的字;governed 品牌頁以白為底 |
| **Star Yellow** 星星黃 | `#FBD000` | 點綴。徽章、高亮 —— 節制使用,不搶紅 |
| **Ink** 墨 | `#17171A` | 字與邊。只做文字與邊框,不做大面積填色 |

五色之外,**奶油底 `#FFF2D6`** 是對話畫布的暖紙感 —— 品牌拍板保留,
Pocket 主題的 canvas 種子;選物店層的輔助色(espresso `#2A1D18`、
kraft `#BE9663`、silver `#C6CACC`)多為實物材質,UI 少用;
Luigi green `#43B14A` 是第六色,slogan 與角色點綴,不進主識別。

## 吉祥物:口袋

App icon = **牛仔口袋擬物** —— 紅內裡 + 白襯線 + 丹寧 + 金黃車線
(generated,never hand-edit)。口袋就是產品隱喻:agent 裝在口袋裡,
伸手就拿得到。

陪口袋出場的是**四隻 chibi persona 頭像**,各佔四色盤一色:
紅 `#DD3126` / 綠 `#2E9E43` / 金 `#C98A12` / 粉 `#DE5C95`
(`PocketColor.Persona`)。工具品牌色(CC ≈`#D47345`、Codex ≈`#338C80`、
OpenClaw `#C41E30`、Gemini `#4285F4`)只在標示工具來源時出現。

## Voice

- **字的聲音**:display 與聊天用 **jf open 粉圓**(OFL 1.1)—— 圓潤、
  親切、像玩具又不幼稚;正文回系統字,閱讀舒適優先。
  Wordmark 用 **Luckiest Guy**(全大寫美式卡通海報字,無 CJK)——
  只在品牌時刻出場,不進 UI 正文。
- **形的聲音**:膠囊鈕、泡泡圓角 14、發話側缺角 6、細邊 1px @ ink 14%、
  柔影、自然大小寫 —— `editorial` 性格:軟、安靜、有彈性。
- **話的聲音**:直接、可靠、不囉嗦。狀態用「沒有壞消息就安靜」表達
  (閒置不畫點、弱資訊吃 1.5s 門檻);緊急態直亮不猶豫。

## Theme 與 CIS 的分工

- **Theme**(可換皮):產品皮膚。使用者可選 pocket / white / dark,
  或用 3 值生成器自訂 —— 值見 [`tokens/`](../tokens)。
- **CIS**(鎖定):品牌代表性的 system 頁(關於頁、onboarding 品牌頁、
  splash)不跟使用者主題走,鎖這份識別:Pocket Red as signal on white、
  ink 字、圓角 14、自然大小寫、粉圓 display。

正文規範(色階、字階、元件、禁例)見本目錄各章;一切值以
[01-positioning.md](01-positioning.md) 起的拆章規範為準,本頁只講故事。
