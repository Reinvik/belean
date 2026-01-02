-- FIX: RLS on Hidden Counter Table
-- The error "new row violates row-level security policy" might be caused by the TRIGGER trying to update this table.

-- 1. Ensure Table Exists
CREATE TABLE IF NOT EXISTS public.company_card_counters (
  company_id uuid PRIMARY KEY,
  last_number integer NOT NULL DEFAULT 0
);

-- 2. Enable RLS (Good practice)
ALTER TABLE public.company_card_counters ENABLE ROW LEVEL SECURITY;

-- 3. PERMISSIVE POLICIES for Counters
-- Allow any authenticated user to view/update counters.
-- We need broad access because any user from any company might trigger this.

DROP POLICY IF EXISTS "Allow All Authenticated Select Counters" ON public.company_card_counters;
CREATE POLICY "Allow All Authenticated Select Counters"
ON public.company_card_counters
FOR SELECT
USING ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Insert Counters" ON public.company_card_counters;
CREATE POLICY "Allow All Authenticated Insert Counters"
ON public.company_card_counters
FOR INSERT
WITH CHECK ( auth.role() = 'authenticated' );

DROP POLICY IF EXISTS "Allow All Authenticated Update Counters" ON public.company_card_counters;
CREATE POLICY "Allow All Authenticated Update Counters"
ON public.company_card_counters
FOR UPDATE
USING ( auth.role() = 'authenticated' );

-- 4. Re-apply the Failsafe for 5S Cards just in case
DROP POLICY IF EXISTS "Allow All Authenticated Select" ON public.five_s_cards;
DROP POLICY IF EXISTS "Allow All Authenticated Insert" ON public.five_s_cards;
DROP POLICY IF EXISTS "Allow All Authenticated Update" ON public.five_s_cards;
DROP POLICY IF EXISTS "Allow All Authenticated Delete" ON public.five_s_cards;

CREATE POLICY "Allow All Authenticated Select" ON public.five_s_cards FOR SELECT USING ( auth.role() = 'authenticated' );
CREATE POLICY "Allow All Authenticated Insert" ON public.five_s_cards FOR INSERT WITH CHECK ( auth.role() = 'authenticated' );
CREATE POLICY "Allow All Authenticated Update" ON public.five_s_cards FOR UPDATE USING ( auth.role() = 'authenticated' );
CREATE POLICY "Allow All Authenticated Delete" ON public.five_s_cards FOR DELETE USING ( auth.role() = 'authenticated' );
