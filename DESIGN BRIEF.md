<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# DESIGN BRIEF - Web App CRM Yến Sào Vĩnh Hưng

**Phiên bản:** 1.0
**Ngày:** 16 tháng 5 năm 2026
**Phong cách:** Minimal Glassmorphism
**Industry:** Thương mại và Bán lẻ yến sào cao cấp

***

## 1. COLOR PALETTE

### 1.1 Màu Chủ Đạo (Inspired by Bird's Nest)

**Màu Accent Chính (Primary):**

- **Golden Nest Yellow** (Vàng Yến Sào): `#D4A574`
    - Sử dụng cho: Primary buttons, active state, important highlights, charts
    - Psychological: Sang trọng, ấm áp, cao cấp, dinh dưỡng

**Màu Neutral (Trung Tính):**


| Tên | HEX | RGB | Sử dụng |
| :-- | :-- | :-- | :-- |
| Фон Sáng (Light Background) | `#FAFAF9` | 250,250,249 | Background toàn app |
| bề mặt trắng (White Surface) | `#FFFFFF` | 255,255,255 | Cards, modals, sidebar |
| Bề mặt Kính Mờ (Glass Surface) | `#FFFFFF` + 85% opacity | - | Glassmorphism cards |
| Text Chính (Primary Text) | `#2C2925` | 44,41,37 | Headings, body text |
| Text Phụ (Secondary Text) | `#6B6458` | 107,100,88 | Labels, descriptions |
| Text Tiềm Ẩn (Muted Text) | `#A8A095` | 168,160,149 | Placeholder, disabled |
| Border Nhẹ (Light Border) | `#E8E4DF` | 232,228,223 | Dividers, input borders |
| Shadow Soft (Soft Shadow) | `#2C2925` + 8% opacity | - | Card shadows |

**Màu Trạng Thái (Status Colors):**


| Trạng thái | HEX | Sử dụng |
| :-- | :-- | :-- |
| Success (Xanh thành công) | `#5A8F5A` | Paid, Completed |
| Warning (Vàng cảnh báo) | `#D4A574` | Pending, Review |
| Error (Đỏ lỗi) | `#C95A5A` | Overdue, Cancelled |
| Info (Xanh dương thông tin) | `#5A7D9A` | New leads, In progress |

**Màu Phân Khúc Khách (Customer Segments):**


| Phân khúc | HEX | Badge style |
| :-- | :-- | :-- |
| Khách lẻ | `#E8F4F8` (xanh nhạt) + text `#5A7D9A` | Light background, thin border |
| Đại lý | `#FFF8E8` (kem nhạt) + text `#D4A574` | Light background, thin border |
| VIP | `#FFF5F5` (hồng nhạt) + text `#C95A5A` | Light background, thin border |

### 1.2 Gradient (Glassmorphism Effect)

**Glass Card Gradient:**

```
Linear gradient: 135deg
- Start: rgba(255, 255, 255, 0.95)
- End: rgba(255, 255, 255, 0.85)
```

**Backdrop Blur:** `10px`

**Border Glass:** `1px solid rgba(255, 255, 255, 0.6)`

**Shadow Glass:** `0 8px 32px rgba(44, 41, 37, 0.08)`

### 1.3 Color Usage Guidelines

**Primary Color (\#D4A574):**

- Chỉ dùng 1 màu accent chính
- Primary buttons (filled)
- Active navigation item
- Link hover color
- Chart primary color
- Price/value highlights

**Không lạm dụng màu:**

- Không dùng quá 3 màu trong 1 màn hình
- Ưu tiên neutral tones (trắng, xám ấm)
- Màu chỉ dùng để highlight thông tin quan trọng

***

## 2. TYPOGRAPHY

### 2.1 Font Family

**Font Chính:** **Inter** (Google Fonts)

- Lý do: Th discontinuity, hiện đại, dễ đọc, font mỏng sang trọng
- weights sử dụng: 300 (Light), 400 (Regular), 500 (Medium), 600 (SemiBold)

**Font Fallback:** `system-ui, -apple-system, sans-serif`

### 2.2 Type Scale

**Headings:**


| Element | Size | Weight | Line Height | Color |
| :-- | :-- | :-- | :-- | :-- |
| H1 (Page Title) | 32px | 300 (Light) | 1.2 | `#2C2925` |
| H2 (Section Title) | 24px | 300 (Light) | 1.3 | `#2C2925` |
| H3 (Card Title) | 20px | 400 (Regular) | 1.4 | `#2C2925` |
| H4 (Component Title) | 16px | 500 (Medium) | 1.4 | `#2C2925` |

**Body Text:**


| Element | Size | Weight | Line Height | Color |
| :-- | :-- | :-- | :-- | :-- |
| Body Large | 18px | 300 (Light) | 1.6 | `#2C2925` |
| Body Regular | 16px | 300 (Light) | 1.6 | `#2C2925` |
| Body Small | 14px | 400 (Regular) | 1.5 | `#6B6458` |
| Caption | 12px | 400 (Regular) | 1.4 | `#A8A095` |

**Special Text:**


| Element | Size | Weight | Color | Usage |
| :-- | :-- | :-- | :-- | :-- |
| KPI Number | 36px | 300 (Light) | `#2C2925` | Dashboard cards |
| KPI Label | 14px | 400 (Regular) | `#6B6458` | Dashboard labels |
| Price/VND | 20px | 300 (Light) | `#D4A574` | Opportunity values |
| Button Text | 16px | 500 (Medium) | White/`#2C2925` | Buttons |

### 2.3 Letter Spacing

**Headings:** `-0.5px` (tighter, elegance)
**Body:** `0px` (normal)
**Buttons:** `0.5px` (slightly wider, readable)
**Uppercase:** `1px` (labels, badges)

### 2.4 Font Examples

```css
/* H1 Page Title */
font-family: 'Inter', sans-serif;
font-size: 32px;
font-weight: 300;
line-height: 1.2;
letter-spacing: -0.5px;
color: #2C2925;

/* KPI Number */
font-family: 'Inter', sans-serif;
font-size: 36px;
font-weight: 300;
line-height: 1.1;
letter-spacing: -0.5px;
color: #2C2925;

/* Primary Button */
font-family: 'Inter', sans-serif;
font-size: 16px;
font-weight: 500;
line-height: 1.4;
letter-spacing: 0.5px;
color: #FFFFFF;
```


***

## 3. LAYOUT STRUCTURE

### 3.1 Global Layout

**Grid System:**

- Container maxWidth: `1440px`
- Grid columns: 12 columns
- Gutter: `24px`
- Margin: `40px` (desktop), `20px` (mobile)

**Layout Structure:**

```
┌─────────────────────────────────────────┐
│              HEADER (64px)              │ ← Logo + User + Logout
├──────────┬──────────────────────────────┤
│          │                              │
│  SIDEBAR │        MAIN CONTENT          │
│  (240px) │     (Fluid, max 1200px)      │
│          │                              │
└──────────┴──────────────────────────────┘
```


### 3.2 Header Style

**Height:** `64px`
**Background:** `#FFFFFF` với glass effect
**Border Bottom:** `1px solid #E8E4DF`

**Content:**

```
┌────────────────────────────────────────────────────┐
│  [Logo]                [Search]  [Notification] 👤 │
│  Yến Sào Vĩnh Hưng                     (avatar)    │
└────────────────────────────────────────────────────┘
```

**Logo:**

- Text: "Yến Sào Vĩnh Hưng"
- Font: 18px, 500 (Medium)
- Color: `#2C2925`
- Icon: Chim yến cách điệu (optional), color `#D4A574`

**User Avatar:**

- Size: `36px` circular
- Border: `2px solid #D4A574`
- Ring: Glass effect


### 3.3 Sidebar Style

**Width:** `240px` (fixed), collapsible mobile
**Background:** `#FFFFFF` với glass effect
**Border Right:** `1px solid #E8E4DF`

**Structure:**

```
┌─────────────────────┐
│  🏠 Tổng quan       │ ← Active: bg #FFF8E8, left border #D4A574
│  📊 Cơ hội          │
│  ✅ Công việc       │
│  👥 Danh sách       │
│  💳 Thanh toán      │
│  ⚙️  Cài đặt        │
│                     │
│  ─────────────────  │ ← Divider
│  📖 Documentation   │
│  💬 Support         │
└─────────────────────┘
```

**Sidebar Item:**

- Height: `48px`
- Padding: `12px 20px`
- Font: 14px, 400 (Regular)
- Color: `#6B6458`
- Icon: 20px, margin-right `12px`
- Hover: Background `#FAFAF9`, color `#2C2925`
- Active: Background `#FFF8E8`, color `#D4A574`, left border `3px solid #D4A574`


### 3.4 Page: Tổng Quan (Dashboard)

**Page Title:**

```
┌─────────────────────────────────────────────────┐
│  Tổng quan                            16/05/2026│
│  (H1, 32px Light)                    (Caption)  │
└─────────────────────────────────────────────────┘
```

**KPI Cards Grid (2x2):**

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│  📊 Tổng lead│  🎯 Cơ hội   │  💰 Doanh thu│  📈 Chuyển   │
│              │  mới         │  tháng       │  đổi         │
│     45       │     12       │  850 triệu   │    18%       │
│  (36px Light)│  (36px Light)│ (36px Light) │ (36px Light) │
│              │              │              │              │
│ khách mới    │ cơ hội       │  ✓ +15%      │ ✓ +3%        │
│ tháng này    │ tuần này     │  vs tháng trước│ vs tháng trước│
└──────────────┴──────────────┴──────────────┴──────────────┘
```

**Card Style:**

- Background: Glass white `rgba(255,255,255,0.95)`
- Border: `1px solid rgba(255,255,255,0.6)`
- Border Radius: `16px`
- Padding: `24px`
- Shadow: `0 8px 32px rgba(44,41,37,0.08)`
- Backdrop blur: `10px`

**Charts Section:**

```
┌──────────────────────────┬──────────────────────────┐
│  Doanh thu theo nhân viên│  Lead theo ngày (30)     │
│  (Bar Chart)             │  (Line Chart)            │
│                          │                          │
│  [Chart 600x300px]       │  [Chart 600x300px]       │
│                          │                          │
│  Top 10 sales            │  30 ngày qua             │
└──────────────────────────┴──────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  Phân khúc khách hàng                               │
│  (Pie Chart 400x300px centered)                     │
│                                                     │
│        [Pie Chart]  Khách lẻ 40%                    │
│                     Đại lý 35%                      │
│                     VIP 25%                         │
└─────────────────────────────────────────────────────┘
```

**Widget Section:**

```
┌──────────────────────┬──────────────────────┐
│  🔥 Lead hot         │  ⚠️  Công việc trễ   │
│  (Deadline 3 ngày)   │  (Overdue)           │
│                      │                      │
│  1. Nguyễn Văn A     │  1. Gọi khách B      │
│     50 triệu • 2 ngày│     Quá hạn 2 ngày   │
│  2. Trần Thị B       │  2. Gửi báo giá C    │
│     25 triệu • 1 ngày│     Quá hạn 1 ngày   │
│  3. Lê Văn C         │  3. ...              │
│     100 triệu • 3 ngày│                      │
└──────────────────────┴──────────────────────┘
```


### 3.5 Page: Cơ Hội Bán Hàng (Kanban)

**Page Header:**

```
┌─────────────────────────────────────────────────────┐
│  Cơ hội bán hàng                    [+ Thêm cơ hội] │
│  (H1, 32px)                                      (Button)│
│                                                      │
│  [Search] [Filter: Nhân▼] [Filter: Phân khúc▼]      │
└─────────────────────────────────────────────────────┘
```

**Kanban Board:**

```
┌──────────┬──────────┬──────────┬──────────┐
│  MỚI     │ LIÊN HỆ  │ ĐỀ XUẤT  │ CHỐT ĐƠN │
│  (12)    │  (8)     │  (5)     │  (3)     │
│          │          │          │          │
│  ┌────┐  │  ┌────┐  │  ┌────┐  │  ┌────┐  │
│  │A   │  │  │B   │  │  │C   │  │  │D   │  │
│  │50M │  │  │25M │  │  │100M│  │  │75M │  │
│  │VIP │  │  │Đại │  │  │VIP │  │  │Đại │  │
│  │2 ngày│ │  │3 ngày│ │  │5 ngày│ │  │✅  │  │
│  └────┘  │  └────┘  │  └────┘  │  └────┘  │
│  ┌────┐  │  ┌────┐  │          │          │
│  │E   │  │  │F   │  │          │          │
│  │15M │  │  │30M │  │          │          │
│  │Lẻ  │  │  │Lẻ  │  │          │          │
│  │4 ngày│ │  │2 ngày│ │          │          │
│  └────┘  │  └────┘  │          │          │
│  ...     │  ...     │          │          │
└──────────┴──────────┴──────────┴──────────┘
```

**Kanban Column:**

- Background: `#FAFAF9` (light warm gray)
- Border Radius: `12px`
- Padding: `16px`
- Width: `280px` (fixed), scrollable
- Header: `14px Medium`, color `#6B6458`, count badge

**Kanban Card:**

- Background: Glass white
- Border Radius: `12px`
- Padding: `16px`
- Margin Bottom: `12px`
- Shadow: `0 4px 16px rgba(44,41,37,0.06)`
- Border: `1px solid rgba(255,255,255,0.8)`
- Hover: Shadow `0 8px 24px rgba(44,41,37,0.12)`, lift `2px`
- Dragging: Shadow `0 12px 32px rgba(44,41,37,0.16)`, scale `1.02`

**Card Content:**

```
┌─────────────────────────┐
│ Nguyễn Văn A            │ ← Title 16px Medium, `#2C2925`
│                         │
│ 💰 50,000,000 ₫         │ ← Price 20px Light, `#D4A574`
│                         │
│ 📅 Còn 2 ngày           │ ← Deadline 14px Regular, `#C95A5A` (nếu <3 ngày)
│                         │
│ [VIP] [Yến chưng]       │ ← Badges
│                         │
│ 👤 Sarah N.             │ ← Owner 12px Regular, `#6B6458`
└─────────────────────────┘
```


### 3.6 Page: Công Việc (Task)

**Page Header:**

```
┌─────────────────────────────────────────────────────┐
│  Công việc                          [+ Thêm công việc]│
│  (H1, 32px)                                      (Button)│
│                                                      │
│  [Hôm nay] [Tuần này] [Trễ hạn] [Tất cả]            │ ← Filter tabs
└─────────────────────────────────────────────────────┘
```

**Task List:**

```
┌─────────────────────────────────────────────────────┐
│ [ ] Gọi điện tư vấn khách A       Hôm nay 16:00  🔴 │
│   ↳ Cơ hội: Nguyễn Văn A - 50 triệu                 │
│                                                     │
│ [✓] Gửi báo giá cho khách B       Hoàn thành   ✅  │
│   ↳ Cơ hội: Trần Thị B - 25 triệu                   │
│                                                     │
│ [ ] meeting đại lý C              Ngày mai 10h  🟡 │
│   ↳ Cơ hội: Công ty ABC - 100 triệu                 │
│                                                     │
│ [ ] Follow-up khách D             Quá hạn 2 ngày 🔴│
│   ↳ Cơ hội: Lê Văn D - 15 triệu                     │
└─────────────────────────────────────────────────────┘
```

**Task Row:**

- Background: Glass white
- Border Radius: `12px`
- Padding: `16px`
- Margin Bottom: `12px`
- Border: `1px solid rgba(255,255,255,0.8)`
- Checkbox: `20px`, color `#D4A574` khi checked
- Priority dot: 🟥 đỏ (cao), 🟡 vàng (trung bình), 🟢 xanh (thấp)


### 3.7 Page: Danh Sách Khách Hàng

**Page Header:**

```
┌─────────────────────────────────────────────────────┐
│  Danh sách khách hàng              [+ Thêm khách] [Upload CSV] [Export CSV]│
│  (H1, 32px)                                    (Buttons)│
│                                                      │
│  [Search khách...] [Phân khúc▼] [Sản phẩm▼] [Owner▼]│
└─────────────────────────────────────────────────────┘
```

**Table:**

```
┌────┬──────────────┬─────────────┬──────────┬──────────┬────────┬──────┬──────┐
│ ☐  │ Tên          │ SĐT         │ Phân khúc│ Sản phẩm │ Owner  │ Ngày │ ≠ ×  │
├────┼──────────────┼─────────────┼──────────┼──────────┼────────┼──────┼──────┤
│ ☐  │ Nguyễn Văn A │ 0901234567  │ [VIP]    │ Yến chưng│ Sarah  │ 15/05│ ✏️ × │
│    │              │ a@email.com │          │          │        │      │      │
├────┼──────────────┼─────────────┼──────────┼──────────┼────────┼──────┼──────┤
│ ☐  │ Trần Thị B   │ 0902345678  │ [Đại lý] │ Yến thô  │ John   │ 14/05│ ✏️ × │
│    │              │ b@email.com │          │          │        │      │      │
└────┴──────────────┴─────────────┴──────────┴──────────┴────────┴──────┴──────┘
                                                  Hiển thị 1-50 / 234  [← 1 2 3 →]
```

**Table Style:**

- Background: Glass white
- Border Radius: `12px`
- Border: `1px solid rgba(255,255,255,0.8)`
- Header: 14px Medium, `#6B6458`, Background `#FAFAF9`
- Row: 16px padding, border-bottom `1px solid #E8E4DF`
- Hover row: Background `#FAFAF9`
- Cell: 14px Regular, `#2C2925`


### 3.8 Page: Thanh Toán

**Page Header:**

```
┌─────────────────────────────────────────────────────┐
│  Thanh toán                          [+ Tạo hóa đơn]│
│  (H1, 32px)                                      (Button)│
└─────────────────────────────────────────────────────┘
```

**Invoice Table:**

```
┌──────┬──────────────┬─────────────┬──────────────┬─────────────┬──────┐
│ Số HĐ│ Khách        │ Số tiền     │ Trạng thái   │ Ngày        │ ≠    │
├──────┼──────────────┼─────────────┼──────────────┼─────────────┼──────┤
│INV-0001│ Nguyễn A  │ 50,000,000 ₫│ [Đã thanh toán]✅│ 15/05/2026│ ✏️ │
├──────┼──────────────┼─────────────┼──────────────┼─────────────┼──────┤
│INV-0002│ Trần B     │ 25,000,000 ₫│ [Chưa thanh toán]🟡│ -       │ ✏️ │
└──────┴──────────────┴─────────────┴──────────────┴─────────────┴──────┘
```


### 3.9 Page: Cài Đặt

**Page Header:**

```
┌─────────────────────────────────────────────────────┐
│  Cài đặt                                                │
│  (H1, 32px)                                                │
│                                                      │
│  [Hồ sơ] [Quản lý người dùng] [Nhóm] [Nhãn]         │ ← Tabs
└─────────────────────────────────────────────────────┘
```

**User Management Table:**

```
┌────┬──────────┬─────────────────┬──────────┬────────┬────────┐
│ 👤 │ Tên      │ Email           │ Vai trò  │ Nhóm   │ ≠ ×    │
├────┼──────────┼─────────────────┼──────────┼────────┼────────┤
│ 👤 │ Admin    │ admin@yen.com   │ [Admin]  │ -      │ ✏️ ×   │
├────┼──────────┼─────────────────┼──────────┼────────┼────────┤
│ 👤 │ Sarah N. │ sarah@yen.com   │ [Manager]│ Nhóm A │ ✏️ ×   │
└────┴──────────┴─────────────────┴──────────┴────────┴────────┘
                      [+ Thêm người dùng]
```


***

## 4. COMPONENT STYLE

### 4.1 Card Component

**Base Card:**

```css
.card {
  background: rgba(255, 255, 255, 0.95);
  border: 1px solid rgba(255, 255, 255, 0.6);
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 8px 32px rgba(44, 41, 37, 0.08);
  backdrop-filter: blur(10px);
}
```

**KPI Card:**

```css
.kpi-card {
  background: rgba(255, 255, 255, 0.95);
  border: 1px solid rgba(255, 255, 255, 0.6);
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 8px 32px rgba(44, 41, 37, 0.08);
  backdrop-filter: blur(10px);
  transition: transform 0.2s, box-shadow 0.2s;
}

.kpi-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 40px rgba(44, 41, 37, 0.12);
}
```


### 4.2 Button Component

**Primary Button (Filled):**

```css
.button-primary {
  background: #D4A574;
  color: #FFFFFF;
  border: none;
  border-radius: 10px;
  padding: 12px 24px;
  font-family: 'Inter', sans-serif;
  font-size: 16px;
  font-weight: 500;
  letter-spacing: 0.5px;
  cursor: pointer;
  transition: background 0.2s, transform 0.1s;
}

.button-primary:hover {
  background: #C49564;
  transform: translateY(-1px);
}

.button-primary:active {
  transform: translateY(0);
}
```

**Secondary Button (Outline):**

```css
.button-secondary {
  background: transparent;
  color: #D4A574;
  border: 2px solid #D4A574;
  border-radius: 10```

