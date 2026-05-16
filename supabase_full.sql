-- ============================================================
-- CRM YẾN SÀO VĨNH HƯNG — SUPABASE SQL FULL SCHEMA
-- Phiên bản: 2.0 (Idempotent — chạy nhiều lần không báo lỗi)
-- Ngày: 16/05/2026
-- ============================================================
-- HƯỚNG DẪN: Chạy toàn bộ file 1 lần trong Supabase SQL Editor
-- File này an toàn để chạy lại nếu cần reset hoặc cập nhật
-- ============================================================


-- ============================================================
-- PHẦN 0: EXTENSIONS
-- ============================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- ============================================================
-- PHẦN 1: XÓA BẢNG CŨ (nếu có) — Theo thứ tự phụ thuộc ngược
-- ============================================================
DROP TABLE IF EXISTS public.activity_logs      CASCADE;
DROP TABLE IF EXISTS public.invoices           CASCADE;
DROP TABLE IF EXISTS public.tasks              CASCADE;
DROP TABLE IF EXISTS public.lead_list_items    CASCADE;
DROP TABLE IF EXISTS public.lead_lists         CASCADE;
DROP TABLE IF EXISTS public.lead_tags_mapping  CASCADE;
DROP TABLE IF EXISTS public.leads              CASCADE;
DROP TABLE IF EXISTS public.lead_tags          CASCADE;
DROP TABLE IF EXISTS public.pipeline_stages    CASCADE;
DROP TABLE IF EXISTS public.team_members       CASCADE;
DROP TABLE IF EXISTS public.teams              CASCADE;
DROP TABLE IF EXISTS public.profiles           CASCADE;

-- Xóa sequence cũ nếu có
DROP SEQUENCE IF EXISTS invoice_seq;

-- Xóa views cũ nếu có
DROP VIEW IF EXISTS public.v_dashboard_kpi    CASCADE;
DROP VIEW IF EXISTS public.v_hot_leads        CASCADE;
DROP VIEW IF EXISTS public.v_revenue_by_sales CASCADE;

-- Xóa functions cũ nếu có
DROP FUNCTION IF EXISTS public.set_updated_at()         CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user()        CASCADE;
DROP FUNCTION IF EXISTS public.generate_invoice_number() CASCADE;
DROP FUNCTION IF EXISTS public.get_my_role()            CASCADE;
DROP FUNCTION IF EXISTS public.get_my_team_ids()        CASCADE;
DROP FUNCTION IF EXISTS public.get_my_team_member_ids() CASCADE;

-- Xóa trigger cũ trên auth.users
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;


-- ============================================================
-- PHẦN 2: BẢNG PROFILES (1-1 với auth.users)
-- ============================================================
CREATE TABLE public.profiles (
    id          UUID         PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email       VARCHAR(255) UNIQUE NOT NULL,
    full_name   VARCHAR(100) NOT NULL,
    avatar_url  TEXT,
    role        VARCHAR(20)  NOT NULL DEFAULT 'sales'
                             CHECK (role IN ('admin', 'team_leader', 'sales')),
    phone       VARCHAR(20),
    is_active   BOOLEAN      NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE  public.profiles      IS 'Hồ sơ người dùng, 1-1 với auth.users';
COMMENT ON COLUMN public.profiles.role IS 'admin | team_leader | sales';

CREATE INDEX idx_profiles_role      ON public.profiles(role);
CREATE INDEX idx_profiles_is_active ON public.profiles(is_active);


-- ============================================================
-- PHẦN 3: BẢNG TEAMS & TEAM_MEMBERS
-- ============================================================
CREATE TABLE public.teams (
    id          UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE TABLE public.team_members (
    id        UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id   UUID        NOT NULL REFERENCES public.teams(id)    ON DELETE CASCADE,
    user_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (team_id, user_id)
);

CREATE INDEX idx_team_members_team ON public.team_members(team_id);
CREATE INDEX idx_team_members_user ON public.team_members(user_id);


-- ============================================================
-- PHẦN 4: BẢNG PIPELINE_STAGES + SEED DATA
-- ============================================================
CREATE TABLE public.pipeline_stages (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name       VARCHAR(50) NOT NULL,
    sort_order INTEGER     NOT NULL,
    color      VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO public.pipeline_stages (id, name, sort_order, color) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Mới',      1, '#5A7D9A'),
    ('22222222-2222-2222-2222-222222222222', 'Liên hệ',  2, '#D4A574'),
    ('33333333-3333-3333-3333-333333333333', 'Đề xuất',  3, '#C95A5A'),
    ('44444444-4444-4444-4444-444444444444', 'Chốt đơn', 4, '#5A8F5A');


-- ============================================================
-- PHẦN 5: BẢNG LEAD_TAGS + SEED DATA
-- ============================================================
CREATE TABLE public.lead_tags (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name       VARCHAR(50) NOT NULL,
    tag_type   VARCHAR(20) NOT NULL CHECK (tag_type IN ('segment', 'product', 'general')),
    color      VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO public.lead_tags (id, name, tag_type, color) VALUES
    ('55555555-5555-5555-5555-555555555555', 'Khách lẻ',     'segment', '#E8F4F8'),
    ('66666666-6666-6666-6666-666666666666', 'Đại lý',       'segment', '#FFF8E8'),
    ('77777777-7777-7777-7777-777777777777', 'VIP',          'segment', '#FFF5F5'),
    ('88888888-8888-8888-8888-888888888888', 'Yến thô',      'product', '#F0F0F0'),
    ('99999999-9999-9999-9999-999999999999', 'Yến chưng',    'product', '#F5F0E8'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Yến tinh chế', 'product', '#E8F0E8');


-- ============================================================
-- PHẦN 6: BẢNG LEADS (Khách hàng / Cơ hội)
-- ============================================================
CREATE TABLE public.leads (
    id          UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(100) NOT NULL,
    phone       VARCHAR(20)  UNIQUE,
    email       VARCHAR(255),
    value       BIGINT       NOT NULL DEFAULT 0,
    stage_id    UUID         REFERENCES public.pipeline_stages(id) ON DELETE SET NULL,
    owner_id    UUID         NOT NULL REFERENCES public.profiles(id),
    notes       TEXT,
    deleted_at  TIMESTAMPTZ,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_by  UUID         NOT NULL REFERENCES public.profiles(id)
);

COMMENT ON COLUMN public.leads.deleted_at IS 'NULL = active, NOT NULL = soft deleted';
COMMENT ON COLUMN public.leads.value      IS 'Giá trị cơ hội (VND)';

CREATE INDEX idx_leads_owner   ON public.leads(owner_id);
CREATE INDEX idx_leads_stage   ON public.leads(stage_id);
CREATE INDEX idx_leads_phone   ON public.leads(phone);
CREATE INDEX idx_leads_deleted ON public.leads(deleted_at);


-- ============================================================
-- PHẦN 7: BẢNG LEAD_TAGS_MAPPING (N-N)
-- ============================================================
CREATE TABLE public.lead_tags_mapping (
    lead_id UUID NOT NULL REFERENCES public.leads(id)     ON DELETE CASCADE,
    tag_id  UUID NOT NULL REFERENCES public.lead_tags(id) ON DELETE CASCADE,
    PRIMARY KEY (lead_id, tag_id)
);


-- ============================================================
-- PHẦN 8: BẢNG LEAD_LISTS & LEAD_LIST_ITEMS
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
    list_id  UUID        NOT NULL REFERENCES public.lead_lists(id) ON DELETE CASCADE,
    lead_id  UUID        NOT NULL REFERENCES public.leads(id)      ON DELETE CASCADE,
    added_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (list_id, lead_id)
);

CREATE INDEX idx_list_items_list ON public.lead_list_items(list_id);
CREATE INDEX idx_list_items_lead ON public.lead_list_items(lead_id);


-- ============================================================
-- PHẦN 9: BẢNG TASKS (Công việc)
-- ============================================================
CREATE TABLE public.tasks (
    id          UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    title       VARCHAR(200) NOT NULL,
    description TEXT,
    assignee_id UUID         NOT NULL REFERENCES public.profiles(id),
    lead_id     UUID         REFERENCES public.leads(id) ON DELETE SET NULL,
    due_date    TIMESTAMPTZ  NOT NULL,
    priority    VARCHAR(10)  NOT NULL DEFAULT 'medium'
                             CHECK (priority IN ('low', 'medium', 'high')),
    status      VARCHAR(20)  NOT NULL DEFAULT 'pending'
                             CHECK (status IN ('pending', 'in_progress', 'done')),
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_by  UUID         NOT NULL REFERENCES public.profiles(id)
);

CREATE INDEX idx_tasks_assignee ON public.tasks(assignee_id);
CREATE INDEX idx_tasks_lead     ON public.tasks(lead_id);
CREATE INDEX idx_tasks_due_date ON public.tasks(due_date);
CREATE INDEX idx_tasks_status   ON public.tasks(status);


-- ============================================================
-- PHẦN 10: BẢNG INVOICES (Hóa đơn thanh toán)
-- ============================================================
CREATE SEQUENCE invoice_seq START 1;

CREATE TABLE public.invoices (
    id             UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_number VARCHAR(20)  UNIQUE NOT NULL DEFAULT '',
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

CREATE INDEX idx_invoices_lead   ON public.invoices(lead_id);
CREATE INDEX idx_invoices_status ON public.invoices(status);


-- ============================================================
-- PHẦN 11: BẢNG ACTIVITY_LOGS (Audit Trail)
-- ============================================================
CREATE TABLE public.activity_logs (
    id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id     UUID        NOT NULL REFERENCES public.profiles(id),
    action      VARCHAR(50) NOT NULL CHECK (action IN ('create','update','delete','move')),
    entity_type VARCHAR(50) NOT NULL,
    entity_id   UUID        NOT NULL,
    old_data    JSONB,
    new_data    JSONB,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_logs_entity  ON public.activity_logs(entity_type, entity_id);
CREATE INDEX idx_logs_user    ON public.activity_logs(user_id);
CREATE INDEX idx_logs_created ON public.activity_logs(created_at DESC);


-- ============================================================
-- PHẦN 12: FUNCTIONS & TRIGGERS
-- ============================================================

-- 12.1 Auto set updated_at
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_profiles_upd  BEFORE UPDATE ON public.profiles  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER trg_teams_upd     BEFORE UPDATE ON public.teams      FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER trg_leads_upd     BEFORE UPDATE ON public.leads      FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER trg_tasks_upd     BEFORE UPDATE ON public.tasks      FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER trg_invoices_upd  BEFORE UPDATE ON public.invoices   FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER trg_lists_upd     BEFORE UPDATE ON public.lead_lists FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


-- 12.2 Tự động tạo profile khi user mới đăng ký (email/password hoặc Google OAuth)
-- ON CONFLICT DO UPDATE để merge identity (Google + email/password cùng email)
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
        avatar_url = COALESCE(EXCLUDED.avatar_url, public.profiles.avatar_url),
        updated_at = NOW();
    RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


-- 12.3 Auto generate invoice number: INV-0001, INV-0002, ...
CREATE OR REPLACE FUNCTION public.generate_invoice_number()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.invoice_number = '' OR NEW.invoice_number IS NULL THEN
        NEW.invoice_number := 'INV-' || LPAD(nextval('invoice_seq')::TEXT, 4, '0');
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_invoice_number
    BEFORE INSERT ON public.invoices
    FOR EACH ROW EXECUTE FUNCTION public.generate_invoice_number();


-- 12.4 Helper functions (dùng trong RLS, tránh đệ quy)
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS TEXT LANGUAGE sql STABLE SECURITY DEFINER AS $$
    SELECT role FROM public.profiles WHERE id = auth.uid();
$$;

CREATE OR REPLACE FUNCTION public.get_my_team_ids()
RETURNS SETOF UUID LANGUAGE sql STABLE SECURITY DEFINER AS $$
    SELECT team_id FROM public.team_members WHERE user_id = auth.uid();
$$;

CREATE OR REPLACE FUNCTION public.get_my_team_member_ids()
RETURNS SETOF UUID LANGUAGE sql STABLE SECURITY DEFINER AS $$
    SELECT user_id FROM public.team_members
    WHERE team_id IN (SELECT public.get_my_team_ids());
$$;


-- ============================================================
-- PHẦN 13: BẬT ROW LEVEL SECURITY
-- ============================================================
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


-- ============================================================
-- PHẦN 14: RLS POLICIES
-- ============================================================

-- ── PROFILES ──
CREATE POLICY "p_profiles_select"      ON public.profiles FOR SELECT USING (true);
CREATE POLICY "p_profiles_update_self" ON public.profiles FOR UPDATE USING (id = auth.uid());
CREATE POLICY "p_profiles_admin"       ON public.profiles FOR ALL    USING (public.get_my_role() = 'admin');

-- ── TEAMS ──
CREATE POLICY "p_teams_select" ON public.teams FOR SELECT USING (true);
CREATE POLICY "p_teams_admin"  ON public.teams FOR ALL    USING (public.get_my_role() = 'admin');

-- ── TEAM_MEMBERS ──
CREATE POLICY "p_team_members_select" ON public.team_members FOR SELECT USING (true);
CREATE POLICY "p_team_members_admin"  ON public.team_members FOR ALL    USING (public.get_my_role() = 'admin');

-- ── PIPELINE_STAGES (dictionary) ──
CREATE POLICY "p_stages_select" ON public.pipeline_stages FOR SELECT USING (true);
CREATE POLICY "p_stages_admin"  ON public.pipeline_stages FOR ALL    USING (public.get_my_role() = 'admin');

-- ── LEAD_TAGS (dictionary) ──
CREATE POLICY "p_tags_select" ON public.lead_tags FOR SELECT USING (true);
CREATE POLICY "p_tags_admin"  ON public.lead_tags FOR ALL    USING (public.get_my_role() = 'admin');

-- ── LEADS ──
CREATE POLICY "p_leads_admin"
    ON public.leads FOR ALL
    USING (public.get_my_role() = 'admin');

CREATE POLICY "p_leads_team_leader_select"
    ON public.leads FOR SELECT
    USING (
        public.get_my_role() = 'team_leader'
        AND owner_id IN (SELECT public.get_my_team_member_ids())
    );

CREATE POLICY "p_leads_team_leader_update"
    ON public.leads FOR UPDATE
    USING (
        public.get_my_role() = 'team_leader'
        AND owner_id IN (SELECT public.get_my_team_member_ids())
    );

CREATE POLICY "p_leads_sales"
    ON public.leads FOR ALL
    USING (
        public.get_my_role() = 'sales'
        AND (owner_id = auth.uid() OR created_by = auth.uid())
    );

-- ── LEAD_TAGS_MAPPING ──
CREATE POLICY "p_ltm_select" ON public.lead_tags_mapping FOR SELECT USING (true);
CREATE POLICY "p_ltm_modify"
    ON public.lead_tags_mapping FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.leads l
            WHERE l.id = lead_tags_mapping.lead_id
            AND (l.owner_id = auth.uid() OR public.get_my_role() IN ('admin','team_leader'))
        )
    );

-- ── LEAD_LISTS ──
CREATE POLICY "p_lists_admin"  ON public.lead_lists FOR ALL    USING (public.get_my_role() = 'admin');
CREATE POLICY "p_lists_own"    ON public.lead_lists FOR ALL    USING (owner_id = auth.uid());
CREATE POLICY "p_lists_leader" ON public.lead_lists FOR SELECT
    USING (
        public.get_my_role() = 'team_leader'
        AND owner_id IN (SELECT public.get_my_team_member_ids())
    );

-- ── LEAD_LIST_ITEMS ──
CREATE POLICY "p_list_items"
    ON public.lead_list_items FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.lead_lists ll
            WHERE ll.id = lead_list_items.list_id
            AND (ll.owner_id = auth.uid() OR public.get_my_role() = 'admin')
        )
    );

-- ── TASKS ──
CREATE POLICY "p_tasks_admin"
    ON public.tasks FOR ALL
    USING (public.get_my_role() = 'admin');

CREATE POLICY "p_tasks_leader"
    ON public.tasks FOR SELECT
    USING (
        public.get_my_role() = 'team_leader'
        AND assignee_id IN (SELECT public.get_my_team_member_ids())
    );

CREATE POLICY "p_tasks_sales"
    ON public.tasks FOR ALL
    USING (assignee_id = auth.uid() OR created_by = auth.uid());

-- ── INVOICES ──
CREATE POLICY "p_invoices_admin"
    ON public.invoices FOR ALL
    USING (public.get_my_role() = 'admin');

CREATE POLICY "p_invoices_leader"
    ON public.invoices FOR SELECT
    USING (
        public.get_my_role() = 'team_leader'
        AND lead_id IN (
            SELECT id FROM public.leads
            WHERE owner_id IN (SELECT public.get_my_team_member_ids())
        )
    );

CREATE POLICY "p_invoices_sales"
    ON public.invoices FOR ALL
    USING (
        lead_id IN (
            SELECT id FROM public.leads WHERE owner_id = auth.uid()
        )
    );

-- ── ACTIVITY_LOGS ──
CREATE POLICY "p_logs_admin"
    ON public.activity_logs FOR SELECT
    USING (public.get_my_role() = 'admin');

CREATE POLICY "p_logs_insert"
    ON public.activity_logs FOR INSERT
    WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "p_logs_own"
    ON public.activity_logs FOR SELECT
    USING (user_id = auth.uid());


-- ============================================================
-- PHẦN 15: VIEWS (Dashboard)
-- ============================================================

CREATE OR REPLACE VIEW public.v_hot_leads AS
SELECT
    l.id, l.name, l.phone, l.value,
    ps.name     AS stage_name,
    ps.color    AS stage_color,
    p.full_name AS owner_name,
    p.avatar_url AS owner_avatar,
    l.created_at
FROM public.leads l
JOIN public.pipeline_stages ps ON ps.id = l.stage_id
JOIN public.profiles p         ON p.id  = l.owner_id
WHERE l.deleted_at IS NULL
ORDER BY l.created_at DESC
LIMIT 10;

CREATE OR REPLACE VIEW public.v_revenue_by_sales AS
SELECT
    p.id           AS user_id,
    p.full_name,
    p.avatar_url,
    COALESCE(SUM(i.amount) FILTER (
        WHERE i.status = 'paid'
        AND DATE_TRUNC('month', i.created_at) = DATE_TRUNC('month', NOW())
    ), 0)          AS revenue_this_month,
    COUNT(DISTINCT l.id) AS total_leads
FROM public.profiles p
LEFT JOIN public.leads    l ON l.owner_id = p.id AND l.deleted_at IS NULL
LEFT JOIN public.invoices i ON i.lead_id  = l.id
WHERE p.is_active = true AND p.role = 'sales'
GROUP BY p.id, p.full_name, p.avatar_url
ORDER BY revenue_this_month DESC
LIMIT 10;

CREATE OR REPLACE VIEW public.v_overdue_tasks AS
SELECT
    t.id, t.title, t.due_date, t.priority, t.status,
    p.full_name AS assignee_name,
    l.name      AS lead_name
FROM public.tasks t
JOIN public.profiles p ON p.id = t.assignee_id
LEFT JOIN public.leads l ON l.id = t.lead_id
WHERE t.status != 'done'
  AND t.due_date < NOW()
ORDER BY t.due_date ASC;


-- ============================================================
-- PHẦN 16: SEED DATA MẪU (Teams)
-- ============================================================
INSERT INTO public.teams (id, name, description) VALUES
    ('aaaabbbb-0000-0000-0000-000000000001', 'Nhóm A', 'Kinh doanh khu vực 1'),
    ('aaaabbbb-0000-0000-0000-000000000002', 'Nhóm B', 'Kinh doanh khu vực 2'),
    ('aaaabbbb-0000-0000-0000-000000000003', 'Nhóm C', 'Kinh doanh khu vực 3')
ON CONFLICT DO NOTHING;


-- ============================================================
-- PHẦN 17: STORAGE BUCKETS
-- ============================================================
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES
    ('avatars',     'avatars',     true,  2097152,  ARRAY['image/jpeg','image/png','image/webp']),
    ('csv-imports', 'csv-imports', false, 10485760, ARRAY['text/csv','text/plain'])
ON CONFLICT (id) DO NOTHING;

-- Storage RLS
CREATE POLICY "s_avatars_read"
    ON storage.objects FOR SELECT USING (bucket_id = 'avatars');

CREATE POLICY "s_avatars_upload"
    ON storage.objects FOR INSERT
    WITH CHECK (bucket_id = 'avatars' AND auth.uid() IS NOT NULL);

CREATE POLICY "s_csv_own"
    ON storage.objects FOR ALL
    USING (
        bucket_id = 'csv-imports'
        AND auth.uid()::text = (storage.foldername(name))[1]
    );


-- ============================================================
-- PHẦN 18: KIỂM TRA KẾT QUẢ
-- ============================================================
-- Sau khi chạy xong, bỏ comment các dòng dưới để verify:

-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' ORDER BY 1;
-- SELECT * FROM public.pipeline_stages ORDER BY sort_order;
-- SELECT * FROM public.lead_tags ORDER BY tag_type, name;
-- SELECT tablename, rowsecurity FROM pg_tables WHERE schemaname = 'public';

-- ============================================================
-- SAU KHI GO-LIVE: Set Admin đầu tiên
-- ============================================================
-- Tạo user qua Supabase Auth Dashboard, sau đó chạy:
-- UPDATE public.profiles SET role = 'admin' WHERE email = 'admin@yensao.com';
