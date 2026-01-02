-- ==============================================================================
-- SCRIPT DE CORRECCIÓN DE POLÍTICAS DE SEGURIDAD (RLS)
-- Objetivo: Permitir que Superadmins vean TODO y Admins vean su EMPRESA.
-- ==============================================================================

-- 1. FUNCIONES AUXILIARES SEGURAS
-- ------------------------------------------------------------------------------

-- Función para verificar si es Super Admin (Global)
CREATE OR REPLACE FUNCTION public.is_super_admin()
RETURNS BOOLEAN AS $$
BEGIN
  -- Revisa si el usuario actual tiene el rol 'superadmin' en la tabla profiles
  RETURN EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'superadmin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para verificar si es Company Admin (Local)
CREATE OR REPLACE FUNCTION public.is_company_admin()
RETURNS BOOLEAN AS $$
BEGIN
  -- Revisa si el usuario actual tiene el rol 'admin' en la tabla profiles
  RETURN EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función helper para obtener el Company ID del usuario actual
CREATE OR REPLACE FUNCTION public.get_my_company_id()
RETURNS UUID AS $$
BEGIN
  RETURN (SELECT company_id FROM public.profiles WHERE id = auth.uid());
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 2. CORRECCIÓN DE POLÍTICAS POR TABLA
-- ------------------------------------------------------------------------------

-- A. PROFILES (Perfiles de Usuario)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Ver perfiles" ON public.profiles;
DROP POLICY IF EXISTS "profiles_select_policy" ON public.profiles;

CREATE POLICY "profiles_select_policy" ON public.profiles
  FOR SELECT TO authenticated
  USING (
    -- Usuario ve su propio perfil
    auth.uid() = id
    -- Superadmin ve todo
    OR public.is_super_admin()
    -- Admin ve usuarios de su misma empresa
    OR (public.is_company_admin() AND company_id = public.get_my_company_id())
  );

DROP POLICY IF EXISTS "Actualizar perfiles" ON public.profiles;
DROP POLICY IF EXISTS "profiles_update_policy" ON public.profiles;

CREATE POLICY "profiles_update_policy" ON public.profiles
  FOR UPDATE TO authenticated
  USING (
    -- Usuario edita su propio perfil (limitado por UI)
    auth.uid() = id
    -- Superadmin edita cualquiera
    OR public.is_super_admin()
    -- Admin edita usuarios de su empresa
    OR (public.is_company_admin() AND company_id = public.get_my_company_id())
  );


-- B. AUDITORÍA 5S (audit_5s)
ALTER TABLE public.audit_5s ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view audit_5s of their company" ON public.audit_5s;
DROP POLICY IF EXISTS "audit_5s_select_policy" ON public.audit_5s;

CREATE POLICY "audit_5s_select_policy" ON public.audit_5s
  FOR SELECT TO authenticated
  USING (
    -- Ve si pertenece a su empresa
    company_id = public.get_my_company_id()
    -- O si es Superadmin (ve todo, ignora company_id)
    OR public.is_super_admin()
  );

DROP POLICY IF EXISTS "Users can insert audit_5s for their company" ON public.audit_5s;
DROP POLICY IF EXISTS "audit_5s_insert_policy" ON public.audit_5s;

CREATE POLICY "audit_5s_insert_policy" ON public.audit_5s
  FOR INSERT TO authenticated
  WITH CHECK (
    -- Inserta en su empresa
    company_id = public.get_my_company_id()
    -- O es Superadmin
    OR public.is_super_admin()
  );

DROP POLICY IF EXISTS "Users can update audit_5s for their company" ON public.audit_5s;
DROP POLICY IF EXISTS "audit_5s_update_policy" ON public.audit_5s;

CREATE POLICY "audit_5s_update_policy" ON public.audit_5s
  FOR UPDATE TO authenticated
  USING (
    company_id = public.get_my_company_id()
    OR public.is_super_admin()
  );

DROP POLICY IF EXISTS "Users can delete audit_5s for their company" ON public.audit_5s;
DROP POLICY IF EXISTS "audit_5s_delete_policy" ON public.audit_5s;

CREATE POLICY "audit_5s_delete_policy" ON public.audit_5s
  FOR DELETE TO authenticated
  USING (
    company_id = public.get_my_company_id()
    OR public.is_super_admin()
  );


-- C. DETALLES AUDITORÍA (audit_5s_entries)
ALTER TABLE public.audit_5s_entries ENABLE ROW LEVEL SECURITY;

-- Nota: audit_5s_entries NO tiene company_id, depende de la auditoría padre.
-- Usamos JOIN implícito via EXISTS

DROP POLICY IF EXISTS "Users can view entries of their company audits" ON public.audit_5s_entries;
DROP POLICY IF EXISTS "audit_entries_select_policy" ON public.audit_5s_entries;

CREATE POLICY "audit_entries_select_policy" ON public.audit_5s_entries
  FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.audit_5s a
      WHERE a.id = audit_5s_entries.audit_id
      AND (
        a.company_id = public.get_my_company_id()
        OR public.is_super_admin()
      )
    )
  );

-- Insert/Update/Delete siguen lógica similar...
DROP POLICY IF EXISTS "Users can insert entries for their company audits" ON public.audit_5s_entries;
DROP POLICY IF EXISTS "audit_entries_insert_policy" ON public.audit_5s_entries;

CREATE POLICY "audit_entries_insert_policy" ON public.audit_5s_entries
  FOR INSERT TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.audit_5s a
      WHERE a.id = audit_5s_entries.audit_id
      AND (
        a.company_id = public.get_my_company_id()
        OR public.is_super_admin()
      )
    )
  );

-- D. INDEXES PARA PERFORMANCE
-- ------------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_audit_5s_company_id ON public.audit_5s(company_id);
CREATE INDEX IF NOT EXISTS idx_audit_5s_audit_date ON public.audit_5s(audit_date);
CREATE INDEX IF NOT EXISTS idx_profiles_company_id ON public.profiles(company_id);
CREATE INDEX IF NOT EXISTS idx_profiles_role ON public.profiles(role);

-- E. REPARACIÓN DE SUPER ADMINISTRADOR (Asegurar que TU usuario tenga el rol correcto)
UPDATE public.profiles
SET role = 'superadmin', is_authorized = true
WHERE email = 'ariel.mellag@gmail.com';

