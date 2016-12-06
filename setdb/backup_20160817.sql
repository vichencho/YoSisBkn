--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.8
-- Dumped by pg_dump version 9.4.8
-- Started on 2016-08-18 00:42:46 VET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 12776)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 180 (class 1259 OID 26979)
-- Name: acceso; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE acceso (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    tipo_acceso integer NOT NULL,
    ip character varying(45) DEFAULT NULL::character varying,
    acceso_at timestamp without time zone
);


ALTER TABLE acceso OWNER TO yosistem;

--
-- TOC entry 179 (class 1259 OID 26977)
-- Name: acceso_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE acceso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acceso_id_seq OWNER TO yosistem;

--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 179
-- Name: acceso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE acceso_id_seq OWNED BY acceso.id;


--
-- TOC entry 182 (class 1259 OID 26994)
-- Name: backup; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE backup (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    denominacion character varying(200) NOT NULL,
    tamano character varying(45) DEFAULT NULL::character varying,
    archivo character varying(45) NOT NULL,
    backup_at timestamp without time zone
);


ALTER TABLE backup OWNER TO yosistem;

--
-- TOC entry 181 (class 1259 OID 26992)
-- Name: backup_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE backup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE backup_id_seq OWNER TO yosistem;

--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 181
-- Name: backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE backup_id_seq OWNED BY backup.id;


--
-- TOC entry 184 (class 1259 OID 27009)
-- Name: estado_usuario; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE estado_usuario (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    estado_usuario integer NOT NULL,
    descripcion character varying(100) NOT NULL,
    estado_usuario_at timestamp without time zone
);


ALTER TABLE estado_usuario OWNER TO yosistem;

--
-- TOC entry 183 (class 1259 OID 27007)
-- Name: estado_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE estado_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estado_usuario_id_seq OWNER TO yosistem;

--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 183
-- Name: estado_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE estado_usuario_id_seq OWNED BY estado_usuario.id;


--
-- TOC entry 186 (class 1259 OID 27023)
-- Name: menu; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE menu (
    id integer NOT NULL,
    menu_id integer,
    recurso_id integer,
    menu character varying(45) NOT NULL,
    url character varying(60) DEFAULT NULL::character varying,
    posicion integer DEFAULT 0,
    icono character varying(45) DEFAULT NULL::character varying,
    activo integer DEFAULT 1 NOT NULL,
    visibilidad integer DEFAULT 1 NOT NULL,
    custom numeric(1,0) DEFAULT 1::numeric
);


ALTER TABLE menu OWNER TO yosistem;

--
-- TOC entry 185 (class 1259 OID 27021)
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE menu_id_seq OWNER TO yosistem;

--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 185
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE menu_id_seq OWNED BY menu.id;


--
-- TOC entry 176 (class 1259 OID 26948)
-- Name: perfil; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE perfil (
    id integer NOT NULL,
    perfil character varying(45) NOT NULL,
    estado integer DEFAULT 1 NOT NULL,
    plantilla character varying(45) DEFAULT 'default'::character varying,
    perfil_at timestamp without time zone
);


ALTER TABLE perfil OWNER TO yosistem;

--
-- TOC entry 175 (class 1259 OID 26946)
-- Name: perfil_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE perfil_id_seq OWNER TO yosistem;

--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 175
-- Name: perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE perfil_id_seq OWNED BY perfil.id;


--
-- TOC entry 174 (class 1259 OID 26931)
-- Name: recurso; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE recurso (
    id integer NOT NULL,
    modulo character varying(45) DEFAULT NULL::character varying,
    controlador character varying(45) DEFAULT NULL::character varying,
    accion character varying(45) DEFAULT NULL::character varying,
    recurso character varying(100) DEFAULT NULL::character varying,
    descripcion text NOT NULL,
    activo integer DEFAULT 1 NOT NULL,
    custom numeric(1,0) DEFAULT 1::numeric,
    recurso_at timestamp without time zone
);


ALTER TABLE recurso OWNER TO yosistem;

--
-- TOC entry 173 (class 1259 OID 26929)
-- Name: recurso_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE recurso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recurso_id_seq OWNER TO yosistem;

--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 173
-- Name: recurso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE recurso_id_seq OWNED BY recurso.id;


--
-- TOC entry 188 (class 1259 OID 27049)
-- Name: recurso_perfil; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE recurso_perfil (
    id integer NOT NULL,
    recurso_id integer NOT NULL,
    perfil_id integer NOT NULL,
    recurso_perfil_at timestamp without time zone,
    recurso_perfil_in timestamp without time zone
);


ALTER TABLE recurso_perfil OWNER TO yosistem;

--
-- TOC entry 187 (class 1259 OID 27047)
-- Name: recurso_perfil_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE recurso_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recurso_perfil_id_seq OWNER TO yosistem;

--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 187
-- Name: recurso_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE recurso_perfil_id_seq OWNED BY recurso_perfil.id;


--
-- TOC entry 190 (class 1259 OID 34093)
-- Name: tipo_nuip; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE tipo_nuip (
    id integer NOT NULL,
    tipo_nuip character varying(45) NOT NULL
);


ALTER TABLE tipo_nuip OWNER TO yosistem;

--
-- TOC entry 189 (class 1259 OID 34091)
-- Name: tipo_nuip_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE tipo_nuip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_nuip_id_seq OWNER TO yosistem;

--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 189
-- Name: tipo_nuip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE tipo_nuip_id_seq OWNED BY tipo_nuip.id;


--
-- TOC entry 178 (class 1259 OID 26958)
-- Name: usuario; Type: TABLE; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE TABLE usuario (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) DEFAULT NULL::character varying NOT NULL,
    login character varying(45) NOT NULL,
    password character varying(45) NOT NULL,
    perfil_id integer NOT NULL,
    email character varying(45) DEFAULT NULL::character varying,
    tema character varying(45) DEFAULT 'default'::character varying,
    app_ajax integer DEFAULT 1,
    datagrid integer DEFAULT 30,
    fotografia character varying(45) DEFAULT 'default.png'::character varying,
    pool character varying(45) DEFAULT NULL::character varying,
    usuario_at timestamp without time zone,
    usuario_in timestamp without time zone
);


ALTER TABLE usuario OWNER TO yosistem;

--
-- TOC entry 177 (class 1259 OID 26956)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: yosistem
--

CREATE SEQUENCE usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuario_id_seq OWNER TO yosistem;

--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 177
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yosistem
--

ALTER SEQUENCE usuario_id_seq OWNED BY usuario.id;


--
-- TOC entry 2867 (class 2604 OID 26982)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY acceso ALTER COLUMN id SET DEFAULT nextval('acceso_id_seq'::regclass);


--
-- TOC entry 2869 (class 2604 OID 26997)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY backup ALTER COLUMN id SET DEFAULT nextval('backup_id_seq'::regclass);


--
-- TOC entry 2871 (class 2604 OID 27012)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY estado_usuario ALTER COLUMN id SET DEFAULT nextval('estado_usuario_id_seq'::regclass);


--
-- TOC entry 2872 (class 2604 OID 27026)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY menu ALTER COLUMN id SET DEFAULT nextval('menu_id_seq'::regclass);


--
-- TOC entry 2856 (class 2604 OID 26951)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY perfil ALTER COLUMN id SET DEFAULT nextval('perfil_id_seq'::regclass);


--
-- TOC entry 2849 (class 2604 OID 26934)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY recurso ALTER COLUMN id SET DEFAULT nextval('recurso_id_seq'::regclass);


--
-- TOC entry 2879 (class 2604 OID 27052)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY recurso_perfil ALTER COLUMN id SET DEFAULT nextval('recurso_perfil_id_seq'::regclass);


--
-- TOC entry 2880 (class 2604 OID 34096)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY tipo_nuip ALTER COLUMN id SET DEFAULT nextval('tipo_nuip_id_seq'::regclass);


--
-- TOC entry 2859 (class 2604 OID 26961)
-- Name: id; Type: DEFAULT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY usuario ALTER COLUMN id SET DEFAULT nextval('usuario_id_seq'::regclass);


--
-- TOC entry 3031 (class 0 OID 26979)
-- Dependencies: 180
-- Data for Name: acceso; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY acceso (id, usuario_id, tipo_acceso, ip, acceso_at) FROM stdin;
\.


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 179
-- Name: acceso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('acceso_id_seq', 1, false);


--
-- TOC entry 3033 (class 0 OID 26994)
-- Dependencies: 182
-- Data for Name: backup; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY backup (id, usuario_id, denominacion, tamano, archivo, backup_at) FROM stdin;
1	1	Sistema inicial	4,09 KB	backup-1.sql.gz	2013-01-01 00:00:01
\.


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 181
-- Name: backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('backup_id_seq', 35, true);


--
-- TOC entry 3035 (class 0 OID 27009)
-- Dependencies: 184
-- Data for Name: estado_usuario; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY estado_usuario (id, usuario_id, estado_usuario, descripcion, estado_usuario_at) FROM stdin;
1	1	2	Activo por ser el Super Usuario del sistema	2016-01-01 00:00:01
\.


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 183
-- Name: estado_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('estado_usuario_id_seq', 1, true);


--
-- TOC entry 3037 (class 0 OID 27023)
-- Dependencies: 186
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY menu (id, menu_id, recurso_id, menu, url, posicion, icono, activo, visibilidad, custom) FROM stdin;
1	\N	\N	Dashboard	#	10	fa-home	1	1	\N
2	1	2	Dashboard	dashboard/	11	fa-home	1	1	\N
3	\N	\N	Sistema	#	900	fa-cogs	1	1	\N
4	3	4	Accesos	sistema/accesos/listar/	901	fa-exchange	1	1	\N
5	3	5	Auditorías	sistema/auditorias/	902	fa-eye	1	1	\N
6	3	6	Backups	sistema/backups/listar/	903	fa-hdd-o	1	1	\N
7	3	7	Mantenimiento	sistema/mantenimiento/	904	fa-bolt	1	1	\N
8	3	8	Menús	sistema/menus/listar/	905	fa-list	1	1	\N
9	3	9	Perfiles	sistema/perfiles/listar/	906	fa-group	1	1	\N
10	3	10	Permisos	sistema/permisos/listar/	907	fa-magic	1	1	\N
11	3	11	Recursos	sistema/recursos/listar/	908	fa-lock	1	1	\N
12	3	12	Usuarios	sistema/usuarios/listar/	909	fa-user	1	1	\N
13	3	13	Visor de sucesos	sistema/sucesos/listar/	910	fa-filter	1	1	\N
14	3	14	Sistema	sistema/configuracion/	911	fa-wrench	1	1	\N
\.


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 185
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('menu_id_seq', 14, true);


--
-- TOC entry 3027 (class 0 OID 26948)
-- Dependencies: 176
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY perfil (id, perfil, estado, plantilla, perfil_at) FROM stdin;
1	Super Usuario	1	default	2016-01-01 00:00:01
2	Monitor	1	default	2016-08-15 20:57:45
\.


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 175
-- Name: perfil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('perfil_id_seq', 2, true);


--
-- TOC entry 3025 (class 0 OID 26931)
-- Dependencies: 174
-- Data for Name: recurso; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY recurso (id, modulo, controlador, accion, recurso, descripcion, activo, custom, recurso_at) FROM stdin;
1	*	NULL	NULL	*	Comodín para la administración total (usar con cuidado)	1	\N	2014-01-01 00:00:01
2	dashboard	*	*	dashboard/*/*	Página principal del sistema	1	\N	2014-01-01 00:00:01
3	sistema	mi_cuenta	*	sistema/mi_cuenta/*	Gestión de la cuenta del usuario logueado	1	\N	2014-01-01 00:00:01
4	sistema	accesos	*	sistema/accesos/*	Submódulo para la gestión de ingresos al sistema	1	\N	2014-01-01 00:00:01
5	sistema	auditorias	*	sistema/auditorias/*	Submódulo para el control de las acciones de los usuarios	1	\N	2014-01-01 00:00:01
6	sistema	backups	*	sistema/backups/*	Submódulo para la gestión de las copias de seguridad	1	\N	2014-01-01 00:00:01
7	sistema	mantenimiento	*	sistema/mantenimiento/*	Submódulo para el mantenimiento de las tablas	1	\N	2014-01-01 00:00:01
8	sistema	menus	*	sistema/menus/*	Submódulo del sistema para la creación de menús	1	\N	2014-01-01 00:00:01
9	sistema	perfiles	*	sistema/perfiles/*	Submódulo del sistema para los perfiles de usuarios	1	\N	2014-01-01 00:00:01
10	sistema	permisos	*	sistema/permisos/*	Submódulo del sistema para asignar recursos a los perfiles	1	\N	2014-01-01 00:00:01
11	sistema	recursos	*	sistema/recursos/*	Submódulo del sistema para la gestión de los recursos	1	\N	2014-01-01 00:00:01
12	sistema	usuarios	*	sistema/usuarios/*	Submódulo para la administración de los usuarios del sistema	1	\N	2014-01-01 00:00:01
13	sistema	sucesos	*	sistema/sucesos/*	Submódulo para el listado de los logs del sistema	1	\N	2014-01-01 00:00:01
14	sistema	configuracion	*	sistema/configuracion/*	Submódulo para la configuración de la aplicación (.ini)	1	\N	2014-01-01 00:00:01
\.


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 173
-- Name: recurso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('recurso_id_seq', 14, true);


--
-- TOC entry 3039 (class 0 OID 27049)
-- Dependencies: 188
-- Data for Name: recurso_perfil; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY recurso_perfil (id, recurso_id, perfil_id, recurso_perfil_at, recurso_perfil_in) FROM stdin;
1	1	1	2016-01-01 00:00:01	\N
2	2	2	2016-08-15 20:57:45	\N
3	3	2	2016-08-15 20:57:45	\N
\.


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 187
-- Name: recurso_perfil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('recurso_perfil_id_seq', 3, true);


--
-- TOC entry 3041 (class 0 OID 34093)
-- Dependencies: 190
-- Data for Name: tipo_nuip; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY tipo_nuip (id, tipo_nuip) FROM stdin;
1	C.C.
2	C.E.
3	PAS.
4	T.I.
5	N.D.
\.


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 189
-- Name: tipo_nuip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('tipo_nuip_id_seq', 5, true);


--
-- TOC entry 3029 (class 0 OID 26958)
-- Dependencies: 178
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: yosistem
--

COPY usuario (id, nombre, apellido, login, password, perfil_id, email, tema, app_ajax, datagrid, fotografia, pool, usuario_at, usuario_in) FROM stdin;
1	Cronjob	System	cronjob	963db57a0088931e0e3627b1e73e6eb5	1	\N	default	1	30	default.png	\N	2013-01-01 00:00:01	\N
2	Súper	Admin	admin	7c4a8d09ca3762af61e59520943dc26494f8941b	1	\N	default	1	30	default.png	\N	2013-01-01 00:00:01	\N
\.


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 177
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yosistem
--

SELECT pg_catalog.setval('usuario_id_seq', 2, true);


--
-- TOC entry 2889 (class 2606 OID 26985)
-- Name: acceso_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY acceso
    ADD CONSTRAINT acceso_pkey PRIMARY KEY (id);


--
-- TOC entry 2892 (class 2606 OID 27000)
-- Name: backup_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY backup
    ADD CONSTRAINT backup_pkey PRIMARY KEY (id);


--
-- TOC entry 2895 (class 2606 OID 27014)
-- Name: estado_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY estado_usuario
    ADD CONSTRAINT estado_usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2900 (class 2606 OID 27034)
-- Name: menu_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2884 (class 2606 OID 26955)
-- Name: perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id);


--
-- TOC entry 2904 (class 2606 OID 27054)
-- Name: recurso_perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY recurso_perfil
    ADD CONSTRAINT recurso_perfil_pkey PRIMARY KEY (id);


--
-- TOC entry 2882 (class 2606 OID 26945)
-- Name: recurso_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY recurso
    ADD CONSTRAINT recurso_pkey PRIMARY KEY (id);


--
-- TOC entry 2906 (class 2606 OID 34098)
-- Name: tipo_nuip_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY tipo_nuip
    ADD CONSTRAINT tipo_nuip_pkey PRIMARY KEY (id);


--
-- TOC entry 2887 (class 2606 OID 26970)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: yosistem; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2890 (class 1259 OID 26991)
-- Name: fk_acceso_usuario_idx; Type: INDEX; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE INDEX fk_acceso_usuario_idx ON acceso USING btree (usuario_id);


--
-- TOC entry 2893 (class 1259 OID 27006)
-- Name: fk_backup_usuario_idx; Type: INDEX; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE INDEX fk_backup_usuario_idx ON backup USING btree (usuario_id);


--
-- TOC entry 2896 (class 1259 OID 27020)
-- Name: fk_estado_usuario_usuario_idx; Type: INDEX; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE INDEX fk_estado_usuario_usuario_idx ON estado_usuario USING btree (usuario_id);


--
-- TOC entry 2897 (class 1259 OID 27046)
-- Name: fk_menu_menu_idx; Type: INDEX; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE INDEX fk_menu_menu_idx ON menu USING btree (menu_id);


--
-- TOC entry 2898 (class 1259 OID 27045)
-- Name: fk_menu_recurso_idx; Type: INDEX; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE INDEX fk_menu_recurso_idx ON menu USING btree (recurso_id);


--
-- TOC entry 2901 (class 1259 OID 27066)
-- Name: fk_recurso_perfil_perfil_idx; Type: INDEX; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE INDEX fk_recurso_perfil_perfil_idx ON recurso_perfil USING btree (perfil_id);


--
-- TOC entry 2902 (class 1259 OID 27065)
-- Name: fk_recurso_perfil_recurso_idx; Type: INDEX; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE INDEX fk_recurso_perfil_recurso_idx ON recurso_perfil USING btree (recurso_id);


--
-- TOC entry 2885 (class 1259 OID 26976)
-- Name: fk_usuario_perfil_idx; Type: INDEX; Schema: public; Owner: yosistem; Tablespace: 
--

CREATE INDEX fk_usuario_perfil_idx ON usuario USING btree (perfil_id);


--
-- TOC entry 2908 (class 2606 OID 26986)
-- Name: fk_acceso_usuario; Type: FK CONSTRAINT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY acceso
    ADD CONSTRAINT fk_acceso_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON UPDATE CASCADE;


--
-- TOC entry 2909 (class 2606 OID 27001)
-- Name: fk_backup_usuario; Type: FK CONSTRAINT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY backup
    ADD CONSTRAINT fk_backup_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON UPDATE CASCADE;


--
-- TOC entry 2910 (class 2606 OID 27015)
-- Name: fk_estado_usuario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY estado_usuario
    ADD CONSTRAINT fk_estado_usuario_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON UPDATE CASCADE;


--
-- TOC entry 2912 (class 2606 OID 27040)
-- Name: fk_menu_menu; Type: FK CONSTRAINT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT fk_menu_menu FOREIGN KEY (menu_id) REFERENCES menu(id) ON UPDATE CASCADE;


--
-- TOC entry 2911 (class 2606 OID 27035)
-- Name: fk_menu_recurso; Type: FK CONSTRAINT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT fk_menu_recurso FOREIGN KEY (recurso_id) REFERENCES recurso(id) ON UPDATE CASCADE;


--
-- TOC entry 2914 (class 2606 OID 27060)
-- Name: fk_recurso_perfil_perfil; Type: FK CONSTRAINT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY recurso_perfil
    ADD CONSTRAINT fk_recurso_perfil_perfil FOREIGN KEY (perfil_id) REFERENCES perfil(id) ON UPDATE CASCADE;


--
-- TOC entry 2913 (class 2606 OID 27055)
-- Name: fk_recurso_perfil_recurso; Type: FK CONSTRAINT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY recurso_perfil
    ADD CONSTRAINT fk_recurso_perfil_recurso FOREIGN KEY (recurso_id) REFERENCES recurso(id) ON UPDATE CASCADE;


--
-- TOC entry 2907 (class 2606 OID 26971)
-- Name: fk_usuario_perfil; Type: FK CONSTRAINT; Schema: public; Owner: yosistem
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT fk_usuario_perfil FOREIGN KEY (perfil_id) REFERENCES perfil(id) ON UPDATE CASCADE;


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-08-18 00:42:46 VET

--
-- PostgreSQL database dump complete
--

