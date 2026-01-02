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
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: -
--

-- INSERT INTO _realtime.tenants VALUES ('0d8c5415-4004-4a90-bbed-dfb3c4f9f140', 'realtime-dev', 'realtime-dev', 'iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==', 200, '2026-01-01 23:33:50', '2026-01-01 23:33:50', 100, 'postgres_cdc_rls', 100000, 100, 100, false, '{"keys": [{"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}', false, false, 65, 'gen_rpc', 1000, 3000);


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: -
--

-- INSERT INTO _realtime.extensions VALUES ('30fdb14c-b8bd-4e39-b124-421ba3555c02', 'postgres_cdc_rls', '{"region": "us-east-1", "db_host": "cl8/MafHaEJM9z8rYMsSg/q9UTdVXNb8A+iZ9ygn8P8=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}', 'realtime-dev', '2026-01-01 23:33:50', '2026-01-01 23:33:50');


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: -
--

-- INSERT INTO _realtime.schema_migrations VALUES (20210706140551, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20220329161857, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20220410212326, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20220506102948, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20220527210857, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20220815211129, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20220815215024, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20220818141501, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20221018173709, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20221102172703, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20221223010058, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20230110180046, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20230810220907, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20230810220924, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20231024094642, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20240306114423, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20240418082835, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20240625211759, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20240704172020, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20240902173232, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20241106103258, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20250424203323, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20250613072131, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20250711044927, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20250811121559, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20250926223044, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20251204170944, '2026-01-01 23:33:16');
-- INSERT INTO _realtime.schema_migrations VALUES (20251218000543, '2026-01-01 23:33:16');


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.companies VALUES ('3dea8bfd-a66c-4c79-a64d-55b10b0b9a83', 'Transportes del Sur', 'transsur.cl', '2026-01-01 23:33:39.154689+00');
INSERT INTO public.companies VALUES ('902d19b6-6771-46e9-866a-936628c8cd67', 'CIAL Alimentos', 'cial.cl', '2026-01-01 23:33:40.011547+00');
INSERT INTO public.companies VALUES ('ba434215-afa9-4452-947f-901b4989f17f', 'Be Lean', 'belean.cl', '2026-01-01 23:33:40.011547+00');


--
-- Data for Name: a3_projects; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.a3_projects VALUES ('1b54b47c-5930-4ccc-96fe-cee232213e27', NULL, 'a3', 'Nuevo', 'Equipo Be Lean', '2026-01-02', 'qwe', 'qwe', 'qwewq', '1231231', '[{"problem": "123123", "categories": {"material": [{"text": "123123", "color": "neutral"}]}}]', '[{"id": 1767312670084, "whys": ["123123", "", "", "", ""], "status": "neutral", "problem": "123123", "parentId": null, "parentWhyIndex": -1}]', '12312', '', '[{"id": 1767312723134, "date": "2026-01-01", "status": "pending", "activity": "12312", "responsible": "Ariel"}, {"id": 1767313034499, "date": "2026-01-01", "status": "done", "activity": "qeqwe", "responsible": "Ariel"}]', '123213', '[{"id": 1767312725562, "goal": "", "kpiName": "", "dataPoints": [{"id": 1767312727424, "date": "2026-01-02", "value": "32"}, {"id": 1767312731665, "date": "2026-01-02", "value": "44"}], "showInDashboard": true}]', '2026-01-02 00:08:52.943406+00', '', '', '[]');


--
-- Data for Name: audit_5s; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.audit_5s VALUES ('cec04539-e0c4-42b3-b2e6-d7d4c1781762', '902d19b6-6771-46e9-866a-936628c8cd67', 'Producción - Línea 1', 'Ariel Mella', '2025-12-01', 92, '2026-01-01 23:33:40.011547+00', 'Auditoría Mensual Q1');
INSERT INTO public.audit_5s VALUES ('eb55aee6-e96e-47ec-93f4-7579d0f85b37', '3dea8bfd-a66c-4c79-a64d-55b10b0b9a83', 'qweeqw', 'Equipo Be Lean', '2026-01-02', 1, '2026-01-02 00:05:59.810946+00', 'qweqw');


--
-- Data for Name: audit_5s_entries; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.audit_5s_entries VALUES ('2a30e6ab-f43d-4591-9a24-2afeb7c09e35', 'cec04539-e0c4-42b3-b2e6-d7d4c1781762', 'S1', '¿Se han eliminado los elementos innecesarios?', 5, 'Todo despejado', '2026-01-01 23:33:40.011547+00');
INSERT INTO public.audit_5s_entries VALUES ('08676698-fdaf-4791-88a2-6396e3d0252e', 'cec04539-e0c4-42b3-b2e6-d7d4c1781762', 'S2', '¿Cada cosa en su lugar?', 5, 'Orden impecable', '2026-01-01 23:33:40.011547+00');
INSERT INTO public.audit_5s_entries VALUES ('c532b597-2060-4e66-be72-d7353d82da56', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S1', '¿Se han eliminado los elementos innecesarios del área?', 5, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('680a7f3e-a884-4c14-bf4a-f56645e7ae76', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S1', '¿Las herramientas y materiales están clasificados correctamente?', 5, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('82832a37-6911-461b-bb3b-f4724fa027c3', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S1', '¿Los pasillos y zonas de paso están libres de obstáculos?', 5, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('9976758f-3d7e-4153-8912-80d089d1e1e5', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S2', '¿Cada cosa tiene un lugar asignado y está en su lugar?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('c4ea0fa3-231f-4a6c-9bd5-fe8ec71d9adc', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S2', '¿Las ubicaciones están claramente etiquetadas?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('bd5c7241-f50e-44a0-968f-8fc7d4dc6735', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S2', '¿Es fácil encontrar y devolver las herramientas?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('c1dd8d96-174e-464b-b8e4-a8392a7a43db', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S3', '¿El área de trabajo está limpia y libre de polvo/aceite?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('937ae6b5-7a3c-4de1-be57-7b83cbfa34c9', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S3', '¿Existen programas de limpieza visibles y se siguen?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('6f1593a9-6b40-4423-a579-1d6981d4a1e4', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S3', '¿Los equipos de limpieza están disponibles y en buen estado?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('ca072ddc-23ef-4181-abc1-d9c9d78100ba', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S4', '¿Existen estándares visuales claros para el estado "normal"?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('47f01875-01fb-4618-9474-5a112b26758c', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S4', '¿Se utiliza código de colores para identificar anomalías?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('fb88c869-c50e-49a1-8050-c19bb074eecb', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S4', '¿Todos conocen los procedimientos estándar?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('2e84480a-d729-4e03-8f51-6f0638df39f8', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S5', '¿Se realizan auditorías periódicas?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('31238ff7-33cd-44e7-b0ea-147a29533c89', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S5', '¿Se respetan las normas establecidas consistentemente?', 0, '', '2026-01-02 00:05:59.825454+00');
INSERT INTO public.audit_5s_entries VALUES ('aedfdee0-247d-4fae-b5c8-aaf7829d5d83', 'eb55aee6-e96e-47ec-93f4-7579d0f85b37', 'S5', '¿Existe un plan de mejora continua activo?', 0, '', '2026-01-02 00:05:59.825454+00');


--
-- Data for Name: company_card_counters; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.company_card_counters VALUES ('902d19b6-6771-46e9-866a-936628c8cd67', 0);
INSERT INTO public.company_card_counters VALUES ('ba434215-afa9-4452-947f-901b4989f17f', 1);
INSERT INTO public.company_card_counters VALUES ('3dea8bfd-a66c-4c79-a64d-55b10b0b9a83', 4);


--
-- Data for Name: five_s_cards; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.five_s_cards VALUES ('cf2eb567-9751-49f5-b988-17573d9ac1bf', '3dea8bfd-a66c-4c79-a64d-55b10b0b9a83', '2026-01-01', '123', '123', '12123', '123', '123', 'Equipo Be Lean', '2025-12-29', '2026-01-01', 'Cerrado', NULL, 'Clasificar', 'http://127.0.0.1:54321/storage/v1/object/public/images/natw4bicrg_1767310700414.png', 'http://127.0.0.1:54321/storage/v1/object/public/images/qc8rwro65pd_1767312786784.png', 1, '2026-01-01 23:38:20.515827+00');
INSERT INTO public.five_s_cards VALUES ('057388e8-17ba-458e-9e9d-7d779b3ef8d3', '3dea8bfd-a66c-4c79-a64d-55b10b0b9a83', '2026-01-02', 'qwe', 'qwe', 'qwe', 'qweqw', 'qwe', 'Ariel', '2026-01-14', NULL, 'En Proceso', NULL, 'Clasificar', 'http://127.0.0.1:54321/storage/v1/object/public/images/zcl596vzf8k_1767313268140.png', NULL, 3, '2026-01-02 00:21:26.710226+00');
INSERT INTO public.five_s_cards VALUES ('ff12c47d-c522-4378-91d2-b3d09835a568', '3dea8bfd-a66c-4c79-a64d-55b10b0b9a83', '2025-12-28', 'Area de Prueba de Métricas', NULL, NULL, 'Prueba de cálculo de días', NULL, 'QA Bot', NULL, '2026-01-01', 'Cerrado', NULL, NULL, NULL, NULL, 4, '2026-01-02 00:29:10.356122+00');


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.profiles VALUES ('70000000-0000-0000-0000-000000000002', 'equipo@belean.cl', 'Equipo Be Lean', 'superadmin', NULL, true, '2026-01-01 23:33:40.011547+00', NULL);
INSERT INTO public.profiles VALUES ('00000000-0000-0000-0000-000000000001', 'ariel.mellag@gmail.com', 'Ariel', 'superadmin', NULL, true, '2026-01-01 23:33:39.825707+00', NULL);


--
-- Data for Name: quick_wins; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.quick_wins VALUES ('c1653cdf-ac82-443a-bd64-e2380ab1d3c9', 'ba434215-afa9-4452-947f-901b4989f17f', 'qwe', 'qwe', 'idea', 'Medio', 'Ariel', '2026-01-02', '2026-01-01', 'http://127.0.0.1:54321/storage/v1/object/public/images/b7tcl9xhs8j_1767312409011.png', NULL, NULL, NULL, 0, '2026-01-02 00:06:50.028884+00', 'qweeq');
INSERT INTO public.quick_wins VALUES ('36e28c11-b413-4395-a18c-afd0d15ac33d', '3dea8bfd-a66c-4c79-a64d-55b10b0b9a83', 'qwe', 'qwe', 'done', 'Medio', 'Equipo Be Lean', '2026-01-01', '2026-01-01', NULL, 'http://127.0.0.1:54321/storage/v1/object/public/images/pp1m3f6oat_1767313011359.png', 'qewqqw', '2026-01-02 00:16:54.048+00', 0, '2026-01-01 23:48:39.024846+00', 'qwe');


--
-- Data for Name: vsm_projects; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vsm_projects VALUES ('5efe53f0-62b0-4f47-b644-c577eafb3019', '3dea8bfd-a66c-4c79-a64d-55b10b0b9a83', '21312', '', '', '2026-01-01', 'current', '', '', '', NULL, '', '2026-01-01 23:40:30.03164+00', NULL, '');


--
-- Data for Name: messages_2025_12_31; Type: TABLE DATA; Schema: realtime; Owner: -
--



--
-- Data for Name: messages_2026_01_01; Type: TABLE DATA; Schema: realtime; Owner: -
--



--
-- Data for Name: messages_2026_01_02; Type: TABLE DATA; Schema: realtime; Owner: -
--



--
-- Data for Name: messages_2026_01_03; Type: TABLE DATA; Schema: realtime; Owner: -
--



--
-- Data for Name: messages_2026_01_04; Type: TABLE DATA; Schema: realtime; Owner: -
--



--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

INSERT INTO realtime.schema_migrations VALUES (20211116024918, '2026-01-01 23:33:21');
INSERT INTO realtime.schema_migrations VALUES (20211116045059, '2026-01-01 23:33:21');
INSERT INTO realtime.schema_migrations VALUES (20211116050929, '2026-01-01 23:33:21');
INSERT INTO realtime.schema_migrations VALUES (20211116051442, '2026-01-01 23:33:21');
INSERT INTO realtime.schema_migrations VALUES (20211116212300, '2026-01-01 23:33:21');
INSERT INTO realtime.schema_migrations VALUES (20211116213355, '2026-01-01 23:33:21');
INSERT INTO realtime.schema_migrations VALUES (20211116213934, '2026-01-01 23:33:21');
INSERT INTO realtime.schema_migrations VALUES (20211116214523, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20211122062447, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20211124070109, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20211202204204, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20211202204605, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20211210212804, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20211228014915, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220107221237, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220228202821, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220312004840, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220603231003, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220603232444, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220615214548, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220712093339, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220908172859, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20220916233421, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20230119133233, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20230128025114, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20230128025212, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20230227211149, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20230228184745, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20230308225145, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20230328144023, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20231018144023, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20231204144023, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20231204144024, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20231204144025, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20240108234812, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20240109165339, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20240227174441, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20240311171622, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20240321100241, '2026-01-01 23:33:22');
INSERT INTO realtime.schema_migrations VALUES (20240401105812, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20240418121054, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20240523004032, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20240618124746, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20240801235015, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20240805133720, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20240827160934, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20240919163303, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20240919163305, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20241019105805, '2026-01-01 23:33:23');
INSERT INTO realtime.schema_migrations VALUES (20241030150047, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20241108114728, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20241121104152, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20241130184212, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20241220035512, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20241220123912, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20241224161212, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20250107150512, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20250110162412, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20250123174212, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20250128220012, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20250506224012, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20250523164012, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20250714121412, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20250905041441, '2026-01-01 23:33:24');
INSERT INTO realtime.schema_migrations VALUES (20251103001201, '2026-01-01 23:33:24');


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--



--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: -
--



--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: -
--

INSERT INTO supabase_functions.migrations VALUES ('initial', '2026-01-01 23:33:11.132285+00');
INSERT INTO supabase_functions.migrations VALUES ('20210809183423_update_grants', '2026-01-01 23:33:11.132285+00');


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: -
--

-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20240101000000', '{"-- SOLUCIÓN DEFINITIVA DE CONFLICTOS
-- Ejecuta esto para limpiar y recrear todo correctamente.
-- 
-- 1. Eliminar Trigger existente (Forzado)
-- drop trigger if exists on_auth_user_created on auth.users","drop function if exists public.handle_new_user()","-- 2. Crear Tablas (Si no existen)
-- do $$
-- begin
--   if not exists (select 1 from pg_class c join pg_namespace n on n.oid = c.relnamespace where c.relname = ''companies'' and n.nspname = ''public'') then
--     create table public.companies (
--       id uuid default gen_random_uuid() primary key,
--       name text not null,
--       domain text not null unique,
--       created_at timestamp with time zone default timezone(''utc''::text, now()) not null
--     );
--   end if;
-- end $$","do $$
-- begin
--   if not exists (select 1 from pg_class c join pg_namespace n on n.oid = c.relnamespace where c.relname = ''profiles'' and n.nspname = ''public'') then
--     create table public.profiles (
--       id uuid references auth.users not null primary key,
--       email text,
--       name text,
--       role text default ''user'', -- ''admin'' o ''user''
--       company_id uuid references public.companies(id),
--       is_authorized boolean default false,
--       created_at timestamp with time zone default timezone(''utc''::text, now()) not null
--     );
--   end if;
-- end $$","-- 3. Habilitar RLS
-- alter table public.companies enable row level security","alter table public.profiles enable row level security","-- 4. Función de Seguridad (CRÍTICO: Evita Error 500 / Recursión)
-- create or replace function public.is_admin()
-- returns boolean as $$
-- begin
--   -- Permite verificar si es admin sin activar políticas RLS recursivas
--   return exists (
--     select 1 from public.profiles
--     where id = auth.uid() and role = ''superadmin'' -- Changed to superadmin explicitly for logic
--   );
-- end;
-- $$ language plpgsql security definer","-- 5. Políticas de Acceso
-- 
-- EMPRESAS
-- drop policy if exists \"Empresas visibles para todos\" on public.companies","create policy \"Empresas visibles para todos\"
--   on public.companies for select using (auth.role() = ''authenticated'')","drop policy if exists \"Admins pueden gestionar empresas\" on public.companies","create policy \"Admins pueden gestionar empresas\"
--   on public.companies for all using ( public.is_admin() )","-- PERFILES
-- drop policy if exists \"Ver perfiles\" on public.profiles","create policy \"Ver perfiles\"
--   on public.profiles for select using (
--     auth.uid() = id
--     OR
--     public.is_admin()
--   )","drop policy if exists \"Actualizar perfiles\" on public.profiles","create policy \"Actualizar perfiles\"
--   on public.profiles for update using (
--     auth.uid() = id
--     OR
--     public.is_admin()
--   )","drop policy if exists \"Insertar perfiles\" on public.profiles","create policy \"Insertar perfiles\"
--   on public.profiles for insert with check (auth.uid() = id)","-- 6. Trigger de Nuevo Usuario (MEJORADO PARA SUPERADMINS)
-- create or replace function public.handle_new_user()
-- returns trigger as $$
-- declare
--   is_super boolean;
--   comp_id uuid;
-- begin
--   -- Lógica Superadmin Hardcoded
--   if new.email = ''ariel.mellag@gmail.com'' or new.email = ''equipo@belean.cl'' then
--     is_super := true;
--   else
--     is_super := false;
--   end if;
-- 
--   -- Asignar Empresa Be Lean
--   if new.email = ''equipo@belean.cl'' then
--     select id into comp_id from public.companies where domain = ''belean.cl'';
--   else
--     comp_id := null;
--   end if;
-- 
--   insert into public.profiles (id, email, name, role, is_authorized, company_id)
--   values (
--     new.id, 
--     new.email, 
--     new.raw_user_meta_data->>''name'',
--     case when is_super then ''superadmin'' else ''user'' end,
--     case when is_super then true else false end,
--     comp_id
--   )
--   on conflict (id) do update 
--   set email = excluded.email, 
--       name = excluded.name, 
--       role = case when is_super then ''superadmin'' else profiles.role end,
--       is_authorized = case when is_super then true else profiles.is_authorized end; 
--       
--   return new;
-- end;
-- $$ language plpgsql security definer","drop trigger if exists on_auth_user_created on auth.users","create trigger on_auth_user_created
--   after insert on auth.users
--   for each row execute procedure public.handle_new_user()","-- 7. Datos y Correcciones
-- insert into public.companies (name, domain)
-- select ''CIAL Alimentos'', ''cialalimentos.cl''
-- where not exists (select 1 from public.companies where domain = ''cialalimentos.cl'')","insert into public.companies (name, domain)
-- select ''Transportes del Sur'', ''transsur.cl''
-- where not exists (select 1 from public.companies where domain = ''transsur.cl'')","-- 8. MÓDULO AUDITORÍA 5S
-- do $$
-- begin
--   if not exists (select 1 from pg_class c join pg_namespace n on n.oid = c.relnamespace where c.relname = ''audit_5s'' and n.nspname = ''public'') then
--     create table public.audit_5s (
--       id uuid default gen_random_uuid() primary key,
--       company_id uuid references public.companies(id) not null,
--       area text not null,
--       auditor text not null,
--       audit_date date not null,
--       total_score numeric default 0,
--       created_at timestamp with time zone default timezone(''utc''::text, now()) not null
--     );
--   end if;
-- end $$","do $$
-- begin
--   if not exists (select 1 from pg_class c join pg_namespace n on n.oid = c.relnamespace where c.relname = ''audit_5s_entries'' and n.nspname = ''public'') then
--     create table public.audit_5s_entries (
--       id uuid default gen_random_uuid() primary key,
--       audit_id uuid references public.audit_5s(id) on delete cascade not null,
--       section text not null, -- ''S1'', ''S2'', ''S3'', ''S4'', ''S5''
--       question text not null,
--       score integer default 0, -- 0-5
--       comment text,
--       created_at timestamp with time zone default timezone(''utc''::text, now()) not null
--     );
--   end if;
-- end $$","-- RLS Auditoría 5S
-- alter table public.audit_5s enable row level security","alter table public.audit_5s_entries enable row level security","-- Policies for audit_5s
-- drop policy if exists \"Users can view audit_5s of their company\" on public.audit_5s","create policy \"Users can view audit_5s of their company\" on public.audit_5s
--   for select using (
--     exists (
--       select 1 from public.profiles
--       where profiles.id = auth.uid()
--       and profiles.company_id = audit_5s.company_id
--     )
--     or public.is_admin()
--   )","drop policy if exists \"Users can insert audit_5s for their company\" on public.audit_5s","create policy \"Users can insert audit_5s for their company\" on public.audit_5s
--   for insert with check (
--     exists (
--       select 1 from public.profiles
--       where profiles.id = auth.uid()
--       and profiles.company_id = audit_5s.company_id
--     )
--     or public.is_admin()
--   )","drop policy if exists \"Users can update audit_5s for their company\" on public.audit_5s","create policy \"Users can update audit_5s for their company\" on public.audit_5s
--   for update using (
--     exists (
--       select 1 from public.profiles
--       where profiles.id = auth.uid()
--       and profiles.company_id = audit_5s.company_id
--     )
--     or public.is_admin()
--   )","drop policy if exists \"Users can delete audit_5s for their company\" on public.audit_5s","create policy \"Users can delete audit_5s for their company\" on public.audit_5s
--   for delete using (
--     exists (
--       select 1 from public.profiles
--       where profiles.id = auth.uid()
--       and profiles.company_id = audit_5s.company_id
--     )
--     or public.is_admin()
--   )","-- Policies for audit_5s_entries
-- drop policy if exists \"Users can view entries of their company audits\" on public.audit_5s_entries","create policy \"Users can view entries of their company audits\" on public.audit_5s_entries
--   for select using (
--     exists (
--       select 1 from public.audit_5s
--       join public.profiles on profiles.company_id = audit_5s.company_id
--       where audit_5s.id = audit_5s_entries.audit_id
--       and profiles.id = auth.uid()
--     )
--     or public.is_admin()
--   )","drop policy if exists \"Users can insert entries for their company audits\" on public.audit_5s_entries","create policy \"Users can insert entries for their company audits\" on public.audit_5s_entries
--   for insert with check (
--     exists (
--       select 1 from public.audit_5s
--       join public.profiles on profiles.company_id = audit_5s.company_id
--       where audit_5s.id = audit_5s_entries.audit_id
--       and profiles.id = auth.uid()
--     )
--     or public.is_admin()
--   )","drop policy if exists \"Users can update entries for their company audits\" on public.audit_5s_entries","create policy \"Users can update entries for their company audits\" on public.audit_5s_entries
--     for update using (
--         exists (
--             select 1 from public.audit_5s
--             join public.profiles on profiles.company_id = audit_5s.company_id
--             where audit_5s.id = audit_5s_entries.audit_id
--             and profiles.id = auth.uid()
--         )
--         or public.is_admin()
--     )","drop policy if exists \"Users can delete entries for their company audits\" on public.audit_5s_entries","create policy \"Users can delete entries for their company audits\" on public.audit_5s_entries
--     for delete using (
--         exists (
--             select 1 from public.audit_5s
--             join public.profiles on profiles.company_id = audit_5s.company_id
--             where audit_5s.id = audit_5s_entries.audit_id
--             and profiles.id = auth.uid()
--         )
--         or public.is_admin()
--     )","-- 9. ACTUALIZACIONES (Add Title)
-- alter table public.audit_5s add column if not exists title text","-- 10. IMAGENES Y STORAGE
-- Bucket para imágenes
-- insert into storage.buckets (id, name, public)
-- values (''images'', ''images'', true)
-- on conflict (id) do nothing","-- Políticas de Storage
-- drop policy if exists \"Public Access to Images\" on storage.objects","create policy \"Public Access to Images\"
--   on storage.objects for select
--   using ( bucket_id = ''images'' )","drop policy if exists \"Authenticated users can upload images\" on storage.objects","create policy \"Authenticated users can upload images\"
--   on storage.objects for insert
--   with check ( bucket_id = ''images'' and auth.role() = ''authenticated'' )","-- Perfil de Usuario (Avatar)
-- alter table public.profiles add column if not exists avatar_url text","-- MIGRACIÓN COMPLETA DE MÓDULOS FALTANTES (Quick Wins, VSM, A3, Tarjetas 5S)
-- Ejecuta este script en el Editor SQL de Supabase para crear todas las tablas necesarias.
-- 
-- 1. QUICK WINS
-- create table if not exists public.quick_wins (
--   id uuid default gen_random_uuid() primary key,
--   company_id uuid references public.companies(id),
--   title text not null,
--   description text,
--   status text default ''idea'', 
--   impact text default ''Medio'',
--   responsible text,
--   date date default current_date,
--   deadline date,
--   image_url text,
--   completion_image_url text,
--   completion_comment text,
--   completed_at timestamp with time zone,
--   likes integer default 0,
--   created_at timestamp with time zone default timezone(''utc''::text, now()) not null
-- )","alter table public.quick_wins enable row level security","-- 2. TARJETAS 5S (Distinto de Auditorías 5S)
-- create table if not exists public.five_s_cards (
--   id uuid default gen_random_uuid() primary key,
--   company_id uuid references public.companies(id),
--   date date default current_date,
--   location text,
--   article text,
--   reporter text,
--   reason text,
--   proposed_action text,
--   responsible text,
--   target_date date,
--   solution_date date,
--   status text default ''Pendiente'',
--   status_color text, -- Opcional, se puede manejar en front
--   type text, -- ''Clasificar'', ''Ordenar'', etc.
--   image_before text,
--   image_after text,
--   card_number integer, -- Added for sequential ID
--   created_at timestamp with time zone default timezone(''utc''::text, now()) not null
-- )","alter table public.five_s_cards enable row level security","-- 3. VSM (Value Stream Mapping)
-- create table if not exists public.vsm_projects (
--   id uuid default gen_random_uuid() primary key,
--   company_id uuid references public.companies(id),
--   name text not null,
--   description text,
--   responsible text,
--   date date default current_date,
--   status text default ''current'', -- ''current'', ''future''
--   lead_time text,
--   process_time text,
--   efficiency text,
--   image_url text,
--   miro_link text,
--   created_at timestamp with time zone default timezone(''utc''::text, now()) not null
-- )","alter table public.vsm_projects enable row level security","-- 4. PROYECTOS A3
-- create table if not exists public.a3_projects (
--   id uuid default gen_random_uuid() primary key,
--   company_id uuid references public.companies(id),
--   title text not null,
--   status text default ''Nuevo'',
--   responsible text,
--   date date default current_date,
--   
--   -- Step 1: Definition
--   background text,
--   current_condition text,
--   goal text,
--   
--   -- Step 2: Analysis
--   root_cause text, -- Resumen de texto
--   ishikawas jsonb default ''[]''::jsonb, -- Array de diagramas
--   five_whys jsonb default ''[]''::jsonb, -- Array de análisis
--   
--   -- Step 3: Plan & Followup
--   countermeasures text,
--   execution_plan text, -- Texto simple del plan (campo antiguo ''plan'')
--   action_plan jsonb default ''[]''::jsonb, -- Estructura detallada
--   follow_up_notes text, -- Notas de cierre
--   follow_up_data jsonb default ''{}''::jsonb, -- Datos de gráficos
--   
--   created_at timestamp with time zone default timezone(''utc''::text, now()) not null
-- )","alter table public.a3_projects enable row level security","-- POLÍTICAS DE SEGURIDAD (RLS) GENÉRICAS PARA TODOS LOS MÓDULOS
-- Se aplican las mismas reglas: Admin ve todo, Usuario ve su empresa + sus asignaciones + globales.
-- 
-- do $$
-- declare
--   tbl text;
-- begin
--   foreach tbl in array ARRAY[''quick_wins'', ''five_s_cards'', ''vsm_projects'', ''a3_projects''] loop
--     
--     -- SELECT POLICY
--     execute format(''drop policy if exists \"Ver %I\" on public.%I'', tbl, tbl);
--     execute format(''
--       create policy \"Ver %I\" on public.%I for select using (
--         public.is_admin()
--         OR
--         (company_id is not null and exists (select 1 from public.profiles where id = auth.uid() and company_id = %I.company_id))
--         OR
--         (responsible is not null and responsible = (select name from public.profiles where id = auth.uid()))
--         OR
--         company_id is null
--       )'', tbl, tbl, tbl);
-- 
--     -- UPDATE/INSERT/DELETE POLICY (Simplificada: si puedes ver, puedes editar por ahora, o restringir más si se desea)
--     execute format(''drop policy if exists \"Gestionar %I\" on public.%I'', tbl, tbl);
--     execute format(''
--       create policy \"Gestionar %I\" on public.%I for all using (
--         public.is_admin()
--         OR
--         (company_id is not null and exists (select 1 from public.profiles where id = auth.uid() and company_id = %I.company_id))
--         OR
--         (responsible is not null and responsible = (select name from public.profiles where id = auth.uid()))
--         OR
--         company_id is null
--       )'', tbl, tbl, tbl);
--       
--   end loop;
-- end $$","-- 1) Crear tabla de contadores por compañía (idempotente)
-- CREATE TABLE IF NOT EXISTS public.company_card_counters (
--   company_id uuid PRIMARY KEY,
--   last_number integer NOT NULL DEFAULT 0
-- )","-- 2) Asegurar UNIQUE constraint para mayor seguridad
-- ALTER TABLE public.five_s_cards
--   ADD CONSTRAINT unique_company_card_number UNIQUE (company_id, card_number)","-- 3) Función trigger segura que respeta card_number provisto y usa contador atómico
-- CREATE OR REPLACE FUNCTION public.set_five_s_card_number()
-- RETURNS TRIGGER AS $$
-- DECLARE
--   newnum integer;
-- BEGIN
--   -- Si la aplicación ya proporcionó un número, no lo sobrescribimos
--   IF NEW.card_number IS NOT NULL THEN
--     RETURN NEW;
--   END IF;
-- 
--   -- Incrementar o insertar el contador de forma atómica
--   INSERT INTO public.company_card_counters(company_id, last_number)
--     VALUES (NEW.company_id, 1)
--   ON CONFLICT (company_id)
--   DO UPDATE SET last_number = company_card_counters.last_number + 1
--   RETURNING last_number INTO newnum;
-- 
--   NEW.card_number := newnum;
--   RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql","-- 4) Crear / reemplazar trigger (antes eliminamos si existe)
-- DROP TRIGGER IF EXISTS trigger_set_five_s_card_number ON public.five_s_cards","CREATE TRIGGER trigger_set_five_s_card_number
-- BEFORE INSERT ON public.five_s_cards
-- FOR EACH ROW
-- EXECUTE FUNCTION public.set_five_s_card_number()"}', 'initial_schema');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20240101000001', '{"-- FIX SCRIPT: Elevate User to Superadmin and Fix Permissions
-- Run this in your Supabase SQL Editor or via psql
-- 
-- BEGIN","-- 1. Upgrade Ariel to Superadmin and Unbind from CIAL
-- UPDATE public.profiles
-- SET role = ''superadmin'', company_id = NULL
-- WHERE email = ''ariel.mellag@gmail.com''","-- 2. Ensure RLS Policies allow Superadmin to see everything
-- We update or create policies for key tables
-- 
-- 2.1 Profiles Policy
-- DROP POLICY IF EXISTS \"Superadmin view all profiles\" ON public.profiles","CREATE POLICY \"Superadmin view all profiles\"
-- ON public.profiles FOR SELECT
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin''
-- )","-- 2.2 Companies Policy
-- DROP POLICY IF EXISTS \"Superadmin view all companies\" ON public.companies","CREATE POLICY \"Superadmin view all companies\"
-- ON public.companies FOR SELECT
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin''
-- )","DROP POLICY IF EXISTS \"Superadmin manage companies\" ON public.companies","CREATE POLICY \"Superadmin manage companies\"
-- ON public.companies FOR ALL
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin''
-- )","-- 2.3 5S Cards Policy
-- DROP POLICY IF EXISTS \"Superadmin select all cards\" ON public.five_s_cards","CREATE POLICY \"Superadmin select all cards\"
-- ON public.five_s_cards FOR SELECT
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin''
-- )",COMMIT,"SELECT * FROM public.profiles WHERE email = ''ariel.mellag@gmail.com''"}', 'fix_admin');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20240101000002', '{"-- Migration: Fix Superadmin RLS Policies
-- Description: Unlocks full access for Superadmins across all companies (even when company_id is NULL or set to a specific one)
-- 
-- BEGIN","-- 1. Function to check for superadmin role effectively
-- (Optional helper, but we''ll stick to direct checks for clarity)
-- 
-- --------------------------------------------------------------
-- 5S CARDS (five_s_cards)
-- --------------------------------------------------------------
-- DROP POLICY IF EXISTS \"Superadmin select all cards\" ON public.five_s_cards","DROP POLICY IF EXISTS \"Superadmin insert all cards\" ON public.five_s_cards","DROP POLICY IF EXISTS \"Superadmin update all cards\" ON public.five_s_cards","DROP POLICY IF EXISTS \"Superadmin delete all cards\" ON public.five_s_cards","-- Unified Policy for Superadmin (Select, Insert, Update, Delete)
-- CREATE POLICY \"Superadmin manage all cards\"
-- ON public.five_s_cards
-- FOR ALL
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )
-- WITH CHECK (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )","--------------------------------------------------------------
-- A3 PROJECTS (a3_projects)
-- --------------------------------------------------------------
-- DROP POLICY IF EXISTS \"Superadmin manage all a3\" ON public.a3_projects","CREATE POLICY \"Superadmin manage all a3\"
-- ON public.a3_projects
-- FOR ALL
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )
-- WITH CHECK (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )","--------------------------------------------------------------
-- QUICK WINS (quick_wins)
-- --------------------------------------------------------------
-- DROP POLICY IF EXISTS \"Superadmin manage all quick_wins\" ON public.quick_wins","CREATE POLICY \"Superadmin manage all quick_wins\"
-- ON public.quick_wins
-- FOR ALL
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )
-- WITH CHECK (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )","--------------------------------------------------------------
-- VSM PROJECTS (vsm_projects)
-- --------------------------------------------------------------
-- DROP POLICY IF EXISTS \"Superadmin manage all vsm\" ON public.vsm_projects","CREATE POLICY \"Superadmin manage all vsm\"
-- ON public.vsm_projects
-- FOR ALL
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )
-- WITH CHECK (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )","--------------------------------------------------------------
-- COMPANIES (companies) - Ensure Management
-- --------------------------------------------------------------
-- DROP POLICY IF EXISTS \"Superadmin manage companies\" ON public.companies","-- Re-create to be sure
-- CREATE POLICY \"Superadmin manage companies\"
-- ON public.companies
-- FOR ALL
-- TO authenticated
-- USING (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )
-- WITH CHECK (
--   (SELECT role FROM public.profiles WHERE id = auth.uid()) = ''superadmin'' OR
--   (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
-- )",COMMIT}', 'fix_superadmin_rls');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101153500', '{"-- CRITICAL SECURITY FIX
-- The previous definition of public.is_admin() included ''admin'' role, which caused standard Company Admins
-- to bypass RLS policies and see ALL data from ALL companies.
-- This script restricts public.is_admin() to ONLY return true for ''superadmin'' role or specific developers.
-- Standard ''admin'' users will now fall through to the specific company-match policies.
-- 
-- create or replace function public.is_admin()
-- returns boolean as $$
-- begin
--   return exists (
--     select 1 from public.profiles
--     where id = auth.uid() 
--     and (
--         role = ''superadmin'' 
--         OR 
--         -- Hardcoded Superadmins (Safety Net)
--         email IN (''ariel.mellag@gmail.com'', ''equipo@belean.cl'')
--     )
--   );
-- end;
-- $$ language plpgsql security definer"}', 'secure_is_admin_function');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101154500', '{"-- Migration: Restore Superadmin Users (Ariel & Equipo)
-- Description: Re-creates the specific Superadmin users in auth.users if missing.
-- 
-- DO $$
-- DECLARE
--     -- Ariel
--     v_ariel_id uuid := ''00000000-0000-0000-0000-000000000001''; 
--     v_ariel_email text := ''ariel.mellag@gmail.com'';
--     v_ariel_pwd text := ''Equix123'';
--     
--     -- Equipo
--     v_equipo_id uuid := ''00000000-0000-0000-0000-000000000002'';
--     v_equipo_email text := ''Equipo@belean.cl'';
--     v_equipo_pwd text := ''Belean123'';
--     
--     v_dummy_id uuid;
-- BEGIN
--     --------------------------------------------------------------
--     -- 1. ARIEL MELLA
--     --------------------------------------------------------------
--     SELECT id INTO v_dummy_id FROM auth.users WHERE email = v_ariel_email;
--     IF v_dummy_id IS NULL THEN
--         INSERT INTO auth.users (
--             instance_id, id, aud, role, email, encrypted_password, 
--             email_confirmed_at, recovery_sent_at, last_sign_in_at, 
--             raw_app_meta_data, raw_user_meta_data, 
--             created_at, updated_at
--         ) VALUES (
--             ''00000000-0000-0000-0000-000000000000'', v_ariel_id, ''authenticated'', ''authenticated'', v_ariel_email, 
--             crypt(v_ariel_pwd, gen_salt(''bf'')), -- Uses pgcrypto
--             now(), now(), now(), 
--             ''{\"provider\":\"email\",\"providers\":[\"email\"]}'', ''{}'', now(), now()
--         );
--         RAISE NOTICE ''Created auth user: %'', v_ariel_email;
--     ELSE
--         -- Optional: Update password if user exists (for dev convenience)
--         UPDATE auth.users 
--         SET encrypted_password = crypt(v_ariel_pwd, gen_salt(''bf'')) 
--         WHERE email = v_ariel_email;
--         -- Capture existing ID for profile linking if needed
--         SELECT id INTO v_ariel_id FROM auth.users WHERE email = v_ariel_email;
--     END IF;
-- 
--     -- Ensure Profile (Ariel)
--     INSERT INTO public.profiles (id, email, name, role, company_id, is_authorized)
--     VALUES (v_ariel_id, v_ariel_email, ''Ariel Mella'', ''superadmin'', NULL, true)
--     ON CONFLICT (id) DO UPDATE
--     SET role = ''superadmin'', company_id = NULL, is_authorized = true;
-- 
-- 
--     --------------------------------------------------------------
--     -- 2. EQUIPO BELEAN
--     --------------------------------------------------------------
--     SELECT id INTO v_dummy_id FROM auth.users WHERE email = v_equipo_email;
--     IF v_dummy_id IS NULL THEN
--         INSERT INTO auth.users (
--             instance_id, id, aud, role, email, encrypted_password, 
--             email_confirmed_at, recovery_sent_at, last_sign_in_at, 
--             raw_app_meta_data, raw_user_meta_data, 
--             created_at, updated_at
--         ) VALUES (
--             ''00000000-0000-0000-0000-000000000000'', v_equipo_id, ''authenticated'', ''authenticated'', v_equipo_email, 
--             crypt(v_equipo_pwd, gen_salt(''bf'')), 
--             now(), now(), now(), 
--             ''{\"provider\":\"email\",\"providers\":[\"email\"]}'', ''{}'', now(), now()
--         );
--         RAISE NOTICE ''Created auth user: %'', v_equipo_email;
--     ELSE
--          UPDATE auth.users 
--         SET encrypted_password = crypt(v_equipo_pwd, gen_salt(''bf'')) 
--         WHERE email = v_equipo_email;
--         SELECT id INTO v_equipo_id FROM auth.users WHERE email = v_equipo_email;
--     END IF;
-- 
--     -- Ensure Profile (Equipo)
--     INSERT INTO public.profiles (id, email, name, role, company_id, is_authorized)
--     VALUES (v_equipo_id, v_equipo_email, ''Equipo BeLean'', ''superadmin'', NULL, true)
--     ON CONFLICT (id) DO UPDATE
--     SET role = ''superadmin'', company_id = NULL, is_authorized = true;
-- 
-- END $$"}', 'restore_superadmin_user');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101162000', '{"-- Add proposed_solution column to quick_wins table
-- ALTER TABLE public.quick_wins ADD COLUMN IF NOT EXISTS proposed_solution text"}', 'add_proposed_solution_to_quick_wins');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101163000', '{"-- Add version column to vsm_projects table
-- ALTER TABLE public.vsm_projects ADD COLUMN IF NOT EXISTS version text"}', 'add_version_to_vsm_projects');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101164000', '{"-- Migration: Fix Profiles RLS Recursion
-- Description: Updates permissions on public.profiles to use the safe is_admin() function
-- preventing infinite recursion when checking roles.
-- 
-- BEGIN","-- 1. Drop existing problematic policies
-- DROP POLICY IF EXISTS \"Superadmin view all profiles\" ON public.profiles","DROP POLICY IF EXISTS \"Public profiles are viewable by everyone\" ON public.profiles","DROP POLICY IF EXISTS \"Users can insert their own profile\" ON public.profiles","DROP POLICY IF EXISTS \"Users can update own profile\" ON public.profiles","-- 2. Create foundational policies
-- 
-- A. Self Access (Always allowed)
-- CREATE POLICY \"Profiles visible to self\"
-- ON public.profiles FOR SELECT
-- USING (id = auth.uid())","CREATE POLICY \"Profiles updatable by self\"
-- ON public.profiles FOR UPDATE
-- USING (id = auth.uid())","-- B. Superadmin Access (Global)
-- Uses public.is_admin() which is SECURITY DEFINER, bypassing RLS to avoid recursion
-- CREATE POLICY \"Superadmin manage all profiles\"
-- ON public.profiles FOR ALL
-- USING (public.is_admin())
-- WITH CHECK (public.is_admin())","-- C. Company Visibility
-- Allow users to see profiles in the same company
-- CREATE POLICY \"Profiles visible to company members\"
-- ON public.profiles FOR SELECT
-- USING (
--     company_id IS NOT NULL 
--     AND 
--     company_id = (
--         SELECT company_id FROM public.profiles WHERE id = auth.uid() LIMIT 1
--     )
-- )",COMMIT}', 'fix_profiles_recursion');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101170000', '{"-- Migration: Fix Recursion via Metadata
-- Description: Moves permission check source from public.profiles (RLS protected) 
-- to auth.users (Safe for Security Definer), breaking the infinite recursion loop.
-- 
-- BEGIN","-- 1. Sync existing profiles roles to auth.users metadata
-- This ensures ''is_admin'' will work immediately after migration
-- UPDATE auth.users u
-- SET raw_user_meta_data = 
--   COALESCE(u.raw_user_meta_data, ''{}''::jsonb) || 
--   jsonb_build_object(''role'', p.role)
-- FROM public.profiles p
-- WHERE u.id = p.id","-- 2. Redefine is_admin() to read from auth.users (Breaking the loop)
-- CREATE OR REPLACE FUNCTION public.is_admin()
-- RETURNS BOOLEAN AS $$
-- DECLARE
--   _role text;
-- BEGIN
--   -- A. Fast Path: Check JWT email (Hardcoded Superadmins)
--   -- This handles the specific users requested regardless of DB state
--   IF (auth.jwt() ->> ''email'') IN (''ariel.mellag@gmail.com'', ''Equipo@belean.cl'') THEN
--     RETURN TRUE;
--   END IF;
-- 
--   -- B. Check Metadata in auth.users
--   -- Since this function is SECURITY DEFINER, it can read auth.users
--   -- auth.users does NOT have RLS that points back to profiles, so no loop.
--   SELECT raw_user_meta_data->>''role''
--   INTO _role
--   FROM auth.users
--   WHERE id = auth.uid();
-- 
--   RETURN (_role = ''superadmin'');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER","-- 3. Trigger to keep metadata in sync
-- Whenever a profile role is updated (e.g. promoting a user), update auth.users
CREATE OR REPLACE FUNCTION public.sync_profile_role()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE auth.users
  SET raw_user_meta_data = 
    COALESCE(raw_user_meta_data, ''{}''::jsonb) || 
    jsonb_build_object(''role'', NEW.role)
  WHERE id = NEW.id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER","DROP TRIGGER IF EXISTS on_profile_role_change ON public.profiles","CREATE TRIGGER on_profile_role_change
AFTER UPDATE OF role ON public.profiles
FOR EACH ROW EXECUTE PROCEDURE public.sync_profile_role()","-- 4. Ensure Trigger also runs on Insert
DROP TRIGGER IF EXISTS on_profile_role_insert ON public.profiles","CREATE TRIGGER on_profile_role_insert
AFTER INSERT ON public.profiles
FOR EACH ROW EXECUTE PROCEDURE public.sync_profile_role()",COMMIT}', 'fix_recursion_with_metadata');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101171000', '{"-- Migration: Fix Profiles Recursion (Final)
-- Description: The previous fix addressed is_admin, but the \"company members\" policy 
-- still caused recursion by querying public.profiles inside the policy.
-- Solution: Use a SECURITY DEFINER function to fetch the user''s company_id without triggering RLS.
-- 
-- BEGIN","-- 1. Create Helper Function (Bypasses RLS)
-- CREATE OR REPLACE FUNCTION public.get_my_company_id()
-- RETURNS uuid AS $$
-- BEGIN
--   RETURN (
--     SELECT company_id 
--     FROM public.profiles 
--     WHERE id = auth.uid()
--   );
-- END;
-- $$ LANGUAGE plpgsql SECURITY DEFINER","-- 2. Drop Problematic Policy
-- DROP POLICY IF EXISTS \"Profiles visible to company members\" ON public.profiles","-- 3. Re-create Policy using Safe Function
-- CREATE POLICY \"Profiles visible to company members\"
-- ON public.profiles FOR SELECT
-- USING (
--     company_id IS NOT NULL 
--     AND 
--     company_id = public.get_my_company_id()
-- )",COMMIT}', 'fix_profiles_recursion_final');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101203000', '{"alter table public.vsm_projects add column if not exists takt_time text"}', 'add_takt_time_column');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101210000', '{"-- Fix VSM Visibility Policy to prevent \"Global\" viewing by regular users
-- 
-- Drop existing generic policies for VSM
-- drop policy if exists \"Ver vsm_projects\" on public.vsm_projects","drop policy if exists \"Gestionar vsm_projects\" on public.vsm_projects","-- Create stricter SELECT policy
-- Regular users can ONLY see:
-- 1. Projects belonging to their assigned company
-- 2. Projects where they are explicitly the responsible person
-- SuperAdmins (is_admin()) see EVERYTHING.
-- create policy \"Ver vsm_projects\" on public.vsm_projects for select using (
--   public.is_admin()
--   OR
--   (company_id is not null and exists (select 1 from public.profiles where id = auth.uid() and company_id = vsm_projects.company_id))
--   OR
--   (responsible is not null and responsible = (select name from public.profiles where id = auth.uid()))
-- )","-- Create stricter MANAGEMENT policy
-- create policy \"Gestionar vsm_projects\" on public.vsm_projects for all using (
--   public.is_admin()
--   OR
--   (company_id is not null and exists (select 1 from public.profiles where id = auth.uid() and company_id = vsm_projects.company_id))
--   OR
--   (responsible is not null and responsible = (select name from public.profiles where id = auth.uid()))
-- )"}', 'fix_vsm_visibility');
-- INSERT INTO supabase_migrations.schema_migrations VALUES ('20260101213000', '{"-- Add missing columns to a3_projects table
-- alter table public.a3_projects add column if not exists background_image_url text","alter table public.a3_projects add column if not exists current_condition_image_url text","alter table public.a3_projects add column if not exists pareto_data jsonb default ''[]''::jsonb"}', 'add_a3_columns');


--
-- Data for Name: seed_files; Type: TABLE DATA; Schema: supabase_migrations; Owner: -
--

-- INSERT INTO supabase_migrations.seed_files VALUES ('supabase/seed.sql', '547d2b03d4d27b15d638a6327e4187538cd49e7a57683d8cec4f039968ef6968');


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--



--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: -
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--
