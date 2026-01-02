-- FIX: RLS Policies for five_s_cards
-- Usage: Run this in Supabase SQL Editor

-- 1. Disable RLS momentarily to clean up if needed (optional, safer to just replacing policies)
ALTER TABLE public.five_s_cards ENABLE ROW LEVEL SECURITY;

-- 2. Drop existing restrictive policies
DROP POLICY IF EXISTS "Ver five_s_cards" ON public.five_s_cards;
DROP POLICY IF EXISTS "Gestionar five_s_cards" ON public.five_s_cards;
DROP POLICY IF EXISTS "Enable read access for all users" ON public.five_s_cards;
DROP POLICY IF EXISTS "Enable insert for authenticated users only" ON public.five_s_cards;

-- 3. Create explicit policies

-- POLICY: VIEW (SELECT)
-- Users can see cards if:
-- 1. They are Admin
-- 2. The card belongs to their Company
-- 3. The card has NO company assigned (public/common?)
-- 4. They are the responsible person (even if company mismatch?)
CREATE POLICY "View 5S Cards"
ON public.five_s_cards
FOR SELECT
USING (
  public.is_admin()
  OR
  company_id IS NULL
  OR
  company_id = (SELECT company_id FROM public.profiles WHERE id = auth.uid())
  OR
  responsible = (SELECT name FROM public.profiles WHERE id = auth.uid())
);

-- POLICY: INSERT
-- Users can insert cards if:
-- 1. They are Admin
-- 2. They are inserting a card for THEIR OWN company
-- 3. They are inserting a card with NO company (if allowed)
CREATE POLICY "Insert 5S Cards"
ON public.five_s_cards
FOR INSERT
WITH CHECK (
  public.is_admin()
  OR
  company_id = (SELECT company_id FROM public.profiles WHERE id = auth.uid())
  OR
  company_id IS NULL
);

-- POLICY: UPDATE
-- Users can update cards if:
-- 1. They are Admin
-- 2. The card belongs to their Company
CREATE POLICY "Update 5S Cards"
ON public.five_s_cards
FOR UPDATE
USING (
  public.is_admin()
  OR
  company_id = (SELECT company_id FROM public.profiles WHERE id = auth.uid())
);

-- POLICY: DELETE
-- Users can delete cards if:
-- 1. They are Admin
-- 2. The card belongs to their Company
CREATE POLICY "Delete 5S Cards"
ON public.five_s_cards
FOR DELETE
USING (
  public.is_admin()
  OR
  company_id = (SELECT company_id FROM public.profiles WHERE id = auth.uid())
);
