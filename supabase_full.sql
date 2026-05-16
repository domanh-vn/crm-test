-- ============================================================
-- CRM YẾN SÀO VĨNH HƯNG — SUPABASE SQL FULL SCHEMA
-- Phiên bản: 1.0 | Ngày: 16/05/2026
-- Chạy tuần tự từng phần trong Supabase SQL Editor
-- ============================================================


-- ============================================================
-- PHẦN 0: EXTENSIONS
-- ============================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- ============================================================
-- PHẦN 1: BẢNG PROFILES (liên kết 1-1 với auth.users)
-- ============================================================
CREATE TABLE public.profiles (
    id            UUID         PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email         VARCHAR(255) UNIQUE NOT NULL,
    full_name     VARCHAR(100) NOT NULL,
    avatar_url    TEXT,
    role          VARCHAR(20)  NOT NULL DEFAULT 'sales'
                               CHECK (role IN ('admin', 'team_leader', 'sales')),
    phone         VARCHAR(20),
    is_active     BOOLEAN      NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.profiles IS 'Hồ sơ người dùng, 1-1 với auth.users';
COMMENT ON COLUMN public.profiles.role IS 'admin | team_leader | sales';

CREATE INDEX idx_profiles_role     ON public.profiles(role);
CREATE INDEX idx_profiles_is_active ON public.profiles(is_active);


-- ============================================================
-- PHẦN 2: BẢNG TEAMS & TEAM_MEMBERS
-- ============================================================
CREATE TABLE public.teams (
    id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE public.team_members (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id    UUID        NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
    user_id    UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    joined_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (team_id, user_id)
);

CREATE INDEX idx_team_members_team_id ON public.team_members(team_id);
CREATE INDEX idx_team_members_user_id ON public.team_members(user_id);


-- ============================================================
-- PHẦN 3: BẢNG PIPELINE_STAGES
-- ============================================================
CREATE TABLE public.pipeline_stages (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name       VARCHAR(50) NOT NULL,
    sort_order INTEGER     NOT NULL,
    color      VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Seed data mẫu cho các giai đoạn
INSERT INTO public.pipeline_stages (id, name, sort_order, color) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Mới',      1, '#5A7D9A'),
    ('22222222-2222-2222-2222-222222222222', 'Liên hệ',  2, '#D4A574'),
    ('33333333-3333-3333-3333-333333333333', 'Đề xuất',  3, '#C95A5A'),
    ('44444444-4444-4444-4444-444444444444', 'Chốt đơn', 4, '#5A8F5A')
ON CONFLICT DO NOTHING;


-- ============================================================
-- PHẦN 4: BẢNG LEAD_TAGS (Phân khúc & Sản phẩm)
-- ============================================================
CREATE TABLE public.lead_tags (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name       VARCHAR(50) NOT NULL,
    tag_type   VARCHAR(20) NOT NULL CHECK (tag_type IN ('segment', 'product', 'general')),
    color      VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Seed data
INSERT INTO public.lead_tags (id, name, tag_type, color) VALUES
    ('55555555-5555-5555-5555-555555555555', 'Khách lẻ',     'segment', '#E8F4F8'),
    ('66666666-6666-6666-6666-666666666666', 'Đại lý',       'segment', '#FFF8E8'),
    ('77777777-7777-7777-7777-777777777777', 'VIP',          'segment', '#FFF5F5'),
    ('88888888-8888-8888-8888-888888888888', 'Yến thô',      'product', '#F0F0F0'),
    ('99999999-9999-9999-9999-999999999999', 'Yến chưng',    'product', '#F5F0E8'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Yến tinh chế', 'product', '#E8F0E8')
ON CONFLICT DO NOTHING;


-- ============================================================
-- PHẦN 5: BẢNG LEADS (Khách hàng tiềm năng)
-- ============================================================
CREATE TABLE public.leads (
    id          UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(100) NOT NULL,
    phone       VARCHAR(20)  UNIQUE,
    email       VARCHAR(255),
    value       BIGINT       NOT NULL DEFAULT 0,
    stage_id    UUID         REFERENCES public.pipeline_stages(id),
    owner_id    UUID         NOT NULL REFERENCES public.profiles(id),
    notes       TEXT,
    deleted_at  TIMESTAMPTZ,                          -- soft delete
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_by  UUID         NOT NULL REFERENCES public.profiles(id)
);

COMMENT ON COLUMN public.leads.deleted_at IS 'NULL = active, NOT NULL = soft deleted';
COMMENT ON COLUMN public.leads.value IS 'Giá trị cơ hội, đơn vị VND';

CREATE INDEX idx_leads_owner_id  ON public.leads(owner_id);
CREATE INDEX idx_leads_stage_id  ON public.leads(stage_id);
CREATE INDEX idx_leads_phone     ON public.leads(phone);
CREATE INDEX idx_leads_deleted   ON public.leads(deleted_at);


-- ============================================================
-- PHẦN 6: BẢNG LEAD_TAGS_MAPPING (N-N)
-- ============================================================
CREATE TABLE public.lead_tags_mapping (
    lead_id UUID NOT NULL REFERENCES public.leads(id) ON DELETE CASCADE,
    tag_id  UUID NOT NULL REFERENCES public.lead_tags(id) ON DELETE CASCADE,
    PRIMARY KEY (lead_id, tag_id)
);


-- ============================================================
-- PHẦN 7: BẢNG LEAD_LISTS & LEAD_LIST_ITEMS
-- ============================================================
CREATE TABLE public.lead_lists (
    id          UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    owner_id    UUID         NOT NULL REFERENCES public.profiles(id),
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE TABLE public.lead_list_items (
    list_id    UUID        NOT NULL REFERENCES public.lead_lists(id) ON DELETE CASCADE,
    lead_id    UUID        NOT NULL REFERENCES public.leads(id) ON DELETE CASCADE,
    added_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (list_id, lead_id)
);

CREATE INDEX idx_lead_list_items_list ON public.lead_list_items(list_id);
CREATE INDEX idx_lead_list_items_lead ON public.lead_list_items(lead_id);


-- ============================================================
-- PHẦN 8: BẢNG TASKS (Công việc)
-- ============================================================
CREATE TABLE public.tasks (
    id           UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    title        VARCHAR(200) NOT NULL,
    description  TEXT,
    assignee_id  UUID         NOT NULL REFERENCES public.profiles(id),
    lead_id      UUID         REFERENCES public.leads(id) ON DELETE SET NULL,
    due_date     TIMESTAMPTZ  NOT NULL,
    priority     VARCHAR(10)  NOT NULL DEFAULT 'medium'
                              CHECK (priority IN ('low', 'medium', 'high')),
    status       VARCHAR(20)  NOT NULL DEFAULT 'pending'
                              CHECK (status IN ('pending', 'in_progress', 'done')),
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_by   UUID         NOT NULL REFERENCES public.profiles(id)
);

COMMENT ON COLUMN public.tasks.priority IS 'low | medium | high';
COMMENT ON COLUMN public.tasks.status   IS 'pending | in_progress | done';

CREATE INDEX idx_tasks_assignee_id ON public.tasks(assignee_id);
CREATE INDEX idx_tasks_lead_id     ON public.tasks(lead_id);
CREATE INDEX idx_tasks_due_date    ON public.tasks(due_date);
CREATE INDEX idx_tasks_status      ON public.tasks(status);


-- ============================================================
-- PHẦN 9: BẢNG SUBSCRIPTIONS / PAYMENTS (Hóa đơn)
-- ============================================================
CREATE TABLE public.invoices (
    id             UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_number VARCHAR(20)  UNIQUE NOT NULL,  -- INV-0001
    lead_id        UUID         NOT NULL REFERENCES public.leads(id) ON DELETE CASCADE,
    amount         BIGINT       NOT NULL CHECK (amount > 0),
    status         VARCHAR(20)  NOT NULL DEFAULT 'pending'
                                CHECK (status IN ('pending', 'paid', 'cancelled')),
    payment_date   DATE,
    notes          TEXT,
    created_at     TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_by     UUID         NOT NULL REFERENCES public.profiles(id)
);

COMMENT ON COLUMN public.invoices.amount IS 'Số tiền VND';
COMMENT ON COLUMN public.invoices.status IS 'pending | paid | cancelled';

CREATE INDEX idx_invoices_lead_id ON public.invoices(lead_id);
CREATE INDEX idx_invoices_status  ON public.invoices(status);

-- Sequence tự động tăng số hóa đơn
CREATE SEQUENCE IF NOT EXISTS invoice_seq START 1;


-- ============================================================
-- PHẦN 10: BẢNG ACTIVITY_LOGS (Audit)
-- ============================================================
CREATE TABLE public.activity_logs (
    id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id     UUID        NOT NULL REFERENCES public.profiles(id),
    action      VARCHAR(50) NOT NULL CHECK (action IN ('create','update','delete','move')),
    entity_type VARCHAR(50) NOT NULL,   -- 'lead', 'task', 'invoice', ...
    entity_id   UUID        NOT NULL,
    old_data    JSONB,
    new_data    JSONB,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_activity_logs_entity  ON public.activity_logs(entity_type, entity_id);
CREATE INDEX idx_activity_logs_user    ON public.activity_logs(user_id);
CREATE INDEX idx_activity_logs_created ON public.activity_logs(created_at DESC);


-- ============================================================
-- PHẦN 11: FUNCTIONS & TRIGGERS
-- ============================================================

-- 11.1 Auto-update updated_at
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER trg_leads_updated_at
    BEFORE UPDATE ON public.leads
    FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER trg_tasks_updated_at
    BEFORE UPDATE ON public.tasks
    FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER trg_invoices_updated_at
    BEFORE UPDATE ON public.invoices
    FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


-- 11.2 Tự động tạo profile khi user mới đăng ký (email/password hoặc Google)
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
    INSERT INTO public.profiles (id, email, full_name, avatar_url, role)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(
            NEW.raw_user_meta_data->>'full_name',
            NEW.raw_user_meta_data->>'name',
            split_part(NEW.email, '@', 1)
        ),
        NEW.raw_user_meta_data->>'avatar_url',
        'sales'
    )
    ON CONFLICT (id) DO UPDATE SET
        avatar_url = COALESCE(
            EXCLUDED.avatar_url,
            public.profiles.avatar_url
        ),
        updated_at = NOW();
    -- Ghi chú: ON CONFLICT DO UPDATE để merge Google OAuth với email/password
    RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


-- 11.3 Auto-generate invoice number: INV-0001, INV-0002, ...
CREATE OR REPLACE FUNCTION public.generate_invoice_number()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    NEW.invoice_number := 'INV-' || LPAD(nextval('invoice_seq')::TEXT, 4, '0');
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_invoice_number
    BEFORE INSERT ON public.invoices
    FOR EACH ROW
    WHEN (NEW.invoice_number IS NULL OR NEW.invoice_number = '')
    EXECUTE FUNCTION public.generate_invoice_number();


-- 11.4 Helper: lấy role của user hiện tại (tránh đệ quy RLS)
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS TEXT LANGUAGE sql STABLE SECURITY DEFINER AS $$
    SELECT role FROM public.profiles WHERE id = auth.uid();
$$;

-- 11.5 Helper: lấy danh sách team_id của user hiện tại
CREATE OR REPLACE FUNCTION public.get_my_team_ids()
RETURNS SETOF UUID LANGUAGE sql STABLE SECURITY DEFINER AS $$
    SELECT team_id FROM public.team_members WHERE user_id = auth.uid();
$$;

-- 11.6 Helper: lấy danh sách user_id cùng nhóm
CREATE OR REPLACE FUNCTION public.get_my_team_member_ids()
RETURNS SETOF UUID LANGUAGE sql STABLE SECURITY DEFINER AS $$
    SELECT user_id
    FROM public.team_members
    WHERE team_id IN (SELECT public.get_my_team_ids());
$$;


-- ============================================================
-- PHẦN 12: ROW LEVEL SECURITY (RLS)
-- ============================================================

-- Bật RLS cho tất cả bảng
ALTER TABLE public.profiles          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teams             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.team_members      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pipeline_stages   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_tags         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_tags_mapping ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.leads             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_lists        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_list_items   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tasks             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.invoices          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activity_logs     ENABLE ROW LEVEL SECURITY;


-- ---- PROFILES ----
CREATE POLICY "profiles_select_all"
    ON public.profiles FOR SELECT
    USING (true);   -- mọi user đã đăng nhập đều thấy danh sách nhân viên

CREATE POLICY "profiles_update_self"
    ON public.profiles FOR UPDATE
    USING (id = auth.uid());

CREATE POLICY "profiles_admin_all"
    ON public.profiles FOR ALL
    USING (public.get_my_role() = 'admin');


-- ---- TEAMS & TEAM_MEMBERS ----
CREATE POLICY "teams_select_all"
    ON public.teams FOR SELECT USING (true);

CREATE POLICY "teams_admin_all"
    ON public.teams FOR ALL
    USING (public.get_my_role() = 'admin');

CREATE POLICY "team_members_select_all"
    ON public.team_members FOR SELECT USING (true);

CREATE POLICY "team_members_admin_all"
    ON public.team_members FOR ALL
    USING (public.get_my_role() = 'admin');


-- ---- PIPELINE_STAGES (Dictionary — mọi người xem, admin quản lý) ----
CREATE POLICY "stages_select_all"
    ON public.pipeline_stages FOR SELECT USING (true);

CREATE POLICY "stages_admin_all"
    ON public.pipeline_stages FOR ALL
    USING (public.get_my_role() = 'admin');


-- ---- LEAD_TAGS (Dictionary) ----
CREATE POLICY "tags_select_all"
    ON public.lead_tags FOR SELECT USING (true);

CREATE POLICY "tags_admin_all"
    ON public.lead_tags FOR ALL
    USING (public.get_my_role() = 'admin');


-- ---- LEADS ----
-- Admin: toàn bộ
CREATE POLICY "leads_admin_all"
    ON public.leads FOR ALL
    USING (public.get_my_role() = 'admin');

-- Team Leader: xem lead trong nhóm
CREATE POLICY "leads_team_leader_select"
    ON public.leads FOR SELECT
    USING (
        public.get_my_role() = 'team_leader'
        AND owner_id IN (SELECT public.get_my_team_member_ids())
    );

-- Team Leader: sửa lead trong nhóm
CREATE POLICY "leads_team_leader_update"
    ON public.leads FOR UPDATE
    USING (
        public.get_my_role() = 'team_leader'
        AND owner_id IN (SELECT public.get_my_team_member_ids())
    );

-- Sales: chỉ lead của mình
CREATE POLICY "leads_sales_own"
    ON public.leads FOR ALL
    USING (
        public.get_my_role() = 'sales'
        AND (owner_id = auth.uid() OR created_by = auth.uid())
        AND deleted_at IS NULL
    );


-- ---- LEAD_TAGS_MAPPING ----
CREATE POLICY "lead_tags_mapping_select"
    ON public.lead_tags_mapping FOR SELECT USING (true);

CREATE POLICY "lead_tags_mapping_modify"
    ON public.lead_tags_mapping FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.leads l
            WHERE l.id = lead_tags_mapping.lead_id
            AND (
                l.owner_id = auth.uid()
                OR public.get_my_role() IN ('admin', 'team_leader')
            )
        )
    );


-- ---- LEAD_LISTS ----
CREATE POLICY "lead_lists_admin_all"
    ON public.lead_lists FOR ALL
    USING (public.get_my_role() = 'admin');

CREATE POLICY "lead_lists_own"
    ON public.lead_lists FOR ALL
    USING (owner_id = auth.uid());

CREATE POLICY "lead_lists_team_leader"
    ON public.lead_lists FOR SELECT
    USING (
        public.get_my_role() = 'team_leader'
        AND owner_id IN (SELECT public.get_my_team_member_ids())
    );


-- ---- LEAD_LIST_ITEMS ----
CREATE POLICY "lead_list_items_via_list"
    ON public.lead_list_items FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.lead_lists ll
            WHERE ll.id = lead_list_items.list_id
            AND (
                ll.owner_id = auth.uid()
                OR public.get_my_role() = 'admin'
            )
        )
    );


-- ---- TASKS ----
CREATE POLICY "tasks_admin_all"
    ON public.tasks FOR ALL
    USING (public.get_my_role() = 'admin');

CREATE POLICY "tasks_team_leader_select"
    ON public.tasks FOR SELECT
    USING (
        public.get_my_role() = 'team_leader'
        AND assignee_id IN (SELECT public.get_my_team_member_ids())
    );

CREATE POLICY "tasks_sales_own"
    ON public.tasks FOR ALL
    USING (
        assignee_id = auth.uid()
        OR created_by = auth.uid()
    );


-- ---- INVOICES ----
CREATE POLICY "invoices_admin_all"
    ON public.invoices FOR ALL
    USING (public.get_my_role() = 'admin');

CREATE POLICY "invoices_team_leader_select"
    ON public.invoices FOR SELECT
    USING (
        public.get_my_role() = 'team_leader'
        AND lead_id IN (
            SELECT id FROM public.leads
            WHERE owner_id IN (SELECT public.get_my_team_member_ids())
        )
    );

CREATE POLICY "invoices_sales_own"
    ON public.invoices FOR ALL
    USING (
        lead_id IN (
            SELECT id FROM public.leads
            WHERE owner_id = auth.uid()
        )
    );


-- ---- ACTIVITY_LOGS ----
CREATE POLICY "activity_logs_admin_all"
    ON public.activity_logs FOR SELECT
    USING (public.get_my_role() = 'admin');

CREATE POLICY "activity_logs_insert_authenticated"
    ON public.activity_logs FOR INSERT
    WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "activity_logs_own_select"
    ON public.activity_logs FOR SELECT
    USING (user_id = auth.uid());


-- ============================================================
-- PHẦN 13: VIEWS HỮU ÍCH (Dashboard queries)
-- ============================================================

-- View: Dashboard KPI
CREATE OR REPLACE VIEW public.v_dashboard_kpi AS
SELECT
    COUNT(*)                                              AS total_leads_this_month,
    COUNT(*) FILTER (WHERE stage_id = '11111111-1111-1111-1111-111111111111')
                                                          AS new_leads_this_week,
    COALESCE(SUM(i.amount) FILTER (WHERE i.status = 'paid'
        AND DATE_TRUNC('month', i.payment_date) = DATE_TRUNC('month', NOW())), 0)
                                                          AS revenue_this_month,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE l.stage_id = '44444444-4444-4444-4444-444444444444')
        / NULLIF(COUNT(*), 0), 1
    )                                                     AS conversion_rate
FROM public.leads l
LEFT JOIN public.invoices i ON i.lead_id = l.id
WHERE l.deleted_at IS NULL
  AND DATE_TRUNC('month', l.created_at) = DATE_TRUNC('month', NOW());


-- View: Hot Leads (deadline trong 3 ngày)
-- Ghi chú: leads.value dùng làm "deadline days remaining" trong prototype
-- Trong production, thêm cột deadline DATE vào bảng leads
CREATE OR REPLACE VIEW public.v_hot_leads AS
SELECT
    l.id,
    l.name,
    l.phone,
    l.value,
    l.stage_id,
    ps.name   AS stage_name,
    p.full_name AS owner_name,
    l.created_at
FROM public.leads l
JOIN public.pipeline_stages ps ON ps.id = l.stage_id
JOIN public.profiles p ON p.id = l.owner_id
WHERE l.deleted_at IS NULL
ORDER BY l.created_at DESC
LIMIT 10;


-- View: Revenue by Sales (for Bar Chart)
CREATE OR REPLACE VIEW public.v_revenue_by_sales AS
SELECT
    p.id          AS user_id,
    p.full_name,
    COALESCE(SUM(i.amount), 0) AS total_revenue
FROM public.profiles p
LEFT JOIN public.leads l  ON l.owner_id = p.id
LEFT JOIN public.invoices i ON i.lead_id = l.id
    AND i.status = 'paid'
    AND DATE_TRUNC('month', i.payment_date) = DATE_TRUNC('month', NOW())
WHERE p.is_active = true
GROUP BY p.id, p.full_name
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- PHẦN 14: SEED DATA MẪU (Chỉ dùng để test)
-- Xóa phần này trước khi go-live production
-- ============================================================

-- Lưu ý: profiles được tạo tự động qua trigger handle_new_user
-- Bạn cần tạo user qua Supabase Auth trước, sau đó update role
-- UPDATE public.profiles SET role = 'admin' WHERE email = 'admin@yensao.com';

-- Seed teams
INSERT INTO public.teams (id, name, description) VALUES
    ('aaaabbbb-0000-0000-0000-000000000001', 'Nhóm A', 'Nhóm kinh doanh khu vực 1'),
    ('aaaabbbb-0000-0000-0000-000000000002', 'Nhóm B', 'Nhóm kinh doanh khu vực 2')
ON CONFLICT DO NOTHING;


-- ============================================================
-- PHẦN 15: STORAGE BUCKETS (Chạy qua Supabase Dashboard hoặc API)
-- ============================================================
-- Chạy lệnh này trong Supabase SQL Editor:

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES
    ('avatars',      'avatars',      true,  2097152,  ARRAY['image/jpeg','image/png','image/webp']),
    ('csv-imports',  'csv-imports',  false, 10485760, ARRAY['text/csv','text/plain'])
ON CONFLICT (id) DO NOTHING;

-- Storage RLS cho bucket avatars (public read)
CREATE POLICY "avatars_public_read"
    ON storage.objects FOR SELECT
    USING (bucket_id = 'avatars');

CREATE POLICY "avatars_auth_upload"
    ON storage.objects FOR INSERT
    WITH CHECK (bucket_id = 'avatars' AND auth.uid() IS NOT NULL);

CREATE POLICY "avatars_own_update"
    ON storage.objects FOR UPDATE
    USING (bucket_id = 'avatars' AND auth.uid()::text = (storage.foldername(name))[1]);

-- Storage RLS cho bucket csv-imports (private)
CREATE POLICY "csv_own_access"
    ON storage.objects FOR ALL
    USING (bucket_id = 'csv-imports' AND auth.uid()::text = (storage.foldername(name))[1]);


-- ============================================================
-- PHẦN 16: KIỂM TRA SAU KHI CHẠY
-- ============================================================
-- Chạy các lệnh dưới để verify:

-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
-- SELECT * FROM public.pipeline_stages;
-- SELECT * FROM public.lead_tags;
-- SELECT schemaname, tablename, rowsecurity FROM pg_tables WHERE schemaname = 'public';
