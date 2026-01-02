-- EMERGENCY FIX: Unblock All Authenticated Inserts
-- Usage: Run this in Supabase SQL Editor

-- 1. Reset Policies completely
DROP POLICY IF EXISTS "Insert 5S Cards" ON public.five_s_cards;
DROP POLICY IF EXISTS "Update 5S Cards" ON public.five_s_cards;
DROP POLICY IF EXISTS "View 5S Cards" ON public.five_s_cards;
DROP POLICY IF EXISTS "Delete 5S Cards" ON public.five_s_cards;

-- 2. CREATE PERMISSIVE POLICIES (Authenticated Only)
-- We remove the company_id checks for now to verify if that is the blocker.
-- If this works, we know the issue is the company_id mismatch.

CREATE POLICY "Allow All Authenticated Select"
ON public.five_s_cards
FOR SELECT
USING ( auth.role() = 'authenticated' );

CREATE POLICY "Allow All Authenticated Insert"
ON public.five_s_cards
FOR INSERT
WITH CHECK ( auth.role() = 'authenticated' );

CREATE POLICY "Allow All Authenticated Update"
ON public.five_s_cards
FOR UPDATE
USING ( auth.role() = 'authenticated' );

CREATE POLICY "Allow All Authenticated Delete"
ON public.five_s_cards
FOR DELETE
USING ( auth.role() = 'authenticated' );

-- 3. ENSURE TRIGGER DOESN'T FAIL
-- Update the trigger to handle NULL company_id gracefully (redundant if you ran previous fix, but good safety)
CREATE OR REPLACE FUNCTION public.set_five_s_card_number()
RETURNS TRIGGER AS $$
DECLARE
  newnum integer;
BEGIN
  IF NEW.card_number IS NOT NULL THEN
    RETURN NEW;
  END IF;

  -- IF NO COMPANY ID, JUST RETURN (No counting)
  IF NEW.company_id IS NULL THEN
     RETURN NEW;
  END IF;

  INSERT INTO public.company_card_counters(company_id, last_number)
    VALUES (NEW.company_id, 1)
  ON CONFLICT (company_id)
  DO UPDATE SET last_number = company_card_counters.last_number + 1
  RETURNING last_number INTO newnum;

  NEW.card_number := newnum;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
