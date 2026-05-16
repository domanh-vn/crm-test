-- Kích hoạt extension pgcrypto để tạo UUID tự động
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==========================================
-- 1. TẠO CÁC BẢNG (TABLES)
-- ==========================================

-- Bảng profiles (1-1 với auth.users)
CREATE TABLE public.profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    avatar_url TEXT,
    role VARCHAR(20) NOT NULL DEFAULT 'sales' CHECK (role IN ('admin', 'team_leader', 'sales')),
    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bảng teams
CREATE TABLE public.teams (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bảng team_members (N-N)
CREATE TABLE public.team_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id UUID REFERENCES public.teams(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(team_id, user_id)
);

-- Bảng pipeline_stages
CREATE TABLE public.pipeline_stages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) NOT NULL,
    "order" INTEGER NOT NULL,
    color VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bảng leads (Khách hàng / Cơ hội)
CREATE TABLE public.leads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255),
    value INTEGER DEFAULT 0,
    stage_id UUID REFERENCES public.pipeline_stages(id),
    owner_id UUID REFERENCES public.profiles(id),
    notes TEXT,
    deleted_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by UUID REFERENCES public.profiles(id)
);

-- Bảng lead_tags
CREATE TABLE public.lead_tags (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('segment', 'product', 'general')),
    color VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bảng lead_tags_mapping (N-N giữa leads và tags)
CREATE TABLE public.lead_tags_mapping (
    lead_id UUID REFERENCES public.leads(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES public.lead_tags(id) ON DELETE CASCADE,
    PRIMARY KEY (lead_id, tag_id)
);

-- Bảng lead_lists
CREATE TABLE public.lead_lists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    owner_id UUID REFERENCES public.profiles(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bảng tasks
CREATE TABLE public.tasks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    assignee_id UUID REFERENCES public.profiles(id),
    lead_id UUID REFERENCES public.leads(id) ON DELETE CASCADE,
    due_date TIMESTAMP WITH TIME ZONE NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'done')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by UUID REFERENCES public.profiles(id)
);

-- Bảng subscriptions
CREATE TABLE public.subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    lead_id UUID REFERENCES public.leads(id) ON DELETE CASCADE,
    plan_name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'cancelled', 'expired')),
    amount INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bảng activity_logs
CREATE TABLE public.activity_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(id),
    action VARCHAR(50) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id UUID NOT NULL,
    details JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);


-- ==========================================
-- 2. TẠO INDEXES TỐI ƯU TRUY VẤN
-- ==========================================
CREATE INDEX idx_profiles_role ON public.profiles(role);
CREATE INDEX idx_team_members_user_id ON public.team_members(user_id);
CREATE INDEX idx_leads_owner_id ON public.leads(owner_id);
CREATE INDEX idx_leads_stage_id ON public.leads(stage_id);
CREATE INDEX idx_leads_phone ON public.leads(phone);
CREATE INDEX idx_tasks_assignee_id ON public.tasks(assignee_id);
CREATE INDEX idx_tasks_due_date ON public.tasks(due_date);
CREATE INDEX idx_activity_logs_entity ON public.activity_logs(entity_type, entity_id);


-- ==========================================
-- 3. CHỨC NĂNG TỰ ĐỘNG TẠO PROFILE (TRIGGER)
-- ==========================================
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, avatar_url, role)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name', split_part(new.email, '@', 1)), 
    new.raw_user_meta_data->>'avatar_url',
    'sales' 
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger thực thi sau khi tạo user trong auth.users
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();


-- ==========================================
-- 4. ROW LEVEL SECURITY (RLS) POLICIES
-- ==========================================

-- Helper Functions lấy thông tin quyền để tránh đệ quy RLS
CREATE OR REPLACE FUNCTION public.get_current_user_role()
RETURNS VARCHAR AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.get_current_user_teams()
RETURNS SETOF UUID AS $$
  SELECT team_id FROM public.team_members WHERE user_id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- BẬT RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.team_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pipeline_stages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.leads ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activity_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_tags_mapping ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_lists ENABLE ROW LEVEL SECURITY;

-- 1. PROFILES
CREATE POLICY "Users can view all profiles" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (id = auth.uid());
CREATE POLICY "Admin can update all profiles" ON public.profiles FOR UPDATE USING (public.get_current_user_role() = 'admin');

-- 2. LEADS
CREATE POLICY "Admin sees all leads" ON public.leads FOR ALL USING (public.get_current_user_role() = 'admin');
CREATE POLICY "Sales sees own leads" ON public.leads FOR ALL USING (owner_id = auth.uid() OR created_by = auth.uid());
CREATE POLICY "Team leader sees team leads" ON public.leads FOR SELECT USING (
  public.get_current_user_role() = 'team_leader' AND 
  owner_id IN (
    SELECT user_id FROM public.team_members WHERE team_id IN (SELECT public.get_current_user_teams())
  )
);

-- 3. TASKS
CREATE POLICY "Admin sees all tasks" ON public.tasks FOR ALL USING (public.get_current_user_role() = 'admin');
CREATE POLICY "Users see own tasks" ON public.tasks FOR ALL USING (assignee_id = auth.uid() OR created_by = auth.uid());
CREATE POLICY "Team leader sees team tasks" ON public.tasks FOR SELECT USING (
  public.get_current_user_role() = 'team_leader' AND 
  assignee_id IN (
    SELECT user_id FROM public.team_members WHERE team_id IN (SELECT public.get_current_user_teams())
  )
);

-- Các bảng Dictionary (Stages, Tags)
CREATE POLICY "All can view stages" ON public.pipeline_stages FOR SELECT USING (true);
CREATE POLICY "Admin manages stages" ON public.pipeline_stages FOR ALL USING (public.get_current_user_role() = 'admin');

CREATE POLICY "All can view tags" ON public.lead_tags FOR SELECT USING (true);
CREATE POLICY "Admin manages tags" ON public.lead_tags FOR ALL USING (public.get_current_user_role() = 'admin');

CREATE POLICY "All can view tags mapping" ON public.lead_tags_mapping FOR SELECT USING (true);
CREATE POLICY "Users manage own lead tags" ON public.lead_tags_mapping FOR ALL USING (
  EXISTS (
    SELECT 1 FROM public.leads 
    WHERE id = lead_tags_mapping.lead_id 
    AND (owner_id = auth.uid() OR public.get_current_user_role() = 'admin')
  )
);


-- ==========================================
-- 5. SEED DATA MẪU
-- ==========================================

-- Insert Pipeline Stages
INSERT INTO public.pipeline_stages (id, name, "order", color) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Mới', 1, '#5A7D9A'),
  ('22222222-2222-2222-2222-222222222222', 'Liên hệ', 2, '#D4A574'),
  ('33333333-3333-3333-3333-333333333333', 'Đề xuất', 3, '#C95A5A'),
  ('44444444-4444-4444-4444-444444444444', 'Chốt đơn', 4, '#5A8F5A')
ON CONFLICT DO NOTHING;

-- Insert Lead Tags (Phân khúc & Sản phẩm)
INSERT INTO public.lead_tags (id, name, type, color) VALUES
  ('55555555-5555-5555-5555-555555555555', 'Khách lẻ', 'segment', '#E8F4F8'),
  ('66666666-6666-6666-6666-666666666666', 'Đại lý', 'segment', '#FFF8E8'),
  ('77777777-7777-7777-7777-777777777777', 'VIP', 'segment', '#FFF5F5'),
  ('88888888-8888-8888-8888-888888888888', 'Yến thô', 'product', '#DDDDDD'),
  ('99999999-9999-9999-9999-999999999999', 'Yến chưng', 'product', '#EEEEEE')
ON CONFLICT DO NOTHING;
