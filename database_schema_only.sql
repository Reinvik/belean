--
-- PostgreSQL database dump
--



-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA _realtime;


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA graphql;


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA graphql_public;


--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA pgbouncer;


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA realtime;


--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA supabase_functions;


--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA supabase_migrations;


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA vault;


--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

/* CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
); */


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

/* CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
); */


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

/* CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
); */


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

/* CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
); */


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

/* CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
); */


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

-- CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
--     LANGUAGE plpgsql SECURITY DEFINER
--     SET search_path TO ''
--     AS $_$
-- begin
--     raise debug 'PgBouncer auth request: %', p_usename;

--     return query
--     select 
--         rolname::text, 
--         case when rolvaliduntil < now() 
--             then null 
--             else rolpassword::text 
--         end 
--     from pg_authid 
--     where rolname=$1 and rolcanlogin;
-- end;
-- $_$;


--
-- Name: get_my_company_id(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_my_company_id() RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  RETURN (
    SELECT company_id 
    FROM public.profiles 
    WHERE id = auth.uid()
  );
END;
$$;


--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
declare
  is_super boolean;
  comp_id uuid;
begin
  -- Lógica Superadmin Hardcoded
  if new.email = 'ariel.mellag@gmail.com' or new.email = 'equipo@belean.cl' then
    is_super := true;
  else
    is_super := false;
  end if;

  -- Asignar Empresa Be Lean
  if new.email = 'equipo@belean.cl' then
    select id into comp_id from public.companies where domain = 'belean.cl';
  else
    comp_id := null;
  end if;

  insert into public.profiles (id, email, name, role, is_authorized, company_id)
  values (
    new.id, 
    new.email, 
    new.raw_user_meta_data->>'name',
    case when is_super then 'superadmin' else 'user' end,
    case when is_super then true else false end,
    comp_id
  )
  on conflict (id) do update 
  set email = excluded.email, 
      name = excluded.name, 
      role = case when is_super then 'superadmin' else profiles.role end,
      is_authorized = case when is_super then true else profiles.is_authorized end; 
      
  return new;
end;
$$;


--
-- Name: is_admin(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.is_admin() RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  _role text;
BEGIN
  -- A. Fast Path: Check JWT email (Hardcoded Superadmins)
  -- This handles the specific users requested regardless of DB state
  IF (auth.jwt() ->> 'email') IN ('ariel.mellag@gmail.com', 'Equipo@belean.cl') THEN
    RETURN TRUE;
  END IF;

  -- B. Check Metadata in auth.users
  -- Since this function is SECURITY DEFINER, it can read auth.users
  -- auth.users does NOT have RLS that points back to profiles, so no loop.
  SELECT raw_user_meta_data->>'role'
  INTO _role
  FROM auth.users
  WHERE id = auth.uid();

  RETURN (_role = 'superadmin');
END;
$$;


--
-- Name: set_five_s_card_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_five_s_card_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


--
-- Name: sync_profile_role(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.sync_profile_role() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  UPDATE auth.users
  SET raw_user_meta_data = 
    COALESCE(raw_user_meta_data, '{}'::jsonb) || 
    jsonb_build_object('role', NEW.role)
  WHERE id = NEW.id;
  RETURN NEW;
END;
$$;


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

-- CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
--     LANGUAGE plpgsql
--     AS $$
-- declare
-- -- Regclass of the table e.g. public.notes
-- entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- -- I, U, D, T: insert, update ...
-- action realtime.action = (
--     case wal ->> 'action'
--         when 'I' then 'INSERT'
--         when 'U' then 'UPDATE'
--         when 'D' then 'DELETE'
--         else 'ERROR'
--     end
-- );

-- -- Is row level security enabled for the table
-- is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

-- subscriptions realtime.subscription[] = array_agg(subs)
--     from
--         realtime.subscription subs
--     where
--         subs.entity = entity_;

-- -- Subscription vars
-- roles regrole[] = array_agg(distinct us.claims_role::text)
--     from
--         unnest(subscriptions) us;

-- working_role regrole;
-- claimed_role regrole;
-- claims jsonb;

-- subscription_id uuid;
-- subscription_has_access bool;
-- visible_to_subscription_ids uuid[] = '{}';

-- -- structured info for wal's columns
-- columns realtime.wal_column[];
-- -- previous identity values for update/delete
-- old_columns realtime.wal_column[];

-- error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- -- Primary jsonb output for record
-- output jsonb;

-- begin
-- perform set_config('role', null, true);

-- columns =
--     array_agg(
--         (
--             x->>'name',
--             x->>'type',
--             x->>'typeoid',
--             realtime.cast(
--                 (x->'value') #>> '{}',
--                 coalesce(
--                     (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
--                     (x->>'type')::regtype
--                 )
--             ),
--             (pks ->> 'name') is not null,
--             true
--         )::realtime.wal_column
--     )
--     from
--         jsonb_array_elements(wal -> 'columns') x
--         left join jsonb_array_elements(wal -> 'pk') pks
--             on (x ->> 'name') = (pks ->> 'name');

-- old_columns =
--     array_agg(
--         (
--             x->>'name',
--             x->>'type',
--             x->>'typeoid',
--             realtime.cast(
--                 (x->'value') #>> '{}',
--                 coalesce(
--                     (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
--                     (x->>'type')::regtype
--                 )
--             ),
--             (pks ->> 'name') is not null,
--             true
--         )::realtime.wal_column
--     )
--     from
--         jsonb_array_elements(wal -> 'identity') x
--         left join jsonb_array_elements(wal -> 'pk') pks
--             on (x ->> 'name') = (pks ->> 'name');

-- for working_role in select * from unnest(roles) loop

--     -- Update `is_selectable` for columns and old_columns
--     columns =
--         array_agg(
--             (
--                 c.name,
--                 c.type_name,
--                 c.type_oid,
--                 c.value,
--                 c.is_pkey,
--                 pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
--             )::realtime.wal_column
--         )
--         from
--             unnest(columns) c;

--     old_columns =
--             array_agg(
--                 (
--                     c.name,
--                     c.type_name,
--                     c.type_oid,
--                     c.value,
--                     c.is_pkey,
--                     pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
--                 )::realtime.wal_column
--             )
--             from
--                 unnest(old_columns) c;

--     if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
--         return next (
--             jsonb_build_object(
--                 'schema', wal ->> 'schema',
--                 'table', wal ->> 'table',
--                 'type', action
--             ),
--             is_rls_enabled,
--             -- subscriptions is already filtered by entity
--             (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
--             array['Error 400: Bad Request, no primary key']
--         )::realtime.wal_rls;

--     -- The claims role does not have SELECT permission to the primary key of entity
--     elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
--         return next (
--             jsonb_build_object(
--                 'schema', wal ->> 'schema',
--                 'table', wal ->> 'table',
--                 'type', action
--             ),
--             is_rls_enabled,
--             (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
--             array['Error 401: Unauthorized']
--         )::realtime.wal_rls;

--     else
--         output = jsonb_build_object(
--             'schema', wal ->> 'schema',
--             'table', wal ->> 'table',
--             'type', action,
--             'commit_timestamp', to_char(
--                 ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
--                 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
--             ),
--             'columns', (
--                 select
--                     jsonb_agg(
--                         jsonb_build_object(
--                             'name', pa.attname,
--                             'type', pt.typname
--                         )
--                         order by pa.attnum asc
--                     )
--                 from
--                     pg_attribute pa
--                     join pg_type pt
--                         on pa.atttypid = pt.oid
--                 where
--                     attrelid = entity_
--                     and attnum > 0
--                     and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
--             )
--         )
--         -- Add "record" key for insert and update
--         || case
--             when action in ('INSERT', 'UPDATE') then
--                 jsonb_build_object(
--                     'record',
--                     (
--                         select
--                             jsonb_object_agg(
--                                 -- if unchanged toast, get column name and value from old record
--                                 coalesce((c).name, (oc).name),
--                                 case
--                                     when (c).name is null then (oc).value
--                                     else (c).value
--                                 end
--                             )
--                         from
--                             unnest(columns) c
--                             full outer join unnest(old_columns) oc
--                                 on (c).name = (oc).name
--                         where
--                             coalesce((c).is_selectable, (oc).is_selectable)
--                             and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
--                     )
--                 )
--             else '{}'::jsonb
--         end
--         -- Add "old_record" key for update and delete
--         || case
--             when action = 'UPDATE' then
--                 jsonb_build_object(
--                         'old_record',
--                         (
--                             select jsonb_object_agg((c).name, (c).value)
--                             from unnest(old_columns) c
--                             where
--                                 (c).is_selectable
--                                 and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
--                         )
--                     )
--             when action = 'DELETE' then
--                 jsonb_build_object(
--                     'old_record',
--                     (
--                         select jsonb_object_agg((c).name, (c).value)
--                         from unnest(old_columns) c
--                         where
--                             (c).is_selectable
--                             and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
--                             and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
--                     )
--                 )
--             else '{}'::jsonb
--         end;

--         -- Create the prepared statement
--         if is_rls_enabled and action <> 'DELETE' then
--             if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
--                 deallocate walrus_rls_stmt;
--             end if;
--             execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
--         end if;

--         visible_to_subscription_ids = '{}';

--         for subscription_id, claims in (
--                 select
--                     subs.subscription_id,
--                     subs.claims
--                 from
--                     unnest(subscriptions) subs
--                 where
--                     subs.entity = entity_
--                     and subs.claims_role = working_role
--                     and (
--                         realtime.is_visible_through_filters(columns, subs.filters)
--                         or (
--                           action = 'DELETE'
--                           and realtime.is_visible_through_filters(old_columns, subs.filters)
--                         )
--                     )
--         ) loop

--             if not is_rls_enabled or action = 'DELETE' then
--                 visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
--             else
--                 -- Check if RLS allows the role to see the record
--                 perform
--                     -- Trim leading and trailing quotes from working_role because set_config
--                     -- doesn't recognize the role as valid if they are included
--                     set_config('role', trim(both '"' from working_role::text), true),
--                     set_config('request.jwt.claims', claims::text, true);

--                 execute 'execute walrus_rls_stmt' into subscription_has_access;

--                 if subscription_has_access then
--                     visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
--                 end if;
--             end if;
--         end loop;

--         perform set_config('role', null, true);

--         return next (
--             output,
--             is_rls_enabled,
--             visible_to_subscription_ids,
--             case
--                 when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
--                 else '{}'
--             end
--         )::realtime.wal_rls;

--     end if;
-- end loop;

-- perform set_config('role', null, true);
-- end;
-- $$;


-- --
-- -- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
--     LANGUAGE plpgsql
--     AS $$
-- DECLARE
--     -- Declare a variable to hold the JSONB representation of the row
--     row_data jsonb := '{}'::jsonb;
-- BEGIN
--     IF level = 'STATEMENT' THEN
--         RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
--     END IF;
--     -- Check the operation type and handle accordingly
--     IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
--         row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
--         PERFORM realtime.send (row_data, event_name, topic_name);
--     ELSE
--         RAISE EXCEPTION 'Unexpected operation type: %', operation;
--     END IF;
-- EXCEPTION
--     WHEN OTHERS THEN
--         RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
-- END;

-- $$;


-- --
-- -- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
--     LANGUAGE sql
--     AS $$
--       /*
--       Builds a sql string that, if executed, creates a prepared statement to
--       tests retrive a row from *entity* by its primary key columns.
--       Example
--           select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
--       */
--           select
--       'prepare ' || prepared_statement_name || ' as
--           select
--               exists(
--                   select
--                       1
--                   from
--                       ' || entity || '
--                   where
--                       ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
--               )'
--           from
--               unnest(columns) pkc
--           where
--               pkc.is_pkey
--           group by
--               entity
--       $$;


-- --
-- -- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
--     LANGUAGE plpgsql IMMUTABLE
--     AS $$
--     declare
--       res jsonb;
--     begin
--       execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
--       return res;
--     end
--     $$;


-- --
-- -- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
--     LANGUAGE plpgsql IMMUTABLE
--     AS $$
--       /*
--       Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
--       */
--       declare
--           op_symbol text = (
--               case
--                   when op = 'eq' then '='
--                   when op = 'neq' then '!='
--                   when op = 'lt' then '<'
--                   when op = 'lte' then '<='
--                   when op = 'gt' then '>'
--                   when op = 'gte' then '>='
--                   when op = 'in' then '= any'
--                   else 'UNKNOWN OP'
--               end
--           );
--           res boolean;
--       begin
--           execute format(
--               'select %L::'|| type_::text || ' ' || op_symbol
--               || ' ( %L::'
--               || (
--                   case
--                       when op = 'in' then type_::text || '[]'
--                       else type_::text end
--               )
--               || ')', val_1, val_2) into res;
--           return res;
--       end;
--       $$;


-- --
-- -- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
--     LANGUAGE sql IMMUTABLE
--     AS $_$
--     /*
--     Should the record be visible (true) or filtered out (false) after *filters* are applied
--     */
--         select
--             -- Default to allowed when no filters present
--             $2 is null -- no filters. this should not happen because subscriptions has a default
--             or array_length($2, 1) is null -- array length of an empty array is null
--             or bool_and(
--                 coalesce(
--                     realtime.check_equality_op(
--                         op:=f.op,
--                         type_:=coalesce(
--                             col.type_oid::regtype, -- null when wal2json version <= 2.4
--                             col.type_name::regtype
--                         ),
--                         -- cast jsonb to text
--                         val_1:=col.value #>> '{}',
--                         val_2:=f.value
--                     ),
--                     false -- if null, filter does not match
--                 )
--             )
--         from
--             unnest(filters) f
--             join unnest(columns) col
--                 on f.column_name = col.name;
--     $_$;


-- --
-- -- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
--     LANGUAGE sql
--     SET log_min_messages TO 'fatal'
--     AS $$
--       with pub as (
--         select
--           concat_ws(
--             ',',
--             case when bool_or(pubinsert) then 'insert' else null end,
--             case when bool_or(pubupdate) then 'update' else null end,
--             case when bool_or(pubdelete) then 'delete' else null end
--           ) as w2j_actions,
--           coalesce(
--             string_agg(
--               realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
--               ','
--             ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
--             ''
--           ) w2j_add_tables
--         from
--           pg_publication pp
--           left join pg_publication_tables ppt
--             on pp.pubname = ppt.pubname
--         where
--           pp.pubname = publication
--         group by
--           pp.pubname
--         limit 1
--       ),
--       w2j as (
--         select
--           x.*, pub.w2j_add_tables
--         from
--           pub,
--           pg_logical_slot_get_changes(
--             slot_name, null, max_changes,
--             'include-pk', 'true',
--             'include-transaction', 'false',
--             'include-timestamp', 'true',
--             'include-type-oids', 'true',
--             'format-version', '2',
--             'actions', pub.w2j_actions,
--             'add-tables', pub.w2j_add_tables
--           ) x
--       )
--       select
--         xyz.wal,
--         xyz.is_rls_enabled,
--         xyz.subscription_ids,
--         xyz.errors
--       from
--         w2j,
--         realtime.apply_rls(
--           wal := w2j.data::jsonb,
--           max_record_bytes := max_record_bytes
--         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
--       where
--         w2j.w2j_add_tables <> ''
--         and xyz.subscription_ids[1] is not null
--     $$;


-- --
-- -- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
--     LANGUAGE sql IMMUTABLE STRICT
--     AS $$
--       select
--         (
--           select string_agg('' || ch,'')
--           from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
--           where
--             not (x.idx = 1 and x.ch = '"')
--             and not (
--               x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
--               and x.ch = '"'
--             )
--         )
--         || '.'
--         || (
--           select string_agg('' || ch,'')
--           from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
--           where
--             not (x.idx = 1 and x.ch = '"')
--             and not (
--               x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
--               and x.ch = '"'
--             )
--           )
--       from
--         pg_class pc
--         join pg_namespace nsp
--           on pc.relnamespace = nsp.oid
--       where
--         pc.oid = entity
--     $$;


-- --
-- -- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
--     LANGUAGE plpgsql
--     AS $$
-- DECLARE
--   generated_id uuid;
--   final_payload jsonb;
-- BEGIN
--   BEGIN
--     -- Generate a new UUID for the id
--     generated_id := gen_random_uuid();

--     -- Check if payload has an 'id' key, if not, add the generated UUID
--     IF payload ? 'id' THEN
--       final_payload := payload;
--     ELSE
--       final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
--     END IF;

--     -- Set the topic configuration
--     EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

--     -- Attempt to insert the message
--     INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
--     VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
--   EXCEPTION
--     WHEN OTHERS THEN
--       -- Capture and notify the error
--       RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
--   END;
-- END;
-- $$;


-- --
-- -- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
--     LANGUAGE plpgsql
--     AS $$
--     /*
--     Validates that the user defined filters for a subscription:
--     - refer to valid columns that the claimed role may access
--     - values are coercable to the correct column type
--     */
--     declare
--         col_names text[] = coalesce(
--                 array_agg(c.column_name order by c.ordinal_position),
--                 '{}'::text[]
--             )
--             from
--                 information_schema.columns c
--             where
--                 format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
--                 and pg_catalog.has_column_privilege(
--                     (new.claims ->> 'role'),
--                     format('%I.%I', c.table_schema, c.table_name)::regclass,
--                     c.column_name,
--                     'SELECT'
--                 );
--         filter realtime.user_defined_filter;
--         col_type regtype;

--         in_val jsonb;
--     begin
--         for filter in select * from unnest(new.filters) loop
--             -- Filtered column is valid
--             if not filter.column_name = any(col_names) then
--                 raise exception 'invalid column for filter %', filter.column_name;
--             end if;

--             -- Type is sanitized and safe for string interpolation
--             col_type = (
--                 select atttypid::regtype
--                 from pg_catalog.pg_attribute
--                 where attrelid = new.entity
--                       and attname = filter.column_name
--             );
--             if col_type is null then
--                 raise exception 'failed to lookup type for column %', filter.column_name;
--             end if;

--             -- Set maximum number of entries for in filter
--             if filter.op = 'in'::realtime.equality_op then
--                 in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
--                 if coalesce(jsonb_array_length(in_val), 0) > 100 then
--                     raise exception 'too many values for `in` filter. Maximum 100';
--                 end if;
--             else
--                 -- raises an exception if value is not coercable to type
--                 perform realtime.cast(filter.value, col_type);
--             end if;

--         end loop;

--         -- Apply consistent order to filters so the unique constraint on
--         -- (subscription_id, entity, filters) can't be tricked by a different filter order
--         new.filters = coalesce(
--             array_agg(f order by f.column_name, f.op, f.value),
--             '{}'
--         ) from unnest(new.filters) f;

--         return new;
--     end;
--     $$;


-- --
-- -- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
--     LANGUAGE sql IMMUTABLE
--     AS $$ select role_name::regrole $$;


-- --
-- -- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
-- --

-- CREATE FUNCTION realtime.topic() RETURNS text
--     LANGUAGE sql STABLE
--     AS $$
-- select nullif(current_setting('realtime.topic', true), '')::text;
-- $$;


-- --
-- -- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: -
-- --

-- CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
--     LANGUAGE plpgsql SECURITY DEFINER
--     SET search_path TO 'supabase_functions'
--     AS $$
--   DECLARE
--     request_id bigint;
--     payload jsonb;
--     url text := TG_ARGV[0]::text;
--     method text := TG_ARGV[1]::text;
--     headers jsonb DEFAULT '{}'::jsonb;
--     params jsonb DEFAULT '{}'::jsonb;
--     timeout_ms integer DEFAULT 1000;
--   BEGIN
--     IF url IS NULL OR url = 'null' THEN
--       RAISE EXCEPTION 'url argument is missing';
--     END IF;

--     IF method IS NULL OR method = 'null' THEN
--       RAISE EXCEPTION 'method argument is missing';
--     END IF;

--     IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
--       headers = '{"Content-Type": "application/json"}'::jsonb;
--     ELSE
--       headers = TG_ARGV[2]::jsonb;
--     END IF;

--     IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
--       params = '{}'::jsonb;
--     ELSE
--       params = TG_ARGV[3]::jsonb;
--     END IF;

--     IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
--       timeout_ms = 1000;
--     ELSE
--       timeout_ms = TG_ARGV[4]::integer;
--     END IF;

--     CASE
--       WHEN method = 'GET' THEN
--         SELECT http_get INTO request_id FROM net.http_get(
--           url,
--           params,
--           headers,
--           timeout_ms
--         );
--       WHEN method = 'POST' THEN
--         payload = jsonb_build_object(
--           'old_record', OLD,
--           'record', NEW,
--           'type', TG_OP,
--           'table', TG_TABLE_NAME,
--           'schema', TG_TABLE_SCHEMA
--         );

--         SELECT http_post INTO request_id FROM net.http_post(
--           url,
--           payload,
--           params,
--           headers,
--           timeout_ms
--         );
--       ELSE
--         RAISE EXCEPTION 'method argument % is invalid', method;
--     END CASE;

--     INSERT INTO supabase_functions.hooks
--       (hook_table_id, hook_name, request_id)
--     VALUES
--       (TG_RELID, TG_NAME, request_id);

--     RETURN NEW;
--   END
-- $$;


-- SET default_tablespace = '';

-- SET default_table_access_method = heap;

-- --
-- -- Name: extensions; Type: TABLE; Schema: _realtime; Owner: -
-- --

-- CREATE TABLE _realtime.extensions (
--     id uuid NOT NULL,
--     type text,
--     settings jsonb,
--     tenant_external_id text,
--     inserted_at timestamp(0) without time zone NOT NULL,
--     updated_at timestamp(0) without time zone NOT NULL
-- );


-- --
-- -- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: -
-- --

-- CREATE TABLE _realtime.schema_migrations (
--     version bigint NOT NULL,
--     inserted_at timestamp(0) without time zone
-- );


-- --
-- -- Name: tenants; Type: TABLE; Schema: _realtime; Owner: -
-- --

-- CREATE TABLE _realtime.tenants (
--     id uuid NOT NULL,
--     name text,
--     external_id text,
--     jwt_secret text,
--     max_concurrent_users integer DEFAULT 200 NOT NULL,
--     inserted_at timestamp(0) without time zone NOT NULL,
--     updated_at timestamp(0) without time zone NOT NULL,
--     max_events_per_second integer DEFAULT 100 NOT NULL,
--     postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
--     max_bytes_per_second integer DEFAULT 100000 NOT NULL,
--     max_channels_per_client integer DEFAULT 100 NOT NULL,
--     max_joins_per_second integer DEFAULT 500 NOT NULL,
--     suspend boolean DEFAULT false,
--     jwt_jwks jsonb,
--     notify_private_alpha boolean DEFAULT false,
--     private_only boolean DEFAULT false NOT NULL,
--     migrations_ran integer DEFAULT 0,
--     broadcast_adapter character varying(255) DEFAULT 'gen_rpc'::character varying,
--     max_presence_events_per_second integer DEFAULT 1000,
--     max_payload_size_in_kb integer DEFAULT 3000,
--     CONSTRAINT jwt_secret_or_jwt_jwks_required CHECK (((jwt_secret IS NOT NULL) OR (jwt_jwks IS NOT NULL)))
-- );


--
-- Name: a3_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.a3_projects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid,
    title text NOT NULL,
    status text DEFAULT 'Nuevo'::text,
    responsible text,
    date date DEFAULT CURRENT_DATE,
    background text,
    current_condition text,
    goal text,
    root_cause text,
    ishikawas jsonb DEFAULT '[]'::jsonb,
    five_whys jsonb DEFAULT '[]'::jsonb,
    countermeasures text,
    execution_plan text,
    action_plan jsonb DEFAULT '[]'::jsonb,
    follow_up_notes text,
    follow_up_data jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    background_image_url text,
    current_condition_image_url text,
    pareto_data jsonb DEFAULT '[]'::jsonb
);


--
-- Name: audit_5s; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_5s (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid NOT NULL,
    area text NOT NULL,
    auditor text NOT NULL,
    audit_date date NOT NULL,
    total_score numeric DEFAULT 0,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    title text
);


--
-- Name: audit_5s_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_5s_entries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    audit_id uuid NOT NULL,
    section text NOT NULL,
    question text NOT NULL,
    score integer DEFAULT 0,
    comment text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: company_card_counters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_card_counters (
    company_id uuid NOT NULL,
    last_number integer DEFAULT 0 NOT NULL
);


--
-- Name: five_s_cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.five_s_cards (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid,
    date date DEFAULT CURRENT_DATE,
    location text,
    article text,
    reporter text,
    reason text,
    proposed_action text,
    responsible text,
    target_date date,
    solution_date date,
    status text DEFAULT 'Pendiente'::text,
    status_color text,
    type text,
    image_before text,
    image_after text,
    card_number integer,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text,
    name text,
    role text DEFAULT 'user'::text,
    company_id uuid,
    is_authorized boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    avatar_url text
);


--
-- Name: quick_wins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quick_wins (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid,
    title text NOT NULL,
    description text,
    status text DEFAULT 'idea'::text,
    impact text DEFAULT 'Medio'::text,
    responsible text,
    date date DEFAULT CURRENT_DATE,
    deadline date,
    image_url text,
    completion_image_url text,
    completion_comment text,
    completed_at timestamp with time zone,
    likes integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    proposed_solution text
);


--
-- Name: vsm_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vsm_projects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid,
    name text NOT NULL,
    description text,
    responsible text,
    date date DEFAULT CURRENT_DATE,
    status text DEFAULT 'current'::text,
    lead_time text,
    process_time text,
    efficiency text,
    image_url text,
    miro_link text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    version text,
    takt_time text
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

-- CREATE TABLE realtime.messages (
--     topic text NOT NULL,
--     extension text NOT NULL,
--     payload jsonb,
--     event text,
--     private boolean DEFAULT false,
--     updated_at timestamp without time zone DEFAULT now() NOT NULL,
--     inserted_at timestamp without time zone DEFAULT now() NOT NULL,
--     id uuid DEFAULT gen_random_uuid() NOT NULL
-- )
-- PARTITION BY RANGE (inserted_at);


-- --
-- -- Name: messages_2025_12_31; Type: TABLE; Schema: realtime; Owner: -
-- --

-- CREATE TABLE realtime.messages_2025_12_31 (
--     topic text NOT NULL,
--     extension text NOT NULL,
--     payload jsonb,
--     event text,
--     private boolean DEFAULT false,
--     updated_at timestamp without time zone DEFAULT now() NOT NULL,
--     inserted_at timestamp without time zone DEFAULT now() NOT NULL,
--     id uuid DEFAULT gen_random_uuid() NOT NULL
-- );


-- --
-- -- Name: messages_2026_01_01; Type: TABLE; Schema: realtime; Owner: -
-- --

-- CREATE TABLE realtime.messages_2026_01_01 (
--     topic text NOT NULL,
--     extension text NOT NULL,
--     payload jsonb,
--     event text,
--     private boolean DEFAULT false,
--     updated_at timestamp without time zone DEFAULT now() NOT NULL,
--     inserted_at timestamp without time zone DEFAULT now() NOT NULL,
--     id uuid DEFAULT gen_random_uuid() NOT NULL
-- );


-- --
-- -- Name: messages_2026_01_02; Type: TABLE; Schema: realtime; Owner: -
-- --

-- CREATE TABLE realtime.messages_2026_01_02 (
--     topic text NOT NULL,
--     extension text NOT NULL,
--     payload jsonb,
--     event text,
--     private boolean DEFAULT false,
--     updated_at timestamp without time zone DEFAULT now() NOT NULL,
--     inserted_at timestamp without time zone DEFAULT now() NOT NULL,
--     id uuid DEFAULT gen_random_uuid() NOT NULL
-- );


-- --
-- -- Name: messages_2026_01_03; Type: TABLE; Schema: realtime; Owner: -
-- --

-- CREATE TABLE realtime.messages_2026_01_03 (
--     topic text NOT NULL,
--     extension text NOT NULL,
--     payload jsonb,
--     event text,
--     private boolean DEFAULT false,
--     updated_at timestamp without time zone DEFAULT now() NOT NULL,
--     inserted_at timestamp without time zone DEFAULT now() NOT NULL,
--     id uuid DEFAULT gen_random_uuid() NOT NULL
-- );


-- --
-- -- Name: messages_2026_01_04; Type: TABLE; Schema: realtime; Owner: -
-- --

-- CREATE TABLE realtime.messages_2026_01_04 (
--     topic text NOT NULL,
--     extension text NOT NULL,
--     payload jsonb,
--     event text,
--     private boolean DEFAULT false,
--     updated_at timestamp without time zone DEFAULT now() NOT NULL,
--     inserted_at timestamp without time zone DEFAULT now() NOT NULL,
--     id uuid DEFAULT gen_random_uuid() NOT NULL
-- );


-- --
-- -- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
-- --

-- CREATE TABLE realtime.schema_migrations (
--     version bigint NOT NULL,
--     inserted_at timestamp(0) without time zone
-- );


-- --
-- -- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
-- --

-- CREATE TABLE realtime.subscription (
--     id bigint NOT NULL,
--     subscription_id uuid NOT NULL,
--     entity regclass NOT NULL,
--     filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
--     claims jsonb NOT NULL,
--     claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
--     created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
-- );


-- --
-- -- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
-- --

-- ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
--     SEQUENCE NAME realtime.subscription_id_seq
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );


-- --
-- -- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: -
-- --

-- CREATE TABLE supabase_functions.hooks (
--     id bigint NOT NULL,
--     hook_table_id integer NOT NULL,
--     hook_name text NOT NULL,
--     created_at timestamp with time zone DEFAULT now() NOT NULL,
--     request_id bigint
-- );


-- --
-- -- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: -
-- --

-- COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


-- --
-- -- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: -
-- --

-- CREATE SEQUENCE supabase_functions.hooks_id_seq
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


-- --
-- -- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: -
-- --

-- ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


-- --
-- -- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: -
-- --

-- CREATE TABLE supabase_functions.migrations (
--     version text NOT NULL,
--     inserted_at timestamp with time zone DEFAULT now() NOT NULL
-- );


-- --
-- -- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: -
-- --

-- CREATE TABLE supabase_migrations.schema_migrations (
--     version text NOT NULL,
--     statements text[],
--     name text
-- );


-- --
-- -- Name: seed_files; Type: TABLE; Schema: supabase_migrations; Owner: -
-- --

-- CREATE TABLE supabase_migrations.seed_files (
--     path text NOT NULL,
--     hash text NOT NULL
-- );


-- --
-- -- Name: messages_2025_12_31; Type: TABLE ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_12_31 FOR VALUES FROM ('2025-12-31 00:00:00') TO ('2026-01-01 00:00:00');


-- --
-- -- Name: messages_2026_01_01; Type: TABLE ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_01 FOR VALUES FROM ('2026-01-01 00:00:00') TO ('2026-01-02 00:00:00');


-- --
-- -- Name: messages_2026_01_02; Type: TABLE ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_02 FOR VALUES FROM ('2026-01-02 00:00:00') TO ('2026-01-03 00:00:00');


-- --
-- -- Name: messages_2026_01_03; Type: TABLE ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_03 FOR VALUES FROM ('2026-01-03 00:00:00') TO ('2026-01-04 00:00:00');


-- --
-- -- Name: messages_2026_01_04; Type: TABLE ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_04 FOR VALUES FROM ('2026-01-04 00:00:00') TO ('2026-01-05 00:00:00');


-- --
-- -- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: -
-- --

-- ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


-- --
-- -- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
-- --

-- ALTER TABLE ONLY _realtime.extensions
--     ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


-- --
-- -- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
-- --

-- ALTER TABLE ONLY _realtime.schema_migrations
--     ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


-- --
-- -- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
-- --

-- ALTER TABLE ONLY _realtime.tenants
--     ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: a3_projects a3_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.a3_projects
    ADD CONSTRAINT a3_projects_pkey PRIMARY KEY (id);


--
-- Name: audit_5s_entries audit_5s_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_5s_entries
    ADD CONSTRAINT audit_5s_entries_pkey PRIMARY KEY (id);


--
-- Name: audit_5s audit_5s_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_5s
    ADD CONSTRAINT audit_5s_pkey PRIMARY KEY (id);


--
-- Name: companies companies_domain_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_domain_key UNIQUE (domain);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_card_counters company_card_counters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_card_counters
    ADD CONSTRAINT company_card_counters_pkey PRIMARY KEY (company_id);


--
-- Name: five_s_cards five_s_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.five_s_cards
    ADD CONSTRAINT five_s_cards_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: quick_wins quick_wins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quick_wins
    ADD CONSTRAINT quick_wins_pkey PRIMARY KEY (id);


--
-- Name: five_s_cards unique_company_card_number; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.five_s_cards
    ADD CONSTRAINT unique_company_card_number UNIQUE (company_id, card_number);


--
-- Name: vsm_projects vsm_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vsm_projects
    ADD CONSTRAINT vsm_projects_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

-- ALTER TABLE ONLY realtime.messages
--     ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


-- --
-- -- Name: messages_2025_12_31 messages_2025_12_31_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages_2025_12_31
--     ADD CONSTRAINT messages_2025_12_31_pkey PRIMARY KEY (id, inserted_at);


-- --
-- -- Name: messages_2026_01_01 messages_2026_01_01_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages_2026_01_01
--     ADD CONSTRAINT messages_2026_01_01_pkey PRIMARY KEY (id, inserted_at);


-- --
-- -- Name: messages_2026_01_02 messages_2026_01_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages_2026_01_02
--     ADD CONSTRAINT messages_2026_01_02_pkey PRIMARY KEY (id, inserted_at);


-- --
-- -- Name: messages_2026_01_03 messages_2026_01_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages_2026_01_03
--     ADD CONSTRAINT messages_2026_01_03_pkey PRIMARY KEY (id, inserted_at);


-- --
-- -- Name: messages_2026_01_04 messages_2026_01_04_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.messages_2026_01_04
--     ADD CONSTRAINT messages_2026_01_04_pkey PRIMARY KEY (id, inserted_at);


-- --
-- -- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.subscription
--     ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


-- --
-- -- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
-- --

-- ALTER TABLE ONLY realtime.schema_migrations
--     ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


-- --
-- -- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: -
-- --

-- ALTER TABLE ONLY supabase_functions.hooks
--     ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


-- --
-- -- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: -
-- --

-- ALTER TABLE ONLY supabase_functions.migrations
--     ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


-- --
-- -- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: -
-- --

-- ALTER TABLE ONLY supabase_migrations.schema_migrations
--     ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


-- --
-- -- Name: seed_files seed_files_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: -
-- --

-- ALTER TABLE ONLY supabase_migrations.seed_files
--     ADD CONSTRAINT seed_files_pkey PRIMARY KEY (path);


-- --
-- -- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: -
-- --

-- CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


-- --
-- -- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: -
-- --

-- CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


-- --
-- -- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: -
-- --

-- CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


-- --
-- -- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
-- --

-- CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


-- --
-- -- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: -
-- --

-- CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


-- --
-- -- Name: messages_2025_12_31_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
-- --

-- CREATE INDEX messages_2025_12_31_inserted_at_topic_idx ON realtime.messages_2025_12_31 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


-- --
-- -- Name: messages_2026_01_01_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
-- --

-- CREATE INDEX messages_2026_01_01_inserted_at_topic_idx ON realtime.messages_2026_01_01 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


-- --
-- -- Name: messages_2026_01_02_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
-- --

-- CREATE INDEX messages_2026_01_02_inserted_at_topic_idx ON realtime.messages_2026_01_02 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


-- --
-- -- Name: messages_2026_01_03_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
-- --

-- CREATE INDEX messages_2026_01_03_inserted_at_topic_idx ON realtime.messages_2026_01_03 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


-- --
-- -- Name: messages_2026_01_04_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
-- --

-- CREATE INDEX messages_2026_01_04_inserted_at_topic_idx ON realtime.messages_2026_01_04 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


-- --
-- -- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
-- --

-- CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


-- --
-- -- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: -
-- --

-- CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


-- --
-- -- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: -
-- --

-- CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


-- --
-- -- Name: messages_2025_12_31_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_12_31_inserted_at_topic_idx;


-- --
-- -- Name: messages_2025_12_31_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_12_31_pkey;


-- --
-- -- Name: messages_2026_01_01_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_01_inserted_at_topic_idx;


-- --
-- -- Name: messages_2026_01_01_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_01_pkey;


-- --
-- -- Name: messages_2026_01_02_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_02_inserted_at_topic_idx;


-- --
-- -- Name: messages_2026_01_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_02_pkey;


-- --
-- -- Name: messages_2026_01_03_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_03_inserted_at_topic_idx;


-- --
-- -- Name: messages_2026_01_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_03_pkey;


-- --
-- -- Name: messages_2026_01_04_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_04_inserted_at_topic_idx;


-- --
-- -- Name: messages_2026_01_04_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
-- --

-- ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_04_pkey;


--
-- Name: profiles on_profile_role_change; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_profile_role_change AFTER UPDATE OF role ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.sync_profile_role();


--
-- Name: profiles on_profile_role_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_profile_role_insert AFTER INSERT ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.sync_profile_role();


--
-- Name: five_s_cards trigger_set_five_s_card_number; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_set_five_s_card_number BEFORE INSERT ON public.five_s_cards FOR EACH ROW EXECUTE FUNCTION public.set_five_s_card_number();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

-- CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


-- --
-- -- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: -
-- --

-- ALTER TABLE ONLY _realtime.extensions
--     ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- Name: a3_projects a3_projects_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.a3_projects
    ADD CONSTRAINT a3_projects_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: audit_5s audit_5s_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_5s
    ADD CONSTRAINT audit_5s_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: audit_5s_entries audit_5s_entries_audit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_5s_entries
    ADD CONSTRAINT audit_5s_entries_audit_id_fkey FOREIGN KEY (audit_id) REFERENCES public.audit_5s(id) ON DELETE CASCADE;


--
-- Name: five_s_cards five_s_cards_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.five_s_cards
    ADD CONSTRAINT five_s_cards_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: profiles profiles_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);


--
-- Name: quick_wins quick_wins_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quick_wins
    ADD CONSTRAINT quick_wins_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: vsm_projects vsm_projects_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vsm_projects
    ADD CONSTRAINT vsm_projects_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: profiles Actualizar perfiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Actualizar perfiles" ON public.profiles FOR UPDATE USING (((auth.uid() = id) OR public.is_admin()));


--
-- Name: companies Admins pueden gestionar empresas; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins pueden gestionar empresas" ON public.companies USING (public.is_admin());


--
-- Name: companies Empresas visibles para todos; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Empresas visibles para todos" ON public.companies FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- Name: a3_projects Gestionar a3_projects; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Gestionar a3_projects" ON public.a3_projects USING ((public.is_admin() OR ((company_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = a3_projects.company_id))))) OR ((responsible IS NOT NULL) AND (responsible = ( SELECT profiles.name
   FROM public.profiles
  WHERE (profiles.id = auth.uid())))) OR (company_id IS NULL)));


--
-- Name: five_s_cards Gestionar five_s_cards; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Gestionar five_s_cards" ON public.five_s_cards USING ((public.is_admin() OR ((company_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = five_s_cards.company_id))))) OR ((responsible IS NOT NULL) AND (responsible = ( SELECT profiles.name
   FROM public.profiles
  WHERE (profiles.id = auth.uid())))) OR (company_id IS NULL)));


--
-- Name: quick_wins Gestionar quick_wins; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Gestionar quick_wins" ON public.quick_wins USING ((public.is_admin() OR ((company_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = quick_wins.company_id))))) OR ((responsible IS NOT NULL) AND (responsible = ( SELECT profiles.name
   FROM public.profiles
  WHERE (profiles.id = auth.uid())))) OR (company_id IS NULL)));


--
-- Name: vsm_projects Gestionar vsm_projects; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Gestionar vsm_projects" ON public.vsm_projects USING ((public.is_admin() OR ((company_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = vsm_projects.company_id))))) OR ((responsible IS NOT NULL) AND (responsible = ( SELECT profiles.name
   FROM public.profiles
  WHERE (profiles.id = auth.uid()))))));


--
-- Name: profiles Insertar perfiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Insertar perfiles" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- Name: profiles Profiles updatable by self; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Profiles updatable by self" ON public.profiles FOR UPDATE USING ((id = auth.uid()));


--
-- Name: profiles Profiles visible to company members; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Profiles visible to company members" ON public.profiles FOR SELECT USING (((company_id IS NOT NULL) AND (company_id = public.get_my_company_id())));


--
-- Name: profiles Profiles visible to self; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Profiles visible to self" ON public.profiles FOR SELECT USING ((id = auth.uid()));


--
-- Name: a3_projects Superadmin manage all a3; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Superadmin manage all a3" ON public.a3_projects TO authenticated USING (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text])))) WITH CHECK (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text]))));


--
-- Name: five_s_cards Superadmin manage all cards; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Superadmin manage all cards" ON public.five_s_cards TO authenticated USING (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text])))) WITH CHECK (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text]))));


--
-- Name: profiles Superadmin manage all profiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Superadmin manage all profiles" ON public.profiles USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- Name: quick_wins Superadmin manage all quick_wins; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Superadmin manage all quick_wins" ON public.quick_wins TO authenticated USING (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text])))) WITH CHECK (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text]))));


--
-- Name: vsm_projects Superadmin manage all vsm; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Superadmin manage all vsm" ON public.vsm_projects TO authenticated USING (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text])))) WITH CHECK (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text]))));


--
-- Name: companies Superadmin manage companies; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Superadmin manage companies" ON public.companies TO authenticated USING (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text])))) WITH CHECK (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text) OR ((auth.jwt() ->> 'email'::text) = ANY (ARRAY['ariel.mellag@gmail.com'::text, 'equipo@belean.cl'::text]))));


--
-- Name: companies Superadmin view all companies; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Superadmin view all companies" ON public.companies FOR SELECT TO authenticated USING ((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text));


--
-- Name: audit_5s Users can delete audit_5s for their company; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can delete audit_5s for their company" ON public.audit_5s FOR DELETE USING (((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = audit_5s.company_id)))) OR public.is_admin()));


--
-- Name: audit_5s_entries Users can delete entries for their company audits; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can delete entries for their company audits" ON public.audit_5s_entries FOR DELETE USING (((EXISTS ( SELECT 1
   FROM (public.audit_5s
     JOIN public.profiles ON ((profiles.company_id = audit_5s.company_id)))
  WHERE ((audit_5s.id = audit_5s_entries.audit_id) AND (profiles.id = auth.uid())))) OR public.is_admin()));


--
-- Name: audit_5s Users can insert audit_5s for their company; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert audit_5s for their company" ON public.audit_5s FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = audit_5s.company_id)))) OR public.is_admin()));


--
-- Name: audit_5s_entries Users can insert entries for their company audits; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert entries for their company audits" ON public.audit_5s_entries FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM (public.audit_5s
     JOIN public.profiles ON ((profiles.company_id = audit_5s.company_id)))
  WHERE ((audit_5s.id = audit_5s_entries.audit_id) AND (profiles.id = auth.uid())))) OR public.is_admin()));


--
-- Name: audit_5s Users can update audit_5s for their company; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update audit_5s for their company" ON public.audit_5s FOR UPDATE USING (((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = audit_5s.company_id)))) OR public.is_admin()));


--
-- Name: audit_5s_entries Users can update entries for their company audits; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update entries for their company audits" ON public.audit_5s_entries FOR UPDATE USING (((EXISTS ( SELECT 1
   FROM (public.audit_5s
     JOIN public.profiles ON ((profiles.company_id = audit_5s.company_id)))
  WHERE ((audit_5s.id = audit_5s_entries.audit_id) AND (profiles.id = auth.uid())))) OR public.is_admin()));


--
-- Name: audit_5s Users can view audit_5s of their company; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view audit_5s of their company" ON public.audit_5s FOR SELECT USING (((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = audit_5s.company_id)))) OR public.is_admin()));


--
-- Name: audit_5s_entries Users can view entries of their company audits; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view entries of their company audits" ON public.audit_5s_entries FOR SELECT USING (((EXISTS ( SELECT 1
   FROM (public.audit_5s
     JOIN public.profiles ON ((profiles.company_id = audit_5s.company_id)))
  WHERE ((audit_5s.id = audit_5s_entries.audit_id) AND (profiles.id = auth.uid())))) OR public.is_admin()));


--
-- Name: a3_projects Ver a3_projects; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Ver a3_projects" ON public.a3_projects FOR SELECT USING ((public.is_admin() OR ((company_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = a3_projects.company_id))))) OR ((responsible IS NOT NULL) AND (responsible = ( SELECT profiles.name
   FROM public.profiles
  WHERE (profiles.id = auth.uid())))) OR (company_id IS NULL)));


--
-- Name: five_s_cards Ver five_s_cards; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Ver five_s_cards" ON public.five_s_cards FOR SELECT USING ((public.is_admin() OR ((company_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = five_s_cards.company_id))))) OR ((responsible IS NOT NULL) AND (responsible = ( SELECT profiles.name
   FROM public.profiles
  WHERE (profiles.id = auth.uid())))) OR (company_id IS NULL)));


--
-- Name: profiles Ver perfiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Ver perfiles" ON public.profiles FOR SELECT USING (((auth.uid() = id) OR public.is_admin()));


--
-- Name: quick_wins Ver quick_wins; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Ver quick_wins" ON public.quick_wins FOR SELECT USING ((public.is_admin() OR ((company_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = quick_wins.company_id))))) OR ((responsible IS NOT NULL) AND (responsible = ( SELECT profiles.name
   FROM public.profiles
  WHERE (profiles.id = auth.uid())))) OR (company_id IS NULL)));


--
-- Name: vsm_projects Ver vsm_projects; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Ver vsm_projects" ON public.vsm_projects FOR SELECT USING ((public.is_admin() OR ((company_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.company_id = vsm_projects.company_id))))) OR ((responsible IS NOT NULL) AND (responsible = ( SELECT profiles.name
   FROM public.profiles
  WHERE (profiles.id = auth.uid()))))));


--
-- Name: a3_projects; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.a3_projects ENABLE ROW LEVEL SECURITY;

--
-- Name: audit_5s; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.audit_5s ENABLE ROW LEVEL SECURITY;

--
-- Name: audit_5s_entries; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.audit_5s_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: companies; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.companies ENABLE ROW LEVEL SECURITY;

--
-- Name: five_s_cards; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.five_s_cards ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: quick_wins; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.quick_wins ENABLE ROW LEVEL SECURITY;

--
-- Name: vsm_projects; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.vsm_projects ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

-- ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

-- --
-- -- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
-- --

-- CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


-- --
-- -- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
-- --

-- CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
--          WHEN TAG IN ('DROP EXTENSION')
--    EXECUTE FUNCTION extensions.set_graphql_placeholder();


-- --
-- -- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
-- --

-- CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
--          WHEN TAG IN ('CREATE EXTENSION')
--    EXECUTE FUNCTION extensions.grant_pg_cron_access();


-- --
-- -- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
-- --

-- CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
--          WHEN TAG IN ('CREATE FUNCTION')
--    EXECUTE FUNCTION extensions.grant_pg_graphql_access();


-- --
-- -- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
-- --

-- CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
--          WHEN TAG IN ('CREATE EXTENSION')
--    EXECUTE FUNCTION extensions.grant_pg_net_access();


-- --
-- -- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
-- --

-- CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
--    EXECUTE FUNCTION extensions.pgrst_ddl_watch();


-- --
-- -- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
-- --

-- CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
--    EXECUTE FUNCTION extensions.pgrst_drop_watch();


--
-- PostgreSQL database dump complete
--



