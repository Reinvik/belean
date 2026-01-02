-- COMPREHENSIVE RLS FIX FOR ALL MODULES
-- Usage: Run this in Supabase SQL Editor

-- Helper macro-like logic: We will drop and recreate permissive policies for all tables

-- ==========================================
-- 1. A3 PROJECTS
-- ==========================================
ALTER TABLE public.a3_projects ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow All Authenticated Select A3" ON public.a3_projects;
CREATE POLICY "Allow All Authenticated Select A3" ON public.a3_projects FOR SELECT USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Insert A3" ON public.a3_projects;
CREATE POLICY "Allow All Authenticated Insert A3" ON public.a3_projects FOR INSERT WITH CHECK ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Update A3" ON public.a3_projects;
CREATE POLICY "Allow All Authenticated Update A3" ON public.a3_projects FOR UPDATE USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Delete A3" ON public.a3_projects;
CREATE POLICY "Allow All Authenticated Delete A3" ON public.a3_projects FOR DELETE USING ( auth.role() = 'authenticated' );


-- ==========================================
-- 2. QUICK WINS
-- ==========================================
ALTER TABLE public.quick_wins ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow All Authenticated Select QW" ON public.quick_wins;
CREATE POLICY "Allow All Authenticated Select QW" ON public.quick_wins FOR SELECT USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Insert QW" ON public.quick_wins;
CREATE POLICY "Allow All Authenticated Insert QW" ON public.quick_wins FOR INSERT WITH CHECK ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Update QW" ON public.quick_wins;
CREATE POLICY "Allow All Authenticated Update QW" ON public.quick_wins FOR UPDATE USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Delete QW" ON public.quick_wins;
CREATE POLICY "Allow All Authenticated Delete QW" ON public.quick_wins FOR DELETE USING ( auth.role() = 'authenticated' );


-- ==========================================
-- 3. VSM PROJECTS
-- ==========================================
ALTER TABLE public.vsm_projects ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow All Authenticated Select VSM" ON public.vsm_projects;
CREATE POLICY "Allow All Authenticated Select VSM" ON public.vsm_projects FOR SELECT USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Insert VSM" ON public.vsm_projects;
CREATE POLICY "Allow All Authenticated Insert VSM" ON public.vsm_projects FOR INSERT WITH CHECK ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Update VSM" ON public.vsm_projects;
CREATE POLICY "Allow All Authenticated Update VSM" ON public.vsm_projects FOR UPDATE USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Delete VSM" ON public.vsm_projects;
CREATE POLICY "Allow All Authenticated Delete VSM" ON public.vsm_projects FOR DELETE USING ( auth.role() = 'authenticated' );


-- ==========================================
-- 4. 5S AUDITS (Headers and Entries)
-- ==========================================
ALTER TABLE public.audit_5s ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_5s_entries ENABLE ROW LEVEL SECURITY;

-- Headers
DROP POLICY IF EXISTS "Allow All Authenticated Select Audit" ON public.audit_5s;
CREATE POLICY "Allow All Authenticated Select Audit" ON public.audit_5s FOR SELECT USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Insert Audit" ON public.audit_5s;
CREATE POLICY "Allow All Authenticated Insert Audit" ON public.audit_5s FOR INSERT WITH CHECK ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Update Audit" ON public.audit_5s;
CREATE POLICY "Allow All Authenticated Update Audit" ON public.audit_5s FOR UPDATE USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Delete Audit" ON public.audit_5s;
CREATE POLICY "Allow All Authenticated Delete Audit" ON public.audit_5s FOR DELETE USING ( auth.role() = 'authenticated' );

-- Entries
DROP POLICY IF EXISTS "Allow All Authenticated Select AuditEntries" ON public.audit_5s_entries;
CREATE POLICY "Allow All Authenticated Select AuditEntries" ON public.audit_5s_entries FOR SELECT USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Insert AuditEntries" ON public.audit_5s_entries;
CREATE POLICY "Allow All Authenticated Insert AuditEntries" ON public.audit_5s_entries FOR INSERT WITH CHECK ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Update AuditEntries" ON public.audit_5s_entries;
CREATE POLICY "Allow All Authenticated Update AuditEntries" ON public.audit_5s_entries FOR UPDATE USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Delete AuditEntries" ON public.audit_5s_entries;
CREATE POLICY "Allow All Authenticated Delete AuditEntries" ON public.audit_5s_entries FOR DELETE USING ( auth.role() = 'authenticated' );
