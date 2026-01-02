-- FIX: Handle NULL company_id in 5S Card Trigger
-- Usage: Run this script in the Supabase SQL Editor

CREATE OR REPLACE FUNCTION public.set_five_s_card_number()
RETURNS TRIGGER AS $$
DECLARE
  newnum integer;
BEGIN
  -- Si la aplicación ya proporcionó un número, no lo sobrescribimos
  IF NEW.card_number IS NOT NULL THEN
    RETURN NEW;
  END IF;

  -- FIX: If company_id is NULL, we cannot increment a per-company counter.
  -- We simply return NEW, leaving card_number as NULL (or let it be handled by app fallback).
  -- This prevents the "null value in column company_id violates not-null constraint" error.
  IF NEW.company_id IS NULL THEN
     RETURN NEW;
  END IF;

  -- Incrementar o insertar el contador de forma atómica
  INSERT INTO public.company_card_counters(company_id, last_number)
    VALUES (NEW.company_id, 1)
  ON CONFLICT (company_id)
  DO UPDATE SET last_number = company_card_counters.last_number + 1
  RETURNING last_number INTO newnum;

  NEW.card_number := newnum;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
