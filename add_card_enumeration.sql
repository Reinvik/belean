-- 1) Crear tabla de contadores por compañía (idempotente)
CREATE TABLE IF NOT EXISTS public.company_card_counters (
  company_id uuid PRIMARY KEY,
  last_number integer NOT NULL DEFAULT 0
);

-- 2) Asegurar UNIQUE constraint para mayor seguridad
ALTER TABLE public.five_s_cards
  ADD CONSTRAINT unique_company_card_number UNIQUE (company_id, card_number);

-- 3) Función trigger segura que respeta card_number provisto y usa contador atómico
CREATE OR REPLACE FUNCTION public.set_five_s_card_number()
RETURNS TRIGGER AS $$
DECLARE
  newnum integer;
BEGIN
  -- Si la aplicación ya proporcionó un número, no lo sobrescribimos
  IF NEW.card_number IS NOT NULL THEN
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

-- 4) Crear / reemplazar trigger (antes eliminamos si existe)
DROP TRIGGER IF EXISTS trigger_set_five_s_card_number ON public.five_s_cards;

CREATE TRIGGER trigger_set_five_s_card_number
BEFORE INSERT ON public.five_s_cards
FOR EACH ROW
EXECUTE FUNCTION public.set_five_s_card_number();
