--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13
-- Dumped by pg_dump version 15.13

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

--
-- Name: amendmentstatus; Type: TYPE; Schema: public; Owner: vox
--

CREATE TYPE public.amendmentstatus AS ENUM (
    'PENDING',
    'ACCEPTED',
    'REJECTED',
    'WITHDRAWN'
);


ALTER TYPE public.amendmentstatus OWNER TO vox;

--
-- Name: pollstatus; Type: TYPE; Schema: public; Owner: vox
--

CREATE TYPE public.pollstatus AS ENUM (
    'OFF',
    'ON'
);


ALTER TYPE public.pollstatus OWNER TO vox;

--
-- Name: questiontype; Type: TYPE; Schema: public; Owner: vox
--

CREATE TYPE public.questiontype AS ENUM (
    'MULTIPLE_CHOICE',
    'SINGLE_CHOICE'
);


ALTER TYPE public.questiontype OWNER TO vox;

--
-- Name: resolutionstatus; Type: TYPE; Schema: public; Owner: vox
--

CREATE TYPE public.resolutionstatus AS ENUM (
    'PENDING',
    'ACCEPTED',
    'REJECTED'
);


ALTER TYPE public.resolutionstatus OWNER TO vox;

--
-- Name: role; Type: TYPE; Schema: public; Owner: vox
--

CREATE TYPE public.role AS ENUM (
    'ADMIN',
    'USER',
    'GRADER'
);


ALTER TYPE public.role OWNER TO vox;

--
-- Name: signaturetype; Type: TYPE; Schema: public; Owner: vox
--

CREATE TYPE public.signaturetype AS ENUM (
    'AUTHOR',
    'SIGNATURE'
);


ALTER TYPE public.signaturetype OWNER TO vox;

--
-- Name: ticketstatus; Type: TYPE; Schema: public; Owner: vox
--

CREATE TYPE public.ticketstatus AS ENUM (
    'WAITING',
    'APPROVED',
    'CANCELED'
);


ALTER TYPE public.ticketstatus OWNER TO vox;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: amendments; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.amendments (
    id integer NOT NULL,
    resolution_id integer NOT NULL,
    author character varying,
    author_id integer,
    club character varying,
    content text,
    target text,
    changes text,
    status public.amendmentstatus NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    withdrawn_reason character varying
);


ALTER TABLE public.amendments OWNER TO vox;

--
-- Name: amendments_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.amendments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.amendments_id_seq OWNER TO vox;

--
-- Name: amendments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.amendments_id_seq OWNED BY public.amendments.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.answers (
    id integer NOT NULL,
    poll_id integer NOT NULL,
    creator_id integer NOT NULL,
    question_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    content character varying
);


ALTER TABLE public.answers OWNER TO vox;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_id_seq OWNER TO vox;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: graders; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.graders (
    id integer NOT NULL,
    user_id integer,
    group_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.graders OWNER TO vox;

--
-- Name: graders_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.graders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.graders_id_seq OWNER TO vox;

--
-- Name: graders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.graders_id_seq OWNED BY public.graders.id;


--
-- Name: grades; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    grader_id integer NOT NULL,
    grade double precision,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.grades OWNER TO vox;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO vox;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: grading_groups; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.grading_groups (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.grading_groups OWNER TO vox;

--
-- Name: grading_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.grading_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grading_groups_id_seq OWNER TO vox;

--
-- Name: grading_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.grading_groups_id_seq OWNED BY public.grading_groups.id;


--
-- Name: polls; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.polls (
    id integer NOT NULL,
    creator_id integer NOT NULL,
    title character varying,
    description character varying,
    status public.pollstatus NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    opened_at timestamp without time zone,
    closed_at timestamp without time zone
);


ALTER TABLE public.polls OWNER TO vox;

--
-- Name: polls_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.polls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polls_id_seq OWNER TO vox;

--
-- Name: polls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.polls_id_seq OWNED BY public.polls.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    creator_id integer NOT NULL,
    poll_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    type public.questiontype,
    choices_number integer,
    content character varying
);


ALTER TABLE public.questions OWNER TO vox;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO vox;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: resolution_signatures; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.resolution_signatures (
    id integer NOT NULL,
    resolution_id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    type public.signaturetype NOT NULL
);


ALTER TABLE public.resolution_signatures OWNER TO vox;

--
-- Name: resolution_signatures_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.resolution_signatures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resolution_signatures_id_seq OWNER TO vox;

--
-- Name: resolution_signatures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.resolution_signatures_id_seq OWNED BY public.resolution_signatures.id;


--
-- Name: resolutions; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.resolutions (
    id integer NOT NULL,
    title character varying NOT NULL,
    slug character varying NOT NULL,
    file_name character varying,
    author_id integer NOT NULL,
    author character varying,
    party character varying,
    preamble text,
    chapters text,
    session_id integer,
    status public.resolutionstatus NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.resolutions OWNER TO vox;

--
-- Name: resolutions_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.resolutions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resolutions_id_seq OWNER TO vox;

--
-- Name: resolutions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.resolutions_id_seq OWNED BY public.resolutions.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.submissions (
    id integer NOT NULL,
    group_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    submission_number character varying NOT NULL,
    about_me character varying,
    subject_1 character varying,
    subject_2 character varying,
    subject_1_answer character varying,
    subject_2_answer character varying
);


ALTER TABLE public.submissions OWNER TO vox;

--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_id_seq OWNER TO vox;

--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    grade_id integer,
    new_grade double precision NOT NULL,
    status public.ticketstatus NOT NULL,
    explanation character varying NOT NULL
);


ALTER TABLE public.tickets OWNER TO vox;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO vox;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying NOT NULL,
    surname character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role public.role NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO vox;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO vox;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: voters; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.voters (
    id integer NOT NULL,
    poll_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    voted_at timestamp without time zone
);


ALTER TABLE public.voters OWNER TO vox;

--
-- Name: voters_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.voters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voters_id_seq OWNER TO vox;

--
-- Name: voters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.voters_id_seq OWNED BY public.voters.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: vox
--

CREATE TABLE public.votes (
    id integer NOT NULL,
    poll_id integer NOT NULL,
    voter_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.votes OWNER TO vox;

--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: vox
--

CREATE SEQUENCE public.votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.votes_id_seq OWNER TO vox;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vox
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- Name: amendments id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.amendments ALTER COLUMN id SET DEFAULT nextval('public.amendments_id_seq'::regclass);


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: graders id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.graders ALTER COLUMN id SET DEFAULT nextval('public.graders_id_seq'::regclass);


--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Name: grading_groups id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.grading_groups ALTER COLUMN id SET DEFAULT nextval('public.grading_groups_id_seq'::regclass);


--
-- Name: polls id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.polls ALTER COLUMN id SET DEFAULT nextval('public.polls_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: resolution_signatures id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.resolution_signatures ALTER COLUMN id SET DEFAULT nextval('public.resolution_signatures_id_seq'::regclass);


--
-- Name: resolutions id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.resolutions ALTER COLUMN id SET DEFAULT nextval('public.resolutions_id_seq'::regclass);


--
-- Name: submissions id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: voters id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.voters ALTER COLUMN id SET DEFAULT nextval('public.voters_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Data for Name: amendments; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.amendments (id, resolution_id, author, author_id, club, content, target, changes, status, created_at, withdrawn_reason) FROM stdin;
\.


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.answers (id, poll_id, creator_id, question_id, created_at, content) FROM stdin;
2163	91	10982	718	2026-09-17 11:16:39.946133	Przeciw
2164	91	10982	718	2026-09-17 11:16:40.006263	Wstrzymuję się
2165	91	10982	719	2026-09-17 11:16:48.498757	Za
2166	91	10982	719	2026-09-17 11:16:48.561538	Przeciw
2167	91	10982	719	2026-09-17 11:16:48.621931	Wstrzymuję się
2168	91	10982	720	2026-09-17 11:16:50.98146	Za
2169	91	10982	720	2026-09-17 11:16:51.037931	Przeciw
2170	91	10982	720	2026-09-17 11:16:51.096115	Wstrzymuję się
2171	91	10982	721	2026-09-17 11:16:54.021425	Za
2172	91	10982	721	2026-09-17 11:16:54.077798	Przeciw
2173	91	10982	721	2026-09-17 11:16:54.139577	Wstrzymuję się
2174	91	10982	722	2026-09-17 11:16:56.397483	Za
2175	91	10982	722	2026-09-17 11:16:56.465409	Przeciw
2176	91	10982	722	2026-09-17 11:16:56.553901	Wstrzymuję się
2177	91	10982	723	2026-09-17 11:16:59.889379	Za
2178	91	10982	723	2026-09-17 11:16:59.950448	Przeciw
2179	91	10982	723	2026-09-17 11:17:00.009185	Wstrzymuję się
2180	91	10982	724	2026-09-17 11:17:03.175723	Za
2181	91	10982	724	2026-09-17 11:17:03.236064	Przeciw
2182	91	10982	724	2026-09-17 11:17:03.297621	Wstrzymuję się
2183	91	10982	725	2026-09-17 11:17:06.138114	Za
2184	91	10982	725	2026-09-17 11:17:06.196117	Przeciw
2185	91	10982	725	2026-09-17 11:17:06.257465	Wstrzymuję się
2186	91	10982	726	2026-09-17 11:17:09.265278	Za
2187	91	10982	726	2026-09-17 11:17:09.329732	Przeciw
2188	91	10982	726	2026-09-17 11:17:09.392793	Wstrzymuję się
2189	91	10982	727	2026-09-17 11:17:14.840148	Za
2190	91	10982	727	2026-09-17 11:17:14.918261	Przeciw
2191	91	10982	727	2026-09-17 11:17:14.9804	Wstrzymuję się
2192	91	10982	728	2026-09-17 11:17:18.366034	Za
2193	91	10982	728	2026-09-17 11:17:18.427879	Przeciw
2194	91	10982	728	2026-09-17 11:17:18.487849	Wstrzymuję się
2195	92	10982	729	2026-09-17 11:17:42.797617	Za
2196	92	10982	729	2026-09-17 11:17:42.858078	Przeciw
2197	92	10982	729	2026-09-17 11:17:42.920304	Wstrzymuję się
2198	92	10982	730	2026-09-17 11:17:52.06057	Za
2199	92	10982	730	2026-09-17 11:17:52.121559	Przeciw
2200	92	10982	730	2026-09-17 11:17:52.179875	Wstrzymuję się
2201	92	10982	731	2026-09-17 11:17:55.1876	Za
2202	92	10982	731	2026-09-17 11:17:55.24757	Przeciw
2203	92	10982	731	2026-09-17 11:17:55.307866	Wstrzymuję się
2204	92	10982	732	2026-09-17 11:17:57.810334	Za
2205	92	10982	732	2026-09-17 11:17:57.869341	Przeciw
2206	92	10982	732	2026-09-17 11:17:57.940016	Wstrzymuję się
2207	92	10982	733	2026-09-17 11:18:00.965903	Za
2208	92	10982	733	2026-09-17 11:18:01.027798	Przeciw
2209	92	10982	733	2026-09-17 11:18:01.090066	Wstrzymuję się
2210	92	10982	734	2026-09-17 11:18:05.829483	Za
2211	92	10982	734	2026-09-17 11:18:05.893464	Przeciw
2212	92	10982	734	2026-09-17 11:18:05.954047	Wstrzymuję się
2213	92	10982	735	2026-09-17 11:18:08.864535	Za
2214	92	10982	735	2026-09-17 11:18:08.925703	Przeciw
2215	92	10982	735	2026-09-17 11:18:09.006042	Wstrzymuję się
2216	92	10982	736	2026-09-17 11:18:12.75595	Za
2217	92	10982	736	2026-09-17 11:18:12.815573	Przeciw
2218	92	10982	736	2026-09-17 11:18:12.88191	Wstrzymuję się
2219	92	10982	737	2026-09-17 11:18:16.511927	Za
2220	92	10982	737	2026-09-17 11:18:16.573626	Przeciw
2221	92	10982	737	2026-09-17 11:18:16.632466	Wstrzymuję się
2222	92	10982	738	2026-09-17 11:18:19.723169	Za
2223	92	10982	738	2026-09-17 11:18:19.78397	Przeciw
2224	92	10982	738	2026-09-17 11:18:19.845819	Wstrzymuję się
2225	92	10982	739	2026-09-17 11:18:22.57378	Za
2226	92	10982	739	2026-09-17 11:18:22.630531	Przeciw
2227	92	10982	739	2026-09-17 11:18:22.701066	Wstrzymuję się
2228	92	10982	740	2026-09-17 11:18:25.389412	Za
2229	92	10982	740	2026-09-17 11:18:25.446746	Przeciw
2230	92	10982	740	2026-09-17 11:18:25.509698	Wstrzymuję się
2135	90	10982	709	2026-09-17 11:15:24.333092	Za
2136	90	10982	709	2026-09-17 11:15:24.427869	Przeciw
2137	90	10982	709	2026-09-17 11:15:24.488282	Wstrzymuję się
2138	90	10982	710	2026-09-17 11:15:36.172065	Za
2139	90	10982	710	2026-09-17 11:15:36.23438	Przeciw
2140	90	10982	710	2026-09-17 11:15:36.295802	Wstrzymuję się
2141	90	10982	711	2026-09-17 11:15:41.179397	Za
2142	90	10982	711	2026-09-17 11:15:41.242052	Przeciw
2143	90	10982	711	2026-09-17 11:15:41.302879	Wstrzymuję się
2144	90	10982	712	2026-09-17 11:15:43.916155	Za
2145	90	10982	712	2026-09-17 11:15:43.979923	Przeciw
2146	90	10982	712	2026-09-17 11:15:44.050727	Wstrzymuję się
2147	90	10982	713	2026-09-17 11:15:47.492228	Za
2148	90	10982	713	2026-09-17 11:15:47.555601	Przeciw
2149	90	10982	713	2026-09-17 11:15:47.612634	Wstrzymuję się
2150	90	10982	714	2026-09-17 11:15:50.211857	Za
2151	90	10982	714	2026-09-17 11:15:50.272605	Przeciw
2152	90	10982	714	2026-09-17 11:15:50.332195	Wstrzymuję się
2153	90	10982	715	2026-09-17 11:15:53.0524	Za
2154	90	10982	715	2026-09-17 11:15:53.112136	Przeciw
2155	90	10982	715	2026-09-17 11:15:53.173584	Wstrzymuję się
2156	90	10982	716	2026-09-17 11:15:57.190328	Za
2157	90	10982	716	2026-09-17 11:15:57.338409	Przeciw
2158	90	10982	716	2026-09-17 11:15:57.435031	Wstrzymuję się
2159	91	10982	717	2026-09-17 11:16:34.086028	Za
2160	91	10982	717	2026-09-17 11:16:34.172158	Przeciw
2161	91	10982	717	2026-09-17 11:16:34.236078	Wstrzymuję się
2162	91	10982	718	2026-09-17 11:16:39.886435	Za
2231	93	10982	741	2026-09-17 11:18:45.008465	Za
2232	93	10982	741	2026-09-17 11:18:45.069683	Przeciw
2233	93	10982	741	2026-09-17 11:18:45.126542	Wstrzymuję się
2234	93	10982	742	2026-09-17 11:18:50.88577	Za
2235	93	10982	742	2026-09-17 11:18:50.949709	Przeciw
2236	93	10982	742	2026-09-17 11:18:51.011237	Wstrzymuję się
2237	93	10982	743	2026-09-17 11:18:53.108056	Za
2238	93	10982	743	2026-09-17 11:18:53.169791	Przeciw
2239	93	10982	743	2026-09-17 11:18:53.234628	Wstrzymuję się
2240	94	10982	744	2026-09-17 11:19:11.317486	Za
2241	94	10982	744	2026-09-17 11:19:11.379739	Przeciw
2242	94	10982	744	2026-09-17 11:19:11.436114	Wstrzymuję się
2243	94	10982	745	2026-09-17 11:19:14.539577	Za
2244	94	10982	745	2026-09-17 11:19:14.601914	Przeciw
2245	94	10982	745	2026-09-17 11:19:14.66367	Wstrzymuję się
2246	94	10982	746	2026-09-17 11:19:34.334608	Za
2247	94	10982	746	2026-09-17 11:19:34.390402	Przeciw
2248	94	10982	746	2026-09-17 11:19:34.44602	Wstrzymuję się
2249	94	10982	747	2026-09-17 11:19:37.362514	Za
2250	94	10982	747	2026-09-17 11:19:37.42008	Przeciw
2251	94	10982	747	2026-09-17 11:19:37.480187	Wstrzymuję się
2252	94	10982	748	2026-09-17 11:19:41.118109	Za
2253	94	10982	748	2026-09-17 11:19:41.176563	Przeciw
2254	94	10982	748	2026-09-17 11:19:41.237515	Wstrzymuję się
2255	94	10982	749	2026-09-17 11:19:43.612275	Za
2256	94	10982	749	2026-09-17 11:19:43.695999	Przeciw
2257	94	10982	749	2026-09-17 11:19:43.755206	Wstrzymuję się
2258	94	10982	750	2026-09-17 11:19:46.063091	Za
2259	94	10982	750	2026-09-17 11:19:46.141577	Przeciw
2260	94	10982	750	2026-09-17 11:19:46.215626	Wstrzymuję się
2261	94	10982	751	2026-09-17 11:19:48.971813	Za
2262	94	10982	751	2026-09-17 11:19:49.02795	Przeciw
2263	94	10982	751	2026-09-17 11:19:49.091481	Wstrzymuję się
2264	94	10982	752	2026-09-17 11:19:51.905901	Za
2265	94	10982	752	2026-09-17 11:19:51.969484	Przeciw
2266	94	10982	752	2026-09-17 11:19:52.03354	Wstrzymuję się
2267	94	10982	753	2026-09-17 11:19:54.63793	Za
2268	94	10982	753	2026-09-17 11:19:54.769417	Przeciw
2269	94	10982	753	2026-09-17 11:19:54.831495	Wstrzymuję się
2270	94	10982	754	2026-09-17 11:19:57.43441	Za
2271	94	10982	754	2026-09-17 11:19:57.496362	Przeciw
2272	94	10982	754	2026-09-17 11:19:57.55593	Wstrzymuję się
2273	94	10982	755	2026-09-17 11:20:00.001668	Za
2274	94	10982	755	2026-09-17 11:20:00.068077	Przeciw
2275	94	10982	755	2026-09-17 11:20:00.131608	Wstrzymuję się
2276	94	10982	756	2026-09-17 11:20:02.721954	Za
2277	94	10982	756	2026-09-17 11:20:02.781567	Przeciw
2278	94	10982	756	2026-09-17 11:20:02.841747	Wstrzymuję się
2279	94	10982	757	2026-09-17 11:20:05.349619	Za
2280	94	10982	757	2026-09-17 11:20:05.406097	Przeciw
2281	94	10982	757	2026-09-17 11:20:05.467993	Wstrzymuję się
2282	94	10982	758	2026-09-17 11:20:08.378584	Za
2283	94	10982	758	2026-09-17 11:20:08.466469	Przeciw
2284	94	10982	758	2026-09-17 11:20:08.530571	Wstrzymuję się
2285	94	10982	759	2026-09-17 11:20:10.826823	Za
2286	94	10982	759	2026-09-17 11:20:10.883913	Przeciw
2287	94	10982	759	2026-09-17 11:20:10.949548	Wstrzymuję się
2288	94	10982	760	2026-09-17 11:20:13.359221	Za
2289	94	10982	760	2026-09-17 11:20:13.419948	Przeciw
2290	94	10982	760	2026-09-17 11:20:13.484711	Wstrzymuję się
2291	94	10982	761	2026-09-17 11:20:17.419265	Za
2292	94	10982	761	2026-09-17 11:20:17.487505	Przeciw
2293	94	10982	761	2026-09-17 11:20:17.549277	Wstrzymuję się
2294	94	10982	762	2026-09-17 11:20:20.028734	Za
2295	94	10982	762	2026-09-17 11:20:20.088022	Przeciw
2296	94	10982	762	2026-09-17 11:20:20.153536	Wstrzymuję się
2297	94	10982	763	2026-09-17 11:20:23.91069	Za
2298	94	10982	763	2026-09-17 11:20:23.973833	Przeciw
2299	94	10982	763	2026-09-17 11:20:24.032519	Wstrzymuję się
2300	94	10982	764	2026-09-17 11:20:26.998561	Za
2301	94	10982	764	2026-09-17 11:20:27.070091	Przeciw
2302	94	10982	764	2026-09-17 11:20:27.135682	Wstrzymuję się
2303	94	10982	765	2026-09-17 11:20:29.892236	Za
2304	94	10982	765	2026-09-17 11:20:29.953639	Przeciw
2305	94	10982	765	2026-09-17 11:20:30.012487	Wstrzymuję się
2306	94	10982	766	2026-09-17 11:20:32.243845	Za
2307	94	10982	766	2026-09-17 11:20:32.303613	Przeciw
2308	94	10982	766	2026-09-17 11:20:32.363576	Wstrzymuję się
2309	94	10982	767	2026-09-17 11:20:36.505354	Za
2310	94	10982	767	2026-09-17 11:20:36.575465	Przeciw
2311	94	10982	767	2026-09-17 11:20:36.639618	Wstrzymuję się
2312	94	10982	768	2026-09-17 11:20:38.92971	Za
2313	94	10982	768	2026-09-17 11:20:39.003509	Przeciw
2314	94	10982	768	2026-09-17 11:20:39.065824	Wstrzymuję się
2315	94	10982	769	2026-09-17 11:20:41.799913	Za
2316	94	10982	769	2026-09-17 11:20:41.862076	Przeciw
2317	94	10982	769	2026-09-17 11:20:41.923617	Wstrzymuję się
2318	94	10982	770	2026-09-17 11:20:44.102193	Za
2319	94	10982	770	2026-09-17 11:20:44.167975	Przeciw
2320	94	10982	770	2026-09-17 11:20:44.226095	Wstrzymuję się
2321	94	10982	771	2026-09-17 11:20:47.95033	Za
2322	94	10982	771	2026-09-17 11:20:48.010179	Przeciw
2323	94	10982	771	2026-09-17 11:20:48.068541	Wstrzymuję się
2324	94	10982	772	2026-09-17 11:20:50.499704	Za
2325	94	10982	772	2026-09-17 11:20:50.556294	Przeciw
2326	94	10982	772	2026-09-17 11:20:50.616138	Wstrzymuję się
2327	94	10982	773	2026-09-17 11:20:53.185558	Za
2328	94	10982	773	2026-09-17 11:20:53.245438	Przeciw
2329	94	10982	773	2026-09-17 11:20:53.321752	Wstrzymuję się
2330	94	10982	774	2026-09-17 11:20:56.213112	Za
2331	94	10982	774	2026-09-17 11:20:56.299527	Przeciw
2332	94	10982	774	2026-09-17 11:20:56.363841	Wstrzymuję się
2333	94	10982	775	2026-09-17 11:20:59.156473	Za
2334	94	10982	775	2026-09-17 11:20:59.214039	Przeciw
2335	94	10982	775	2026-09-17 11:20:59.275648	Wstrzymuję się
2336	94	10982	776	2026-09-17 11:21:01.367669	Za
2337	94	10982	776	2026-09-17 11:21:01.427638	Przeciw
2338	94	10982	776	2026-09-17 11:21:01.487397	Wstrzymuję się
2339	94	10982	777	2026-09-17 11:21:03.608305	Za
2340	94	10982	777	2026-09-17 11:21:03.675709	Przeciw
2341	94	10982	777	2026-09-17 11:21:03.738121	Wstrzymuję się
2342	94	10982	778	2026-09-17 11:21:05.798008	Za
2343	94	10982	778	2026-09-17 11:21:05.862099	Przeciw
2344	94	10982	778	2026-09-17 11:21:05.923388	Wstrzymuję się
2345	94	10982	779	2026-09-17 11:21:09.778826	Za
2346	94	10982	779	2026-09-17 11:21:09.836971	Przeciw
2347	94	10982	779	2026-09-17 11:21:09.905831	Wstrzymuję się
2348	94	10982	780	2026-09-17 11:21:13.104212	Za
2349	94	10982	780	2026-09-17 11:21:13.163771	Przeciw
2350	94	10982	780	2026-09-17 11:21:13.225584	Wstrzymuję się
2351	94	10982	781	2026-09-17 11:21:16.320578	Za
2352	94	10982	781	2026-09-17 11:21:16.417742	Przeciw
2353	94	10982	781	2026-09-17 11:21:16.48973	Wstrzymuję się
2354	94	10982	782	2026-09-17 11:21:20.473797	Za
2355	94	10982	782	2026-09-17 11:21:20.545846	Przeciw
2356	94	10982	782	2026-09-17 11:21:20.607914	Wstrzymuję się
2357	94	10982	783	2026-09-17 11:21:23.297557	Za
2358	94	10982	783	2026-09-17 11:21:23.357661	Przeciw
2359	94	10982	783	2026-09-17 11:21:23.425781	Wstrzymuję się
2360	94	10982	784	2026-09-17 11:21:26.405224	Za
2361	94	10982	784	2026-09-17 11:21:26.485194	Przeciw
2362	94	10982	784	2026-09-17 11:21:26.548279	Wstrzymuję się
2363	94	10982	785	2026-09-17 11:21:29.797425	Za
2364	94	10982	785	2026-09-17 11:21:29.853858	Przeciw
2365	94	10982	785	2026-09-17 11:21:29.923816	Wstrzymuję się
2366	94	10982	786	2026-09-17 11:21:33.365892	Za
2367	94	10982	786	2026-09-17 11:21:33.422376	Przeciw
2368	94	10982	786	2026-09-17 11:21:33.48542	Wstrzymuję się
2369	94	10982	787	2026-09-17 11:21:36.277644	Za
2370	94	10982	787	2026-09-17 11:21:36.36954	Przeciw
2371	94	10982	787	2026-09-17 11:21:36.450041	Wstrzymuję się
2372	94	10982	788	2026-09-17 11:21:38.723099	Za
2373	94	10982	788	2026-09-17 11:21:38.80988	Przeciw
2374	94	10982	788	2026-09-17 11:21:38.886249	Wstrzymuję się
2375	94	10982	789	2026-09-17 11:21:42.276144	Za
2376	94	10982	789	2026-09-17 11:21:42.335869	Przeciw
2377	94	10982	789	2026-09-17 11:21:42.394453	Wstrzymuję się
2378	94	10982	790	2026-09-17 11:21:45.122782	Za
2379	94	10982	790	2026-09-17 11:21:45.186232	Przeciw
2380	94	10982	790	2026-09-17 11:21:45.265833	Wstrzymuję się
2381	94	10982	791	2026-09-17 11:21:48.5456	Za
2382	94	10982	791	2026-09-17 11:21:48.609751	Przeciw
2510	97	10982	834	2026-09-17 11:29:52.433333	Za
2383	94	10982	791	2026-09-17 11:21:48.673118	Wstrzymuję się
2384	94	10982	792	2026-09-17 11:21:51.684651	Za
2385	94	10982	792	2026-09-17 11:21:51.745707	Przeciw
2386	94	10982	792	2026-09-17 11:21:51.806175	Wstrzymuję się
2387	94	10982	793	2026-09-17 11:21:54.895916	Za
2388	94	10982	793	2026-09-17 11:21:54.954034	Przeciw
2389	94	10982	793	2026-09-17 11:21:55.015041	Wstrzymuję się
2390	94	10982	794	2026-09-17 11:21:58.045453	Za
2391	94	10982	794	2026-09-17 11:21:58.109013	Przeciw
2392	94	10982	794	2026-09-17 11:21:58.169475	Wstrzymuję się
2393	95	10982	795	2026-09-17 11:25:29.56815	Za
2394	95	10982	795	2026-09-17 11:25:29.721998	Przeciw
2395	95	10982	795	2026-09-17 11:25:29.785322	Wstrzymuję się
2396	95	10982	796	2026-09-17 11:25:33.015895	Za
2397	95	10982	796	2026-09-17 11:25:33.073769	Przeciw
2398	95	10982	796	2026-09-17 11:25:33.171279	Wstrzymuję się
2399	95	10982	797	2026-09-17 11:25:39.369991	Za
2400	95	10982	797	2026-09-17 11:25:39.427732	Przeciw
2401	95	10982	797	2026-09-17 11:25:39.492821	Wstrzymuję się
2402	95	10982	798	2026-09-17 11:25:41.623356	Za
2403	95	10982	798	2026-09-17 11:25:41.72165	Przeciw
2404	95	10982	798	2026-09-17 11:25:41.783	Wstrzymuję się
2405	95	10982	799	2026-09-17 11:25:44.039711	Za
2406	95	10982	799	2026-09-17 11:25:44.097456	Przeciw
2407	95	10982	799	2026-09-17 11:25:44.16557	Wstrzymuję się
2408	95	10982	800	2026-09-17 11:25:45.939335	Za
2409	95	10982	800	2026-09-17 11:25:45.999404	Przeciw
2410	95	10982	800	2026-09-17 11:25:46.055446	Wstrzymuję się
2411	95	10982	801	2026-09-17 11:25:49.457334	Za
2412	95	10982	801	2026-09-17 11:25:49.516978	Przeciw
2413	95	10982	801	2026-09-17 11:25:49.578814	Wstrzymuję się
2414	95	10982	802	2026-09-17 11:25:52.037047	Za
2415	95	10982	802	2026-09-17 11:25:52.103226	Przeciw
2416	95	10982	802	2026-09-17 11:25:52.167265	Wstrzymuję się
2417	95	10982	803	2026-09-17 11:25:54.730927	Za
2418	95	10982	803	2026-09-17 11:25:54.791479	Przeciw
2419	95	10982	803	2026-09-17 11:25:54.881154	Wstrzymuję się
2420	95	10982	804	2026-09-17 11:25:57.36724	Za
2421	95	10982	804	2026-09-17 11:25:57.431102	Przeciw
2422	95	10982	804	2026-09-17 11:25:57.491487	Wstrzymuję się
2423	95	10982	805	2026-09-17 11:26:01.506666	Za
2424	95	10982	805	2026-09-17 11:26:01.565338	Przeciw
2425	95	10982	805	2026-09-17 11:26:01.625105	Wstrzymuję się
2426	95	10982	806	2026-09-17 11:26:03.846084	Za
2427	95	10982	806	2026-09-17 11:26:03.908253	Przeciw
2428	95	10982	806	2026-09-17 11:26:03.96743	Wstrzymuję się
2429	95	10982	807	2026-09-17 11:26:07.849579	Za
2430	95	10982	807	2026-09-17 11:26:07.913239	Przeciw
2431	95	10982	807	2026-09-17 11:26:07.974235	Wstrzymuję się
2432	95	10982	808	2026-09-17 11:26:11.538857	Za
2433	95	10982	808	2026-09-17 11:26:11.599112	Przeciw
2434	95	10982	808	2026-09-17 11:26:11.660375	Wstrzymuję się
2435	96	10982	809	2026-09-17 11:26:39.037257	Za
2436	96	10982	809	2026-09-17 11:26:39.103175	Przeciw
2437	96	10982	809	2026-09-17 11:26:39.185519	Wstrzymuję się
2438	96	10982	810	2026-09-17 11:26:42.587677	Za
2439	96	10982	810	2026-09-17 11:26:42.647853	Przeciw
2440	96	10982	810	2026-09-17 11:26:42.709131	Wstrzymuję się
2441	96	10982	811	2026-09-17 11:26:48.867011	Za
2442	96	10982	811	2026-09-17 11:26:48.927195	Przeciw
2443	96	10982	811	2026-09-17 11:26:48.9874	Wstrzymuję się
2444	96	10982	812	2026-09-17 11:26:51.301585	Za
2445	96	10982	812	2026-09-17 11:26:51.36561	Przeciw
2446	96	10982	812	2026-09-17 11:26:51.426987	Wstrzymuję się
2447	96	10982	813	2026-09-17 11:26:53.667884	Za
2448	96	10982	813	2026-09-17 11:26:53.733602	Przeciw
2449	96	10982	813	2026-09-17 11:26:53.797573	Wstrzymuję się
2450	96	10982	814	2026-09-17 11:26:55.788839	Za
2451	96	10982	814	2026-09-17 11:26:55.84782	Przeciw
2452	96	10982	814	2026-09-17 11:26:55.911348	Wstrzymuję się
2453	96	10982	815	2026-09-17 11:26:58.019836	Za
2454	96	10982	815	2026-09-17 11:26:58.124144	Przeciw
2455	96	10982	815	2026-09-17 11:26:58.185138	Wstrzymuję się
2456	96	10982	816	2026-09-17 11:27:02.32733	Za
2457	96	10982	816	2026-09-17 11:27:02.385108	Przeciw
2458	96	10982	816	2026-09-17 11:27:02.446899	Wstrzymuję się
2459	96	10982	817	2026-09-17 11:27:05.067237	Za
2460	96	10982	817	2026-09-17 11:27:05.195865	Przeciw
2462	96	10982	817	2026-09-17 11:27:05.254992	Wstrzymuję się
2465	97	10982	819	2026-09-17 11:29:02.73288	Za
2466	97	10982	819	2026-09-17 11:29:02.797224	Przeciw
2467	97	10982	819	2026-09-17 11:29:02.858862	Wstrzymuję się
2468	97	10982	820	2026-09-17 11:29:06.069618	Za
2469	97	10982	820	2026-09-17 11:29:06.141475	Przeciw
2470	97	10982	820	2026-09-17 11:29:06.20318	Wstrzymuję się
2471	97	10982	821	2026-09-17 11:29:12.644947	Za
2472	97	10982	821	2026-09-17 11:29:12.703382	Przeciw
2473	97	10982	821	2026-09-17 11:29:12.768866	Wstrzymuję się
2474	97	10982	822	2026-09-17 11:29:15.237148	Za
2475	97	10982	822	2026-09-17 11:29:15.31718	Przeciw
2476	97	10982	822	2026-09-17 11:29:15.529431	Wstrzymuję się
2477	97	10982	823	2026-09-17 11:29:18.059324	Za
2478	97	10982	823	2026-09-17 11:29:18.11886	Przeciw
2479	97	10982	823	2026-09-17 11:29:18.175505	Wstrzymuję się
2480	97	10982	824	2026-09-17 11:29:20.966661	Za
2481	97	10982	824	2026-09-17 11:29:21.028675	Przeciw
2482	97	10982	824	2026-09-17 11:29:21.090556	Wstrzymuję się
2483	97	10982	825	2026-09-17 11:29:23.693303	Za
2484	97	10982	825	2026-09-17 11:29:23.757085	Przeciw
2485	97	10982	825	2026-09-17 11:29:23.819123	Wstrzymuję się
2486	97	10982	826	2026-09-17 11:29:28.146807	Za
2487	97	10982	826	2026-09-17 11:29:28.203358	Przeciw
2488	97	10982	826	2026-09-17 11:29:28.267548	Wstrzymuję się
2489	97	10982	827	2026-09-17 11:29:30.963651	Za
2490	97	10982	827	2026-09-17 11:29:31.024698	Przeciw
2491	97	10982	827	2026-09-17 11:29:31.090076	Wstrzymuję się
2492	97	10982	828	2026-09-17 11:29:33.814863	Za
2493	97	10982	828	2026-09-17 11:29:33.876798	Przeciw
2494	97	10982	828	2026-09-17 11:29:33.948586	Wstrzymuję się
2495	97	10982	829	2026-09-17 11:29:39.87565	Za
2496	97	10982	829	2026-09-17 11:29:39.933505	Przeciw
2497	97	10982	829	2026-09-17 11:29:40.003626	Wstrzymuję się
2498	97	10982	830	2026-09-17 11:29:42.404203	Za
2499	97	10982	830	2026-09-17 11:29:42.465732	Przeciw
2500	97	10982	830	2026-09-17 11:29:42.523568	Wstrzymuję się
2501	97	10982	831	2026-09-17 11:29:44.688721	Za
2502	97	10982	831	2026-09-17 11:29:44.750263	Przeciw
2503	97	10982	831	2026-09-17 11:29:44.819262	Wstrzymuję się
2504	97	10982	832	2026-09-17 11:29:47.456959	Za
2505	97	10982	832	2026-09-17 11:29:47.515986	Przeciw
2506	97	10982	832	2026-09-17 11:29:47.573429	Wstrzymuję się
2507	97	10982	833	2026-09-17 11:29:50.303489	Za
2508	97	10982	833	2026-09-17 11:29:50.359482	Przeciw
2509	97	10982	833	2026-09-17 11:29:50.421149	Wstrzymuję się
2511	97	10982	834	2026-09-17 11:29:52.494968	Przeciw
2512	97	10982	834	2026-09-17 11:29:52.558876	Wstrzymuję się
2513	97	10982	835	2026-09-17 11:29:55.315179	Za
2514	97	10982	835	2026-09-17 11:29:55.3732	Przeciw
2515	97	10982	835	2026-09-17 11:29:55.436804	Wstrzymuję się
2516	97	10982	836	2026-09-17 11:29:58.213058	Za
2517	97	10982	836	2026-09-17 11:29:58.275042	Przeciw
2518	97	10982	836	2026-09-17 11:29:58.35111	Wstrzymuję się
2519	98	10982	837	2026-09-17 11:30:43.447626	Za
2520	98	10982	837	2026-09-17 11:30:43.509395	Przeciw
2521	98	10982	837	2026-09-17 11:30:43.568949	Wstrzymuję się
2522	98	10982	838	2026-09-17 11:30:53.055319	Za
2523	98	10982	838	2026-09-17 11:30:53.114909	Przeciw
2524	98	10982	838	2026-09-17 11:30:53.181153	Wstrzymuję się
2525	98	10982	839	2026-09-17 11:30:55.231238	Za
2526	98	10982	839	2026-09-17 11:30:55.293145	Przeciw
2527	98	10982	839	2026-09-17 11:30:55.353286	Wstrzymuję się
2528	98	10982	840	2026-09-17 11:30:57.565225	Za
2529	98	10982	840	2026-09-17 11:30:57.626771	Przeciw
2530	98	10982	840	2026-09-17 11:30:57.690988	Wstrzymuję się
2531	98	10982	841	2026-09-17 11:30:59.676866	Za
2532	98	10982	841	2026-09-17 11:30:59.733334	Przeciw
2533	98	10982	841	2026-09-17 11:30:59.794919	Wstrzymuję się
2534	98	10982	842	2026-09-17 11:31:02.077916	Za
2535	98	10982	842	2026-09-17 11:31:02.133895	Przeciw
2536	98	10982	842	2026-09-17 11:31:02.19207	Wstrzymuję się
2537	98	10982	843	2026-09-17 11:31:05.085326	Za
2538	98	10982	843	2026-09-17 11:31:05.147948	Przeciw
2539	98	10982	843	2026-09-17 11:31:05.208709	Wstrzymuję się
2540	98	10982	844	2026-09-17 11:31:08.127699	Za
2541	98	10982	844	2026-09-17 11:31:08.187057	Przeciw
2542	98	10982	844	2026-09-17 11:31:08.245237	Wstrzymuję się
2543	98	10982	845	2026-09-17 11:31:11.238628	Za
2544	98	10982	845	2026-09-17 11:31:11.304729	Przeciw
2545	98	10982	845	2026-09-17 11:31:11.36987	Wstrzymuję się
2546	98	10982	846	2026-09-17 11:31:13.91328	Za
2547	98	10982	846	2026-09-17 11:31:13.972845	Przeciw
2548	98	10982	846	2026-09-17 11:31:14.061041	Wstrzymuję się
2549	98	10982	847	2026-09-17 11:31:18.502897	Za
2550	98	10982	847	2026-09-17 11:31:18.567815	Przeciw
2551	98	10982	847	2026-09-17 11:31:18.629182	Wstrzymuję się
2552	98	10982	848	2026-09-17 11:31:20.515122	Za
2553	98	10982	848	2026-09-17 11:31:20.585598	Przeciw
2554	98	10982	848	2026-09-17 11:31:20.649246	Wstrzymuję się
2555	98	10982	849	2026-09-17 11:31:24.205727	Za
2556	98	10982	849	2026-09-17 11:31:24.269506	Przeciw
2557	98	10982	849	2026-09-17 11:31:24.331526	Wstrzymuję się
2558	98	10982	850	2026-09-17 11:31:26.418869	Za
2559	98	10982	850	2026-09-17 11:31:26.475596	Przeciw
2560	98	10982	850	2026-09-17 11:31:26.53524	Wstrzymuję się
2561	98	10982	851	2026-09-17 11:31:30.415266	Za
2562	98	10982	851	2026-09-17 11:31:30.538899	Przeciw
2563	98	10982	851	2026-09-17 11:31:30.597107	Wstrzymuję się
2564	98	10982	852	2026-09-17 11:31:33.35961	Za
2565	98	10982	852	2026-09-17 11:31:33.428979	Przeciw
2566	98	10982	852	2026-09-17 11:31:33.486325	Wstrzymuję się
2567	98	10982	853	2026-09-17 11:31:35.909294	Za
2568	98	10982	853	2026-09-17 11:31:35.970534	Przeciw
2569	98	10982	853	2026-09-17 11:31:36.033111	Wstrzymuję się
2570	98	10982	854	2026-09-17 11:31:39.032968	Za
2571	98	10982	854	2026-09-17 11:31:39.092651	Przeciw
2572	98	10982	854	2026-09-17 11:31:39.178741	Wstrzymuję się
2573	98	10982	855	2026-09-17 11:31:41.935025	Za
2574	98	10982	855	2026-09-17 11:31:41.995142	Przeciw
2575	98	10982	855	2026-09-17 11:31:42.065536	Wstrzymuję się
2576	98	10982	856	2026-09-17 11:31:44.879455	Za
2577	98	10982	856	2026-09-17 11:31:44.966865	Przeciw
2578	98	10982	856	2026-09-17 11:31:45.030184	Wstrzymuję się
2579	98	10982	857	2026-09-17 11:31:48.659527	Za
2580	98	10982	857	2026-09-17 11:31:48.726626	Przeciw
2581	98	10982	857	2026-09-17 11:31:48.791255	Wstrzymuję się
2582	98	10982	858	2026-09-17 11:31:57.609327	Za
2583	98	10982	858	2026-09-17 11:31:57.693219	Przeciw
2584	98	10982	858	2026-09-17 11:31:57.755255	Wstrzymuję się
2585	98	10982	859	2026-09-17 11:32:00.210341	Za
2586	98	10982	859	2026-09-17 11:32:00.271217	Przeciw
2587	98	10982	859	2026-09-17 11:32:00.340996	Wstrzymuję się
2588	98	10982	860	2026-09-17 11:32:02.597734	Za
2589	98	10982	860	2026-09-17 11:32:02.660905	Przeciw
2590	98	10982	860	2026-09-17 11:32:02.719071	Wstrzymuję się
\.


--
-- Data for Name: graders; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.graders (id, user_id, group_id, created_at) FROM stdin;
15	10980	4	2026-02-15 20:36:54.577669
17	10974	4	2026-02-15 20:36:57.967632
18	10975	5	2026-02-15 20:37:00.100134
20	10979	5	2026-02-15 20:37:03.091861
19	10971	5	2026-02-15 20:37:01.734889
21	10972	6	2026-02-15 20:37:04.871182
23	10976	6	2026-02-15 20:37:07.405382
22	10977	6	2026-02-15 20:37:06.258291
24	11115	4	2026-06-20 20:20:30.625028
\.


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.grades (id, submission_id, grader_id, grade, created_at) FROM stdin;
3374	2265	15	4.5	2026-06-18 08:29:01.306424
3375	2259	15	4	2026-06-18 08:29:54.151757
3376	2271	15	4	2026-06-18 08:30:55.111559
3377	2268	15	3.5	2026-06-18 08:31:43.271491
3378	2262	15	3	2026-06-18 08:32:31.03188
3379	2269	18	4	2026-06-18 08:32:40.381183
3380	2263	18	3	2026-06-18 08:32:51.585435
3381	2266	18	3	2026-06-18 08:33:00.761736
3382	2272	18	3.5	2026-06-18 08:33:11.313065
3383	2260	18	3.5	2026-06-18 08:33:19.789887
3384	2268	17	3	2026-06-18 09:57:00.648215
3385	2271	17	4	2026-06-18 10:05:08.807476
3386	2259	17	3.5	2026-06-18 10:08:41.050335
3387	2262	17	4.5	2026-06-18 10:10:38.049394
3388	2265	17	4.5	2026-06-18 10:11:56.244421
3389	2263	20	2	2026-06-18 18:05:45.521795
3390	2260	20	2.5	2026-06-18 18:15:50.758752
3391	2272	20	3	2026-06-18 18:16:47.803877
3392	2269	20	3	2026-06-18 18:17:47.892577
3393	2266	20	3	2026-06-18 18:18:58.436768
3394	2266	19	5	2026-06-19 11:58:33.055543
3395	2272	19	4.5	2026-06-19 11:58:48.684358
3396	2260	19	4.5	2026-06-19 11:59:07.687328
3397	2263	19	4	2026-06-19 11:59:18.635738
3398	2269	19	4.5	2026-06-19 11:59:33.799278
3399	2267	22	4	2026-06-19 15:31:59.389382
3400	2264	22	1.5	2026-06-19 15:38:36.54435
3401	2273	22	3	2026-06-19 15:56:58.798045
3402	2270	22	3.5	2026-06-19 16:05:53.492153
3403	2261	22	3.5	2026-06-19 16:10:08.086721
3404	2264	23	3	2026-06-19 19:57:17.967796
3405	2273	23	2	2026-06-19 19:58:04.768233
3406	2270	23	3.5	2026-06-19 19:58:51.840848
3407	2267	23	3	2026-06-19 19:59:36.667325
3408	2261	23	4	2026-06-19 20:00:08.744764
3409	2273	21	2	2026-06-20 06:43:59.597204
3410	2270	21	4	2026-06-20 06:45:24.093759
3411	2261	21	2	2026-06-20 06:46:52.716114
3412	2267	21	1.5	2026-06-20 06:48:01.461938
3413	2264	21	1.5	2026-06-20 06:49:26.94435
3414	2259	24	3	2026-06-20 20:27:32.252526
3415	2268	24	3.5	2026-06-20 20:30:20.716538
3416	2271	24	4.5	2026-06-20 20:32:25.758356
3417	2262	24	3.5	2026-06-20 20:34:35.743472
3418	2265	24	3	2026-06-20 20:36:24.838152
\.


--
-- Data for Name: grading_groups; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.grading_groups (id, created_at) FROM stdin;
4	2026-02-15 20:36:49.573297
5	2026-02-15 20:36:51.005545
6	2026-02-15 20:36:51.70698
\.


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.polls (id, creator_id, title, description, status, created_at, opened_at, closed_at) FROM stdin;
90	10982	2A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE BEZPIECZEŃSTWA ENERGETYCZNEGO, ODPOWIEDZIALNEJ TRANSFORMACJI ENERGETYCZNEJ ORAZ WSPARCIA  REGIONÓW GÓRNICZYCH		OFF	2026-09-17 11:15:24.006946	\N	\N
91	10982	3A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE NADAWANIA KIERUNKÓW DZIAŁAŃ W PROCESIE TRANSFORMACJI SEKTORA  ENERGETYCZNEGO		OFF	2026-09-17 11:16:33.963012	\N	\N
92	10982	4A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE OPTYMALIZACJI UWARUNKOWAŃ PRAWNYCH DLA ROZWOJU  INFRASTRUKTURY MAGAZYNOWANIA ENERGII ELEKTRYCZNEJ, INTEGRACJI USŁUG ELASTYCZNOŚCI Z KRAJOWYM SYSTEMEM ELEKTROENERGETYCZNYM, ROZWOJU ENERGETYKI JĄDROWEJ, KADR PRACOWNIKÓW ENERGETYKI JĄDROWEJ ORAZ REWITALIZACJI GMIN  GÓRNICZYCH		OFF	2026-09-17 11:17:42.675958	\N	\N
93	10982	6A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE SPOŁECZNYCH ASPEKTÓW TRANSFORMACJI ENERGETYCZNEJ		OFF	2026-09-17 11:18:44.887878	\N	\N
94	10982	7A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE STRATEGICZNEJ POLITYKI ENERGETYCZNEJ		OFF	2026-09-17 11:19:11.199949	\N	\N
95	10982	8A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE ZWIĘKSZENIA ZASTOSOWANIA ZNACZENIA BIOMETANU I BIOGAZU W SYSTEMIE ENERGETYCZNYM RZECZYPOSPOLITEJ POLSKIEJ		OFF	2026-09-17 11:25:29.393379	\N	\N
96	10982	9A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE RYNKOWEJ I KONKURENCYJNEJ TRANSFORMACJI ENERGETYCZNEJ POLSKI		OFF	2026-09-17 11:26:38.851309	\N	\N
97	10982	10A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE ZWIĘKSZENIA UDZIAŁU OBYWATELI W TRANSFORMACJI ENERGETYCZNEJ		OFF	2026-09-17 11:29:02.603504	\N	\N
98	10982	11A - POPRAWKI DO PROJEKTU UCHWAŁY W SPRAWIE OKREŚLENIA KIERUNKÓW POLITYKI ENERGETYCZNEJ RZECZYPOSPOLITEJ  POLSKIEJ		OFF	2026-09-17 11:30:43.304945	\N	\N
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.questions (id, creator_id, poll_id, created_at, type, choices_number, content) FROM stdin;
729	10982	92	2026-09-17 11:17:42.73632	\N	\N	Poprawka 1
730	10982	92	2026-09-17 11:17:51.94822	\N	\N	Poprawka 2
781	10982	94	2026-09-17 11:21:16.184055	\N	\N	Poprawka 38 (Przyjęcie poprawki 38 spowoduje bezprzedmiotowość poprawki 39)
731	10982	92	2026-09-17 11:17:55.125825	\N	\N	Poprawka 3
732	10982	92	2026-09-17 11:17:57.750476	\N	\N	Poprawka 4
760	10982	94	2026-09-17 11:20:13.29972	\N	\N	Poprawka 17 (Przyjęcie poprawki 17 spowoduje bezprzedmiotowość poprawki 19 i 20)
709	10982	90	2026-09-17 11:15:24.205044	\N	\N	Poprawka 1
733	10982	92	2026-09-17 11:18:00.902637	\N	\N	Poprawka 5
710	10982	90	2026-09-17 11:15:36.100481	\N	\N	Poprawka 2
711	10982	90	2026-09-17 11:15:41.114396	\N	\N	Poprawka 3
779	10982	94	2026-09-17 11:21:09.720277	\N	\N	Poprawka 36
712	10982	90	2026-09-17 11:15:43.859031	\N	\N	Poprawka 4
734	10982	92	2026-09-17 11:18:05.768113	\N	\N	Poprawka 6
713	10982	90	2026-09-17 11:15:47.430098	\N	\N	Poprawka 5
714	10982	90	2026-09-17 11:15:50.149302	\N	\N	Poprawka 6
756	10982	94	2026-09-17 11:20:02.636119	\N	\N	Poprawka 13 (Przyjęcie poprawki 13 spowoduje bezprzedmiotowość poprawki 14)
715	10982	90	2026-09-17 11:15:52.986486	\N	\N	Poprawka 7
735	10982	92	2026-09-17 11:18:08.805724	\N	\N	Poprawka 7
716	10982	90	2026-09-17 11:15:56.492426	\N	\N	Poprawka 8
717	10982	91	2026-09-17 11:16:34.026719	\N	\N	Poprawka 1
736	10982	92	2026-09-17 11:18:12.700026	\N	\N	Poprawka 8
718	10982	91	2026-09-17 11:16:39.828402	\N	\N	Poprawka 2
719	10982	91	2026-09-17 11:16:48.438099	\N	\N	Poprawka 3
720	10982	91	2026-09-17 11:16:50.915777	\N	\N	Poprawka 4
737	10982	92	2026-09-17 11:18:16.450765	\N	\N	Poprawka 9
721	10982	91	2026-09-17 11:16:53.960415	\N	\N	Poprawka 5
763	10982	94	2026-09-17 11:20:23.848909	\N	\N	Poprawka 20
722	10982	91	2026-09-17 11:16:56.336258	\N	\N	Poprawka 6
738	10982	92	2026-09-17 11:18:19.659985	\N	\N	Poprawka 10
723	10982	91	2026-09-17 11:16:59.820777	\N	\N	Poprawka 7
724	10982	91	2026-09-17 11:17:03.114377	\N	\N	Poprawka 8
725	10982	91	2026-09-17 11:17:06.060123	\N	\N	Poprawka 9
739	10982	92	2026-09-17 11:18:22.510651	\N	\N	Poprawka 11
726	10982	91	2026-09-17 11:17:09.203827	\N	\N	Poprawka 10
761	10982	94	2026-09-17 11:20:17.359719	\N	\N	Poprawka 18 (Przyjęcie poprawki 18 spowoduje bezprzedmiotowość poprawki 19 i 20)
727	10982	91	2026-09-17 11:17:14.782159	\N	\N	Poprawka 11
740	10982	92	2026-09-17 11:18:25.326528	\N	\N	Poprawka 12
728	10982	91	2026-09-17 11:17:18.296924	\N	\N	Poprawka 12
741	10982	93	2026-09-17 11:18:44.950082	\N	\N	Poprawka 1
742	10982	93	2026-09-17 11:18:50.822561	\N	\N	Poprawka 2
765	10982	94	2026-09-17 11:20:29.830412	\N	\N	Poprawka 22
743	10982	93	2026-09-17 11:18:53.048184	\N	\N	Poprawka 3
744	10982	94	2026-09-17 11:19:11.256075	\N	\N	Poprawka 1
745	10982	94	2026-09-17 11:19:14.478329	\N	\N	Poprawka 2 (Przyjęcie poprawki 2 spowoduje bezprzedmiotowość poprawki 3 i 4)
790	10982	94	2026-09-17 11:21:45.060354	\N	\N	Poprawka 47 (Przyjęcie poprawki 47 spowoduje bezprzedmiotowość poprawki 48)
746	10982	94	2026-09-17 11:19:34.276261	\N	\N	Poprawka 3
780	10982	94	2026-09-17 11:21:13.043856	\N	\N	Poprawka 37
747	10982	94	2026-09-17 11:19:37.299863	\N	\N	Poprawka 4
748	10982	94	2026-09-17 11:19:41.058731	\N	\N	Poprawka 5
762	10982	94	2026-09-17 11:20:19.961581	\N	\N	Poprawka 19 (Przyjęcie poprawki 19 spowoduje bezprzedmiotowość poprawki 20)
749	10982	94	2026-09-17 11:19:43.55163	\N	\N	Poprawka 6 (Przyjęcie poprawki 6 spowoduje bezprzedmiotowość poprawki 7)
750	10982	94	2026-09-17 11:19:45.99941	\N	\N	Poprawka 7
751	10982	94	2026-09-17 11:19:48.908163	\N	\N	Poprawka 8 (Przyjęcie poprawki 8 spowoduje bezprzedmiotowość poprawki 9)
767	10982	94	2026-09-17 11:20:36.436876	\N	\N	Poprawka 24
752	10982	94	2026-09-17 11:19:51.847648	\N	\N	Poprawka 9
768	10982	94	2026-09-17 11:20:38.854428	\N	\N	Poprawka 25 (Przyjęcie poprawki 25 spowoduje bezprzedmiotowość poprawki 26 i 27)
753	10982	94	2026-09-17 11:19:54.569498	\N	\N	Poprawka 10
754	10982	94	2026-09-17 11:19:57.376083	\N	\N	Poprawka 11 (Przyjęcie poprawki 11 spowoduje bezprzedmiotowość poprawki 12, 13 i 14)
755	10982	94	2026-09-17 11:19:59.943189	\N	\N	Poprawka 12 (Przyjęcie poprawki 12 spowoduje bezprzedmiotowość poprawki 14)
795	10982	95	2026-09-17 11:25:29.457605	\N	\N	Poprawka 1
769	10982	94	2026-09-17 11:20:41.738145	\N	\N	Poprawka 26
757	10982	94	2026-09-17 11:20:05.281596	\N	\N	Poprawka 14
758	10982	94	2026-09-17 11:20:08.318309	\N	\N	Poprawka 15
759	10982	94	2026-09-17 11:20:10.765928	\N	\N	Poprawka 16
791	10982	94	2026-09-17 11:21:48.480407	\N	\N	Poprawka 48
782	10982	94	2026-09-17 11:21:20.413701	\N	\N	Poprawka 39
770	10982	94	2026-09-17 11:20:44.045649	\N	\N	Poprawka 27
771	10982	94	2026-09-17 11:20:47.885043	\N	\N	Poprawka 28
764	10982	94	2026-09-17 11:20:26.931811	\N	\N	Poprawka 21 (Przyjęcie poprawki 21 spowoduje bezprzedmiotowość poprawki 22)
772	10982	94	2026-09-17 11:20:50.436472	\N	\N	Poprawka 29
773	10982	94	2026-09-17 11:20:53.125688	\N	\N	Poprawka 30
784	10982	94	2026-09-17 11:21:26.321143	\N	\N	Poprawka 41 (Przyjęcie poprawki 41 spowoduje bezprzedmiotowość poprawki 43)
774	10982	94	2026-09-17 11:20:56.129906	\N	\N	Poprawka 31
778	10982	94	2026-09-17 11:21:05.736853	\N	\N	Poprawka 35 (Przyjęcie poprawki 35 spowoduje bezprzedmiotowość poprawki 36, 37, 38 i 39)
775	10982	94	2026-09-17 11:20:59.091753	\N	\N	Poprawka 32
776	10982	94	2026-09-17 11:21:01.303829	\N	\N	Poprawka 33
796	10982	95	2026-09-17 11:25:32.957812	\N	\N	Poprawka 2
777	10982	94	2026-09-17 11:21:03.547811	\N	\N	Poprawka 34
766	10982	94	2026-09-17 11:20:32.185941	\N	\N	Poprawka 23 (Przyjęcie poprawki 23 spowoduje bezprzedmiotowość poprawki 24)
789	10982	94	2026-09-17 11:21:42.219593	\N	\N	Poprawka 46 (Przyjęcie poprawki 46 spowoduje bezprzedmiotowość poprawki 48)
786	10982	94	2026-09-17 11:21:33.301963	\N	\N	Poprawka 43
783	10982	94	2026-09-17 11:21:23.235967	\N	\N	Poprawka 40 (Przyjęcie poprawki 40 spowoduje bezprzedmiotowość poprawki 43)
787	10982	94	2026-09-17 11:21:36.195862	\N	\N	Poprawka 44
788	10982	94	2026-09-17 11:21:38.662353	\N	\N	Poprawka 45
797	10982	95	2026-09-17 11:25:39.309411	\N	\N	Poprawka 3
837	10982	98	2026-09-17 11:30:43.386462	\N	\N	Poprawka 1
794	10982	94	2026-09-17 11:21:57.987102	\N	\N	Poprawka 51
793	10982	94	2026-09-17 11:21:54.830681	\N	\N	Poprawka 50 
785	10982	94	2026-09-17 11:21:29.736528	\N	\N	Poprawka 42 (Przyjęcie poprawki 42 spowoduje bezprzedmiotowość poprawki 43)
799	10982	95	2026-09-17 11:25:43.979248	\N	\N	Poprawka 5
792	10982	94	2026-09-17 11:21:51.61383	\N	\N	Poprawka 49 (Przyjęcie poprawki 49 spowoduje bezprzedmiotowość poprawki 50)
800	10982	95	2026-09-17 11:25:45.877437	\N	\N	Poprawka 6
801	10982	95	2026-09-17 11:25:49.399787	\N	\N	Poprawka 7
802	10982	95	2026-09-17 11:25:51.975155	\N	\N	Poprawka 8
803	10982	95	2026-09-17 11:25:54.669635	\N	\N	Poprawka 9
860	10982	98	2026-09-17 11:32:02.539047	\N	\N	Poprawka 24
804	10982	95	2026-09-17 11:25:57.307963	\N	\N	Poprawka 10
805	10982	95	2026-09-17 11:26:01.444014	\N	\N	Poprawka 11
824	10982	97	2026-09-17 11:29:20.90539	\N	\N	Poprawka 6 (Przyjęcie poprawki 6 spowoduje bezprzedmiotowość poprawki 7 i 8)
806	10982	95	2026-09-17 11:26:03.781374	\N	\N	Poprawka 12
838	10982	98	2026-09-17 11:30:52.991114	\N	\N	Poprawka 2
807	10982	95	2026-09-17 11:26:07.791363	\N	\N	Poprawka 13
808	10982	95	2026-09-17 11:26:11.477661	\N	\N	Poprawka 14
798	10982	95	2026-09-17 11:25:41.561803	\N	\N	Poprawka 4 (Przyjęcie poprawki 4 spowoduje bezprzedmiotowość poprawki 5)
809	10982	96	2026-09-17 11:26:38.923298	\N	\N	Poprawka 1
810	10982	96	2026-09-17 11:26:42.531091	\N	\N	Poprawka 2
811	10982	96	2026-09-17 11:26:48.794716	\N	\N	Poprawka 3
839	10982	98	2026-09-17 11:30:55.155723	\N	\N	Poprawka 3
812	10982	96	2026-09-17 11:26:51.211754	\N	\N	Poprawka 4
813	10982	96	2026-09-17 11:26:53.597627	\N	\N	Poprawka 5
814	10982	96	2026-09-17 11:26:55.723022	\N	\N	Poprawka 6
815	10982	96	2026-09-17 11:26:57.947767	\N	\N	Poprawka 7
840	10982	98	2026-09-17 11:30:57.502821	\N	\N	Poprawka 4
816	10982	96	2026-09-17 11:27:02.267683	\N	\N	Poprawka 8
817	10982	96	2026-09-17 11:27:05.003212	\N	\N	Poprawka 9
819	10982	97	2026-09-17 11:29:02.663295	\N	\N	Poprawka 1
841	10982	98	2026-09-17 11:30:59.612955	\N	\N	Poprawka 5
820	10982	97	2026-09-17 11:29:05.96962	\N	\N	Poprawka 2
821	10982	97	2026-09-17 11:29:12.57952	\N	\N	Poprawka 3
856	10982	98	2026-09-17 11:31:44.818855	\N	\N	Poprawka 20 (Przyjęcie poprawki 20 spowoduje bezprzedmiotowość poprawki 21)
822	10982	97	2026-09-17 11:29:15.174093	\N	\N	Poprawka 4
823	10982	97	2026-09-17 11:29:18.001709	\N	\N	Poprawka 5
843	10982	98	2026-09-17 11:31:05.021103	\N	\N	Poprawka 7
825	10982	97	2026-09-17 11:29:23.615612	\N	\N	Poprawka 7
826	10982	97	2026-09-17 11:29:28.086458	\N	\N	Poprawka 8
827	10982	97	2026-09-17 11:29:30.90581	\N	\N	Poprawka 9
844	10982	98	2026-09-17 11:31:08.061454	\N	\N	Poprawka 8
828	10982	97	2026-09-17 11:29:33.749148	\N	\N	Poprawka 10
829	10982	97	2026-09-17 11:29:39.816148	\N	\N	Poprawka 11
853	10982	98	2026-09-17 11:31:35.853501	\N	\N	Poprawka 17 (Przyjęcie poprawki 17 spowoduje bezprzedmiotowość poprawki 18)
830	10982	97	2026-09-17 11:29:42.34252	\N	\N	Poprawka 12
845	10982	98	2026-09-17 11:31:11.110448	\N	\N	Poprawka 9
832	10982	97	2026-09-17 11:29:47.389444	\N	\N	Poprawka 14
834	10982	97	2026-09-17 11:29:52.373951	\N	\N	Poprawka 16
846	10982	98	2026-09-17 11:31:13.856882	\N	\N	Poprawka 10
835	10982	97	2026-09-17 11:29:55.199334	\N	\N	Poprawka 17
836	10982	97	2026-09-17 11:29:58.154496	\N	\N	Poprawka 18
847	10982	98	2026-09-17 11:31:18.440917	\N	\N	Poprawka 11
850	10982	98	2026-09-17 11:31:26.291609	\N	\N	Poprawka 14 (Przyjęcie poprawki 14 spowoduje bezprzedmiotowość poprawki 15)
833	10982	97	2026-09-17 11:29:50.231159	\N	\N	Poprawka 15 (Przyjęcie poprawki 15 spowoduje bezprzedmiotowość poprawki 16, 17 i 18)
848	10982	98	2026-09-17 11:31:20.455149	\N	\N	Poprawka 12
831	10982	97	2026-09-17 11:29:44.624912	\N	\N	Poprawka 13 (Przyjęcie poprawki 13 spowoduje bezprzedmiotowość poprawki 14)
849	10982	98	2026-09-17 11:31:24.141742	\N	\N	Poprawka 13
851	10982	98	2026-09-17 11:31:30.317528	\N	\N	Poprawka 15
842	10982	98	2026-09-17 11:31:02.01302	\N	\N	Poprawka 6 (Przyjęcie poprawki 6 spowoduje bezprzedmiotowość poprawki 7)
852	10982	98	2026-09-17 11:31:33.278875	\N	\N	Poprawka 16
854	10982	98	2026-09-17 11:31:38.971444	\N	\N	Poprawka 18
855	10982	98	2026-09-17 11:31:41.873754	\N	\N	Poprawka 19
857	10982	98	2026-09-17 11:31:48.59582	\N	\N	Poprawka 21
858	10982	98	2026-09-17 11:31:57.544656	\N	\N	Poprawka 22
859	10982	98	2026-09-17 11:32:00.153234	\N	\N	Poprawka 23
\.


--
-- Data for Name: resolution_signatures; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.resolution_signatures (id, resolution_id, user_id, "timestamp", type) FROM stdin;
\.


--
-- Data for Name: resolutions; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.resolutions (id, title, slug, file_name, author_id, author, party, preamble, chapters, session_id, status, created_at) FROM stdin;
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.submissions (id, group_id, created_at, submission_number, about_me, subject_1, subject_2, subject_1_answer, subject_2_answer) FROM stdin;
2261	6	2026-06-16 16:23:37.765588	442	Od 2022 roku jestem aktywnym uczestnikiem wielu działań społecznych. Należę, do młodzieżówki Młodej Lewicy w, której to realizuję wraz z innymi członkami działania m.in promujące zdrowie psychiczne dzieci i młodzieży (co potwierdza mój udział w Okrągłym Stole na temat psychiatrii dziecięcej), kolektywnie i co roku piszemy projekty na Budżet Obywatelski miasta Białystok (w ubiegłym roku był to projekt dot. Rewitalizacji Skweru im. doc. Włodzimierza Zankiewicza) oraz prowadzimy liczne kampanie - wyborów parlamentarnych jak i wyborów prezydenckich na korzyść Magdaleny Biejat. \nNa co dzień mieszkam przy białoruskiej granicy, gdzie zarówno mniejszość białoruska i ukraińska żyją w zgodzie. Zależy mi na tym, aby głos mniejszości był słyszany lokalnie jak i na forum całej Polski – co roku wraz ze stowarzyszeniem „Nasza Szkoła”, które funkcjonuje przy mojej szkole aktywnie działam w organizacji m.in. „Pikniku z Białorusem” – który to polega na promowaniu białoruskiej kultury, sztuki, podtrzymania świadomości narodowej i dziedzictwa narodowego. \nNa terenie całego miasta zrzeszam przedszkola, szkoły podstawowe i szkoły średnie w celu promocji lokalnego środowiska – tworzymy razem drzewa genaologiczne, rozmawiamy o przodkach i historii regionu oraz pokazuję to co nas wszystkich łączy. \nJestem zaangażowany w działania, które skłaniają dzieci i młodzież do wspólnej partycypacji. Idee, które promuję są rozpowszechnione w całym województwie podlaskim, gdyż skupiają one grono szkół podstawowych, oraz ponadpodstawowych w których regularnie przeprowadzany jest z mojego ramienia Szkolny Budżet Partycypacyjny – koordynuję ten projekt i co roku pokazuję młodzieży, że mają wpływ na to co się dzieje w szkolę, uczę ich podstaw demokracji i współdecydowania, co jest kluczowe w dorosłym życiu.	Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?, Media społecznościowe i sztuczna inteligencja - nowe wyzwania ery cyfrowej.		Kryzys demograficzny nie jest przede wszystkim problemem „braku chęci do posiadania dzieci”, lecz skutkiem niepewności finansowej, braku stabilnych i odpowiednio tanich mieszkań, przeciążonej pracy i słabej dostępności usług publicznych. Młodzi odkładają decyzje o rodzinie, bo nie mają poczucia bezpieczeństwa. Dlatego polityka demograficzna powinna opierać się nie na jednorazowych świadczeniach finansowych, ale na systemowych i skutecznych rozwiązaniach: rozwoju taniego budownictwa publicznego, skroceniu czasu pracy przy zachowaniu wynagrodzeń, dostępnej opiece żłobkowej i przedszkolnej oraz realnym wsparciu zdrowia psychicznego rodziców i dzieci. Ważna jest również równość płci - urlopy rodzicielskie powinny być w równym stopniu dostępne dla kobiet i mężczyzn, aby ciężar opieki nie spadał głównie na matki. Jeśli młodzi będą mieli stabilność i wsparcie panstwa, decyzja o rodzinie stanie się naturalna i nie będzie ona strachem, młodzi ludzie mniej będą obawiać się ryzyka. \nRównolegle należy przeciwdziałać wyludnianiu mniejszych miejscowości poprzez inwestycje w transport publiczny, dostęp do edukacji, kultury i usług zdrowotnych. Problemem mniejszych aglomeracji jest również niewystarczająca liczba miejsc pracy - w tych miejscach przedsiębiorcy w regionie powinni liczyć na ulgi, które wesprą prowadzenie ich biznesu, i będą mieli szansę na realny rozwoj. Polska nie może rozwijać się tylko wokół wielkich miast - potrzebna jest silna polityka regionalna, która da młodym perspektywy takze poza metropoliami. \n\nDrugim obszarem, który uważam za kluczowy, są media społecznościowe i sztuczna inteligencaja. Dla mojego pokolenia internet nie jest dodatkiem do życia - to jego integralna część. To tam uczymy się, budujemy relacje i kształtujemy poglądy i możemy poczuć się „na czasie” . Problem polega na tym, że platformy działają według algorytmów nastawionych na maksymalizację zysku, a nie na dobro użytkowników. Im więcej emocji, kontrowersji i skrajnych treści, tym większe zaangazowanie - co często prowadzi do polaryzacji społeczeństwa, szerzenia dezinformacji oraz pogorszenia zdrowia psychicznego młodych ludzi. Często media przedstawiają nam nieocenzurowane treści, które destruktywnie działają na młode umysły, pokazując działania skrajnie patologiczne i nieodpowiednie. \nUważam, że państwo powinno odważniej regulować media społecznościowe: wprowadzić przejrzystość algorytmów, ograniczyć działalność tzw. „patostreamerów” i destruktywnych treści oraz zobowiązać platformy do realnej walki z hejtem i fake newsami. Równolegle potrzebna jest edukacja cyfrowa - ucząca krytycznego myslenia, rozpoznawania manipulacji i dbania o higienę psychiczną w sieci. W obecnych czasach ciężko jest przefiltrować co jest prawdą a co nie, sztuczna inteligencja na przestrzeni kilku ostatnich lat stała się ogromnym narzędziem - na co dzień dostrzegamy m.in. filmiki wygenerowane przez AI, które to coraz trudniej rozróżnić od rzeczywistości. 	
2262	4	2026-06-16 16:23:37.765588	474	Działam w sferze aktywności młodzieżowej od trzech lat, wcześniej uczestnicząc w samorządzie uczniowskim. Tym początkiem było działanie mające na celu zdiagnozować problemy szkolnej społeczności, przeprowadzić z nią dialog i wprowadzić zmianę (niestety została ona zatrzymana przez beton dyrektorski, niechęć do konwersacji). Odtąd to właśnie kwestia dialogu najbardziej się dla mnie liczyła. Zawsze staram się dążyć do uwzględnienia różnych światopoglądów w swoim otoczeniu, albowiem nasza demokracja nie będzie działać bez tej wymiany. Od ponad roku jestem członkiem MRD, w ramach której brałem udział w wielu wydarzeniach, a sam współorganizowałem dzielnicową konferencję samorządów uczniowskich, która była przestrzenią dla nich, by mogły się lepiej zintegrować, jak i zobaczyć działalność naszej rady; jak również spotkania z uczniami na temat Unii Europejskiej, które przybliżyły im ówczesną wówczas Prezydencję Polską w radzie UE. Jestem również absolwentem WAML 9.0, w ramach którego przeszedłem wiele dni szkoleń, zwieńczając ów drogę współorganizacją sesji dialogu na temat miejsca dla młodych na listach wyborczych. Przemawiałem również przy wielu okazjach, jednym z nich była Konferencja Opiekunów Młodzieżowych Rad Mazowsza, dzieląc się swoimi poglądami i odczuciami na dany temat konwersacji(pomaga mi w tym również moje uczestnictwo w Warszawskiej Lidze Debatanckiej). Opiniowałem również projekt strategii Warszawa 2040+, których kiepski proces konsultacyjny otwarcie komentowałem, zaś w samej strategii widziałem duży brak stawiania jasnych sformułowań i akcji w zakresie tolerancji, współpracy z NGO, czy dialogu. Uważam, iż udział w wielu wydarzeniach i szkoleniach różnorakiej natury (w tym tych niewymienionych tutaj) czyni ze mnie osobę dość doświadczoną w młodzieżowej polityce	Polityka zagraniczna III Rzeczypospolitej Polskiej - strategia na czasy niepokoju z perspektywy młodych., Energetyka XXI wieku. Jak powinna wyglądać transformacja energetyczna "po polsku" ?		Zacznijmy od kwestii polityki zagranicznej naszej Rzeczypospolitej. Aktualny konflikt na linii Pałac Prezydencki-Rząd jest jawnym zagrożeniem dla naszego społeczeństwa, tworząc podziały wewnętrzne, które wschodnie wpływy chętnie utylizują siejąc dezinformację i nieufność do polityki rządu. Polaryzacja ta osłabia też przekaz Polski, gdzie jedni idą na kolanach do Ameryki, która coraz bardziej otwarcie chce opuszczać Europę i jej mankamenty, zaś drudzy widzą nasze miejsce na świecie w kategoriach Europejskich. Myślę, że podstawową rolą młodych w tej sytuacji winno być stworzenie nacisku, aby obie strony doszły do porozumienia, albowiem mimo różnic dążymy do tego samego celu, bezpiecznej i silnej Polski jako lider regionu, kraju gdzie ludzie nie będą się bać żyć i rozwijać. Polska powinna jasno postawić na Europę i silną w niej pozycję, zaś młodzi muszą ufać Europie. UE by przetrwać jako znaczący byt musi pójść w stronę federalizacji, tworząc nowy blok pomiędzy Chinami a USA, zdolny stanąć na równej pozycji w nowym koncercie mocarstw. Integracja pozwoli na rozwój Polski, da jej lepszą nogę w polityce międzynarodowej. Lecz wraz z integracją w UE, powinniśmy budować partnerstwo w regionie, gdzie stanowimy siłę. Dobrym przykładem tego była inicjatywa Trójmorza. Jeśli oba procesy zachodziłyby równocześnie, to Polska idąca na czele bloku środkowoeuropejskiego miałaby dużą siłę perswazyjną na kontynencie. Zarazem nie możemy zapomnieć o naszych sojusznikach gotowych nam pomóc, nasz kraj jest wierny swym sojuszom, zaś one powinny być nam.\n\nAntropogeniczne zmiany klimatu to egzystencjalne zagrożenie dla ludzi w XXI w. Polska zaś stoi z tyłu za innymi krajami Europy, zaś znaczna część sceny politycznej walczy przeciwko transformacji energetycznej. Jest to absurdalne rozwiązanie idące w sprzeczności z interesem społeczeństwa, w tym i nas młodych. Niskoemisyjne źródła energii są tańsze i wydajniejsze od źródeł (ceny OZE zamykają się, bez podatku węglowego, 200zł, zaś najtańszy węgiel brunatny to już 225zł/MWh według MKiŚ). Polska ma unikalną okazję by jako kraj z rozwiniętym sektorem rolniczym móc zbudować silny sektor biogazowni; które mogą wykorzystywać elementy pozostałe po produkcji żywieniowej. Odpadki i tak będą istnieć, zaś energetyczne zutylizowanie ich w formie biogazu, zarazem pomagające przemysłowi nawozowemu to rozwiązanie dobre dla każdego. Polska zarazem posiada nienajgorszą lokalizację do rozwoju energetyki wiatrowej i słonecznej, choć w przypadkach niepogody muszą być one uzupełniane przez inne źródła. Transformacja energetyczna to jednak nie tylko ekonomika, lecz również bezpieczeństwo. Po pierwsze stawiając na OZE uniezależniamy się od importu amerykańskiego gazu, rosyjskiego węgla, czy kazachskiego uranu. OZE też jest bardziej zdecentralizowane, przez co trudniej jest je zaatakować i poważnie zaszkodzić energetyce kraju(patrz: ostatnie problemy na Ukrainie). Drugie to długoterminowe zagrożenie jakim jest załamanie się ziemskiego klimatu przez człowieka. Akcje podjęte dzisiaj będą wielokroć płacić dywidendę dla nas i naszych dzieci. (z większym limitem napisałbym więcej)	
2259	4	2026-06-16 16:23:37.765588	90	Jestem wolontariuszką w Fundacji „To My Dziewczyny”, w której realizowane są programy mentoringowe dla uczniów, a także warsztaty i programy stypendialne. Jestem członkinią Polish Youth Association i planuję aplikować na wolontariat. Działam również w zespole organizacyjnym naukowej konferencji STEM. Brałam udział w posiedzeniu podkomisji w Sejmie RP, dwukrotnie wystąpiłam w programie „Bez kitu” na TVN24 oraz uczestniczyłam w wydarzeniu Ministerstwa Nauki i Szkolnictwa Wyższego realizowanym w ramach programów Ministra. Ukończyłam również kursy zakończone certyfikatami, m.in.: Master Financial Fundamentals (Harvard Business Review), European Business Law: Understanding the Fundamentals (Lund University), Global Diplomacy: Diplomacy in the Modern World (University of London), AI w biznesie i codziennym życiu (Microsoft), Zarządzanie innowacjami (Politechnika Krakowska im.Tadeusza Kościuszki) oraz Wprowadzenie do AI: Kompleksowy przewodnik po sztucznej inteligencji (Microsoft). Brałam także udział w warsztatach z zakresu komercyjnego due diligence prowadzonych przez Deloitte, przedsiębiorczości, transformacji kariery oraz budowania własnego biznesu w oparciu o doświadczenia liderów e-commerce organizowanych przez When U Buy, a także warsztatach z doradztwa strategicznego i consultingu prowadzonych przez BCG. Dodatkowo uczestniczyłam w konferencjach takich jak Girls Future Ready Summit, Our Future Forum oraz BeSecure (Code Me). W przyszłości planuję podjąć studia stacjonarne na kierunku prawo oraz studia niestacjonarne (zaoczne) na kierunku politologia. 	Polityka zagraniczna III Rzeczypospolitej Polskiej - strategia na czasy niepokoju z perspektywy młodych., Media społecznościowe i sztuczna inteligencja - nowe wyzwania ery cyfrowej.		W obliczu złożoności wyzwań stojących przed Rzeczpospolitą, konieczne jest sformułowanie spójnej strategii, która jednocześnie zabezpieczy nasze interesy na arenie międzynarodowej i zatrzyma negatywne procesy demograficzne oraz regionalne w kraju. Moje poglądy koncentrują się na synergii między wzmocnieniem pozycji międzynarodowej a budowaniem spójności wewnętrznej poprzez rozwiązania strukturalne.\n\nW kontekście Polityki Zagranicznej III RP, w czasach niestabilności i polaryzacji, polska dyplomacja musi wykroczyć poza tradycyjne schematy. Postuluję cyfrową modernizację sojuszy. Kluczowe jest ustanowienie i aktywne promowanie w ramach NATO oraz UE inicjatywy mającej na celu standaryzację protokołów cyberobrony i odporności infrastruktury krytycznej. Wymaga to utworzenia Centrum Wymiany Kompetencji Cyfrowych z Państwami Bałtyckimi, gdzie eksperci poniżej 35. roku życia będą koordynować wspólne symulacje i wymianę danych dotyczących zagrożeń hybrydowych. Ponadto, polska strategia zagraniczna musi kłaść nacisk na budowanie sojuszy technologicznych, promując nasze innowacje na rynkach międzynarodowych, zwłaszcza w obszarze bezpiecznych rozwiązań dla e-administracji. Z perspektywy młodych, kluczowe jest też zwiększenie funduszy na wymiany studenckie i naukowe w krajach strategicznie istotnych dla naszej stabilności regionalnej.\n\nRównocześnie, media społecznościowe i sztuczna inteligencja stanowią nowe wyzwania dla demokracji i bezpieczeństwa informacyjnego. Wyzwanie polega na kontrolowaniu wpływu nieprzejrzystych algorytmów na procesy demokratyczne. Postuluję powołanie Nadzoru nad Algorytmami Dyskursu Publicznego, organu wyposażonego w kompetencje techniczne do audytowania platform cyfrowych pod kątem systemowego promowania treści polaryzujących lub dezinformujących, bazujących na AI. Aby skutecznie przeciwdziałać manipulacji, niezbędne jest wprowadzenie Obowiązkowego Modułu Krytycznego Myślenia Cyfrowego do programu nauczania na wszystkich poziomach edukacji, wyposażającego obywateli w narzędzia weryfikacji źródeł i rozpoznawania treści generowanych przez AI. W wymiarze legislacyjnym, konieczne jest stworzenie ram etycznych dla rozwoju AI, wspierających polskie firmy w budowaniu narzędzi, które wzmacniają dialog społeczny i przejrzystość, jednocześnie chroniąc suwerenność informacyjną państwa przed obcymi ingerencjami. Te dwa obszary zabezpieczenie międzynarodowe poprzez technologię i ochrona demokracji przed dezinformacją cyfrową stanowią spójny fundament dla wizji Polski w 2026	
2260	5	2026-06-16 16:23:37.765588	198	Jestem aktywną i zaangażowaną w życie publiczne osobą. Przez 2 lata pełniłem funkcje Przewodniczącego Młodzieżowej Rady Miejskiej w Stalowej Woli, z sukcesami współpracując z władzami miasta, oraz prowadząc radę do inicjacji rozmów o budowie Centrum Sportów Młodzieżowych, jednego z najnowocześniejszych obiektów tego typu w Europie, którego budowa trwa. Również jako przewodniczący mogę poszczycić się tym, że wraz z radą doprowadziliśmy do wprowadzenia darmowej komunikacji miejskiej na terenie miasta Stalowej Woli. Od ponad 2 lat działam też jako dziennikarz sportowy, obecnie będąc wice-redaktorem naczelnym w rozwijającej się redakcji SektorZ. Na swoim koncie mam relacje radiowe na żywo z wielu ważnych meczów piłki nożnej, w tym finał Pucharu Polski skomentowany wprost że Stadionu Narodowego w Warszawie, obok takich nazwisk jak Mateusz Borek czy Grzegorz Mielcarski. Studiuje również prawo na Uniwersytecie Rzeszowskim. 	Polityka zagraniczna III Rzeczypospolitej Polskiej - strategia na czasy niepokoju z perspektywy młodych., Media społecznościowe i sztuczna inteligencja - nowe wyzwania ery cyfrowej.		Skuteczna polityka zagraniczna nie polega wyłącznie na wyborze jednego czy drugiego sojusznika. W obecnych czasach, powinniśmy pokazać światu, że można, a wręcz trzeba łączyć wszystkie pożyteczne dla nas opcje. Stany Zjednoczone, które są militarną potęgą, powinny postrzegać nas jako sojusznika pierwszej kategorii. Będąc państwem które wyznacza granice Paktu Północnoatlantyckiego, powinniśmy starać się o to, aby USA utworzyło na naszym terytorium swoją stałą bazę wojskową, a także aby żołnierze USA przebywali w naszych granicach. Nie możemy zapominać też o państwach Unii Europejskiej, które są geograficznie naszymi najbliższym partnerami militarnymi i gospodarczymi. Polska powinna dawać przykład państwom UE, jak należy rozwijać armię, i jak należy dbać o bezpieczeństwo z rozwojem gospodarczym, nie spychając żadnej z tych dziedzin na boczny tor. Z drugiej jednak strony, historia pokazuje nam, że nie możemy wyłącznie polegać na umowach międzynarodowych. Musimy sami zadbać o własne bezpieczeństwo, stawiając na naszych polskich przedsiębiorców w branży militarnej, np. Huta Stalowa Wola, której flagowy produkt, armatohaubica "Krab", sprawdzona w bojach w wojnie ukraińsko-rosyjskiej, ukazuje, że polskie firmy potrafią tworzyć skuteczną broń. Im silniejsze wojsko, tym większa szansa na to, że potencjalny wróg będzie bał się najechać nasz kraj. Tak samo, powinniśmy zadbać o to, żeby nasze społeczeństwo wiedziało, jak zachować się w sytuacji kryzysu. Powinien zostać wdrożony plan szkoleń z obsługi broni, oraz reakcji na ogłoszenie alarmu i ewakuacji. Nie oznacza to, że powinna powrócić obowiązkowa służba wojskowa, gdyż realnie patrząc, obywatele którzy by podlegali obowiązkowi służby, a nie chcieli by do niej trafić, robiliby wszystko, aby jej uniknąć. Zatem umowy międzynarodowe powinny stanowić jedynie dodatek i dopełnienie naszych własnych umiejętności obronnych.\n\nKwestia mediów społecznościowych i sztucznej inteligencji staje się ważna, w dobie tak daleko postępującego rozwoju technologicznego. Trzeba do tego podejść rozsądnie, i szukać złotego środka. Zamiast zakazywać korzystania z mediów społecznościowych młodzieży, lepiej jest ją edukować od najmłodszych lat o zagrożeniach w sieci. Tak samo jeśli chodzi o sztuczną inteligencję. Lepiej edukujmy, i pokazujmy że poza możliwościami jakie niesie AI, jest ono pełne zagrożeń, i wskazujmy, jak tych zagrożeń unikać. Osiągniemy dzięki temu lepsze efekty, niż nakładając sztywne zakazy, które i tak będą obchodzone przez ludzi. Dlatego należy wprowadzić obowiązkowe szkolenia i kursy dotyczące mediów społecznościowych i AI w szkołach oraz zakładach pracy, nawet tych, które nie są z tym związane. Program tych szkoleń i kursów, byłby ciągle rozwijany, tak, aby brać pod uwagę najnowsze zmiany na rynku technologicznym. Jeśli zaszczepimy w społeczeństwie świadomość o cyber bezpieczeństwie, wypracujemy u nich potrzebę weryfikacji danych lub informacji zamieszczanych w intrenecie, takich jak deepfake lub fake news. Dzięki temu społeczeństwo będzie rozsądniej i świadomiej korzystać z dostępnych technologii.  	
2263	5	2026-06-16 16:23:37.765588	502	Mam 20 lat i jestem studentem kierunku Finanse i Biznes Międzynarodowy na Uniwersytecie Łódzkim. Pochodzę z Piotrkowa Trybunalskiego, gdzie odbyłem poprzednie etapy edukacji. Jestem osobą pełną chęci do działania. Mając 16 lat zachorowałem na nowotwór złośliwy w najwyższym stadium. Otrzymałem wtedy ogromne wsparcie od rodziny, znajomych, a także całej społeczności szkoły. Dzisiaj, kiedy leczenie jest już za mną zajmuję się działalnością społeczną, staram się nieść pomoc tym, którzy jej potrzebują - tak jak ja dostałem ją w swoich najgorszych chwilach. Wracam często na oddział onkologiczny, rozdając tam paczki dla pacjentów czy przekazując darowizny na rzecz fundacji. Jestem członkiem Studenckiego Koła Naukowego Inwestor funkcjonującego przy Wydziale Ekonomiczno-Socjologicznym Uniwersytetu Łódzkiego. Aktywnie działamy na rzecz społeczności studentów zarówno z Łodzi jak i z całej Polski. Część naszych projektów jest także charytatywna, gdzie zbieramy środki na lokalne schroniska, bądź też dla WOŚP przy projekcie Zbudujmy Razem Serce. Jestem także częścią Stowarzyszenia Viviena - niesiemy pomoc, propagujemy naukę i wyrównujemy szanse. Bagaż doświadczeń w połączeniu z wiedzą akademicką, pozwalają mi szkolić osoby w każdej sytuacji. Możliwość wstąpienia do Parlamentu Młodych byłaby kamieniem milowym - szansą na pomoc obywatelom na jeszcze szerszą skalę. 	Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?, Media społecznościowe i sztuczna inteligencja - nowe wyzwania ery cyfrowej.		Kryzys demograficzny i wyludnianie mniejszych ośrodków\n\nWyludnianie się mniejszych ośrodków to w dużej mierze skutek wykluczenia komunikacyjnego. Są miejscowości w Polsce, w których publiczny transport nie istnieje bądź ogranicza się do dwóch kursów dziennie. Przez lata państwo inwestowało w budowę kluczowych dróg i autostrad. Nadszedł czas, żeby do wydatków infrastrukturalnych włączyć budowę kolei na dużą skalę oraz rozbudować lokalne linie autobusowe - bez mobilności nie zatrzymamy ludzi w regionach.\nKryzys demograficzny pogłębia się pomimo zwiększania wydatków socjalnych. Program 500+, choć ograniczył skrajne ubóstwo, nie zdołał trwale zwiększyć liczby urodzeń.  Według danych GUS-u (2024r.) na jedną kobietę w Polsce przypada około 1,1 dziecka, gdzie potrzeba około 2,1 dzieci, żeby mówić o zastępowalności pokoleń. Jeśli sytuacja nie ulegnie zmianie zawali się polski system wypłaty emerytur - ZUS szacuje, że w roku 2050 przeciętna emerytura spadnie poniżej 30% w stosunku do przeciętnego wynagrodzenia. Młodzi Polacy rezygnują z rodzicielstwa, głównie przez stan służby zdrowia, rosnące koszty życia oraz brak zaufania do Państwa po zawirowaniach politcznych w roku 2020. Musimy zmienić strategię. Popularność programu In-Vitro pokazuje, jak duże jest na nie zapotrzebowanie. Należy zwiększyć wydatki na ten program oraz przebudować program 800+ tak, żeby premiował rodziny wielodzietne. Budowa tanich mieszkań na wynajem zamiast wyprzedaży majątku miejskiego. Konieczne jest także wsparcie rodzin nie poprzez transfery pieniężne a jako zdrowie reprodukcyjne, opieka, wykształcenie czy stabilny rynek mieszkaniowy. \n\nMedia społecznościowe i sztuczna inteligencja\n\nW 2026 roku stajemy przed bezprecedensowym wyzwaniem. Technologia, a w szczególności sztuczna inteligencja rozwija się w tempie, za którym nie nadążają regulacje prawne. AI wkroczyło i zadomowiło się w mediach społecznościowych, generując nie tylko muzykę czy obrazy, ale całe fałszywe profile. Stanowi to realne zagrożenie dla bezpieczeństwa, także tych najmłodszych. \nWedług raportu “Internet dzieci” 1,4 miliona dzieci w wieku 7-12 lat aktywnie korzysta z aplikacji i portali przeznaczonych dla osób starszych. Brak skutecznych regulacji na szczeblu zarówno krajowym jak i międzynarodowym to ogromne ryzyko. Australia jako pierwszy demokratyczny kraj wprowadziła restrykcyjne prawo dotyczące mediów społecznościowych dla dzieci. Uważam, że powinniśmy iść tym tropem, traktując prawo w Australii jako punkt wyjścia do stworzenia skuteczniejszego systemu. Przeciwnicy regulacji zrzucają odpowiedzialność na rodziców, jednak dane pokazują, że jest to nieskuteczne. W takiej sytuacji państwo musi interweniować. \nAlternatywą i koniecznym uzupełnieniem zakazu muszą być szeroko zakrojone kampanie edukacyjne, zarówno rządowe jak prowadzone przez NGO, uświadamiające rodzicom i dzieciom realne zagrożenia cyfrowe. Narzędzia AI stają się nie tylko idealnymi do siania dezinformacji - jest to jednocześnie wejście na wyższy poziom cyberbullyingu. Należy ograniczyć zakres poleceń jakie mogą wykonać publicznie dostępne programy oraz karać firmy, które nie chcą dostosować swoich technologii do tych ograniczeń.   	
2264	6	2026-06-16 16:23:37.765588	624	Jestem aktywnym działaczem szachowym oraz społecznym z Leszna. Od kilku lat angażuję się w rozwój lokalnej społeczności szachowej, organizując turnieje, warsztaty i zajęcia dla dzieci oraz młodzieży, co pozwala popularyzować szachy jako formę edukacji i rozwijania umiejętności strategicznego myślenia. Uczę również szachów w przedszkolach, szkołach podstawowych, wspierając młode pokolenie w rozwijaniu koncentracji, logicznego myślenia i kreatywności. Mam doświadczenie w organizowaniu turniejów ogólnopolskich, na które przyjeżdżali zawodnicy z całej Polski – wydarzenia te gromadziły ponad 100 osób. Współpracuję z Międzyszkolnym Młodzieżowym Klubem Sportowym „Wieniawa” w Lesznie, gdzie pełnię funkcję koordynatora turniejów i inicjatyw dla młodych szachistów.\n\nRównolegle działam w Młodzieżowej Radzie Miasta Leszna jako sekretarz, gdzie aktywnie uczestniczę w projektach skierowanych do młodzieży i mieszkańców miasta, wspierając inicjatywy edukacyjne, kulturalne i sportowe. Moja działalność społeczna obejmuje zarówno organizację wydarzeń lokalnych, jak i współpracę z instytucjami samorządowymi w celu promowania aktywności obywatelskiej i integracji społecznej.\n\nŁącząc pasję do szachów z zaangażowaniem społecznym, staram się tworzyć przestrzeń, w której młodzi ludzie mogą rozwijać swoje talenty, uczyć się współpracy i odpowiedzialności, a także aktywnie uczestniczyć w życiu swojej społeczności.	Polityka zagraniczna III Rzeczypospolitej Polskiej - strategia na czasy niepokoju z perspektywy młodych., Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?		Z perspektywy młodego obywatela Polska stoi w XXI wieku przed wieloma wyzwaniami w sferze polityki zagranicznej. Czasy niepokoju, związane z niestabilnością globalną, kryzysami energetycznymi czy konfliktami regionalnymi, wymagają przemyślanej strategii, która łączy bezpieczeństwo państwa z aktywnym uczestnictwem w strukturach międzynarodowych. Dla młodych ludzi kluczowe jest, aby polityka zagraniczna nie ograniczała się do deklaracji i dyplomacji wysokiego szczebla, ale w praktyce wpływała na bezpieczeństwo, mobilność, edukację i możliwości rozwoju zawodowego młodzieży.\n\nW mojej opinii Polska powinna konsekwentnie wzmacniać swoje członkostwo w NATO i Unii Europejskiej, rozwijać współpracę regionalną w ramach Grupy Wyszehradzkiej, ale też aktywnie wspierać inicjatywy młodzieżowe i edukacyjne w wymiarze międzynarodowym. Ważnym elementem jest promowanie kultury dialogu, współpracy naukowej oraz wymiany młodzieży – takie działania budują świadomość globalną i odporność społeczną. Z perspektywy młodych warto też inwestować w edukację w zakresie bezpieczeństwa cyfrowego, mediów i krytycznego myślenia, ponieważ w dobie dezinformacji i zagrożeń cybernetycznych młodzi obywatele są kluczowym filarem stabilności kraju.\n\nMoim zdaniem strategia na czasy niepokoju powinna być oparta na trzech filarach: bezpieczeństwie narodowym, aktywnej dyplomacji i edukacji młodzieży. Polska powinna stawiać na współpracę wielostronną, rozwój własnego potencjału obronnego i energetycznego oraz budowanie świadomości obywatelskiej wśród młodych ludzi, aby czuli się nie tylko uczestnikami, ale i współtwórcami bezpieczeństwa państwa.\n\nPolska zmaga się z wyraźnym kryzysem demograficznym, a mniejsze miasta i wsie wyludniają się, gdy młode rodziny wyjeżdżają w poszukiwaniu pracy, edukacji i lepszych perspektyw. Polityka rodzinna powinna łączyć wsparcie finansowe z dostępem do przedszkoli, żłobków oraz atrakcyjnych form edukacji pozaszkolnej, które umożliwią rodzicom aktywność zawodową i rozwój dzieci w ich lokalnych społecznościach.\n\nRównie istotne jest wspieranie lokalnej gospodarki i tworzenie miejsc pracy, które zatrzymają młodych ludzi w mniejszych ośrodkach. Dobrze zaplanowane inwestycje w infrastrukturę – w tym transport publiczny, mieszkania komunalne, przestrzenie rekreacyjne i kulturalne – mogą zwiększyć atrakcyjność życia w takich miastach i wsi. Warto również rozwijać lokalne inicjatywy społeczne i edukacyjne, które wzmacniają więzi między mieszkańcami i integrują społeczność.\n\nHolistyczne podejście, łączące wsparcie finansowe, rozwój infrastruktury i aktywność społeczną, pozwoli zatrzymać młodych ludzi w swoich społecznościach, przeciwdziałać wyludnianiu mniejszych ośrodków oraz budować stabilne i przyjazne środowisko do życia dla całych rodzin.	
2265	4	2026-06-16 16:23:37.765588	678	 Jestem studentem zarządzania w sztuce na Akademii Sztuk Pięknych we Wrocławiu, a we wcześniejszych latach uczęszczałem do LXXV im. Jana III Sobieskiego w Warszawie. Na studiach jak i we wcześniejszych latach angażowałem się w samorządy uczniowskie, a aktualnie jestem reprezentantem studentów w komisji do spraw jakości kształcenia. Udzielam się również w zarządzie koła naukowego, a prywatnie regularnie biorę udział w wolontariatach. Aktywnie śledzę polską i światową scenę polityczną, a każdą kwestie dogłębnie analizuję i wyrabiam swoje niezależne zdanie. Gdy moi faworyci polityczni się mylą nie jestem na to ślepy, a gdy trzeba biorę udział w manifestacjach. Od zawsze angażuję się w każdą inicjatywę, która umożliwia mi poszerzanie moich horyzontów oraz kompetencji. Często łączę to z moją pasją jaką są podróże dla tego już w liceum brałem udział w programie Erasmus+ do Hiszpani, a najbliższe lato spędzę na wymianie w USA. Historia nie tylko pomaga mi w rozumieniu mechanizmów zachodzących w polityce, ale jest również moją pasją, szczególnie historia polski oraz mojej rodziny, którą badam od wielu lat. Kolejnym niezwykle ważnym aspektem mojego życia jest sport. Z drużyną pływacką reprezentuję swoją uczelnię na Akademickich Zawodach Sportowych, a wolne chwile spędzam z plecakiem w górach. Jak widać we wszystkie obszary swoich zainteresowań jestem w stanie zaangażować się w stu procentach. Bez wątpienia gdybym tylko dostał taką możliwość Parlament Młodych Rzeczpospolitej Polskiej byłby dla mnie niezwykłą okazją do wykazania siebie, zabrania głosu oraz realnego działania w kwestiach tego wymagających. 	Polityka zagraniczna III Rzeczypospolitej Polskiej - strategia na czasy niepokoju z perspektywy młodych., Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?		Polityka zagraniczna \nW obliczu globalnego kryzysu Polska powinna dążyć do jedności nie tylko z Europą, ale i państwami wyznającymi te same wartości, jak Kanada czy Australia. Obecnie formują się nowe ośrodki sojusznicze, a Unia Europejska naturalnie staje się jednym z kluczowych partnerów. Obawiam się jednak, że kwestia wspólnej obronności pozostaje na razie w sferze deklaracji. Powinna ona zostać uregulowana konkretnymi umowami, łączącymi państwa europejskie z ośrodkami kultury zachodniej, które wyewoluowały w światowe potęgi dzięki dziedzictwu Starego Kontynentu. Mówiąc o europejskiej dominacji, nie sposób pominąć USA. Trudno uwierzyć, że państwo stworzone na peryferiach zdominowało niegdyś tak doskonałe cywilizacje. Jestem pewien, że tylko wygaszenie wewnętrznych konfliktów i zjednoczenie Europy w światową potęgę zapewni Polsce bezpieczeństwo oraz przywróci kontynentowi dawny podziw świata. Kluczowa jest tu zgoda wewnętrzna. Politycy wszystkich opcji zbyt często szukają wrogów w strategicznych sąsiadach i partnerach, czy to za Odrą, czy za Niemenem, zapominając, że agresywna retoryka może zemścić się w godzinie próby. Uważam, że filarem bezpieczeństwa powinna być neutralność i izolacja od kwestii szkodliwych, choć musimy się jednoczyć, konflikty państw NATO, które czerpią zyski z globalnych niepokojów, nie powinny nas angażować bardziej niż wymagane przez Art. 5 minimum. Przykładem mogą być państwa skandynawskie, które unikają niepotrzebnego opowiadania się po stronach. Model ten mógłby z powodzeniem funkcjonować w skali ogólnoeuropejskiej.\nKryzys demograficzny\nAnalizując demografię Polski, widzę błędne założenie, że bezpieczeństwo rodziny można po prostu kupić. Jako student zarządzania dostrzegam, że programy oparte na bezpośrednich transferach gotówki są krótkowzroczne. Pieniądze rozproszone w domowych budżetach rzadko służą optymalnej strategii państwa. Fundamentem nowoczesnej polityki nie powinno być rozdawnictwo, lecz budowa infrastruktury usług publicznych, która realnie odciąży rodziców. Zamiast świadczeń pieniężnych, państwo powinno zagwarantować bezpłatną, powszechną opiekę. Rozbudowa sieci żłobków i przedszkoli, zwłaszcza w wyludniających się mniejszych ośrodkach, byłaby inwestycją w kapitał ludzki. Równie ważne jest pełne finansowanie posiłków w szkołach i zajęć dodatkowych, co wyrównałoby szanse dzieci z różnych warstw społecznych. Kluczowe są także darmowy transport publiczny dla uczących się oraz priorytetowy dostęp do opieki pediatrycznej i psychologicznej. Wdrożenie takiego programu rozwiązałoby problem ucieczki do metropolii. Jeśli młody człowiek w rodzinnej miejscowości napotyka bariery komunikacyjne i brak miejsc w żłobkach, naturalnie wybiera duże miasto. Musimy przestać traktować politykę rodzinną jako koszt, a zacząć widzieć w niej inwestycję w tkankę narodową. Moje badania nad historią rodziny potwierdzają, że przetrwanie wspólnoty zależy od stabilnych fundamentów, a nie doraźnych zapomóg. Tylko przejście od państwa płacącego do wspierającego jakością usług zatrzyma katastrofę demograficzną. Musimy stworzyć system, w którym dziecko jest naturalnym etapem życia, a nie wyzwaniem logistycznym.	
2266	5	2026-06-16 16:23:37.765588	761	Hej, jestem uczniem Technikum Elektroniczno-Informatycznego w Sosnowcu na kierunku programista. Od zawsze interesowałem się technologią oraz naturą. Uwielbiam majstrować przy sprzęcie i pisać kod, często z różnymi efektami :). Zainteresowanie naturą wzięło się z faktu mieszkania na wsi oraz z tego, że moi rodzice są rolnikami i prowadzimy gospodarstwo rolne. To mama zaszczepiła we mnie ideę zdrowego odżywiania oraz ekologii.\n\nPierwsze zderzenie z polityką miałem około 2019 roku, kiedy w mojej okolicy planowano otworzyć kopalnię cynku i ołowiu. Opór mieszkańców przyczynił się do tego, że kopalnia nie została otwarta ze względu na ochronę natury oraz zdrowia. Wtedy zobaczyłem, że realna zmiana jest możliwa. Już w podstawówce na WOS-ie rozmawiałem z kolegami o tym, co można zmienić w Polsce, i brałem udział w konsultacjach Strategii RP na rzecz młodego pokolenia. W tym okresie byłem centrystą, chociaż patrząc z perspektywy czasu, już wtedy stopniowo skręcałem w lewo.\n\nAktualnie określiłbym się jako centro-lewicowiec, choć można by mnie po prostu nazwać lewicowym. Nie jestem konserwatystą, jednak potrafię zrozumieć takie poglądy. W niektórych kwestiach mam bardziej prawicowe stanowisko. Przykładem może być liberalizacja dostępu do broni. Obecnie jestem członkiem Partii Razem; moja decyzja była związana z  wyborami prezydenckimi, w których po raz pierwszy mogłem głosować. Nie byłem zwolennikiem obecnej koalicji, dlatego mój głos oddałem na Adriana Zandberga. Już podczas kampanii rozwieszałem jego plakaty w mojej rodzinnej miejscowości, nie będąc jeszcze członkiem partii.\n\nChciałbym spróbować swoich sił jako młodzieżowy poseł, aby sprawdzić, czy się do tego nadaję i czy mogę wiązać z tym swoją przyszłość.	Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?, Energetyka XXI wieku. Jak powinna wyglądać transformacja energetyczna "po polsku" ?		Kryzys demograficzny w Polsce jest faktem. W małych miastach i wsiach żyje coraz mniej młodych ludzi. Wielu z nich wyjeżdża, bo w innych miejscach mogą znaleźć pracę, studiować lub łatwiej korzystać z różnych usług.\nGdy myślimy o tym, żeby w Polsce rodziło się więcej dzieci, młodzi potrzebują przede wszystkim poczucia, że ich życie jest bezpieczne. Jeśli ktoś nie ma stałej pracy czy własnego mieszkania, trudno mu podjąć ważną decyzję o dziecku.\nRozwój budownictwa społecznego i dostępnych mieszkań, także w mniejszych gminach, powinien stać się priorytetem. Równolegle trzeba ograniczyć nadużywanie umów cywilnoprawnych (tzw. „śmieciówek”), wzmacniać przewidywalne formy zatrudnienia.\nDrugim powodem są usługi publiczne. Bez żłobka, dobrej szkoły i lekarza w rozsądnej odległości nic nie zatrzyma młodych poza metropoliami. Państwo musi silniej wspierać małe samorządy w utrzymaniu tych usług oraz ułatwiać łączenie pracy z rodzicielstwem, np. poprzez wsparcie w pierwszych latach życia dziecka.\nWyludnianie to także kwestia perspektyw pracy. W wielu powiatach znikają nie tylko miejsca pracy, ale całe branże. Wielu młodych wyjeżdża z małych miejscowości i już nie wraca, bo zbyt mało jest tu dla nich dobrych miejsc pracy. Małe firmy często się zamykają, a szkoły zawodowe nie uczą tego, czego potrzeba na rynku.\nMożna to zmienić, jeśli da się firmom zniżki podatkowe, gdy tworzą nowe miejsca pracy w małych miastach, jeżeli utrzymają te miejsca przez dłuższy czas. Dobrym pomysłem jest też lepszy kontakt między szkołami a lokalnymi firmami co pomoże uczniom zdobyć konkretne umiejętności i mieć pewność, że znajdą staż czy pracę blisko domu.\nWażne też, żeby poprawić transport publiczny. Potrzebne są częste i pewne połączenia kolejowe czy autobusowe, by ludzie mogli dojeżdżać do pracy, nie musząc się przeprowadzać.\n\nTransformacja energetyczna musi zapewniać bezpieczeństwo energetyczne, niższe koszty i czystsze powietrze. Polska opiera ok. 60% produkcji energii na węglu, który jest nie tylko wysokoemisyjny, ale też coraz droższy, koszty uprawnień do emisji CO2 oraz głębokość złóż znacząco podnoszą ceny prądu. W 2022 roku spalanie paliw kopalnych, przede wszystkim węgla, odpowiadało za blisko 78% całkowitych emisji gazów cieplarnianych w Polsce, czyniąc węgiel największym źródłem emisji oraz czynnikiem degradacji środowiska.. Węgiel jest dziś „złem przejściowym”, potrzebnym dla stabilności systemu, ale nie jako docelowe rozwiązanie.\nKluczowe jest zmodernizowanie przestarzałej sieci energetycznej. Bez inwestycji w magazyny energii, cyfryzację i linie przesyłowe nie wykorzystamy potencjału OZE. Odnawialne źródła, głównie fotowoltaika i wiatr, powinny być rozwijane, bo są dziś jednymi z najtańszych źródeł energii w UE (wg IRENA).\nJednocześnie potrzebujemy stabilnego źródła mocy. Tę rolę powinien pełnić atom. Elektrownie jądrowe zapewniają niskoemisyjną, przewidywalną energię przez dekady i zmniejszają zależność od importu surowców. Gaz może pełnić rolę przejściową, ale nie docelową.\nPodsumowywując, powinniśmy modernizować sieci, rozwijać OZE, budować energetykę jądrową, odejść od węgla. Jest to gwarancja ekologicznej, taniej i stabilnej energetyki.	
2267	6	2026-06-16 16:23:37.765588	767	Działalność w Partii Razem i niedługo w Stowarzyszeniu Młodzi Razem, zacząłem na początku roku 2025 w trakcie Kampanii Prezydenckiej Adriana Zandberga. Długo na swoje pierwsze wydarzenie polityczne, nie musiałem czekać zbyt długo, ponieważ niedługo po moim przyjęciu do Partii i Stowarzyszenia, pomagałem przy Wizycie Adriana Zandberga w Łodzi. Pomaganie przy działaniach politycznych wzbudziło we mnie zainteresowanie Social Mediami, którymi pragnę i próbuje się zajmować w wolnym czasie, przez prowadzenie Konta Social Media Młodych Razem Łódzkie od początku Grudnia 2025, kiedy dołączyłem do Zarządu Okręgu Młodzieżówki. Poza pomocą w działaniu okręgu Łódzkiego Partii Razem i Stowarzyszenia Młodzi Razem, uczestniczę również w LARPach Warhammer Fantasy, należąc do dawnego Korpusu Zbrojnego Gostahoff, obecnie Gostahoff Beste. Prywatnie interesuje się Historią Starożytności, szczególnie Epoki Brązu na Bliskim Wschodzie, różnymi Wyznaniami i cywilizacjami Mezoamerykańskimi. Obecnie uczęszczam do Klasy 5 Technikum na kierunku Technik Informatyk, jednakże po zakończeniu Edukacji Średniej planuje udać się na Studia, na kierunek Stosunków Międzynarodowych, planując optymistycznie pracę jako Dyplomata. Z ciekawostek o sobie na koniec, jestem wstanie powiedzieć że latach 2013-2014 mieszkałem w Niemczech, czego wspomnienia nieco skłaniają do chęci pracy z ludźmi innych kultur i narodowości, oraz stwierdzić iż moimi ulubionymi serialami są "Battlestar Galactica" oraz "Stargate SG-1".  	Polityka zagraniczna III Rzeczypospolitej Polskiej - strategia na czasy niepokoju z perspektywy młodych., Media społecznościowe i sztuczna inteligencja - nowe wyzwania ery cyfrowej.		Temat 1 \n   Współczesne stosunki międzynarodowe w czasach po-covidowych można porównać do powojennego Politycznego Realizmu według myśli H. Morgenthau. Polska, jako państwo graniczne cywilizacji zachodniej, znajduje się na geopolitycznym rozdrożu, gdzie obranie złej ścieżki, będzie mogło mieć poważne konsekwencje dla stabilności i bezpieczeństwa regionu Europy Wschodniej. Od początku roku 2025, w polityce zagranicznej USA można dostrzec tendencje zbliżone do założeń tzw. "Doktryny Wolfowitza", która nawołuje za utrzymaniem statusu USA jako jedynego supermocarstwa. Polityka ta, jak i program nałożenia ceł, doprowadził do ochłodzenia się relacji USA z UE, oraz do powstania wcześniej wspomnianego rozdroża, który może być rozumiany jako rozłam wewnątrz struktur NATO, uważanych dotąd za nadzwyczaj stabilne. W najbliższych latach polska polityka zagraniczna powinna dążyć do przyjęcia roli prowadzącej w dyplomacji między cywilizacjami zachodu oraz wschodu, z jednoczesnym dążeniem do zaciśnięcia relacji i współpracy z państwami Europy, w której to Polska powinna aspirować do roli jednego z liderów UE, aby móc kształtować jej przyszłość. Z perspektywy młodego pokolenia kluczowe jest, aby polityka zagraniczna Polski gwarantowała długofalowe bezpieczeństwo, możliwość rozwoju w zjednoczonej Europie oraz utrzymanie silnych sojuszy. To młode pokolenie będzie funkcjonować w świecie kształtowanym przez dzisiejsze decyzje, dlatego Polska powinna aktywnie współtworzyć architekturę bezpieczeństwa i współpracy w regionie.\n\nTemat 2 \n   Wypuszczony na rynek w listopadzie 2022, Model SI ChatGPT od firmy OpenAI zrewolucjonizował to, w jaki sposób społeczeństwo postrzega i wykorzystuje SI. Wszechobecne już w większości sfer życia Media Społecznościowe były i są z kolejnymi latami, oraz w związku z pojawianiem się na rynku nowych modeli SI, zalewane coraz większą ilością sztucznie wygenerowanych zdjęć i filmów. Te na początku, były łatwe do odróżnienia od realnego życia, jednakże z ewolucją modeli SI i dalszym eliminowaniem niedoskonałości w generowanej przez nich treści, ów wygenerowane zdjęcia i filmy są obecnie nie raz nie do odróżnienia od realnego życia. Przykładem realnego wykorzystania tego mechanizmu są działania dezinformacyjne Fed. Rosyjskiej, która od lat prowadzi cyberwojnę w przestrzeni cyfrowej. SI umożliwia dziś tworzenie nagrań i zdjęć pokazujących wydarzenia i polityków wypowiadających słowa, które nigdy nie padły. Tego typu treści mogą być następnie rozpowszechniane w Internecie w celu podważania zaufania do instytucji państwowych, wzmacniania skrajnych postaw społecznych oraz pogłębiania polaryzacji politycznej. Zjawisko to niesie poważne konsekwencje dla funkcjonowania demokracji. W świecie, w którym głównym źródłem informacji dla młodego pokolenia są media społecznościowe, zdolność do odróżnienia prawdy od fikcji staje się kluczową umiejętnością obywatelską. Odpowiedzią na to wyzwanie powinna być nie tylko regulacja platform cyfrowych i obowiązek oznaczania treści generowanych przez SI, oraz rozwój edukacji cyfrowej, tak aby młode pokolenie było świadome o dezinformacji i szerzonej propagandzie w Internecie. \n	
2268	4	2026-06-16 16:23:37.765588	778	Jestem radną Rady Młodzieżowej przy Parlamentarnym Zespole ds. Młodzieży, która jest największym takim organem w Polsce, a jednocześnie inicjatywą prawnie ulokowaną przy polskim Parlamencie. Pełnię funkcję rzeczniczki Komisji Klimatu i Środowiska. Odpowiada to mojemu zainteresowaniu ochroną środowiska i zmianą klimatu. Wiąże się z nim też zeszłoroczny projekt 5 Elements of Science, którego byłam liderką. Składał się on z półrocznego badania naukowego, dotyczącego wpływu zielonych instalacji na jakość powietrza w Warszawie, a następnie szerokiej kampanii społeczno-informacyjnej, obejmującej kontakt z instytucjami publicznymi, występy w mediach takich jak Polskie Radio i warsztaty dla warszawskiej młodzieży. \n\nNa co dzień chodzę do II LO im. Stefana Batorego, na profilu matury międzynarodowej (IB Diplomma). \n\nAktywnie angażuję się w życie społeczności szkolnej - od pierwszej klasy działam w samorządzie uczniowskim, jako przewodnicząca mojej klasy. W zeszłym roku byłam wiceprzewodniczącą jednej z 2 głównych partii w samorządzie - w ramach kampanii opracowałam program wyborczy i nawiązałam wiele współprac z zewnętrznymi organizacjami i placówkami. Pełnię też funkcję wiceredaktorki naczelnej gazetki “Batorak” - kieruję redakcją, składającą się z ponad 50 osób. Co miesiąc zarządzam zbieraniem artykułów, sprawdzaniem merytoryki i składem numeru, a następnie dystrybucją i promocją. W tym roku organizuję konferencję naukową Warsaw Science Slam, zrzeszającą młodzież z całej Polski, zainteresowaną naukami ścisłymi. Prowadzę również szkolną grupę teatralną, reżyserując przedstawienie, które w marcu będzie wystawiane całkowicie za darmo. Uczestniczę też co roku w organizacji licealnego festiwalu muzycznego UFO, będącego największym tego rodzaju wydarzeniem w całej Polsce.	Polityka zagraniczna III Rzeczypospolitej Polskiej - strategia na czasy niepokoju z perspektywy młodych., Energetyka XXI wieku. Jak powinna wyglądać transformacja energetyczna "po polsku" ?		Jako osoba zaangażowana w walkę z zmianą klimatu uważam, że globalnie powinniśmy dążyć do transformacji energetycznej w kierunku źródeł energii, których negatywny wpływ na środowisko jest możliwie jak najmniejszy. Jako Polska powinniśmy się kierować taką motywacją, nie zapominając o aspekcie społeczno-politycznym zmian.\nOZE powinny być wprowadzane do użytku, biorąc pod uwagę ich efektywność w poszczególnych regionach kraju. Pomorze skorzystałoby na budowie morskich farm wiatrowych. Generują więcej energii od lądowych, równocześnie nie wpływając na komfort życia mieszkańców. Tradycyjne, lądowe turbiny wiatrowe mają największy potencjał wykorzystania na północy kraju - w województwach pomorskim, zachodnio-pomorskim i warmińsko-mazurskim. Niż Środkowo-Polski i Basen Podhalański to regiony, których warunki odpowiadają energetyce geotermalnej.\nJestem ogromną zwolenniczką energetyki jądrowej. Jest to czyste, tanie i bezpieczne! źródło. Mimo swojej nieodnawialności, złoża uranu są ogromne, a jego pozyskanie staje się możliwe też z innych źródeł. Przeszkodą jest tylko uprzedzenie społeczne i brak rozumienia, z którymi powinniśmy walczyć kampaniami edukacyjnymi.\nEnergetyka oparta na spalaniu węgla jest nie ekologiczna, ale też nieopłacalna. Wydobycie jest nierentowne ze względu na głębokość i spadek jakości złóż. Infrastruktura jest przestarzała, co prowadzi do niskiej sprawności i wysokich kosztów modernizacji i napraw. Elektrownie funkcjonują tylko dzięki osłonie finansowej państwa, która kosztuje nasz budżet nawet 9 miliardów PLN rocznie. Uważam, że większość z nich powinna być stopniowo wyłączana z regularnego użytku - część, która zostanie, byłaby zabezpieczeniem energetycznym w przypadku kryzysu.\nJako kraj powinniśmy uniezależnić się od rosyjskiej energii - w czasach niepokoju, ta relacja może zostać wykorzystana jako środek wywierania wpływu na polską politykę. Mimo wygaszenia umowy z Gazpromem w 2022, rosyjski gaz ziemny nadal trafia do naszego obiegu przez niemieckie spółki - powinniśmy szukać innych rozwiązań. Rozwinięcie współpracy z Norwegią (Baltic Pipe) i skończenie terminalu LNG w Świnoujściu pozwolą na dywersyfikację źródeł.\n\nPolska powinna dążyć do zacieśnienia współpracy z krajami UE. To nasi najbardziej wiarygodni sojusznicy - jesteśmy już związani geograficznie, politycznie, ekonomicznie i społecznie. Podobnie z krajami NATO, które jest najważniejszym współczesnym sojuszem militarnym Polski.\nPolska powinna wspierać Ukrainę w walce z inwazją rosyjską, nie tylko samodzielnie, ale też na arenie międzynarodowej.\nW świetle nieprzewidywalności politycznej, Polska powinna uniezależniać się od działań USA. Współpraca powinna jak najbardziej być kontynuowana, ale nie stanowić większości potencjału dyplomatycznego i militarnego kraju. Inne kierunki (nawet te niepopierane przez amerykański rząd) powinny być rozwijane, jako alternatywy.\nPolska nigdy nie skupiała się na rozwijaniu relacji z krajami Azji. Myślę, że jest to region o ogromnym potencjale - tak ważny, że pomijanie go w polityce zagranicznej jest ogromnym błędem. Indie, Chiny i Korea Południowa są krajami, które rozwijają się w niesamowitym tempie, otwierając ogromne możliwości.	
2269	5	2026-06-16 16:23:37.765588	819	Pochodzę z Warszawy. Poza polityką interesuję się militariami, klasyczną męską elegancją i żeglarstwem. Moją działalność zacząłem od zostania przewodniczącym samorządu w liceum, w tym okresie zostałem również członkiem stowarzyszenia “Stowarzyszenie Precedens” gdzie pomagałem przy różnych inicjatywach np. Debata Parlamentarna (wrzesień 2023) czy test poglądów politycznych myPolitics (w kontekście wyborów samorządowych w Warszawie). Pod koniec VII kadencji, uzyskałem mandat parlamentarzysty PMRP, wtedy też dołączyłem do partii Nowa Nadzieja oraz jej młodzieżówki Młodzi dla Wolności. Przez ostatni rok aktywnie działałem w strukturach partii, przez pewien okres byłem Sekretarzem Okręgu 19 Młodych dla Wolności. Od marca 2025 roku jestem asystentem posła Przemysława Wiplera, pracuję w jego biurze poselskim oraz fundacji. W listopadzie 2025 roku dostałem się na staż w biurze europosła Marcina Sypniewskiego w Brukseli. 	Polityka zagraniczna III Rzeczypospolitej Polskiej - strategia na czasy niepokoju z perspektywy młodych., Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?		Polityka zagraniczna i wewnętrzna to kwestie połączone, decydujące o być albo nie być państwa. W obecnych czasach, które niestety można nazwać przedwojennymi, nasze położenie w strukturach takich jak UE czy NATO jest kluczowe, jednak podstawą naszej strategii musi być asertywność. Obecna mentalność, w której polityk jest albo „rosyjskim”, albo „niemieckim” agentem, jest niezwykle szkodliwa - brakuje nam bowiem agentów polskich. W świecie zdominowanym przez narracje o „globalnej wiosce” łatwo zapomnieć, że dyplomacja jest narzędziem realizacji interesu narodowego, a nie celem samym w sobie. Czasy niepokoju pokazują słabość strategii opartej na zaufaniu do instytucji międzynarodowych, które w godzinie próby okazują się niewydolne i głuche na specyfikę naszego regionu.\n\nOd lat Polska boryka się z syndromem „podwykonawcy”. Choć saldo handlowe z np. Niemcami wynosi miliardy euro to głębsza analiza pokazuje, że jesteśmy jedynie ogniwem w obcych łańcuchach dostaw. Według Eurostatu polska gospodarka jest jedną z najbardziej obciążonych regulacjami, co w połączeniu z unijnym regulacjami klimatycznym i kosztami energii wyższymi o 30-40% niż w USA czy Chinach, drastycznie obniża naszą konkurencyjność. Uzależnienie od ideologicznych postulatów, takich jak Zielony Ład, to droga do wasalizacji ekonomicznej. Suwerenność wymaga swobody operacyjnej i zdolności do samodzielnego finansowania potrzeb bez zgody obcych państw.\n\nJednak nawet najlepiej zarządzane państwo i najsilniejsza armia stracą sens, jeśli zabraknie obywateli. Kryzys demograficzny jest największym wyzwaniem krajów rozwiniętych, groźniejszym w skutkach niż kryzysy energetyczne czy wojny. Z wojny, nawet przegranej, naród może się podnieść, a najgorszy scenariusz demograficzny oznacza całkowite wymarcie języka, kultury i historii. Od 2013 roku przyrost naturalny spada, a w 2024 roku straciliśmy prawie 130 tysięcy obywateli. Prognozy mówią o spadku populacji do 27 milionów w 2100 roku. Przy obecnym wskaźniku dzietności (ok. 1,15) wchodzimy w fazę zapaści pokoleniowej, co uderza bezpośrednio w system emerytalny, rynek pracy i bezpieczeństwo.\n\nTraktowanie demografii jedynie w kategoriach socjalnych jest błędem. Populacja to żywa tkanka - bez niej granice i systemy prawne tracą znaczenie. Próżnia demograficzna zasysa dziś imigrantów, co bez strategii asymilacyjnej prowadzi do napięć i utraty spójności kulturowej. Dlatego walka o wzrost dzietności jest walką o tożsamość narodową.\n\nRatowanie Polski wymaga spójnej strategii na obu frontach. Z jednej strony musimy zdefiniować relacje z sojusznikami w oparciu o bilans korzyści i zbudować armię zdolną samodzielnie powstrzymać atak. Z drugiej - musimy całkowicie przemodelować priorytety wewnętrzne, tworząc trwały ekosystem sprzyjający życiu. Oznacza to przywrócenie młodym wiary w dostępność mieszkań, rewitalizację Polski lokalnej oraz zmianę postrzegania rodzicielstwa jako najwyższej formy służby wspólnocie. Tylko Polska silna gospodarczo, asertywna dyplomatycznie i tętniąca życiem będzie w stanie przetrwać turbulencje XXI wieku i stać się liderem Europy Środkowej, a nie jedynie wykonawcą cudzych scenariuszy.	
2270	6	2026-06-16 16:23:37.765588	886	Jestem ambitną, konsekwentną i pracowitą osobą, która od najmłodszych lat angażuje się w działalność społeczną. Przede wszystkim cenię sobie pracę zespołową, a także czuję się pewnie i kompetentnie w roli liderki. Potrafię wyznaczać cele, motywować grupę do działania oraz skutecznie realizować ambitne projekty. Swoją działalność społeczną rozpoczęłam w samorządzie uczniowskim w szkole podstawowej, w której zdobywałam pierwsze doświadczenia organizacyjne i reprezentowałam głos uczniów. W liceum, jako przewodnicząca samorządu uczniowskiego, ściśle współpracowałam z gronem pedagogicznym przy organizacji licznych wydarzeń oraz akcji społecznych, m.in. zbiórek w ramach „Pomocy Ukrainie”, obchodów Dnia Dziecka oraz inicjatyw integrujących społeczność szkolną. Odpowiadałam za koordynację zespołu, planowanie działań i konsultacje z uczniami, dbając o to, by podejmowane inicjatywy odpowiadały na ich realne potrzeby. Dzięki współpracy z Młodzieżową Radą Miasta w szkole zorganizowany został międzyszkolny turniej sportowy promujący aktywność fizyczną oraz integrację młodzieży. Sprawowałam mandat Młodzieżowej Radnej Rady Miasta Bydgoszczy. Jako przewodnicząca Komisji Rewizyjnej odpowiadałam za nadzór nad frekwencją radnych oraz prawidłowością działań Rady. Uczestniczyłam w spotkaniach roboczych i uroczystych sesjach, dbając o merytoryczny poziom pracy oraz współpracę między komisjami. Obecnie działam w Stowarzyszeniu "Siła Młodych", w którym angażuję się w projekty związane z polityką edukacyjną - szczególnie w obszarze MEN. Analizuję proponowane rozwiązania i formułuję postulaty zmian, które mogą realnie poprawić jakość edukacji i warunki życia młodych ludzi. Moim celem jest wzmacnianie głosu młodzieży oraz przekształcanie zaangażowania w konkretne, trwałe efekty.	Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?, Media społecznościowe i sztuczna inteligencja - nowe wyzwania ery cyfrowej.		Wyludnianie mniejszych miejscowości to jedno z najpoważniejszych wyzwań demograficznych Polski w najbliższych latach. Problem ten wynika przede wszystkim z braku stabilnych miejsc pracy, ograniczonych możliwości rozwoju oraz wykluczenia komunikacyjnego. Duże miasta przyciągają młodych ludzi perspektywą kariery, edukacji i życia kulturalnego, podczas gdy mniejsze ośrodki tracą potencjał społeczny i gospodarczy.\nDotychczasowe programy socjalne nie zahamowały spadku liczby ludności, ponieważ nie eliminują przyczyn strukturalnych. Dlatego konieczne są konkretne działania systemowe.\nW tym zakresie postuluję o:\n1.\tPowołanie Funduszu Rozwoju Małych i Średnich Ośrodków, finansowanego z budżetu państwa oraz środków unijnych. Jego celem byłoby tworzenie stabilnych miejsc pracy w powiatach o ujemnym przyroście naturalnym poprzez ulgi podatkowe dla firm tworzących etaty, granty inwestycyjne dla przedsiębiorstw lokujących działalność poza metropoliami oraz wsparcie lokalnych centrów dla początkujących przedsiębiorców.\n2.\tOgraniczenie wykluczenia komunikacyjnego poprzez zwiększenie finansowania regionalnych połączeń autobusowych i kolejowych, szczególnie w gminach oddalonych od centrów wojewódzkich.\n3.\tZagwarantowanie dostępu do miejsc w żłobku w każdej gminie, współfinansowanego przez budżet centralny i samorządy, oraz zwiększenie środków na budownictwo społeczne w mniejszych ośrodkach wraz z preferencyjnymi kredytami dla młodych rodzin.\nDrugim istotnym obszarem są media społecznościowe i sztuczna inteligencja. Technologie te przynoszą realne korzyści, ułatwiają dostęp do wiedzy, wspierają rozwój kompetencji cyfrowych, umożliwiają szybkie dotarcie do informacji i budowanie społeczności. Jednocześnie niosą zagrożenia w postaci dezinformacji, uzależnień cyfrowych, polaryzacji społecznej czy manipulacji treściami. Dlatego wymagają jasnych regulacji.\nW tym zakresie postuluję o:\n1.\tWprowadzenie obowiązkowej edukacji cyfrowej w szkołach ponadpodstawowych, obejmującej weryfikację informacji, rozpoznawanie manipulacji oraz odpowiedzialne korzystanie z AI. Program powinien być finansowany przez Ministerstwo Edukacji przy wsparciu funduszy europejskich i obejmować szkolenia nauczycieli.\n2.\tWprowadzenie obowiązku oznaczania treści generowanych przez AI oraz zwiększenie przejrzystości algorytmów rekomendacji. Nadzór powinien sprawować wyspecjalizowany organ krajowy ds. usług cyfrowych, uprawniony do kontroli platform i nakładania sankcji, działający we współpracy z instytucjami unijnymi.\n3.\tWzmocnienie ochrony osób niepełnoletnich poprzez skuteczniejsze mechanizmy weryfikacji wieku, domyślne ustawienia prywatności dla osób poniżej 18 roku życia oraz obowiązek zapewnienia narzędzi kontroli rodzicielskiej.\nPodsumowując, przeciwdziałanie kryzysowi demograficznemu wymaga inwestycji w rozwój regionalny i stabilną politykę rodzinną, natomiast rozwój technologii cyfrowych powinien iść w parze z odpowiedzialnymi regulacjami i ochroną użytkowników.	
2271	4	2026-06-16 16:23:37.765588	896	Nazywam się Natasza Tkaczyk-Turek, chodzę do drugiej klasy liceum na profil z rozrzedzonym WOS-em, historią i polskim. Marzę o karierze politycznej, moim hobby jest czytanie książek, debatowanie i zajmowanie się moim psem. W przeszłości angażowałam się szczególnie w wolontariat na świetlicy szkolnej, na szczycie fundacji girls future ready, w centrum pomocy społecznej dla dzielnicy Śródmieście oraz w fundacji Mary i Max. Działam również w stowarzyszeniu precedens gdzie przeprowadzam warsztaty w szkołach i organizuję wydarzenia i  nadzorowałam pisanie rekomendacji do strategii dzieci i młodzieży z dziedziny edukacji obywatelskiej oraz już wkrótce poprowadzę mój własny projekt dotyczący edukacji prawnej młodzieży i w stowarzyszeniu siła młodych gdzie również organizuję wydarzenia i działam przy projekcie mającym na celu zwiększenie wiedzy uczniów na temat dyplomacji. Prowadzę mój własny projekt społeczny serca pokoleń, mający na celu integrację międzypokoleniową, w ramach olimpiady zwolnieni z teorii, którego jestem kierowniczką. Jestem również młodzieżową ambasadorką parlamentu europejskiego w ramach projektu EPAS. W szkole podstawowej działałam w samorządzie.	Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?, Energetyka XXI wieku. Jak powinna wyglądać transformacja energetyczna "po polsku" ?		Żadna obecna partia nie oddaje moich centrowych poglądów więc nie planuje dołączać do młodzieżówki a do parlamentu młodych.Poniżej moje postulaty dotyczące kryzysu demograficznego, wyludnianiu mniejszych ośrodków i energetyki XXI wieku:\n1.Zniesienie opłat za dodatkowe godziny pobytu dziecka w przedszkolu.\n2.Lepszy transport publiczny z wsi do miast z ofertami edukacyjnymi, by zapobiegać wykluczeniu komunikacyjnemu małych ośrodków, finansowany z European Regional Development Fund (ERDF). Skierowany do słabo skomunikowanych gmin np.: Błotnica, Dukla, powiaty jasielski i gorlicki. Autobusy kursowałyby zgodnie z godzinami zajęć, umożliwiając dzieciom dojazd do szkół.Zniżki na transport publiczny dla rodziców dzieci ze żłobka, przedszkola i klas 1–3 szkoły podstawowej. Wprowadzenie rodzinnej karty transportu publicznego potwierdzającej zniżki oraz, dla uczniów szkoły podstawowej, prawo do darmowego dojazdu do placówek. Mniejszy dochód z biletów prawdopodobnie rekompensowałby większa liczba korzystających z transportu publicznego.\n3.Wprowadzenie rządowych stypendiów dla młodzieży z gmin wiejskich i miejsko-wiejskich, obejmujące koszty internatu i wsparcie miesięczne, finansowane z budżetu krajowego i Europejskiego Funduszu Społecznego+.\n4.Lepszy dostęp do in Vitro, zwłaszcza w małych ośrodkach, finansowany z EFRR. Budowa banków komórek i zarodków w miejscach z najniższą średnią urodzeń (np. gmina Sczerzyny) oraz zwiększenie ośrodków in Vitro no. w woj. Świętokrzyskim, Łódzkim, Podkarpackim. Coroczne badania płodności w szpitalach gminnych, dostęp po rejestracji online.\n5.Polityka mieszkaniowa inkluzywna i powszechna, w tym dla dużych rodzin. Budowa mieszkań tam, gdzie ich brak, długi czas oczekiwania (gł. woj. Lubelskie) i wysoka cena/m² (Mazowieckie, Małopolskie, Zachodniopomorskie). 3-letni wynajem dla par małżeńskich lub konkubinatów zarabiających <10 tys. zł brutto przez pierwsze 13 miesięcy od przydziału, dostępny od drugiego dziecka.\n6.Stworzenie strony Gov.pl z pełną informacją o polityce prorodzinnej: komu co przysługuje, infolinia i kontakt do urzędników, instrukcje aplikacji ze wsparciem, mapa szpitali oferujących usługi dla rodzin, banki komórek i zarodków, dostępne mieszkania państwowe, listy zniżek i stypendiów z warunkami przyznania i możliwością ubiegania się.\n7.Niższe o 1,5% podatki dochodowe dla firm posiadających dowód na korzystanie jedynie z polskich źródeł energii odnawialnej.\n8.Wstrzymanie wydawania nowych koncesji na wydobycie węgla od 2027 r, Fundusz Transformacji Śląska o wartości co najmniej 50 mld zł finansowany z funduszy unijnych i emisji obligacji.\n9.Budowa magazynów energii finansowanych z KPO i Funduszu Modernizacyjnego UE.\n11.Masową termomodernizację budynków finansowaną z programów krajowych i unijnych.\n12.Produkcję zielonego wodoru dla przemysłu przy wsparciu funduszy UE i inwestorów prywatnych.\n13.Zmniejszenia minimalnej odległości farm wiatrowych do 450 metrów od budynków mieszkalnych, przy jednoczesnym zmniejszeniu podatku od nieruchomości  zbudowanych w promieniu 3km od tych farm o 0,5%.	
2272	5	2026-06-16 16:23:37.765588	906	Hej, od czterech lat działam na rzecz społeczności szkolnej Zespołu Szkół Budowlanych nr 1 w Płocku oraz mieszkańców miasta Płocka od czterech lat. Wielokrotnie pełniłem funkcję przewodniczącego Samorządu Uczniowskiego swojej szkoły, a do dziś jestem przewodniczącym swojej klasy. Dzięki zaufaniu koleżanek i kolegów pełniłem również funkcję wiceprzewodniczącego Młodzieżowej Rady Miasta Płocka w kadencji 2024/2026, która dobiegła końca w styczniu. Po ukończeniu kadencji zdecydowałem się na dołączenie do Stowarzyszenia Siła Młodych. Posiadam bogate doświadczenie w debatach oksfordzkich organizowanych przez Fundację Projekty Edukacyjne oraz Fundację Rozwoju Demokracji Lokalnej we współpracy z MEN-em. Wraz ze swoją drużyną debatującą w ubiegłym roku zajęliśmy trzecie miejsce w projekcie „Liga Debat Fundacji Orlen”, debatując nad tematami zielonej transformacji. Dzięki uczestnictwu w debatach uzyskałem również tytuł Najlepszego Mówcy zeszłorocznej edycji. W niedalekiej przeszłości mieliśmy także okazję debatować podczas Gali Finałowej organizowanej przez FRDL oraz MEN, gdzie zajęliśmy pierwsze miejsce. Ponadto wraz z grupą nieformalną tworzyłem wydarzenie kina plenerowego „Mamma Mia - pokolenia pod gwiazdami”, realizowane dzięki dofinansowaniu z Funduszu Grantowego dla Płocka. Jestem również głównym pomysłodawcą i realizatorem wydarzenia „Aktywni młodzi - silna wspólnota”, którego celem jest rozwijanie kompetencji miękkich oraz kształtowanie postaw obywatelskich wśród młodych ludzi. W ramach tego projektu otrzymałem „Nagrodę Publiczności”. Dodatkowo w ostatnim czasie złożyłem również wniosek o przyznanie Europejskiej Nagrody dla Młodzieży im. Karola Wielkiego. Działanie na rzecz społeczeństwa jest dla mnie niczym tlen - daje mi siłę do dalszej pracy i rozwoju. \nPozdrawiam:)	Media społecznościowe i sztuczna inteligencja - nowe wyzwania ery cyfrowej., Energetyka XXI wieku. Jak powinna wyglądać transformacja energetyczna "po polsku" ?		1. Media społecznościowe są codziennością młodych ludzi. Badania studentów Uniwersytet Marii Curie-Skłodowskiej w Lublinie pokazują, że 97% osób w wieku 16-19 lat korzysta z nich codziennie. Według analiz National Library of Medicine krytyczne myślenie kształtuje się między 12 a 18 rokiem życia, a pełna dojrzałość mózgu następuje około 25 roku życia, co czyni młodzież podatną na dezinformację i fake newsy. Proponuję:\n- Lepszą weryfikację wieku: implementacja skuteczniejszych  narzędzi, np. technologii biometrycznych, zamiast pytań typu „Czy masz ukończone x lat?” pozwalające realnie zweryfikować wiek użytkownika\n- Ograniczenie dostępu: utrzymanie granicy 13 lat dla platform komunikacyjnych jak Facebook i Messenger, służących do kontaktu. Ograniczenie dostępu do serwisów takich jak TikTok i Instagram od 16 roku życia, by zmniejszyć ekspozycję na fake newsy, przemoc i nienawiść, tym samym odwracając zjawisko zastępowalności telewizji, kilkunastosekundowymi filmikami pełniącymi funkcję "odmóżdżenia" dla młodych. \n\nSztuczna inteligencja jest powszechnie wykorzystywana, dlatego jej rozwój powinien iść w parze z dbałością o środowisko. Systemy chłodzenia serwerów AI zużywają dziennie około 2 100 m3 wody - tyle co miasto liczące 20/25 tys. mieszkańców. W przyszłości zapotrzebowanie to będzie rosło, mogąc prowadzić do konkurencji o zasoby wodne.\nPROPONUJĘ:\n- Obowiązek stosowania obiegu zamkniętego wody w centrach danych oraz efektywnych systemów chłodzenia,  w innym wypadku świadomie chcąc oszczędzać wodę wraz z korzystaniem z AI będziemy wykonywać "syzyfową pracę". \n\n2. Transformacja energetyczna w Polsce oznacza odejście od źródeł konwencjonalnych na rzecz OZE. Obecnie około 30% energii pochodzi z OZE; do 2030 roku udział ma przekroczyć 50%, a do 2040 roku osiągnąć około 65%. Rozwój wymaga przewidywania wyzwań, wdrażania rozwiązań, dofinansowań unijnych i samorządowych oraz sankcji finansowych za nieprzestrzeganie norm ekologicznych. PROPONUJĘ:\n- Bezpieczne składowanie urządzeń OZE: zużyte elementy, np. łopaty turbin wiatrowych, powinny trafiać do specjalnych miejsc oddalonych od zabudowy i terenów zielonych. Aktualnie trafiają na zwykłe wysypiska, stwarzając zagrożenie dla ludzi i zwierząt, m.in. poprzez promieniowanie. Należy także rozwijać bardziej ekologiczne komponenty urządzeń OZE umożliwiające częściowy odzysk materiałów.\n- Rozwój sektora wodorowego: Polska zajmuje 3 miejsce w Europie w produkcji wodoru, dlatego powinna intensywnie rozwijać ten sektor i czerpać korzyści z m.in sprzedaży go  innym krajom.\n- Modernizację oczyszczalni ścieków: w Polsce działa ok. 3600 oczyszczalni i 14,7 mln gospodarstw domowych, lecz tylko 6% produkuje energię z biogazu. Pełne wykorzystanie potencjału mogłoby zapewnić energię nawet dla 16 mln gospodarstw.\nOparcie systemu głównie na OZE może zagrozić stabilności kraju - instalacje mogą stać się celem ataków w kryzysie militarnym, a linie przesyłowe nie są przystosowane do dużych obciążeń przy ekstremalnych zjawiskach pogodowych. Polska powinna więc rozwijać wodór i biogaz, kontynuować rozwój OZE oraz z ograniczeniem emisji CO2 utrzymywać część produkcji z paliw kopalnych dla bezpieczeństwa energetycznego Polski	
2273	6	2026-06-16 16:23:37.765588	1036	Hej! Moja działalność społeczna rozpoczęła się w 2022 r. gdy jako członek SU w mojej szkole podstawowej, wziąłem udział jako wolontariusz w akcji "Paczka dla Rodaka i Bohatera na Kresach", organizowanej przez Fundację Polskich Wartości. Wówczas spodobała mi się idea wolontariatu i przez następne 2 lata brałem aktywny udział w tej akcji. W lutym 2024 r. dołączyłem do Wolontariatu Teatru Współczesnego w Szczecinie, co okazało się dla mnie strzałem w dziesiątkę. Już w kwietniu miałem okazję pomagać w organizacji 57. Międzynarodowego Festiwalu Teatralnego "Kontrapunkt", podczas którego poznałem zaplecze teatralne od środka, miałem również możliwość współpracy z zagranicznymi artystami. Jednocześnie jako osoba interesującą się historią, polityką i sprawami społecznymi, także w kwietniu 2024 r. zostałem laureatem Konkursu Kuratoryjnego z WOS-u, zajmując 2 miejsce w województwie. Niedługo później zacząłem się także interesować kryzysem klimatycznym, więc we wrześniu 2024 r. dołączyłem do Młodzieżowego Strajku Klimatycznego, by móc realnie działać na rzecz walki ze zmianami klimatycznymi. W listopadzie tego samego roku, jako członek MSK, wziąłem udział w Okrągłym Stole Uczniowskim, z Ministrą Edukacji Barbarą Nowacką i ówczesnym Ministrem Sportu Sławomirem Nitrasem. Miałem wówczas okazję do rozmowy z P. Ministrą nt. wprowadzenia edukacji klimatycznej w szkołach. Na początku ub. roku odbyłem szkolenia z przeprowadzania Mozaiki Klimatycznej. Uzyskałem wówczas uprawnienia moderatora Mozaiki, co pozwala mi na przeprowadzanie warsztatów edukacyjnych. W listopadzie tego samego roku, zostałem wybrany na Radnego Młodzieżowej Rady Miejskiej w Policach, oraz zostałem jej Wiceprzewodniczącym. Obecnie przygotowuję się do finału Olimpiady z Wiedzy o Polsce i Świecie Współczesnym. :)	Kryzys demograficzny i wyludnianie mniejszych ośrodków. Jak kształtować politykę rodzinną i społeczną?, Energetyka XXI wieku. Jak powinna wyglądać transformacja energetyczna "po polsku" ?		Problem kryzysu demograficznego to zjawisko ściśle związane z obecnymi realiami społeczno-ekonomicznymi. Młodzi Polacy, nie decydują się na zakładanie rodzin, ponieważ nie mają stabilności mieszkaniowej ani zawodowej. Tzw. umowy "śmieciowe", czy wygórowane wymagania pracodawców pozostają zmorą młodych na rynku pracy. Podstawą zmiany obecnego stanu rzeczy powinna być m.in. reforma Państwowej Inspekcji Pracy i zwiększenie jej kompetencji.  \n\nW dalszym ciągu problemem pozostaje też kryzys mieszkaniowy. Ceny zakupu mieszkań na własność są dla wielu młodych nieosiągalne, a ceny wynajmu są nader często wygórowane. Państwo powołać do życia ogólnopolski program budowy tanich mieszkań na wynajem, który nadzorowany powinien być przez samorządy i wykorzystywać do tego istniejące już rozwiązania takie jak TBS-y, które np. dobrze prosperują w moim mieście wojewódzkim, gdzie TBS nie tylko buduje nowe mieszkania wraz z infrastrukturą, ale i dokonuje rewitalizacji pustostanów w mieście, będąc przy tym krajowym liderem. Jednak wraz z tym powinna iść dalsza regulacja przepisów dotyczącą deweloperów.\n \nWyludnianie mniejszych ośrodków wynika głownie z braku usług publicznych i perspektyw. Ograniczony dostęp do lekarzy specjalistów, braki na rynku pracy, likwidacja oddziałów położniczych, wykluczenie komunikacyjne czy brak żłobków powodują migrację młodych do dużych miast, gdzie z kolei muszą liczyć się z wyższymi kosztami życia. Kluczowe są inwestycje w transport publiczny, ochronę zdrowia i cyfryzację administracji, aby wyrównywać warunki życia poza głównymi ośrodkami miejskimi.\n\nSkuteczna polityka demograficzna powinna być polityką równego dostępu do usług, mieszkań i stabilnej pracy. Póki nie osiągniemy tego celu, ciężko o zatrzymanie pełzającego kryzysu. \n-\nMimo istnienia wśród niemalże całej polskiej sceny politycznej konsensusu w sprawie budowy elektrowni jądrowej w Polsce, do tej pory żadna z ekip rządzących nie była w stanie jej rozpocząć. Jednocześnie Polska pozostaje jedynym wydobywcą węgla kamiennego w Unii Europejskiej, a Polska dopłaca aż 25 milionów złotych dziennie do górnictwa. Środki te powinny być przeznaczane na przeprowadzenie sprawiedliwej transformacji energetycznej, poprzez inwestycje w energetykę jądrową, OZE i pomoc w przekwalifikowaniu górników do innych zawodów. Nierentowne kopalnie powinny być stopniowo zamykane, nie pozostawiając przy tym górników na lodzie. \n\nJuż w czerwcu 2025 r. osiągnęliśmy przełomowy moment - OZE odpowiadały za 44,1% produkcji prądu w Polsce, podczas gdy węgiel za 43,7%. OZE produkuje także o wiele tańszą od węgla energię, jednak musimy pamiętać o jednym - za ten wynik odpowiadały w głównej mierze elektrownie słoneczne, które w okresie jesienno-zimowym produkują znacznie mniej energii. Dlatego musimy dalej rozwijać elektrownie wiatrowe, i wreszcie rozpocząć budowę elektrowni jądrowych, bo OZE może być jedynie uzupełniającym źródłem energii przy wiodącej roli atomu, jeśli chcemy odejść od węgla. Warto także pamiętać, że lwia część naszych elektrowni węglowych, to technologia z lat 70, wybudowana jeszcze za czasów Edwarda Gierka.\n	
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.tickets (id, grade_id, new_grade, status, explanation) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.users (id, name, surname, email, password, role, created_at) FROM stdin;
10982	Koordynator	Główny	koordynatorglowny@parlamentmlodych.eu	$2b$12$gBdr0NW1EGxTtI7YXhc//uVm0hanO6jkNZ4.ZC4yp19R5t1PTGIj2	ADMIN	2026-03-03 17:27:32.389009+00
10855	Koordynator	Główny	filip199966@gmail.com	$2b$12$jnIbj8asn7jftAsBH98twePRftLZhK4PFMgmxdTeJUHewfimxpTDu	ADMIN	2025-06-12 17:17:56.026679+00
10986	Olga	Duchnik	olga.duchnik@parlamentmlodych.eu	$2b$12$wzSTswaklObgOGoRyP1g3egUKEpkLrAi2chBnR9a/oq9AEYWHOlWC	USER	2026-03-03 17:39:17.105957+00
10989	Dominik	Łukowski	dominik.lukowski@parlamentmlodych.eu	$2b$12$8TOIEXpMkd6lHmrS4IvpJOpP75cYG10yEAtA1QD1wShKyv8iGOycq	USER	2026-03-03 18:38:44.655797+00
11112	Alicja	Mazurkiewicz	alicja.mazurkiewicz@parlamentmlodych.eu	$2b$12$O7Ka2nR6pFXRY/69ycOyvuHaTONYxicI4hWKnwo2KDkaLi4HbBV8O	USER	2026-06-02 09:54:43.61721+00
11113	Bartosz	Wojciechowski	bartosz.wojciechowski@parlamentmlodych.eu	$2b$12$1xzwnuqbuBb6CdQ8dGyCvu6e129x1pAySopaEJNA6DHETbyciLggK	USER	2026-06-02 09:55:28.566695+00
10994	Miłosz	Andrejczuk	andrejczukmilosz@gmail.com	$2b$12$5wquQgACGnMumoeWzle4MOPazFg9.nnhMeFyxmi7Yu8az4rN9i/1a	USER	2026-03-04 18:17:03.981423+00
10995	Markijan	Andrusejko	andruseikom@gmail.com	$2b$12$CLwDJEUTMfeXyp21.9RxdeTbDlGZdqCk24SozE88Lho6LDBu.TEVC	USER	2026-03-04 18:17:04.615962+00
10996	Jan	Augustyniak	jan.augustyniak09@gmail.com	$2b$12$x5CS9l5AH60SDUjti7sZGeRoWrXzqk1JYZHXAzC5jSUxd.7KAhEpu	USER	2026-03-04 18:17:05.253049+00
10997	Oliwia	Barć	oliwiabarc2006@gmail.com	$2b$12$qTazsYlgqa2.M2ta701Y9eWwRXnzhA57LsIdtN9xDCb2gffTs7UrC	USER	2026-03-04 18:17:05.88813+00
10998	Herbert	Białach	herbertbialach@wp.pl	$2b$12$2ZFsqBz/MzwZV7HPy4BuL.UVa8I8cD6UG/sG0/BjOn85xdAs1c0yi	USER	2026-03-04 18:17:06.509515+00
11014	Alicja	Dyczka	vogtallicja@gmail.com	$2b$12$zClOtWDz6FpAaGIBvBp1m.BMlfly7awvoiCUk6/pKjbuuu860W1M6	USER	2026-03-04 18:17:20.343156+00
11015	Piotr Krzysztof	Fajkis	piotr@fajkis.edu.pl	$2b$12$kAhpqaUd9rqYKuoj0ocVfuN0b5nTnC1arkrrWBQ.q8BOm/kLS1Tbq	USER	2026-03-04 18:17:21.449697+00
11016	Paweł	Genczelewski	genczelewskip@gmail.com	$2b$12$ABP6EG6ifI/l5m1/8W/l3.eb9S91m0t/oZekahmFmpj0vtqqvRPMC	USER	2026-03-04 18:17:22.235709+00
11018	Zofia	Gosk	zofiagosk7@gmail.com	$2b$12$5SYVwdzN4WWOwPi9jZi1Xu3e982zBm5zNpXPqV9lSKSx8rFceHx4W	USER	2026-03-04 18:17:23.717076+00
11019	Jakub	Góras	gorasjakub@gmail.com	$2b$12$hze8gIx11hP4e8gCHRm.Fe3QIhIHQ8VRNDB8iFiPfEYxcxFsC1hoe	USER	2026-03-04 18:17:24.368899+00
11020	Jan	Grzybowski	j_grzybowski@poczta.onet.pl	$2b$12$jtBCAFQiWBi7n6bG3UIKk.6vUsrfRj7QC4scVX.VEXZfn276yXGsO	USER	2026-03-04 18:17:25.247884+00
11021	Mateusz Daniel	Hajer	m.hajer@wp.pl	$2b$12$QZD5DoIQH9utM8kX55YlAe/hvUMxiiRdHDMJPwCCejWgL/OuTaCva	USER	2026-03-04 18:17:26.090265+00
11022	Piotr	Hohendorf	piotrhohendorf@gmail.com	$2b$12$P5rY8p2eu.b.GFjusZZ4Du3G.J7FKEYGQKRCxivBd04SjiGLSeSHK	USER	2026-03-04 18:17:27.134433+00
11094	Filip	Kościsty	filip.koscisty@parlamentmlodych.eu	$2b$12$iWp374GsseoXl0Fj.i534uTD.z/B4HxNpNDLWzzgrPIVYSiZMuL9S	USER	2026-06-02 08:58:04.248756+00
11095	Daria	Śliwa	daria.sliwa@parlamentmlodych.eu	$2b$12$iKREl5YVJPCw99kRigHUcO5T5D1YtoL.4gHKL1r6WhPUqeDOyXdvG	USER	2026-06-02 09:29:23.736709+00
11096	Weronika	Kieliba	weronika.kieliba@parlamentmlodych.eu	$2b$12$qgDDzv1FHU6vS7//5KnFJ.Yqig/xceEa7FiGUcMi9p9bBosttdXn2	USER	2026-06-02 09:31:43.435057+00
11097	Mateusz	Majkut	mateusz.majkut@parlamentmlodych.eu	$2b$12$KnHAiayFUc.HHH4R1irbi.XbUoLNTzT.X8Xa4TEr5YJAS9Nkp/ZZW	USER	2026-06-02 09:32:39.361268+00
11098	Agata	Michalewicz	agata.michalewicz@parlamentmlodych.eu	$2b$12$2si/pIIrO2RHUMc6BQH/Ie1ogjKaaaCZzbPPckIgSWGmX9ViALZ9u	USER	2026-06-02 09:34:01.32123+00
11099	Amelia	Nikel	amelia.nikel@parlamentmlodych.eu	$2b$12$.eW.RGd4CgJ3nZzPw.VmjO.rE1vqOIL8fDMt6iWWgppcxvHbTfuFO	USER	2026-06-02 09:34:41.146993+00
11100	Marcin	Adamcewicz	marcin.adamcewicz@parlamentmlodych.eu	$2b$12$ytH3t2bPkbirHsCTgl.lg..QXGGLgpEOhLEr5zxfkn3UKcy7cD1gW	USER	2026-06-02 09:35:39.654875+00
11102	Kamil	Kusiak	kamil.kusiak@parlamentmlodych.eu	$2b$12$R6Ec7bWeLZuo/yprqF2r4eX5QEo52nTM1T7cX0pQxWpM03y2EkYnq	USER	2026-06-02 09:45:19.752124+00
11103	Katarzyna	Paciorek	katarzyna.paciorek@parlamentmlodych.eu	$2b$12$jV4HlGKLAfZhOcqlFHVXcOwv2RteMgE3pJna9/eMgNQiiR/kQtFBW	USER	2026-06-02 09:46:01.430009+00
11104	Karolina	Szumiał	karolina.szumial@parlamentmlodych.eu	$2b$12$nW72g/QwcRcViLYV77CGSuU0ogBNkHUNjrk4AoesKIWXFQP7Fpfae	USER	2026-06-02 09:46:38.794846+00
11105	Jan	Kwasek	jan.kwasek@parlamentmlodych.eu	$2b$12$sQxdzLhsmAZLSIJz9INnZ./Vf8ENcQStYIpYqdA/F6h/on8Gn7bD6	USER	2026-06-02 09:48:20.344765+00
11106	Karol	Turkiewicz	karol.turkiewicz@parlamentmlodych.eu	$2b$12$7T3e0wtW/MYtmq5eovi1eO5pnB0k7AexjWAm7JmFApE65WlU4dGMG	USER	2026-06-02 09:49:07.805654+00
11107	Oskar	Możdżeń	oskar.mozdzen@parlamentmlodych.eu	$2b$12$CDsmb7gq6T0urjyehk4K2ufriIn5UFlclCbusIuCM2P.fZVqJh7GG	USER	2026-06-02 09:50:20.107161+00
11110	Teresa	Medlakowska	teresa.medlakowska@parlamentmlodych.eu	$2b$12$y64GTHJq9bRwXfUBjfoBUurLE2a50XGGfjiHhDaoBa5ucKI53OFwO	USER	2026-06-02 09:53:13.180558+00
11111	Kacper	Słowik	kacper.slowik@parlamentmlodych.eu	$2b$12$4GDetr09LwJ5cdIkn6boIOEfLz2ChiuXJ0V137gLxY1ryZBSA9DZ6	USER	2026-06-02 09:53:54.102032+00
11109	Jakub	Nykiel	jakub.nykiel@parlamentmlodych.eu	$2b$12$M/TG5A6jHQzeEcOx6lhz0eHpmoFchLMcxz0ozl61x5CpXupOSSZfS	USER	2026-06-02 09:52:34.432576+00
11108	Piotr	Perzyński	piotr.perzynski@parlamentmlodych.eu	$2b$12$yS1nVAAB1vCvhhn.XIn01.qnUognkUTBOguMQ7SNoEzguQtZNwpLq	USER	2026-06-02 09:51:39.299273+00
11114	Adrian	Cherek	adrian.cherek@parlamentmlodych.eu	$2b$12$9bvMOabQflNqDUmcZTksN.XM1f/LbRwH3mQ/7MUAMWSuVxSdV6XOO	USER	2026-06-02 09:56:10.413036+00
11115	Dominik	Majcher	dommaj231@wp.pl	$2b$12$ZWVKKdQ0SXsJLkAQFMNvzeRRkfwJuM2HJUzAay5hMZEoPXAIMTzUK	GRADER	2026-06-20 20:20:12.861245+00
11116	Bartłomiej	Górka	bartlomiej.gorka@parlamentmlodych.eu	$2b$12$ViUHl7NRLNvkfg69F06cgOnyw5IPex0JJP5jglE624APkkI88Bi5G	USER	2026-06-21 16:58:30.90811+00
11117	Jan	Alechniewicz	jan.alechniewicz@parlamentmlodych.eu	$2b$12$T8dWCOj/7njl8LviaQT8/e044MhazZ2g84QC6IWHzSPeBoo3eFTGW	USER	2026-06-21 16:59:09.706653+00
11118	Krzysztof	Kazimierczak	krzysztof.kazimierczak@parlamentmlodych.eu	$2b$12$36pIpoS2HnRXWA/sTxGUV.MdXlYMJVMkcZGe6//p6xWBxQZ2zoQ6y	USER	2026-06-21 17:00:00.508357+00
11119	Maciej	Czarnecki	maciej.czarnecki@parlamentmlodych.eu	$2b$12$twdhb45eJiwpn9LODHOexO2FeZezWWWxoqi1Z.2Akx6k3v2GIVkzW	USER	2026-06-21 17:00:39.231056+00
11101	Dominik	Majcher	dominik.majcher@parlamentmlodych.eu	$2b$12$T1k4SWyq2CE9dGYJpEXoeeoaAO3AMtonLEAxeN4zAuKVNI/s9wcli	USER	2026-06-02 09:44:42.909124+00
11122	Aleksander	Szostek	aleksander.szostek@gmail.com	$2b$12$eRjYuGfD.VZfpz6ww/UGwOBwcdC0a2jbfzuumoYYEHRNdeJ8.bLTS	USER	2026-09-15 17:10:15.164366+00
11124	Eryk	Leszczyński	eleszczynski.mrdpp@gmail.com	$2b$12$4VI6CkjS5CxzH2ZqF8HRU.P/gxjePebXiZ6te58122DOmjdZHQ0Re	USER	2026-09-15 17:11:10.313349+00
11125	Julia	Olejnik	olejnikjulia2703@wp.pl	$2b$12$gy4xkTO2yqgekDmhtu7JLOykYLO66kkeM6QJ4t1UPMjzJnGg.P4va	USER	2026-09-15 17:11:25.393942+00
11126	Natasza	Tkaczyk-Turek	nataszatt@gmail.com	$2b$12$uprWjLeINHcyYCo38.98C.5EC7uprvqzNVZGE0AWkspNFI04KLEMK	USER	2026-09-15 17:11:44.704582+00
11123	Mikołaj	Winiarz	mikoswiniarz@gmail.com	$2b$12$cBM1pxe6ce7mCFMbU0igWemof5K1qKxUef3XdBFKUm30dAWtNvayS	USER	2026-09-15 17:10:52.703671+00
10999	Igor	Bistuła	bistulaigor@gmail.com	$2b$12$Vwp3Dep2ktGrMuWRCOdNl.zUCtCEPqVTtQiRFOFkdXD6Md7g/lbFO	USER	2026-03-04 18:17:07.567875+00
11000	Mikołaj	Błach	blach.mikolaj.2005@gmail.com	$2b$12$d9MsklOZyKUhGgpMd9gp6e10Ei3ILsgE/eyQeWsRDKG7I5mN5tuxS	USER	2026-03-04 18:17:08.193327+00
11001	Hanna	Bręczewska	hanbrecz@gmail.com	$2b$12$/1YGGl/dET6Pc1NTQQuFVeWL6yVpCtpB9NzBVR7G0j5wzVN2W7AB.	USER	2026-03-04 18:17:08.872047+00
11002	Kasper Dorian	Brudniewicz	kasper.brudniewicz@silamlodych.pl	$2b$12$EtilWcLuPISXfBzZxdCiA.cKVDXZym9L63kDCfVHrRWOwKd2ZUu.O	USER	2026-03-04 18:17:09.550524+00
11003	Aleksander	Buchaniec	buchaniecaleksander@gmail.com	$2b$12$kY7JXolCP.mqFmQ5dD2dU.JrdmIOuC4QKxNl0ncKPwxWLIEK7gJbC	USER	2026-03-04 18:17:10.194964+00
11004	Mateusz Andrzej	Całkowski	mateusz2calkowski@gmail.com	$2b$12$fumRnVvJC8yX68VH7M4QRe1.3NI5rbs3OZinH6ufQuKUcmy3Hm2nu	USER	2026-03-04 18:17:10.815922+00
11005	Julia Anna	Chełmicka	juliachelm08@gmail.com	$2b$12$8O6anJ2AbsY0AIuRQE7xJ./tmBuZvPKIkRoI5NnRWeStJYc4fA3Mu	USER	2026-03-04 18:17:11.525308+00
11006	Mikołaj	Chorążak	chorazakmikolaj@gmail.com	$2b$12$1vHVhlqD8u20B7Orqf8aYOpl.ScwRNZ21cieb/8a8d6Ro9NofnUFW	USER	2026-03-04 18:17:12.238464+00
11007	Zuzanna Marta	Cichy	cichymartazuzanna@gmail.com	$2b$12$6BMZjht5MxC2e1t06/nrPejXTsP3vlL78x/SjKAoB0Ck8KJyRP0Ri	USER	2026-03-04 18:17:13.39066+00
11008	Jakub Artur	Czajka	czajkajakub06@gmail.com	$2b$12$Xi3N4BdR2mzbUrxMmgytaOiwioM5coNj1iiF092Rhdb9Z5z8FfPQO	USER	2026-03-04 18:17:14.512313+00
11010	Zuzanna Maria	Czupryńska	zuziacz555@gmail.com	$2b$12$uSdZbM67Wm7AkwagfclB2.MjLbDZJMPmTg.cKK4jdomMD0GW2Ki4q	USER	2026-03-04 18:17:16.248418+00
11011	Perdo	Ćwikliński	drogowy.poznan@gmail.com	$2b$12$Hgn9QTWi9P6fub.tbt5CKetVhJu8.ETnCfwPCw7H3rsF96sCoDOB.	USER	2026-03-04 18:17:17.37494+00
11012	Antoni	Den Braven	denbravenanthony@gmail.com	$2b$12$J25Yo7V7HzRnDXhcTblpBeX8N3dM9kLQTVS9AwEVZJvNk/4THtMK2	USER	2026-03-04 18:17:18.396909+00
11013	Anna	Dudzik	dudzik.ana@gmail.com	$2b$12$BG7MuL4a7seMvDSUb/dU.ez1vA37u..xhXvfD0TFS88TqDSXeoxZe	USER	2026-03-04 18:17:19.343813+00
11023	Aleksander Mariusz	Iskrzycki	alexanderiskrzycki@gmail.com	$2b$12$/HtG26CxlGY7TlYdAbwobeRJKb8bcqnuB74U1zNfR0DxfuXVfacXi	USER	2026-03-04 18:17:28.126271+00
11024	Martyna Weronika	Jałowska	martynaja0811@gmail.com	$2b$12$ukB0IGeCo7pXrlKic.LrHu5dr/heAA3PoJ5iFRvt9afq8GJpx3tFW	USER	2026-03-04 18:17:28.977923+00
11026	Stanisław	Janowicz	stanislaw.janowicz@gmail.com	$2b$12$G3JQ5IeTaZFr2XvnNBi/xea0FGEr5UjDQr7msTBh2UHpfGdVWfIZO	USER	2026-03-04 18:17:30.385682+00
11027	Jan Jakub	Jarzecki	borixplayer@gmail.com	$2b$12$H/4eMVl5jSTV5ao4N88Ol.RuEcg9awtMNnnhhvLxapZP8lMLxM.xi	USER	2026-03-04 18:17:31.089148+00
11028	Magdalena Anna	Jensz	magda.jensz@gmail.com	$2b$12$p6zH1HzYiSg4fhXbwOzUouli4TK8r7gVKNktGx7EnLxlFgyEbvBOi	USER	2026-03-04 18:17:31.804494+00
11029	Marek (Amelia)	Jung	chcewracacdoundertale@gmail.com	$2b$12$dweM32F0U8loye0FRuDy8.Oqaa2KBRPzg7KfdHrN5EHbVQ6UudVe2	USER	2026-03-04 18:17:32.495707+00
11030	Maciej Tomasz	Kaczmarczyk	kaczmarczykmaciej007@gmail.com	$2b$12$gqiPkO./cICxQFEcBYwIDepHcoPxBjfLBHCko8ZKH9rig5uFmmNUC	USER	2026-03-04 18:17:33.210251+00
11031	Antonina Nadia	Kaja	antoninakaja000008@gmail.com	$2b$12$17u3SZQHJ/3SfHny16KEKOtMlQ3qFJ9lz3yDkWmUs.LqDS7TXaPbe	USER	2026-03-04 18:17:33.940061+00
11032	Stanisław Grzegorz	Kałęcki	staskalecki@gmail.com	$2b$12$.SWW5//KnfsCO8xrsLzcWep5SPTezFMofRQ/SWnTl2Hq5vSo8DYPC	USER	2026-03-04 18:17:34.620106+00
11033	Hanna	Karyś	kaa.hannah0@gmail.com	$2b$12$6yM17lRc0N9X269qkaIDJej/3JsXvtUgVMEryoqAxoQXxc172jtL.	USER	2026-03-04 18:17:35.285063+00
11034	Joachim	Kawka	kawkaodkawki@gmail.com	$2b$12$MR3ZgHDoCTM7YzIk2uhq6.q6snAapP.M.SAw2A78.qbOBIdDmuUES	USER	2026-03-04 18:17:36.005142+00
11035	Olivier	Kopciewicz	olivierkop.os@gmail.com	$2b$12$i0ix986mxw.7d1XDBMRgxuUiGDn9jX8.xQqZvK31.A9kY3CIGaIMa	USER	2026-03-04 18:17:37.043826+00
11037	Adam	Kowalczyk	adamkowalczyk7c@gmail.com	$2b$12$ABvgeHayDtiRCiYzw0D9zuVssC2dncvAY6s7TlPqDO5Doq7GasH4K	USER	2026-03-04 18:17:39.49722+00
11038	Aleksander	Kowalczyk	olekow@icloud.com	$2b$12$ZdM.Hwh7pmeV9LeDjQN1ouTMreLCdWasNzFuru6bxygrba4vNt5Ty	USER	2026-03-04 18:17:40.463623+00
11039	Jan	Kozłowski	jk.jan.kozlowski@gmail.com	$2b$12$48bSR9Pc0YQ.t1LE5fyfb.7LBNP0Woz3UNlaP0zPiVlBb/Vco5ZpW	USER	2026-03-04 18:17:41.233955+00
11040	Wiktor	Krompaszczyk	wiktorkrompaszczyk@gmail.com	$2b$12$77.FIfh6GZK9aeMVTsu0.eNZN642Z6c4MbnNgHBNJ.K4zBKyvolqi	USER	2026-03-04 18:17:41.973022+00
11041	Jan Jerzy	Krzywolak	jankrzyw123@gmail.com	$2b$12$i8GzXVWupPnS.bYqXGI7/uYkr6hJGi3WOe8TRqzXGaxD.1.6dHQ.C	USER	2026-03-04 18:17:42.69764+00
11042	Jakub	Kubik	jakubkubik3009@gmail.com	$2b$12$ARwgM/TJjCbiqV7gb3xH7ucVta4fpTjMdW8VNOeuUbtdo8rbzqZO.	USER	2026-03-04 18:17:43.433757+00
11043	Radosław Michał	Kuk	radoslawkuk.co@gmail.com	$2b$12$3OhSV3Hil7DwmLFFgFlxIeg2HfwEcgANOx0RRjVlZ9H5D/oT3trCq	USER	2026-03-04 18:17:44.190394+00
11045	Lena	Kuźniar	lenakuzniar13@gmail.com	$2b$12$EUvnmdLDxbJZqQ72k2Cp6uyfdUDShFjWTmO43VoVq3GNbjm7slQYq	USER	2026-03-04 18:17:45.699635+00
11046	Nazarii	Leontiev	nazariyleon92@gmail.com	$2b$12$FuNSChkTeNmO7vH5smN7HOwWP9Xv48Co4SEj90IdpI7KKEbFdgWr6	USER	2026-03-04 18:17:46.418443+00
11047	Kamil	Leszczyński	leszczynski.kamil08@gmail.com	$2b$12$upYwfrjCUlaeNz.OC4ztCOw.0vTQe.DMqgxtileHRKBKzmhbDFqbq	USER	2026-03-04 18:17:47.139732+00
11048	Daminik	Lisichonak	lisouczyk.geology@zbsunion.org	$2b$12$L9NSN72VZrLCGQEn6ARd/eufaQw4M3O6mR/yYswvX8vEriPYBV3qW	USER	2026-03-04 18:17:47.876575+00
11049	Patryk	Ławniczak	patryklawniczak2704@gmail.com	$2b$12$bLeW9nrsYs4AzDWBTWSq/OfmSmlhjOhlUMJFM0aID7wrlRLJlgmCi	USER	2026-03-04 18:17:48.627223+00
11050	Kacper Jan	Makarski	kacpermakarski99@gmail.com	$2b$12$vxge9fW0ms01xTGFphi8I.t5pSE9F.vR2jKZnO.tqS5ruYaPBuEpG	USER	2026-03-04 18:17:49.409007+00
11051	Jan Bolesław	Małek	jbmalek.batory@gmail.com	$2b$12$u3mX9G0IVopm1DQGBjNoLOvY765Kfi1/hFdEA./6uJVBDqaCbDGkG	USER	2026-03-04 18:17:50.110165+00
11053	Blanka	Michalska	blanka.michalska10@wp.pl	$2b$12$iAOJo8kPgGqJYpmX6UNljeo9MOLkL9uglPkcTIYw534GKPQVwn6C.	USER	2026-03-04 18:17:51.672017+00
11054	Oskar Mateusz	Migoń	oskar.migon123@gmail.com	$2b$12$0j7nHCW/g6IPoOp41ZbqQ.R0ZZQtA1VMvpNGl5M3s4UD09bzfjjVG	USER	2026-03-04 18:17:52.37547+00
11055	Karol Jacek	Mirecki	kmirecki06@gmail.com	$2b$12$IiTe4xdwOfJ2rI8ffe8YYeNQYC/Kw4D0zSGL6BZg3DzHBFTnRmiQi	USER	2026-03-04 18:17:53.099449+00
11056	Bartosz	Mizgalski	mizgalskibartoszroman@gmail.com	$2b$12$EuEnb3LVDm4FSg23tMPbae.0.RwbH8chDcJ822WaZMY7dBgA25Ghu	USER	2026-03-04 18:17:53.865624+00
11057	Bartłomiej Tomasz	Morawik	morawik.bartlomiej@gmail.com	$2b$12$BWneQlJbuwYr7d3QRVYUHOtzbcXSdS0CCxoDEiDmduyp7vsgkvvYW	USER	2026-03-04 18:17:54.612569+00
11058	Krzysztof	Nestorowicz	neskoral@op.pl	$2b$12$11wM5XqteBQM6hn7Pqf7ku7mN13yUDSIGFYelQqq9r2kW5ztVb7/C	USER	2026-03-04 18:17:55.325061+00
11059	Jeremi Piotr	Noga	jeremi.noga2000@gmail.com	$2b$12$5fdcjJbLAJG5XF9DgVnBgO2/8NXZVzNSkON2OPHuFEW14qkfDRQea	USER	2026-03-04 18:17:56.171431+00
11009	Franciszek	Czajkowski	FCzajkowski@proton.me	$2b$12$U.WxlL4GjAAg81htlB.igeastLOUgYFuSR6jDljLhxZ8u3LpPcI6G	USER	2026-03-04 18:17:15.46722+00
11036	Stanisław	Kośmicki	esemik8@gmail.com	$2b$12$OajYur3Vr2NcJcw3AAr.Je8cMAcgyHlWFZCQN7AcD4CiHCBPvGOa.	USER	2026-03-04 18:17:38.231828+00
11060	Jan Piotr	Olczyk	jan_olczyk@icloud.com	$2b$12$LJEQpJncJ2mIudkj/BFJq.taHG3U7s3QNiY6M79BNALC/zs7/mCSa	USER	2026-03-04 18:17:56.863267+00
11061	Antoni Stanisław	Olszewski	a.olszewski2005@wp.pl	$2b$12$x8G/wnbXuLxMeRqeiu0qquSH25e.IGpcvvQCEXz9ZbJIDpIzEIwSu	USER	2026-03-04 18:17:57.607156+00
11062	Stanisław Paweł	Pasteczka	sppasteczka@gmail.com	$2b$12$dijenvwy5vm4bjq7Pnawz.o10tUj56ApJGOVpz5xHHvTIU8dwDV7e	USER	2026-03-04 18:17:58.441986+00
11063	Wiktor Ignacy	Pawlikowski	wiktorignpawlikowski@gmail.com	$2b$12$B.vsk6uos6czAGfOVCbwwuMNqzlk.AC5M9StJnuXFSERJxCM61BOm	USER	2026-03-04 18:17:59.254825+00
11064	Stanisław	Pietrykowski	pietrykowski.stanislaw@gmail.com	$2b$12$FnPVtqnktBSnVHActbu4VeSqc/Y6xpnq.DE0GawIQnfvnMDQZ6oFO	USER	2026-03-04 18:17:59.997904+00
11065	Igor	Piskórz	igorius2000@gmail.com	$2b$12$KFHwnMt3K9xfhfpxJyPTje2GHvYo90qDSU/6pnjtKrqOL5iCswegG	USER	2026-03-04 18:18:00.730591+00
11066	Mateusz	Pochopień	pochopienmateusz@outlook.com	$2b$12$933uOjS1rqIM7E4sJtUn3uekZImsW4IljamLVTnvZatxf1vJMHDde	USER	2026-03-04 18:18:01.497154+00
11067	Paweł	Polakowski	polakowskipawel9@gmail.com	$2b$12$FYCHLc5zojdOJQQWeYAV8e/DJMntYMKApGTwWN4DV0MBj0h.Wpng.	USER	2026-03-04 18:18:02.230925+00
11068	Kamil	Poświątny	kamil.poswiatny2010@gmail.com	$2b$12$EFUU.brRPJb/dJUoM9ektORfXH5j/9kjfc1EWHFgvZGTji225FCPW	USER	2026-03-04 18:18:02.991131+00
11069	Hubert Krzysztof	Przytuła	przytula.kontakt@gmail.com	$2b$12$66dSzwsn4tZF06KWGARh7u4.3sgxenHH1i/GFBlXKp6dIXHR1RDCa	USER	2026-03-04 18:18:03.797805+00
11070	Mateusz	Ptaszek	mateuszptaszek86@gmail.com	$2b$12$jxrnZrl3Zrl0gppw3qBiCOHRvo6/9TBQyhJMrzmZu.NeYNHkawaRa	USER	2026-03-04 18:18:04.545903+00
11071	Antoni	Roik	antoni.roik@icloud.com	$2b$12$qj2VdKP7zX2amQyjCOhaJe5U3OlH6AyNAfgNxLCcQwQ743wpNcQuq	USER	2026-03-04 18:18:05.272504+00
11072	Fryderyk	Różański	f1rozanski@gmail.com	$2b$12$J0Eaia8pONPxWf6cKhbnley41hfhOKcqPSznvp8xSuNYTTPHGmXKu	USER	2026-03-04 18:18:05.983885+00
11073	Kajetan Mateusz	Ruszkowski	drugi.ruszkowski20@gmail.com	$2b$12$jgrzb7YAAz1nyTDm6A6c/uFx07WX0TOVbnRkniLw.ddyk8sEg1Piu	USER	2026-03-04 18:18:06.7407+00
11074	Daniel Stanisław	Sabat	danielsabat2009@gmail.com	$2b$12$obzpg39vyp0.YlWCx2D9fuY1J5jw7zKYh1sXwBsLKWEnysYo0OnQe	USER	2026-03-04 18:18:07.444455+00
11075	Szymon	Sędzik	szymon.sedzik@poczta.onet.pl	$2b$12$Xt2s5K33HsfXzZ4lHFE6wei2HkfBXQHOzZlUDp31BJ/mQEcD/F3wK	USER	2026-03-04 18:18:08.187932+00
11076	Carmen Julia	Skowyra	carmenskowyra421@gmail.com	$2b$12$YWbo69JPQoxDoIxdTJ31euytOVL0DGAygsi/R9j.LsT5Dw06aq4g.	USER	2026-03-04 18:18:09.04405+00
11077	Michał	Sochalski	msochalski11@gmail.com	$2b$12$.sjo0kLZ5WkHJMdqOFPG1uPAIkRcXA57HVuliEmjODE6.Xf04j30W	USER	2026-03-04 18:18:09.749966+00
11078	Julia Anna	Stankala	julia.stankala@gmail.com	$2b$12$FlOd1HPtgpaBcX6dDefaHu0LEIvmhUc2nhbsBOAuDerJCcUUri77u	USER	2026-03-04 18:18:10.511651+00
11079	Magdalena Maria	Staśkiewicz	magdalenastas@proton.me	$2b$12$g9UbeFFxQXjxZe31ELnUzOOj.NilehFCn6NJHFsbwUc7yGD7.nzUq	USER	2026-03-04 18:18:11.364938+00
11080	Julia Wiktoria	Syrytczyk	julia.syrytczyk@gmail.com	$2b$12$MqPv/VUHA.spMrbviCw22.M45qc1nLdvMkQes5TDoq8tqzZnTKbSq	USER	2026-03-04 18:18:12.132289+00
11081	Zuzanna	Szafran	zuziaszafran204@gmail.com	$2b$12$9IBQSpDDHbKdK3Mvo0qykO3Gds96cf7xxTnZVWKYAkpi1g4reTRKa	USER	2026-03-04 18:18:12.862553+00
11082	Oliwier Andrzej	Szulejko	szulejkooliwier@gmail.com	$2b$12$giePVAyaKtan8tVwBV9IluEzJwCUs9KNzhnL9Q2kDbW5ONFh5sxc6	USER	2026-03-04 18:18:13.604414+00
11083	Szymon Jakub	Świątek	szymswiatek05@gmail.com	$2b$12$TN5Pdw2XtEuTEnX0ibA4re1nh/.XFZ.kBhQgNiD1fBHjA6j28MUfa	USER	2026-03-04 18:18:14.392607+00
11084	Ignacy Andrzej	Święcki	swieckiignacy@gmail.com	$2b$12$hOOxOdO0wwmwe9zQqqK9Uu3McUPvOR71X9H7TFSE7ZjOWrh/kct1W	USER	2026-03-04 18:18:15.112702+00
11085	Kamil Tomasz	Trąbała	Kamiltrabala2005@gmail.com	$2b$12$DEsHxsGc/59raYSru6oK4el9Gy1H/lp99/ciVNI.osgR59XgslM2K	USER	2026-03-04 18:18:15.860206+00
11086	Borys Mateusz	Wal	Boryswal79@gmail.com	$2b$12$pb2SkHWkzPGl3417WPAlteZTv/UqAVws8.BmqXs7x9Fo5utwCxC3.	USER	2026-03-04 18:18:16.614026+00
11087	Wojciech	Wasilewski	wasilewski05@icloud.com	$2b$12$p1En7YPDoEjBsR38kV.doOpGSREJCwp0hXyhMvFdq8/mrD5cxIleW	USER	2026-03-04 18:18:17.596669+00
11121	Malwina	Woźniak	malwina.wozniak@parlamentmlodych.eu	$2b$12$3pcTCAMRdr7AVH7EYAxlV.o5qWq8iKFuxVQc85e8g/uKGK/eXebmq	USER	2026-06-21 17:02:11.842299+00
11120	Maciej	Wyszyński	maciej.wyszynski@parlamentmlodych.eu	$2b$12$9OhZ4zUJAp5cTiLW87oS2.r5jcXuvbHWv.d0wJU6o7ShnsThBhCMy	USER	2026-06-21 17:01:28.782608+00
10970	test	test	test@test.com	$2b$12$liRBcEElTa02EzKWpWtaNeOYRyA5/TjAcPsoc8e3Nhntt5LbOHF/C	GRADER	2026-02-11 17:09:12.623107+00
1	admin	admin	admin@admin.com	$2b$12$GuXZPFmsuj5mz0.plqopL.U1VoZwkD6JuEnDU.5qaVQ6B26m7/GaS	ADMIN	2025-06-11 16:21:25.475538+00
11088	Krzysztof Dominik	Weber	krzysztof.weber.yt@gmail.com	$2b$12$WyNyrad2/yXXX1ud.PRxReEP8obnq34v9PDnWNxhber1F31.v.C6a	USER	2026-03-04 18:18:18.359909+00
11090	Adrian	Wróblewski	adrian.wroblewski.pro@gmail.com	$2b$12$5giXRxbYwwuyEoEJauZSlOOBOznRJOTD7wF4n5f/goIx58/QUAdba	USER	2026-03-04 18:18:19.861034+00
11091	Miłosz	Zieliński	milosz.zielinski5@wp.pl	$2b$12$1sV6FyRorc6/emJvFMXj9eRMkfqFa/EZs5FqhAnSjgR5kmxzbcTjG	USER	2026-03-04 18:18:20.625165+00
11092	Amelia	Zienkiewicz	amelia.zienkiewicz0@gmail.com	$2b$12$EKlybJbLM9JwVc7.DVABg.JV4xzFiCtsHDeddH4ITum3Yq0pWGpMe	USER	2026-03-04 18:18:21.40303+00
11093	Kacper	Bielecki	bieleckikacper94@gmail.com	$2b$12$UmiGJw7Jvug4RZrONcsz4.q3O7TG6hSnMd5zv4YiUiij4gP.xYp1a	USER	2026-03-04 18:25:03.670639+00
10969	Oskar	Możdżeń	oskar.mozdzen@gmail.com	$2b$12$r3dQ9WUWCWhd/NOEPAhVMOz2OblT2duiQ5MqTozj8izGGE5xN/uhK	USER	2026-02-10 19:15:35.554404+00
10980	Marcin	Adamcewicz	marcin.adamcewicz0217@gmail.com	$2b$12$RzEj95Eq0JDN67ZF06bPMeeLDuifOwrl7MsKR7QZ.8M/yNtTEMHcu	GRADER	2026-02-13 12:50:07.1865+00
10979	Patrycja	Lamparska	patrycjalamparska18@gmail.com	$2b$12$Wb2FfDu4tk6s4Sn0VQjXEOday3xWwLq17350hRUq/H07lq1ZbfR9K	GRADER	2026-02-13 12:49:44.77652+00
10977	Bartosz	Wojciechowski	bartoszwojciechowski.bw@gmail.com	$2b$12$zqQYjOBzloCLwJYUzkG6teR/zey5C1EzMpaeEE9D3B3nQCidV7PVO	GRADER	2026-02-13 12:47:35.28475+00
10976	Amelia	Nikel	nikel.amelia16@gmail.com	$2b$12$xqrGG3R0dPPJmXGXluLlTOUg/zymEkRVThgT8AmgUSUMucUK8W/Fa	GRADER	2026-02-13 12:47:04.016511+00
10975	Kacper	Słowik	k.slowwik@gmail.com	$2b$12$EfrV7Lgc65/CI6X5MXOw6epO00M9xUDunn86h7iwdBWomv2GSJUA.	GRADER	2026-02-13 12:45:54.95818+00
10973	Daria	Śliwa	daria.sliwa12@gmail.com	$2b$12$HX1rSMI65UEAXdFIMJ2b8eBo/t9h5riKP8HWAPHX.NFUkEb.E5Aee	GRADER	2026-02-13 12:44:00.306866+00
10974	Alicja	Mazurkiewicz	alicjaamazurkiewicz@gmail.com	$2b$12$jJWhCgfL9JIKu.uQFmNt3eSfUMQez/cdq0HHVUt4GNk51oW6OFPre	GRADER	2026-02-13 12:44:31.814843+00
10971	Agata	Michalewicz	agata.michalewicz@icloud.com	$2b$12$2CnXpPmHVvbpbqdWMu5YO.zDFNiI7dwwDnum3Haiwxi0CHldiKU/a	GRADER	2026-02-11 17:19:14.478962+00
10972	Weronika	Kieliba	weronika.kieliba@gmail.com	$2b$12$fkUqRku/ECt0/c2QHqIrbe/5GG/rTYwePHcd2CU/XoMxwI7e9YEdG	GRADER	2026-02-13 12:42:37.906849+00
\.


--
-- Data for Name: voters; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.voters (id, poll_id, user_id, created_at, voted_at) FROM stdin;
\.


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: vox
--

COPY public.votes (id, poll_id, voter_id, question_id, answer_id, created_at) FROM stdin;
\.


--
-- Name: amendments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.amendments_id_seq', 1, false);


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.answers_id_seq', 2590, true);


--
-- Name: graders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.graders_id_seq', 24, true);


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.grades_id_seq', 3418, true);


--
-- Name: grading_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.grading_groups_id_seq', 6, true);


--
-- Name: polls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.polls_id_seq', 98, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.questions_id_seq', 860, true);


--
-- Name: resolution_signatures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.resolution_signatures_id_seq', 1, false);


--
-- Name: resolutions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.resolutions_id_seq', 1, false);


--
-- Name: submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.submissions_id_seq', 2273, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.tickets_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.users_id_seq', 11126, true);


--
-- Name: voters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.voters_id_seq', 5098, true);


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vox
--

SELECT pg_catalog.setval('public.votes_id_seq', 151428, true);


--
-- Name: amendments amendments_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.amendments
    ADD CONSTRAINT amendments_pkey PRIMARY KEY (id);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: graders graders_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.graders
    ADD CONSTRAINT graders_pkey PRIMARY KEY (id);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: grading_groups grading_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.grading_groups
    ADD CONSTRAINT grading_groups_pkey PRIMARY KEY (id);


--
-- Name: polls polls_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: resolution_signatures resolution_signatures_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.resolution_signatures
    ADD CONSTRAINT resolution_signatures_pkey PRIMARY KEY (id);


--
-- Name: resolutions resolutions_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.resolutions
    ADD CONSTRAINT resolutions_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: voters voters_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.voters
    ADD CONSTRAINT voters_pkey PRIMARY KEY (id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: ix_amendments_author_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_amendments_author_id ON public.amendments USING btree (author_id);


--
-- Name: ix_amendments_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_amendments_id ON public.amendments USING btree (id);


--
-- Name: ix_amendments_resolution_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_amendments_resolution_id ON public.amendments USING btree (resolution_id);


--
-- Name: ix_answers_creator_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_answers_creator_id ON public.answers USING btree (creator_id);


--
-- Name: ix_answers_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_answers_id ON public.answers USING btree (id);


--
-- Name: ix_answers_poll_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_answers_poll_id ON public.answers USING btree (poll_id);


--
-- Name: ix_answers_question_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_answers_question_id ON public.answers USING btree (question_id);


--
-- Name: ix_graders_group_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_graders_group_id ON public.graders USING btree (group_id);


--
-- Name: ix_graders_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_graders_id ON public.graders USING btree (id);


--
-- Name: ix_graders_user_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_graders_user_id ON public.graders USING btree (user_id);


--
-- Name: ix_grades_grader_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_grades_grader_id ON public.grades USING btree (grader_id);


--
-- Name: ix_grades_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_grades_id ON public.grades USING btree (id);


--
-- Name: ix_grades_submission_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_grades_submission_id ON public.grades USING btree (submission_id);


--
-- Name: ix_grading_groups_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_grading_groups_id ON public.grading_groups USING btree (id);


--
-- Name: ix_polls_creator_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_polls_creator_id ON public.polls USING btree (creator_id);


--
-- Name: ix_polls_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_polls_id ON public.polls USING btree (id);


--
-- Name: ix_polls_title; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_polls_title ON public.polls USING btree (title);


--
-- Name: ix_questions_creator_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_questions_creator_id ON public.questions USING btree (creator_id);


--
-- Name: ix_questions_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_questions_id ON public.questions USING btree (id);


--
-- Name: ix_questions_poll_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_questions_poll_id ON public.questions USING btree (poll_id);


--
-- Name: ix_resolution_signatures_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_resolution_signatures_id ON public.resolution_signatures USING btree (id);


--
-- Name: ix_resolution_signatures_resolution_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_resolution_signatures_resolution_id ON public.resolution_signatures USING btree (resolution_id);


--
-- Name: ix_resolution_signatures_user_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_resolution_signatures_user_id ON public.resolution_signatures USING btree (user_id);


--
-- Name: ix_resolutions_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_resolutions_id ON public.resolutions USING btree (id);


--
-- Name: ix_resolutions_slug; Type: INDEX; Schema: public; Owner: vox
--

CREATE UNIQUE INDEX ix_resolutions_slug ON public.resolutions USING btree (slug);


--
-- Name: ix_submissions_group_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_submissions_group_id ON public.submissions USING btree (group_id);


--
-- Name: ix_submissions_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_submissions_id ON public.submissions USING btree (id);


--
-- Name: ix_tickets_grade_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_tickets_grade_id ON public.tickets USING btree (grade_id);


--
-- Name: ix_tickets_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_tickets_id ON public.tickets USING btree (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: vox
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_voters_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_voters_id ON public.voters USING btree (id);


--
-- Name: ix_voters_poll_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_voters_poll_id ON public.voters USING btree (poll_id);


--
-- Name: ix_voters_user_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_voters_user_id ON public.voters USING btree (user_id);


--
-- Name: ix_votes_answer_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_votes_answer_id ON public.votes USING btree (answer_id);


--
-- Name: ix_votes_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_votes_id ON public.votes USING btree (id);


--
-- Name: ix_votes_poll_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_votes_poll_id ON public.votes USING btree (poll_id);


--
-- Name: ix_votes_question_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_votes_question_id ON public.votes USING btree (question_id);


--
-- Name: ix_votes_voter_id; Type: INDEX; Schema: public; Owner: vox
--

CREATE INDEX ix_votes_voter_id ON public.votes USING btree (voter_id);


--
-- Name: amendments amendments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.amendments
    ADD CONSTRAINT amendments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: amendments amendments_resolution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.amendments
    ADD CONSTRAINT amendments_resolution_id_fkey FOREIGN KEY (resolution_id) REFERENCES public.resolutions(id);


--
-- Name: answers answers_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: answers answers_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES public.polls(id);


--
-- Name: answers answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: graders graders_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.graders
    ADD CONSTRAINT graders_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.grading_groups(id);


--
-- Name: graders graders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.graders
    ADD CONSTRAINT graders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: grades grades_grader_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_grader_id_fkey FOREIGN KEY (grader_id) REFERENCES public.graders(id);


--
-- Name: grades grades_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: polls polls_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: questions questions_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: questions questions_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES public.polls(id);


--
-- Name: resolution_signatures resolution_signatures_resolution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.resolution_signatures
    ADD CONSTRAINT resolution_signatures_resolution_id_fkey FOREIGN KEY (resolution_id) REFERENCES public.resolutions(id);


--
-- Name: resolution_signatures resolution_signatures_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.resolution_signatures
    ADD CONSTRAINT resolution_signatures_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: submissions submissions_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.grading_groups(id);


--
-- Name: tickets tickets_grade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_grade_id_fkey FOREIGN KEY (grade_id) REFERENCES public.grades(id);


--
-- Name: voters voters_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.voters
    ADD CONSTRAINT voters_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES public.polls(id);


--
-- Name: voters voters_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.voters
    ADD CONSTRAINT voters_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: votes votes_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.answers(id);


--
-- Name: votes votes_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES public.polls(id);


--
-- Name: votes votes_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: votes votes_voter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vox
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_voter_id_fkey FOREIGN KEY (voter_id) REFERENCES public.voters(id);


--
-- PostgreSQL database dump complete
--

