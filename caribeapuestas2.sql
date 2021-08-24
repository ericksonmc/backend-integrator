--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: award_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.award_details (
    id bigint NOT NULL,
    ticket_id integer,
    amount double precision,
    status integer DEFAULT 0 NOT NULL,
    award_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    reaward boolean DEFAULT false,
    bet_id integer
);


ALTER TABLE public.award_details OWNER TO postgres;

--
-- Name: award_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.award_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.award_details_id_seq OWNER TO postgres;

--
-- Name: award_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.award_details_id_seq OWNED BY public.award_details.id;


--
-- Name: awards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.awards (
    id bigint NOT NULL,
    number character varying,
    draw_id integer,
    info_re_award jsonb,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.awards OWNER TO postgres;

--
-- Name: awards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.awards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.awards_id_seq OWNER TO postgres;

--
-- Name: awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.awards_id_seq OWNED BY public.awards.id;


--
-- Name: bets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bets (
    id bigint NOT NULL,
    ticket_id bigint NOT NULL,
    amount double precision,
    prize double precision,
    played boolean,
    bet_statu_id integer,
    lotery_id integer,
    number character varying,
    player_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    remote_bet_id integer
);


ALTER TABLE public.bets OWNER TO postgres;

--
-- Name: bets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bets_id_seq OWNER TO postgres;

--
-- Name: bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bets_id_seq OWNED BY public.bets.id;


--
-- Name: integrators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.integrators (
    id bigint NOT NULL,
    name character varying,
    phone character varying,
    address character varying,
    email character varying,
    apikey character varying,
    status boolean,
    product_settings jsonb,
    setting_apis jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.integrators OWNER TO postgres;

--
-- Name: integrators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.integrators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.integrators_id_seq OWNER TO postgres;

--
-- Name: integrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.integrators_id_seq OWNED BY public.integrators.id;


--
-- Name: lottery_setups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lottery_setups (
    id bigint NOT NULL,
    mmt double precision,
    mpj double precision,
    jpt double precision,
    mt double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.lottery_setups OWNER TO postgres;

--
-- Name: lottery_setups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lottery_setups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lottery_setups_id_seq OWNER TO postgres;

--
-- Name: lottery_setups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lottery_setups_id_seq OWNED BY public.lottery_setups.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id bigint NOT NULL,
    email character varying,
    cedula character varying,
    player_id character varying,
    company character varying,
    site character varying,
    integrator_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    username character varying,
    password character varying,
    token character varying
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_id_seq OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying,
    rules character varying,
    url character varying,
    type_product integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    id bigint NOT NULL,
    number integer,
    confirm integer,
    total_amount double precision,
    cant_bets integer,
    remote_user_id integer,
    ticket_status_id integer,
    prize double precision,
    payed boolean,
    remote_center_id integer,
    remote_agency_id integer,
    remote_group_id integer,
    remote_master_center_id integer,
    date_pay integer,
    security character varying,
    player_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    ticket_string character varying
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO postgres;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying,
    password_digest character varying,
    email character varying,
    role integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: award_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award_details ALTER COLUMN id SET DEFAULT nextval('public.award_details_id_seq'::regclass);


--
-- Name: awards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.awards ALTER COLUMN id SET DEFAULT nextval('public.awards_id_seq'::regclass);


--
-- Name: bets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bets ALTER COLUMN id SET DEFAULT nextval('public.bets_id_seq'::regclass);


--
-- Name: integrators id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrators ALTER COLUMN id SET DEFAULT nextval('public.integrators_id_seq'::regclass);


--
-- Name: lottery_setups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lottery_setups ALTER COLUMN id SET DEFAULT nextval('public.lottery_setups_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2021-08-17 20:35:15.657478	2021-08-23 19:37:30.613751
\.


--
-- Data for Name: award_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.award_details (id, ticket_id, amount, status, award_id, created_at, updated_at, reaward, bet_id) FROM stdin;
12	27	5600000000	3	9	2021-08-23 20:09:20.869697	2021-08-23 20:30:05.821391	f	4937112
15	27	560000000	0	9	2021-08-23 20:48:54.384334	2021-08-23 20:48:54.384337	t	4937112
13	27	5600000000	4	9	2021-08-23 20:26:26.801535	2021-08-23 20:48:54.616926	t	4937112
14	27	5600000000	4	9	2021-08-23 20:30:05.365124	2021-08-23 20:48:54.695931	t	4937112
\.


--
-- Data for Name: awards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.awards (id, number, draw_id, info_re_award, status, created_at, updated_at) FROM stdin;
9	123	101	[{"premio": "560000000.00", "id_apuesta": 4937112}]	2	2021-08-23 20:09:20.848557	2021-08-23 20:48:54.324482
\.


--
-- Data for Name: bets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bets (id, ticket_id, amount, prize, played, bet_statu_id, lotery_id, number, player_id, created_at, updated_at, remote_bet_id) FROM stdin;
897	26	20000	0	f	1	114	125	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937103
898	26	20000	0	f	1	114	225	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937104
899	26	20000	0	f	1	114	325	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937105
900	26	20000	0	f	1	114	425	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937106
901	26	20000	0	f	1	114	525	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937107
902	26	20000	0	f	1	114	625	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937108
903	26	20000	0	f	1	114	725	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937109
904	26	20000	0	f	1	114	825	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937110
905	26	20000	0	f	1	114	925	1	2021-08-23 19:38:51.712556	2021-08-23 19:38:51.712556	4937111
906	27	8000000	0	f	1	101	815	1	2021-08-23 19:38:55.831788	2021-08-23 19:38:55.831788	4937112
907	28	80000000	0	f	1	92	123	1	2021-08-23 19:57:26.359174	2021-08-23 19:57:26.359174	4937163
908	29	20000	0	f	1	92	123	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937175
909	29	20000	0	f	1	92	321	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937176
910	29	20000	0	f	1	92	456	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937177
911	29	20000	0	f	1	92	987	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937178
912	29	20000	0	f	1	98	123	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937179
913	29	20000	0	f	1	98	321	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937180
914	29	20000	0	f	1	98	456	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937181
915	29	20000	0	f	1	98	987	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937182
916	29	20000	0	f	1	99	123	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937183
917	29	20000	0	f	1	99	321	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937184
918	29	20000	0	f	1	99	456	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937185
919	29	20000	0	f	1	99	987	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937186
920	29	20000	0	f	1	100	123	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937187
921	29	20000	0	f	1	100	321	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937188
922	29	20000	0	f	1	100	456	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937189
923	29	20000	0	f	1	100	987	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937190
924	29	20000	0	f	1	101	123	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937191
925	29	20000	0	f	1	101	321	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937192
926	29	20000	0	f	1	101	456	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937193
927	29	20000	0	f	1	101	987	1	2021-08-23 20:15:19.805779	2021-08-23 20:15:19.805779	4937194
928	30	20000	0	f	1	98	123	1	2021-08-23 20:16:07.809383	2021-08-23 20:16:07.809383	4937195
929	31	20000	0	f	1	98	852	1	2021-08-23 20:16:32.009681	2021-08-23 20:16:32.009681	4937196
930	32	20000	0	f	1	98	123	1	2021-08-23 20:17:42.941864	2021-08-23 20:17:42.941864	4937197
931	32	20000	0	f	1	98	879	1	2021-08-23 20:17:42.941864	2021-08-23 20:17:42.941864	4937198
932	32	20000	0	f	1	98	785	1	2021-08-23 20:17:42.941864	2021-08-23 20:17:42.941864	4937199
\.


--
-- Data for Name: integrators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.integrators (id, name, phone, address, email, apikey, status, product_settings, setting_apis, created_at, updated_at) FROM stdin;
1	Integrator Centro de Apuestas	+584141234567	Maracaibo	admin@centrodeapuestas.com	a50f74ffe424c2f652e10e42112602ee5546	t	\N	{"balance": {"url": "https://www.centrodeapuestas.com/external/api/v1/sales/player_balance?player_id=", "mehtod": "GET"}, "casher_transaction": {"url": "https://www.centrodeapuestas.com/external/api/v1/sales/player_operacion", "method": "POST", "params": ["amount", "type_transaction", "description", "reference", "player_id", "credit_type"]}}	2021-08-17 22:04:49.371629	2021-08-17 22:04:49.371629
2	Caribe Apuestas	+5804126453792	Margarita	admin@caribeapuestas.com	e641acd1cf5a122bdefbc4969fbac6000904ac978496f3f254bc42a2e12b9b8d	t	\N	{"balance": {"url": "https://ca02-vm03.sagcit.com/GCIT.Api/api/CaribeApuestas/saldo?player_id=", "mehtod": "GET"}, "casher_transaction": {"url": "https://ca02-vm03.sagcit.com/GCIT.Api/api/CaribeApuestas/transaccion", "method": "POST", "params": ["amount", "type_transaction", "description", "reference", "player_id", "credit_type"]}}	2021-08-17 22:04:49.37974	2021-08-17 22:04:49.37974
\.


--
-- Data for Name: lottery_setups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lottery_setups (id, mmt, mpj, jpt, mt, created_at, updated_at) FROM stdin;
1	10000	10000	500	1000	2021-08-17 22:04:49.346108	2021-08-17 22:04:49.346108
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players (id, email, cedula, player_id, company, site, integrator_id, created_at, updated_at, username, password, token) FROM stdin;
1	Vlapenta@gmail.com	\N	40033	cordialito	GrupoCordialito	2	2021-08-17 21:59:14.1516	2021-08-17 21:59:14.1516	\N	\N	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, rules, url, type_product, created_at, updated_at) FROM stdin;
1	Triple Caracas	http://www.triplecaracas.com/assets/REGLAMENTOWEB.pdf	http://www.triplecaracas.com/	1	2021-08-17 22:04:49.39626	2021-08-17 22:04:49.39626
2	Triple Caliente	http://triplecaliente.com.ve/images/ReglamentodeJuegoTripleCaliente.pdf	http://triplecaliente.com.ve	1	2021-08-17 22:04:49.402573	2021-08-17 22:04:49.402573
3	Triple Zulia	http://resultadostriplezulia.com/images/ReglamentodeJuegoTripleZulia_23-10-2015.pdf	http://resultadostriplezulia.com	1	2021-08-17 22:04:49.407183	2021-08-17 22:04:49.407183
4	Zamorano	http://triplezamorano.com/images/Reglamento_TripleZamorano_23-10-2015.pdf	http://triplezamorano.com/	1	2021-08-17 22:04:49.411315	2021-08-17 22:04:49.411315
5	Jungla Millonaria	http://junglamillonaria.com/images/Reglamento_Jungla_Millonaria.pdf	http://junglamillonaria.com/	0	2021-08-17 22:04:49.41537	2021-08-17 22:04:49.41537
6	La Granjita	https://iframe.centrodeapuestas.com/rules-la-granjita.pdf	https://lagranjitaonline.com/	0	2021-08-17 22:04:49.419108	2021-08-17 22:04:49.419108
7	La granjita internacional		https://www.instagram.com/lagranjitainternacional	0	2021-08-17 22:04:49.428124	2021-08-17 22:04:49.428124
8	Ruleta activa		\N	0	2021-08-17 22:04:49.432058	2021-08-17 22:04:49.432058
9	La Ricachona		https://www.instagram.com/laricachonavzla/	1	2021-08-17 22:04:49.437646	2021-08-17 22:04:49.437646
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20210303014105
20210303014335
20210303015207
20210303140922
20210603014455
20210611030505
20210611031201
20210616041933
20210624235852
20210709025357
20210709030034
20210818004752
20210819010752
20210823182918
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (id, number, confirm, total_amount, cant_bets, remote_user_id, ticket_status_id, prize, payed, remote_center_id, remote_agency_id, remote_group_id, remote_master_center_id, date_pay, security, player_id, created_at, updated_at, ticket_string) FROM stdin;
26	881538	817	180000	9	13	1	0	f	2	3	5	1	\N	20210823193851	1	2021-08-23 19:38:52.793603	2021-08-23 19:38:52.793603	CARIBEAPUESTAS\nRIF: J-409540634\nTicket: #881538\nSerial/S: 817EFFF\nFecha/Hora: 23/08/2021 19:38\n--------------------------------\nTRIPLE ZULIA A 7:05 PM:\n125- 225- 325- 425- 525- 625- 725- 825- 925\n--------------------------------\nJugadas: 9\nTotal: 180000.0\n
27	881539	8708	8000000	1	13	1	0	f	2	3	5	1	\N	20210823193856	1	2021-08-23 19:38:56.880231	2021-08-23 19:38:56.880231	CARIBEAPUESTAS\nRIF: J-409540634\nTicket: #881539\nSerial/S: 8708AF9\nFecha/Hora: 23/08/2021 19:38\n--------------------------------\nLA RICACHONA 8:15 PM:\n815\n--------------------------------\nJugadas: 1\nTotal: 8000000.0\n
28	881545	0	80000000	1	13	1	0	f	2	3	5	1	\N	20210823195726	1	2021-08-23 19:57:27.698367	2021-08-23 19:57:27.698367	CARIBEAPUESTAS\nRIF: J-409540634\nTicket: #881545\nSerial/S: D0AB391\nFecha/Hora: 23/08/2021 19:57\n--------------------------------\nLA RICACHONA 11:15 PM:\n123\n--------------------------------\nJugadas: 1\nTotal: 80000000.0\n
29	881547	6	400000	20	13	1	0	f	2	3	5	1	\N	20210823201520	1	2021-08-23 20:15:21.434522	2021-08-23 20:15:21.434522	CARIBEAPUESTAS\nRIF: J-409540634\nTicket: #881547\nSerial/S: 6BA16D2\nFecha/Hora: 23/08/2021 20:15\n--------------------------------\nLA RICACHONA 11:15 PM:\n123- 321- 456- 987\nLA RICACHONA 5:15 PM:\n123- 321- 456- 987\nLA RICACHONA 6:15 PM:\n123- 321- 456- 987\nLA RICACHONA 7:15 PM:\n123- 321- 456- 987\nLA RICACHONA 8:15 PM:\n123- 321- 456- 987\n--------------------------------\nJugadas: 20\nTotal: 400000.0\n
30	881548	66	20000	1	13	1	0	f	2	3	5	1	\N	20210823201608	1	2021-08-23 20:16:09.101033	2021-08-23 20:16:09.101033	CARIBEAPUESTAS\nRIF: J-409540634\nTicket: #881548\nSerial/S: 66A4492\nFecha/Hora: 23/08/2021 20:16\n--------------------------------\nLA RICACHONA 5:15 PM:\n123\n--------------------------------\nJugadas: 1\nTotal: 20000.0\n
31	881549	7	20000	1	13	1	0	f	2	3	5	1	\N	20210823201632	1	2021-08-23 20:16:33.295259	2021-08-23 20:16:33.295259	CARIBEAPUESTAS\nRIF: J-409540634\nTicket: #881549\nSerial/S: 7DB4266\nFecha/Hora: 23/08/2021 20:16\n--------------------------------\nLA RICACHONA 5:15 PM:\n852\n--------------------------------\nJugadas: 1\nTotal: 20000.0\n
32	881550	0	60000	3	13	1	0	f	2	3	5	1	\N	20210823201743	1	2021-08-23 20:17:44.302356	2021-08-23 20:17:44.302356	CARIBEAPUESTAS\nRIF: J-409540634\nTicket: #881550\nSerial/S: C20AD38\nFecha/Hora: 23/08/2021 20:17\n--------------------------------\nLA RICACHONA 5:15 PM:\n123- 879- 785\n--------------------------------\nJugadas: 3\nTotal: 60000.0\n
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password_digest, email, role, created_at, updated_at) FROM stdin;
1	ericksonmc	$2a$12$gFGr4F2iCuTn5K2jRT0UUul2/K03rrnfuHUKAzDVCn1IgUa2Smkg.	erick2109@gmail.com	1	2021-08-17 22:04:49.327746	2021-08-17 22:04:49.327746
\.


--
-- Name: award_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.award_details_id_seq', 15, true);


--
-- Name: awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.awards_id_seq', 9, true);


--
-- Name: bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bets_id_seq', 932, true);


--
-- Name: integrators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.integrators_id_seq', 2, true);


--
-- Name: lottery_setups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lottery_setups_id_seq', 1, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.players_id_seq', 1, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 9, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tickets_id_seq', 32, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: award_details award_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award_details
    ADD CONSTRAINT award_details_pkey PRIMARY KEY (id);


--
-- Name: awards awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.awards
    ADD CONSTRAINT awards_pkey PRIMARY KEY (id);


--
-- Name: bets bets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bets
    ADD CONSTRAINT bets_pkey PRIMARY KEY (id);


--
-- Name: integrators integrators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrators
    ADD CONSTRAINT integrators_pkey PRIMARY KEY (id);


--
-- Name: lottery_setups lottery_setups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lottery_setups
    ADD CONSTRAINT lottery_setups_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_award_details_on_award_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_award_details_on_award_id ON public.award_details USING btree (award_id);


--
-- Name: index_bets_on_player_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_bets_on_player_id ON public.bets USING btree (player_id);


--
-- Name: index_bets_on_ticket_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_bets_on_ticket_id ON public.bets USING btree (ticket_id);


--
-- Name: index_tickets_on_player_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_tickets_on_player_id ON public.tickets USING btree (player_id);


--
-- Name: tickets fk_rails_1200e400b2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT fk_rails_1200e400b2 FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: bets fk_rails_5be81103bc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bets
    ADD CONSTRAINT fk_rails_5be81103bc FOREIGN KEY (ticket_id) REFERENCES public.tickets(id);


--
-- Name: bets fk_rails_f260dbc57f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bets
    ADD CONSTRAINT fk_rails_f260dbc57f FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- PostgreSQL database dump complete
--

