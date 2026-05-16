<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# TÀI LIỆU YÊU CẦU SẢN PHẨM (PRD) CUỐI CÙNG

## Web App CRM - Công ty Yến Sào Vĩnh Hưng (Giai Đoạn 1)

**Phiên bản:** 1.0 FINAL (ĐÃ CHỐT)
**Ngày tạo:** 16 tháng 5 năm 2026
**Ngày phê duyệt:** 16 tháng 5 năm 2026
**Người soạn:** Manh Do
**Người phê duyệt:** Ban lãnh đạo Công ty Yến Sào Vĩnh Hưng
**Trạng thái:** ĐÃ PHÊ DUYỆT, SẴN SÀNG TRIỂN KHAI
**Ngân sách:** 45 triệu đồng
**Timeline:** 8 tuần (go-live 13/07/2026)

***

## MỤC LỤC

1. Tổng Quan Sản Phẩm
2. Bối Cảnh và Vấn Đề Kinh Doanh
3. Mục Tiêu và KPI
4. Chân Dung Người Dùng
5. Phạm Vi Sản Phẩm (Scope)
6. Danh Sách Module và Tính Năng Chi Tiết
7. User Flow Chi Tiết
8. Mô Hình Dữ Liệu và Data Fields
9. Quy Tắc Phân Quyền Truy Cập
10. Yêu Cầu Xác Thực Người Dùng
11. Yêu Cầu Giao Diện và Trải Nghiệm Người Dùng
12. Yêu Cầu Kỹ Thuật Mức Cao
13. Kế Hoạch Triển Khai và Lộ Trình
14. Tiêu Chí Nghiệm Thu
15. Rủi Ro và Giới Hạn
16. Phụ lục: Danh Sách UserBan Đầu

***

## 1. TỔNG QUAN SẢN PHẨM

### 1.1 Tên Sản Phẩm

Web App CRM cho Công ty Yến Sào Vĩnh Hưng - Giai Đoạn 1

### 1.2 Mô Tả Ngắn Gọn

CRM là hệ thống quản lý quan hệ khách hàng dạng web ứng dụng, giúp Yến Sào Vĩnh Hưng số hóa toàn bộ quy trình bán hàng từ tiếp cận khách hàng tiềm năng, theo dõi cơ hội bán hàng, quản lý công việc đến báo cáo doanh thu. Ứng dụng chạy trên trình duyệt web, hỗ trợ cả desktop và mobile, không cần cài đặt phần mềm.

### 1.3 Loại Sản Phẩm

- Product: B2B/B2C CRM (Customer Relationship Management)
- Platform: Web Application (Responsive)
- Deployment: SaaS trên đám mây (Supabase + Vercel/Netlify)


### 1.4 Đối Tượng Khách Hàng Mục Tiêu

Doanh nghiệp nhỏ và vừa trong ngành thương mại và bán lẻ yến sào tại Việt Nam, đặc biệt là Yến Sào Vĩnh Hưng với 10-30 nhân viên sales, doanh thu hàng năm 5-20 tỷ đồng.

### 1.5 Giá Trị Độc Đáo

CRM được thiết kế riêng cho ngành yến sào Việt Nam, với phân khúc khách hàng (lẻ, đại lý, VIP), gắn nhãn sản phẩm (yến thô, yến chưng, yến tinh chế), Kanban kéo thả, đồng thời hỗ trợ đa phương thức đăng nhập (email/password và Google OAuth) với cơ chế merge tài khoản thông minh.

***

## 2. BỐI CẢNH VÀ VẤN ĐỀ KINH DOANH

### 2.1 Giới Thiệu Về Công Ty Yến Sào Vĩnh Hưng

Công ty Yến Sào Vĩnh Hưng là doanh nghiệp chuyên hoạt động trong lĩnh vực thương mại và bán lẻ yến sào tại Việt Nam, trụ sở tại TP. Hồ Chí Minh. Công ty phân phối tổ yến thô, yến tinh chế (bạch yến, huyết yến), yến tươi chưng sẵn, và set quà tặng biếu cao cấp.

Sản phẩm đạt chuẩn ISO 22000:2018, sản xuất khép kín, đảm bảo chất lượng. Khách hàng: cá nhân (mua dùng/biếu), đại lý phân phối, khách VIP (doanh nghiệp, khách sạn, nhà hàng).

Kênh bán: cửa hàng vật lý, website (yensaocaocapvinhhung.com), Shopee, Facebook Marketplace.

### 2.2 Vấn Đề Kinh Doanh Hiện Tại

**Vấn đề 1: Quản lý khách hàng rời rạc**

- Thông tin ghi chép qua Zalo, Excel, sổ tay, dễ mất
- Không có lịch sử tương tác đầy đủ
- Khi nhân viên nghỉ, dữ liệu khách có nguy cơ mất theo

**Vấn đề 2: Theo dõi cơ hội bán hàng kém**

- Không rõ lead nào ở giai đoạn nào
- Lead hot bị bỏ quên do thiếu follow-up
- Trùng lặp: nhiều sales cùng tiếp cận một khách

**Vấn đề 3: Đánh giá hiệu suất sales không chính xác**

- Không có số liệu tổng hợp doanh số theo nhân viên/tháng
- Khó xác định ai làm tốt, ai cần hỗ trợ
- Trưởng nhóm mất nhiều thời gian tổng hợp báo cáo

**Vấn đề 4: Phối hợp nhóm kém**

- Sales không biết đồng nghiệp đang xử lý lead nào
- Khó chuyển giao lead khi nhân viên nghỉ/quá tải

**Vấn đề 5: Thiếu công cụ hỗ trợ quyết định**

- Ban lãnh đạo không có dashboard real-time
- Không dự báo doanh thu dựa trên pipeline


### 2.3 Tại Sao Cần CRM Ngay Bây Giờ

- Doanh nghiệp đang tăng trưởng, cần chuẩn hóa trước khi mở rộng
- Số lượng khách tăng nhanh, vượt quá khả năng quản lý thủ công
- Cạnh tranh gay gắt, cần tối ưu hiệu suất sales
- Chi phí triển khai hợp lý (45 triệu), ROI nhanh 3-6 tháng
- Công nghệ sẵn sàng, dễ triển khai với Supabase

***

## 3. MỤC TIÊU VÀ KPI

### 3.1 Mục Tiêu Chung

Xây dựng CRM đơn giản, dễ sử dụng, giúp Yến Sào Vĩnh Hưng:

- Số hóa 100% quy trình quản lý khách hàng và bán hàng
- Tăng hiệu suất đội sales 20-30%
- Cải thiện tỷ lệ chuyển đổi lead thành đơn hàng
- Cung cấp dữ liệu chính xác để ra quyết định


### 3.2 KPI Sau 90 Ngày (ĐÃ CHỐT)

| KPI | Hiện Tại | Mục Tiêu 90 Ngày | Mức Cải Thiện |
| :-- | :-- | :-- | :-- |
| Tỷ lệ chuyển đổi lead → đơn | 15% | 18% | +20% |
| Thời gian xử lý 1 lead | 3 ngày | 1 ngày | -67% |
| Doanh số mỗi sales/tháng | 200 triệu VND | 230 triệu VND | +15% |
| Lead bị quên (>7 ngày) | 30% | 10% | -67% |
| Thời gian làm báo cáo tháng | 4 giờ | 15 phút | -94% |

### 3.3 KPI Theo Dõi Trong CRM

**KPI Doanh Số:**

- Doanh thu tháng (so tháng trước, cùng kỳ năm ngoái)
- Doanh thu theo phân khúc (lẻ, đại lý, VIP)
- Doanh thu theo sản phẩm (yến thô, yến chưng, yến tinh chế)

**KPI Lead và Cơ Hội:**

- Tổng lead mới tháng này
- Tỷ lệ chuyển đổi theo giai đoạn
- Pipeline value (tổng giá trị cơ hội mở)
- Lead hot (deadline trong 3 ngày)

**KPI Hiệu Suất:**

- Doanh số theo nhân viên (ranking)
- Số lead mỗi sales đang xử lý
- Tỷ lệ chốt đơn theo sales
- Công việc trễ hạn theo sales

***

## 4. CHÂN DUNG NGƯỜI DÙNG

### 4.1 Admin (Ban Lãnh Đạo)

- Số lượng: 1-2 người
- Độ tuổi: 35-50 tuổi
- Vị trí: Giám đốc, Phó giám đốc, Trưởng phòng kinh doanh
- Mục tiêu: Xem dashboard tổng quan, quản lý user, xuất báo cáo
- Điểm đau: Mất thời gian tổng hợp báo cáo, không có số liệu real-time

**Kịch bản:** Mỗi sáng mở CRM, xem Dashboard biết doanh thu tháng đạt 80% mục tiêu, xuất báo cáo doanh số theo sales gửi kế toán.

### 4.2 Trưởng Nhóm Sales

- Số lượng: 2-5 người
- Độ tuổi: 30-45 tuổi
- Vị trí: Trưởng nhóm kinh doanh, Quản lý cấp trung
- Mục tiêu: Xem Kanban nhóm, giao task, theo dõi lead hot, báo cáo hiệu suất
- Điểm đau: Không biết sales đang làm gì, lead hot bị quên, mất 2-3 giờ làm báo cáo

**Kịch bản:** Mở Kanban thấy 5 cơ hội deadline trong 3 ngày, giao task cho sales. Cuối tuần xem dashboard nhóm đạt 70% tuần.

### 4.3 Nhân Viên Sales

- Số lượng: 10-20 người
- Độ tuổi: 25-35 tuổi
- Vị trí: Nhân viên kinh doanh
- Mục tiêu: Thêm lead nhanh, kéo thả Kanban, xem task hôm nay, tìm khách cũ
- Điểm đau: Quên follow-up, mất thông tin khách, trùng lặp với đồng nghiệp

**Kịch bản:** Gặp khách hội chợ, nhập lead mobile 30 giây. Tối về kéo Kanban sang "Liên hệ", gọi tư vấn. Khách đồng ý, kéo "Chốt đơn", tạo hóa đơn.

***

## 5. PHẠM VI SẢN PHẨM (SCOPE) ĐÃ CHỐT

### 5.1 Phạm Vi Giai Đoạn 1 (BẮT BUỘC)

**Module 1: Tổng Quan (Dashboard)**

- 4 card KPI: Tổng lead tháng, Cơ hội mới, Doanh thu tháng, Tỷ lệ chuyển đổi
- Biểu đồ cột: Doanh thu theo nhân viên (top 10)
- Biểu đồ đường: Lead theo ngày (30 ngày)
- Biểu đồ tròn: Phân khúc khách (lẻ, đại lý, VIP)
- Widget: Lead hot (deadline 3 ngày), Công việc trễ hạn

**Module 2: Cơ Hội Bán Hàng (Kanban)**

- Board Kanban 4 cột: Mới, Liên hệ, Đề xuất, Chốt đơn
- Thẻ cơ hội: Tên khách, giai đoạn, giá trị, deadline, nhãn
- Kéo thả giữa cột (desktop + mobile)
- Filter: Nhân viên, Phân khúc, Sản phẩm, Group
- Search: Tên, sđt, email
- Chi tiết cơ hội: Tab thông tin, lịch sử, công việc

**Module 3: Công Việc (Task)**

- Danh sách task của tôi (sales) / nhóm (manager)
- Trạng thái: Chưa làm, Đang làm, Hoàn thành
- Filter: Hôm nay, Tuần này, Trễ hạn
- Tạo task: Tiêu đề, mô tả, gán cho ai, deadline, link cơ hội
- Checkbox hoàn thành

**Module 4: Danh Sách Khách Hàng**

- Bảng list với pagination (50/trang)
- Cột: Tên, SĐT, Email, Phân khúc, Sản phẩm, Owner, Created date
- Search: Tên, sđt, email
- Filter: Phân khúc, Sản phẩm, Owner, Group
- Thêm mới: Form (tên, sđt, email, phân khúc, sản phẩm, ghi chú)
- Chỉnh sửa: Modal edit
- Xóa mềm: Confirm dialog
- Chi tiết: Tab thông tin, lịch sử giao dịch, ghi chú
- Upload CSV: Drag-drop, validate, preview 5 rows, import
- Export CSV: Filter → Export

**Module 5: Thanh Toán**

- Danh sách hóa đơn: Số HĐ, Khách, Số tiền, Trạng thái, Ngày
- Tạo hóa đơn: Chọn cơ hội, số tiền, ngày thanh toán
- Cập nhật trạng thái: Chưa thanh toán → Đã thanh toán
- Tổng doanh thu theo tháng

**Module 6: Cài Đặt**

- Quản lý user (Admin only): Thêm/sửa/xóa, gán role, gán group
- Role: Admin, Trưởng nhóm, Sales
- Group: Nhóm A, B, C (tùy chỉnh)
- Cấu hình nhãn: Phân khúc, Sản phẩm
- Đổi mật khẩu, đổi email (user self-service)

**Xác Thực Người Dùng (ĐÃ CHỐT):**

1. Đăng ký bằng email + mật khẩu
2. Đăng nhập bằng email + mật khẩu
3. Đăng nhập bằng Google OAuth
4. Quên mật khẩu / Đặt lại mật khẩu
5. **KHÔNG tạo trùng tài khoản nếu cùng email dùng nhiều cách**

**Phân Quyền (ĐÃ CHỐT):**

- Admin: Full access tất cả module, tất cả data
- Trưởng nhóm: Access data trong group
- Sales: Chỉ data assigned (owner = self)

**Cơ Sở Dữ Liệu:**

- Supabase PostgreSQL
- Tables: users, leads, opportunities, tasks, payments, groups, group_members
- Row Level Security (RLS)
- Audit log


### 5.2 Phạm Vi Ngoài Giai Đoạn 1 (KHÔNG CÓ)

- Quản lý kho hàng (inventory)
- Quản lý đơn hàng chi tiết (shipping)
- Marketing automation (email/SMS bulk)
- Báo giá và hợp đồng điện tử
- Tích hợp cổng thanh toán
- AI dự báo doanh thu
- Mobile app native (iOS/Android)
- Tích hợp phần mềm kế toán
- Customer portal
- Đa ngôn ngữ, đa tiền tệ

***

## 6. DANH SÁCH MODULE VÀ TÍNH NĂNG CHI TIẾT

### 6.1 Module Tổng Quan (Dashboard)

**Card KPI (4 card):**

1. Tổng lead tháng: Số lead mới tháng hiện tại
2. Cơ hội mới: Số cơ hội cột "Mới" trong 7 ngày
3. Doanh thu tháng: Tổng tiền đã thanh toán tháng (VND)
4. Tỷ lệ chuyển đổi: (Đơn chốt / Tổng lead) x 100%

Mỗi card: Số lớn (32px bold), label dưới (14px gray), badge so tháng trước (+15% xanh, -5% đỏ).

**Biểu đồ 1: Doanh thu theo nhân viên (Bar Chart)**

- Trục X: Tên nhân viên (top 10)
- Trục Y: Doanh thu (triệu VND)
- Color: Gradient xanh

**Biểu đồ 2: Lead theo ngày (Line Chart)**

- Trục X: Ngày (30 ngày)
- Trục Y: Số lead mới
- Color: Xanh \#4A90E2

**Biểu đồ 3: Phân khúc (Pie Chart)**

- 3 phần: Khách lẻ, Đại lý, VIP
- Color: Xanh, Vàng, Cam

**Widget 1: Lead hot**

- List 5-10 leaddeadline 3 ngày
- Badge "Nóng" đỏ

**Widget 2: Công việc trễ hạn**

- List 5-10 task quá hạn
- Click → Trang Task filter trễ hạn

**Quy tắc:** Auto load khi mở, refresh 5 phút, filter khoảng thời gian.

### 6.2 Module Cơ Hội Bán Hàng (Kanban)

**4 cột:**

1. Mới: Lead mới, chưa liên hệ
2. Liên hệ: Đã gọi/Zalo, đang tư vấn
3. Đề xuất: Đã báo giá, chờ quyết định
4. Chốt đơn: Khách đồng ý, chờ thanh toán

**Thẻ cơ hội:**

- Header: Tên khách (bold 16px)
- Body: Giá trị (50 triệu), Deadline (25/05), Phân khúc (badge), Sản phẩm (badge nhỏ)
- Footer: Owner (avatar + tên 12px)

**Kéo thả:**

- Desktop: Drag mouse, drop cột
- Mobile: Touch và kéo, drop
- Animation mượt, card "nổi" khi drag
- Drop → Auto update stage, log lịch sử
- Undo trong 3 giây nếu drop nhầm

**Filter và Search:**

- Filter: Nhân viên, Phân khúc, Sản phẩm, Group
- Search: Tên, sđt, email (debounce 300ms)
- Real-time filter, không reload

**Chi tiết cơ hội (Click thẻ):**

- Modal/side panel
- Tab 1: Thông tin (tên, sđt, email, phân khúc, sản phẩm, giá trị, deadline, notes)
- Tab 2: Lịch sử (timeline chuyển stage)
- Tab 3: Công việc liên kết
- Nút: Chỉnh sửa, Xóa, Thêm task, Tạo hóa đơn


### 6.3 Module Công Việc (Task)

**View:**

- Sales: Task gán cho mình
- Manager: Task nhóm (sales trong group)
- Admin: Tất cả task

**Cột bảng:**

- Tiêu đề (click chi tiết)
- Gán cho (avatar + tên)
- Liên kết cơ hội (tên, click)
- Deadline (đỏ nếu trễ)
- Trạng thái: Checkbox
- Hành động: Sửa, Xóa

**Trạng thái:**

- Chưa làm: Checkbox unchecked, đen
- Đang làm: Checkbox unchecked, xanh
- Hoàn thành: Checkbox checked, xám, gạch ngang

**Tạo Task:**

- Nút "Thêm công việc"
- Modal: Tiêu đề (required), Mô tả (optional 500 ký tự), Gán cho (required), Deadline (required), Link cơ hội (optional)
- Nút: Tạo, Hủy

**Filter:** Today, This week, Overdue, All

**Nhắc nhở:** Email 1 ngày trước (giai đoạn 2), in-app notification (giai đoạn 1)

### 6.4 Module Danh Sách Khách Hàng

**Cột bảng:**

1. Tên (click chi tiết)
2. SĐT (click tel:)
3. Email (click mailto:)
4. Phân khúc (badge: xanh=lẻ, vàng=đại lý, đỏ=VIP)
5. Sản phẩm (list badge)
6. Owner (avatar + tên)
7. Created date
8. Actions (sửa, xóa)

**Pagination:** 50/trang, Previous/Next, Page number, Total

**Search:** Name, sđt, email (OR logic, debounce 300ms)

**Filter:** Phân khúc, Sản phẩm, Owner, Group, Apply, Reset

**Thêm khách:**

- Nút "Thêm khách"
- Form: Tên (required), SĐT (required VN format), Email (optional unique), Phân khúc (required 1 trong 3), Sản phẩm (required multi-select 1 trong 3), Ghi chú (optional 500 ký tự), Owner (auto self)
- Nút: Lưu, Hủy

**Chỉnh sửa:** Click "Chỉnh sửa" → Modal edit (chỉ admin/owner)

**Xóa:** Click "Xóa" → Confirm → Soft delete (deleted_at), filter "Hiển thị đã xóa"

**Chi tiết khách:**

- Tab 1: Thông tin (readonly)
- Tab 2: Lịch sử giao dịch (opportunity + payment)
- Tab 3: Ghi chú (timeline, thêm mới)
- Nút: Sửa, Tạo cơ hội, Tạo hóa đơn

**Upload CSV:**

- Nút "Upload CSV"
- Modal: Hướng dẫn, Template download, Drag-drop/chọn file, Preview 5 rows, Validate
- Validate: Required (tên, sđt), Unique (sđt, email), Valid (phân khúc/sản phẩm)
- Báo cáo: Thành công X/Y, Lỗi Z (dòng...)
- Nút: Import, Hủy

**Export CSV:** Filter → Export → leads_YYYYMMDD_HHMMSS.csv (UTF-8 BOM)

### 6.5 Module Thanh Toán

**Cột bảng:**

- Số HĐ (INV-0001 auto)
- Khách (click chi tiết)
- Cơ hội (tên)
- Số tiền (50,000,000 ₫)
- Trạng thái: Chưa thanh toán (vàng), Đã thanh toán (xanh)
- Ngày thanh toán
- Actions (sửa, xóa)

**Tạo hóa đơn:**

- Nút "Tạo hóa đơn"
- Modal: Chọn cơ hội (dropdown chưa có HĐ), Số tiền (required), Ngày (default hôm nay), Ghi chú (optional)
- Nút: Tạo

**Cập nhật:** Click HĐ → Edit → Đổi trạng thái → Ngày thanh toán → Save → Dashboard auto update

**Tổng hợp:** Dashboard card "Doanh thu tháng", Chart 12 tháng

### 6.6 Module Cài Đặt

**Quản lý user (Admin):**

- Danh sách: Avatar, Tên, Email, Role, Group, Date, Actions
- Add: Tên, Email, Password (min 8, chữ hoa/thường/số), Role, Group → Tạo
- Edit: Đổi role, group, password → Lưu
- Xóa: Soft delete

**Role:** Admin (full), Manager (group), Sales (self)

**Group:** Nhóm A, B, C (tên tùy chỉnh), Member list, Add/remove

**Nhãn:** Phân khúc (lẻ, đại lý, VIP), Sản phẩm (thô, chưng, tinh chế) - add/edit/delete

**Hồ sơ:** Đổi password, đổi email (verify), đổi avatar

***

## 7. USER FLOW CHI TIẾT

### 7.1 Flow Đăng Ký Email/Password

```
[Trang chủ] → [Đăng ký] → [Form: email, password, tên] → [Đăng ký]
→ [Check email tồn tại?]
  ├─ Tồn tại → Error "Email đã dùng"
  └─ Mới → Tạo user Supabase Auth
       → Gán role mặc định "Sales"
       → Redirect "Đăng ký thành công"
       → [Dashboard]
```


### 7.2 Flow Đăng Nhập Email/Password

```
[Đăng nhập] → [Email/Password] → [Form: email, password] → [Đăng nhập]
→ [Validate credentials]
  ├─ Sai → Error "Email/pass không đúng"
  └─ Đúng → Load user role/group
       → Tạo session
       → Redirect theo role (Admin/Manager/Sales)
       → [Dashboard]
```


### 7.3 Flow Đăng Nhập Google OAuth

```
[Đăng nhập] → [Google OAuth] → [Google popup chọn account]
→ [Google trả email + name]
→ [Check email tồn tại trong DB?]
  ├─ Tồn tại → Sign in existing (merge session)
  │    → Load role/group cũ
  │    → KHÔNG tạo user mới
  │
  └─ Mới → Tạo user Supabase Auth provider="google"
       → Gán role mặc định "Sales"
       → Link Google account với email
       → Redirect theo role
       → [Dashboard]
```


### 7.4 Flow Merge Email (ĐÃ CHỐT)

```
User A: Đã đăng ký email/password: john@example.com, Role: Manager

User A lần 2: Đăng nhập Google: john@example.com (cùng email)
→ [Check email tồn tại?]
  ├─ Có → KHÔNG tạo mới
  │    → Update user: provider="email,google"
  │    → Giữ nguyên role: Manager
  │    → Giữ nguyên group: Nhóm A
  │    → Sign in thành công
  │
  └─ Không → Tạo mới (xem Flow 7.3)
```


### 7.5 Flow Quên Mật Khẩu

```
[Đăng nhập] → [Quên mật khẩu?] → [Form: email] → [Gửi link]
→ [Backend gửi email reset link]
→ [User click link trong email]
→ [Form: mật khẩu mới, nhập lại] → [Đặt lại]
→ [Update password] → [Thông báo thành công]
→ [Đăng nhập]
```


### 7.6 Flow Thêm Khách (Sales)

```
[Sales mở CRM] → [Danh sách khách] → [Thêm khách]
→ [Form: tên, sđt, email, phân khúc, sản phẩm, ghi chú]
→ [Lưu] → [Validate]
  ├─ Thiếu required → Error
  ├─ SĐT trùng → Error
  ├─ Email trùng → Warning merge
  └─ Hợp lệ → Insert DB
       → Tạo Opportunity tự động cột "Mới"
       → Toast "Thành công"
       → Refresh danh sách
```


### 7.7 Flow Kéo Thả Kanban

```
[Mở Kanban] → [Click giữ card "Lead A"] → [Card nổi]
→ [Kéo sang cột "Liên hệ"] → [Drop]
→ [Update opportunity.stage="Liên hệ"]
→ [Log lịch sử: "Chuyển lúc 14:30, bởi Sales A"]
→ [Toast "Đã chuyển"]
→ [Card nằm cột "Liên hệ"]
→ [Click card] → [Modal chi tiết: thông tin, lịch sử, task]
```


### 7.8 Flow Upload CSV

```
[Mở "Danh sách khách"] → [Upload CSV]
→ [Modal: hướng dẫn, template] → [Drag-drop file]
→ [Preview 5 rows] → [Validate]
→ [Báo cáo: Thành công 48/50, Lỗi 2]
→ [Import] → Insert 48 khách
→ [Toast "Thành công 48 khách"]
→ [Refresh danh sách]
```


### 7.9 Flow Export CSV

```
[Mở "Danh sách khách"] → [Filter: VIP, Yến thô]
→ [Apply] → [Bảng hiện 20 khách]
→ [Export CSV] → [Backend query filtered data]
→ [Generate CSV UTF-8] → [Download leads_20260516.csv]
```


### 7.10 Flow Quản Lý User (Admin)

```
[Mở "Cài đặt"] → [Tab "Quản lý user"]
→ [Bảng danh sách user] → ["Thêm người dùng"]
→ [Form: tên, email, password, role, group]
→ [Tạo] → [Supabase Auth tạo user]
→ [Send email invite] → [Toast "Đã tạo, email đã gửi"]
→ [Refresh danh sách]
```


***

## 8. MÔ HÌNH DỮ LIỆU VÀ DATA FIELDS

### 8.1 Bảng Users

| Field | Type | Required | Default | Description |
| :-- | :-- | :-- | :-- | :-- |
| id | UUID | Yes | Auto | PK, Supabase Auth ID |
| email | VARCHAR(255) | Yes | - | Unique, indexed |
| password_hash | VARCHAR(255) | No | NULL | NULL nếu chỉ Google |
| full_name | VARCHAR(100) | Yes | - | Tên hiển thị |
| avatar_url | VARCHAR(500) | No | - | Link ảnh |
| role | ENUM | Yes | 'sales' | admin, manager, sales |
| group_id | UUID | No | NULL | FK → groups.id |
| phone | VARCHAR(20) | No | - | SĐT |
| is_active | BOOLEAN | Yes | true | Soft delete flag |
| created_at | TIMESTAMP | Yes | NOW() | Ngày tạo |
| updated_at | TIMESTAMP | Yes | NOW() | Ngày cập nhật |
| created_by | UUID | No | NULL | User tạo |
| updated_by | UUID | No | NULL | User cập nhật |

**Indexes:** email (unique), role, group_id

**Constraints:** UNIQUE(email), CHECK(role IN ...)

### 8.2 Bảng Groups

| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| id | UUID | Yes | PK |
| name | VARCHAR(100) | Yes | Nhóm A, B, C |
| created_at | TIMESTAMP | Yes | NOW() |

### 8.3 Bảng Group_Members

| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| id | UUID | Yes | PK |
| group_id | UUID | Yes | FK → groups |
| user_id | UUID | Yes | FK → users |
| joined_at | TIMESTAMP | Yes | NOW() |

**Unique:** (group_id, user_id)

### 8.4 Bảng Leads

| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| id | UUID | Yes | PK |
| name | VARCHAR(100) | Yes | Tên khách |
| phone | VARCHAR(20) | Yes | SĐT, unique |
| email | VARCHAR(255) | No | Unique |
| segment | ENUM | Yes | lẻ, đại lý, VIP |
| products | TEXT[] | Yes | ["yến_thô", "yến_chưng"] |
| notes | TEXT | No | Ghi chú max 500 |
| owner_id | UUID | Yes | FK → users (sales) |
| deleted_at | TIMESTAMP | No | Soft delete |
| created_at | TIMESTAMP | Yes | NOW() |
| updated_at | TIMESTAMP | Yes | NOW() |
| created_by | UUID | Yes | FK → users |
| updated_by | UUID | No | FK → users |

**Indexes:** phone (unique), email (unique), segment, owner_id

### 8.5 Bảng Opportunities

| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| id | UUID | Yes | PK |
| lead_id | UUID | Yes | FK → leads |
| name | VARCHAR(200) | Yes | Tên cơ hội |
| stage | ENUM | Yes | mới, liên_hệ, đề_xuất, chốt |
| value | INTEGER | Yes | Giá trị VND |
| deadline | DATE | Yes | Ngày hạn |
| status | ENUM | Yes | active, closed |
| created_at | TIMESTAMP | Yes | NOW() |
| updated_at | TIMESTAMP | Yes | NOW() |

**Indexes:** lead_id, stage, status, deadline

### 8.6 Bảng Tasks

| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| id | UUID | Yes | PK |
| title | VARCHAR(200) | Yes | Tiêu đề |
| description | TEXT | No | Mô tả max 500 |
| assignee_id | UUID | Yes | FK → users |
| opportunity_id | UUID | No | FK → opportunities |
| due_date | TIMESTAMP | Yes | Deadline |
| status | ENUM | Yes | pending, in_progress, done |
| created_at | TIMESTAMP | Yes | NOW() |
| updated_at | TIMESTAMP | Yes | NOW() |
| created_by | UUID | Yes | FK → users |

**Indexes:** assignee_id, status, due_date, opportunity_id

### 8.7 Bảng Payments

| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| id | UUID | Yes | PK |
| invoice_number | VARCHAR(20) | Yes | INV-0001, unique |
| opportunity_id | UUID | Yes | FK → opportunities |
| amount | INTEGER | Yes | Số tiền VND |
| status | ENUM | Yes | pending, paid |
| payment_date | DATE | No | Ngày thanh toán |
| notes | TEXT | No | Ghi chú |
| created_at | TIMESTAMP | Yes | NOW() |
| created_by | UUID | Yes | FK → users |

**Indexes:** invoice_number (unique), opportunity_id, status

### 8.8 Bảng Audit_Logs

| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| id | UUID | Yes | PK |
| table_name | VARCHAR(50) | Yes | leads, opportunities... |
| record_id | UUID | Yes | Record ID |
| action | ENUM | Yes | create, update, delete |
| old_data | JSONB | No | Dữ liệu cũ |
| new_data | JSONB | No | Dữ liệu mới |
| user_id | UUID | Yes | FK → users |
| created_at | TIMESTAMP | Yes | NOW() |


***

## 9. QUY TẮC PHÂN QUYỀN TRUY CẬP (ĐÃ CHỐT)

### 9.1 Quy Tắc Tổng Quát

**Dựa trên Role-Based Access Control (RBAC):**


| Tính Năng | Admin | Manager | Sales |
| :-- | :-- | :-- | :-- |
| Xem Dashboard toàn công ty | ✅ | ❌ (nhóm) | ❌ (cá nhân) |
| Quản lý user | ✅ | ❌ | ❌ |
| Xem Kanban toàn công ty | ✅ | ✅ (nhóm) | ❌ (cá nhân) |
| Thêm/sửa/xóa khách | ✅ | ✅ (nhóm) | ✅ (self) |
| Upload CSV | ✅ | ✅ | ✅ |
| Export CSV | ✅ | ✅ | ✅ |
| Giao task người khác | ✅ | ✅ (nhóm) | ❌ |
| Xem báo cáo team | ✅ | ✅ | ❌ |

### 9.2 Quy Tắc Dữ liệu

**Query Filter:**

- Admin: Không filter (xem tất cả)
- Manager: `WHERE owner_id IN (SELECT user_id FROM group_members WHERE group_id = current_user.group_id)`
- Sales: `WHERE owner_id = current_user.id`

**Row Level Security (RLS) trên Supabase:**

```sql
-- Leads table RLS
CREATE POLICY "Admin sees all" ON leads
  FOR ALL USING (auth_jwt ->> 'role' = 'admin');

CREATE POLICY "Manager sees group" ON leads
  FOR ALL USING (
    owner_id IN (
      SELECT user_id FROM group_members 
      WHERE group_id = (SELECT group_id FROM users WHERE id = auth.uid())
    )
  );

CREATE POLICY "Sales sees self" ON leads
  FOR ALL USING (owner_id = auth.uid());
```


### 9.3 Audit Log

Tất cả create/update/delete đều ghi audit_log:

- table_name, record_id, action, old_data, new_data, user_id, created_at

***

## 10. YÊU CẦU XÁC THỰC NGƯỜI DÙNG (ĐÃ CHỐT)

### 10.1 Phương Thức Xác Thực

**1. Email/Password:**

- Đăng ký: email + password (min 8, chữ hoa/thường/số) + full_name
- Đăng nhập: email + password
- Forgot password: email → reset link → password mới

**2. Google OAuth:**

- Scope: email, profile
- Click "Đăng nhập với Google" → Popup Google → Grant → Sign in


### 10.2 Xử Lý Email Trùng (ĐÃ CHỐT)

**Nguyên tắc:**

- UNIQUE constraint trên email toàn hệ thống
- Login Google: Nếu email tồn tại → Sign in existing, KHÔNG tạo mới
- Đăng ký email: Check exist → Error "Email đã dùng"

**Merge logic:**

```
User tồn tại: email=john@example.com, role=manager, group=nhóm_a

User đăng nhập Google: email=john@example.com
→ Check DB: email tồn tại
→ Provider update: "email,google"
→ Giữ nguyên role: manager
→ Giữ nguyên group: nhóm_a
→ Sign in thành công
```


### 10.3 Phân Quyền Không Phụ Thuộc Auth Method

- Role và group lưu ở DB users table
- Session load role từ DB sau auth
- Dù login bằng email hay Google, quyền vẫn theo user record
- Đổi auth method không làm mất role


### 10.4 Bảo Mật

- HTTPS bắt buộc
- Password min 8 ký tự, complexity
- Rate limit: 5 failed login → lock 15 phút
- Session timeout: 30 phút không hoạt động
- CSRF protection
- SQL injection prevention (parameterized queries)

***

## 11. YÊU CẦU GIAO DIỆN VÀ TRẢI NGHIỆM

### 11.1 Phong Cách Tổng Thể

- Màu chủ đạo: Xanh dương \#4A90E2 (tin cậy, cao cấp)
- Accent: Vàng nhạt \#F5D76E (KPI hot), Cam \#FF6B6B (VIP)
- Background: Trắng
- Font: Inter hoặc Roboto (sans-serif), 14-24px


### 11.2 Layout

- Header: Logo Yến Sào Vĩnh Hưng, User avatar, Logout
- Sidebar: Icons + text cho 6 modules, collapsible mobile
- Main: Card-based, table pagination/search
- Kanban: Drag-drop, card badges


### 11.3 Responsive

- Mobile-first: Bootstrap/Tailwind
- Breakpoints: 320px (mobile), 768px (tablet), 1024px (desktop)
- Sidebar collapse hamburger menu mobile


### 11.4 UX Principles

- Loading spinner <1s
- Toast notification success/error
- Confirm dialog delete
- Debounce search 300ms
- Hotkey: Ctrl+S save, Ctrl+F search


### 11.5 Accessible

- ARIA labels
- Keyboard navigation
- Color contrast 4.5:1
- Focus indicators

***

## 12. YÊU CẦU KỸ THUẬT MỨC CAO

### 12.1 Tech Stack

**Frontend:**

- React.js 18+/Next.js 14
- Tailwind CSS
- Zustand (state)
- React Query (data fetching)
- Chart.js (biểu đồ)
- React DnD (kanban drag-drop)

**Backend:**

- Supabase (Postgres DB, Auth, Realtime, Storage)
- Edge Functions (API custom)
- Row Level Security (RLS)

**Deployment:**

- Frontend: Vercel/Netlify
- Backend: Supabase hosted
- Domain: crm.yensaovinhhung.com


### 12.2 Database

- PostgreSQL 14+
- Supabase hosted (starter plan)
- Tables: users, groups, group_members, leads, opportunities, tasks, payments, audit_logs
- Indexes: email, phone, segment, stage, status, owner_id
- RLS policies: admin all, manager group, sales self


### 12.3 Auth

- Supabase Auth
- Providers: email/password, Google OAuth
- JWT tokens, refresh tokens
- Email verification (optional)


### 12.4 API

- RESTful qua Supabase
- GET /api/leads (filter, search, paginate)
- POST /api/leads (create)
- PUT /api/leads/:id (update)
- DELETE /api/leads/:id (soft delete)
- Realtime subscriptions (Kanban updates)


### 12.5 File Storage

- Supabase Storage
- CSV upload <10MB
- Avatar upload <2MB
- Public bucket: avatars, private bucket: csv_exports


### 12.6 Performance

- Page load <2s (Lighthouse 90+)
- API response <500ms
- Concurrent 20 users realtime
- Lazy load lists, virtual scroll 1000+ rows
- Image optimization (WebP)


### 12.7 Security

- HTTPS enforced
- CORS configured
- Rate limiting (100 req/minute)
- Input validation (Zod schema)
- XSS prevention (React escape)
- SQL injection prevention (parameterized)

***

## 13. KẾ HOẠCH TRIỂN KHAI VÀ LỘ TRÌNH

### 13.1 Timeline 8 Tuần (ĐÃ CHỐT)

**Tuần 1 (18-24/05/2026): Khởi động**

- Họp kickoff, ký hợp đồng
- Cung cấp logo, màu sắc, danh sách user
- Setup project, repository

**Tuần 2-3 (25/05-07/06/2026): Thiết kế**

- Wireframe 6 module (Figma)
- UI design finalize
- Prototype tương tác
- Chốt UI

**Tuần 4 (08-14/06/2026): Xác thực**

- Setup Supabase Auth
- Email/password login/register
- Google OAuth
- Forgot password
- Merge email logic
- Test auth 100%

**Tuần 5 (15-21/06/2026): Danh sách khách**

- CRUD leads
- Search, filter
- Upload CSV, Export CSV
- Test CRUD, CSV

**Tuần 6 (22-28/06/2026): Kanban + Task**

- Kanban 4 cột
- Drag-drop desktop/mobile
- Task CRUD, filter
- Test drag-drop

**Tuần 7 (29/06-05/07/2026): Dashboard + Thanh toán + Cài đặt**

- Dashboard卡, charts
- Payments CRUD
- User management
- Test toàn bộ

**Tuần 8 (06-12/07/2026): Test + Đào tạo + Go-live**

- System test 50+ cases
- Đào tạo 20-30 user
- Deploy production
- Go-live 13/07/2026


### 13.2 Milestones

| Milestone | Ngày | Deliverable |
| :-- | :-- | :-- |
| Ký hợp đồng | 20/05/2026 | Hợp đồng, 50% payment |
| Chốt UI | 07/06/2026 | Figma UI finalize |
| Auth complete | 14/06/2026 | Login/register/test |
| leads complete | 21/06/2026 | CRUD/C |

