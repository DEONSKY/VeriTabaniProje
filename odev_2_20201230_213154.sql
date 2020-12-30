--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12rc1

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
-- Name: app_shema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA app_shema;


ALTER SCHEMA app_shema OWNER TO postgres;

--
-- Name: calculate_general_rating(); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.calculate_general_rating() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare 
	avarage int;
	begin
		select AVG(user_rating) into avarage FROM app_shema.user_coffee_settings  where coffee_setting_id= new.coffee_setting_id ;
		update app_shema.coffee_settings set global_rating = avarage where  coffee_setting_id =new.coffee_setting_id  ;
		return new ;
	END;
$$;


ALTER FUNCTION app_shema.calculate_general_rating() OWNER TO postgres;

--
-- Name: change_bo_password(character varying, integer); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.change_bo_password(new_second_password character varying, input_business_owner_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
	BEGIN
		update app_shema.business_owner set second_password =  new_second_password where  business_owner_id = input_business_owner_id ;
	return 1;
	END;
$$;


ALTER FUNCTION app_shema.change_bo_password(new_second_password character varying, input_business_owner_id integer) OWNER TO postgres;

--
-- Name: delete_user(integer); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.delete_user(id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		update app_shema.users set is_account_active = false WHERE user_id = id;
	END;
$$;


ALTER FUNCTION app_shema.delete_user(id integer) OWNER TO postgres;

--
-- Name: insert_business_owner(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.insert_business_owner(new_username character varying, new_email character varying, new_password character varying, new_business_name character varying, new_second_password character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare 
	id integer;
	BEGIN
		INSERT INTO app_shema.users(username,email,"password",is_account_active) VALUES
	(new_username ,new_email , new_password , true)returning app_shema.users.user_id into id;
		INSERT INTO app_shema.business_owner VALUES
	(id, new_business_name , new_second_password );
	return 1;
	END;
$$;


ALTER FUNCTION app_shema.insert_business_owner(new_username character varying, new_email character varying, new_password character varying, new_business_name character varying, new_second_password character varying) OWNER TO postgres;

--
-- Name: insert_user(character varying, character varying, character varying); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.insert_user(new_username character varying, new_email character varying, new_password character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO app_shema.users(username,email,"password",is_account_active) VALUES
	(new_username ,new_email , new_password , true);
	return true;
	END;
$$;


ALTER FUNCTION app_shema.insert_user(new_username character varying, new_email character varying, new_password character varying) OWNER TO postgres;

--
-- Name: new_order(); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.new_order() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		insert into app_shema.orders_in_queue values (new."order_id");
	return new;
	END;
$$;


ALTER FUNCTION app_shema.new_order() OWNER TO postgres;

--
-- Name: order_is_ready(); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.order_is_ready() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		update app_shema.orders set order_finish_date = CURRENT_TIMESTAMP where old.order_id = order_id;
		return new;
	END;
$$;


ALTER FUNCTION app_shema.order_is_ready() OWNER TO postgres;

--
-- Name: ordersinqueuecount(); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.ordersinqueuecount() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
	total integer;
	BEGIN
		select count(*) into total from app_shema.orders_in_queue oiq ;
		return total;
	END;
$$;


ALTER FUNCTION app_shema.ordersinqueuecount() OWNER TO postgres;

--
-- Name: sold_coffee_count(); Type: FUNCTION; Schema: app_shema; Owner: postgres
--

CREATE FUNCTION app_shema.sold_coffee_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare 
	total int;
	begin
		select count(*) into total from app_shema.orders where coffee_setting_id = new.coffee_setting_id;
		update app_shema.licanced_coffee_settings set sold_coffee_count =  total where  coffee_setting_id =new.coffee_setting_id ;
		return new;
	END;
$$;


ALTER FUNCTION app_shema.sold_coffee_count() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: business_owner; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.business_owner (
    business_owner_id integer NOT NULL,
    business_name character varying,
    second_password character varying
);


ALTER TABLE app_shema.business_owner OWNER TO postgres;

--
-- Name: catalog_options; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.catalog_options (
    catalog_option_id integer NOT NULL,
    title character varying NOT NULL,
    description character varying,
    stock integer,
    type_id integer
);


ALTER TABLE app_shema.catalog_options OWNER TO postgres;

--
-- Name: catalog_types; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.catalog_types (
    type_id integer NOT NULL,
    type_name character varying,
    type_description character varying,
    needed_module character varying,
    type_unit character varying NOT NULL
);


ALTER TABLE app_shema.catalog_types OWNER TO postgres;

--
-- Name: coffee_setting_options; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.coffee_setting_options (
    catalog_option_id integer NOT NULL,
    coffee_setting_id integer NOT NULL,
    amount integer
);


ALTER TABLE app_shema.coffee_setting_options OWNER TO postgres;

--
-- Name: coffee_settings; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.coffee_settings (
    setting_name character varying NOT NULL,
    description character varying NOT NULL,
    global_rating integer,
    coffee_setting_id integer NOT NULL
);


ALTER TABLE app_shema.coffee_settings OWNER TO postgres;

--
-- Name: coffee_settings_coffee_setting_id_seq; Type: SEQUENCE; Schema: app_shema; Owner: postgres
--

CREATE SEQUENCE app_shema.coffee_settings_coffee_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_shema.coffee_settings_coffee_setting_id_seq OWNER TO postgres;

--
-- Name: coffee_settings_coffee_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: app_shema; Owner: postgres
--

ALTER SEQUENCE app_shema.coffee_settings_coffee_setting_id_seq OWNED BY app_shema.coffee_settings.coffee_setting_id;


--
-- Name: device_catalog_options; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.device_catalog_options (
    device_set_id integer NOT NULL,
    catalog_option_id integer NOT NULL
);


ALTER TABLE app_shema.device_catalog_options OWNER TO postgres;

--
-- Name: device_modules; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.device_modules (
    module_id integer NOT NULL,
    device_set_id integer NOT NULL,
    model_id character varying NOT NULL,
    production_date timestamp(0) without time zone NOT NULL
);


ALTER TABLE app_shema.device_modules OWNER TO postgres;

--
-- Name: device_sets; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.device_sets (
    device_set_id integer NOT NULL,
    production_date timestamp(0) without time zone NOT NULL,
    last_maintance_date timestamp(0) without time zone,
    owner_id integer NOT NULL,
    location_coords character varying
);


ALTER TABLE app_shema.device_sets OWNER TO postgres;

--
-- Name: licanced_coffee_settings; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.licanced_coffee_settings (
    coffee_setting_id integer NOT NULL,
    licance_begins timestamp(0) without time zone NOT NULL,
    licance_end timestamp(0) without time zone NOT NULL,
    sold_coffee_count integer,
    business_owner_id integer NOT NULL
);


ALTER TABLE app_shema.licanced_coffee_settings OWNER TO postgres;

--
-- Name: models; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.models (
    model_id character varying NOT NULL
);


ALTER TABLE app_shema.models OWNER TO postgres;

--
-- Name: non_licanced_coffee_settings; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.non_licanced_coffee_settings (
    coffee_setting_id integer NOT NULL,
    user_id integer
);


ALTER TABLE app_shema.non_licanced_coffee_settings OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.orders (
    coffee_setting_id integer NOT NULL,
    order_date timestamp(0) without time zone NOT NULL,
    device_set_id integer NOT NULL,
    order_finish_date timestamp(0) without time zone,
    order_id integer NOT NULL,
    user_id integer
);


ALTER TABLE app_shema.orders OWNER TO postgres;

--
-- Name: orders_in_queue; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.orders_in_queue (
    order_id integer NOT NULL
);


ALTER TABLE app_shema.orders_in_queue OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: app_shema; Owner: postgres
--

CREATE SEQUENCE app_shema.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_shema.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: app_shema; Owner: postgres
--

ALTER SEQUENCE app_shema.orders_order_id_seq OWNED BY app_shema.orders.order_id;


--
-- Name: telemetry_datas; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.telemetry_datas (
    telemtry_data_id integer NOT NULL,
    value real,
    telemtry_dataset_id integer NOT NULL,
    key character varying NOT NULL
);


ALTER TABLE app_shema.telemetry_datas OWNER TO postgres;

--
-- Name: telemtry_datasets; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.telemtry_datasets (
    telemtry_dataset_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    module_id integer
);


ALTER TABLE app_shema.telemtry_datasets OWNER TO postgres;

--
-- Name: tokens; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.tokens (
    token_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    expired_at timestamp(0) without time zone,
    ip_address character varying,
    token_value character varying
);


ALTER TABLE app_shema.tokens OWNER TO postgres;

--
-- Name: user_coffee_settings; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.user_coffee_settings (
    user_id integer NOT NULL,
    coffee_setting_id integer NOT NULL,
    user_rating integer,
    special_name character varying
);


ALTER TABLE app_shema.user_coffee_settings OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: app_shema; Owner: postgres
--

CREATE TABLE app_shema.users (
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    is_account_active boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE app_shema.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: app_shema; Owner: postgres
--

CREATE SEQUENCE app_shema.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_shema.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: app_shema; Owner: postgres
--

ALTER SEQUENCE app_shema.users_user_id_seq OWNED BY app_shema.users.user_id;


--
-- Name: coffee_settings coffee_setting_id; Type: DEFAULT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.coffee_settings ALTER COLUMN coffee_setting_id SET DEFAULT nextval('app_shema.coffee_settings_coffee_setting_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.orders ALTER COLUMN order_id SET DEFAULT nextval('app_shema.orders_order_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.users ALTER COLUMN user_id SET DEFAULT nextval('app_shema.users_user_id_seq'::regclass);


--
-- Data for Name: business_owner; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.business_owner VALUES
	(15, 'sdfsdfsg', 'Security Password'),
	(16, 'sdfvdf', 'svfav'),
	(36, 'Hexagon', '123123'),
	(38, '234', '543'),
	(14, 'asdasdsad', ''),
	(48, 'Yeni Kahveci', 'güvenli'),
	(50, 'Yeni şirket', 'asdasd');


--
-- Data for Name: catalog_options; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.catalog_options VALUES
	(1, 'My Coffee', 'hard', 1200, 1),
	(2, 'You Coffee', 'soft', 2345, 1),
	(3, 'White Milk', 'white', 2000, 2),
	(4, 'Heavy Milk', 'heavy', 1000, 2);


--
-- Data for Name: catalog_types; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.catalog_types VALUES
	(1, 'Coffee', NULL, NULL, 'gram'),
	(2, 'Milk', NULL, NULL, 'ml'),
	(3, 'Aroma', NULL, NULL, 'ml');


--
-- Data for Name: coffee_setting_options; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.coffee_setting_options VALUES
	(1, 1, 10),
	(3, 1, 200),
	(2, 2, 7),
	(4, 2, 150);


--
-- Data for Name: coffee_settings; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.coffee_settings VALUES
	('D', 'F', 15, 2),
	('A', 'B', 267, 1);


--
-- Data for Name: device_catalog_options; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.device_catalog_options VALUES
	(14, 1),
	(14, 2),
	(14, 3);


--
-- Data for Name: device_modules; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.device_modules VALUES
	(1, 14, 'expresso machine trx 3080', '1999-01-08 04:05:06'),
	(2, 14, 'grinder f300', '1999-01-08 04:05:06'),
	(3, 14, 'milk forter 3000', '1999-01-08 04:05:06');


--
-- Data for Name: device_sets; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.device_sets VALUES
	(14, '1999-01-08 04:05:06', '1999-01-08 04:05:06', 1, '212122');


--
-- Data for Name: licanced_coffee_settings; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.licanced_coffee_settings VALUES
	(1, '1999-01-08 04:05:06', '2021-01-08 04:05:06', 14, 14);


--
-- Data for Name: models; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.models VALUES
	('expresso machine trx 3080'),
	('grinder f300'),
	('milk forter 3000');


--
-- Data for Name: non_licanced_coffee_settings; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.non_licanced_coffee_settings VALUES
	(2, 44);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.orders VALUES
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 20:50:01', 18, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:28:47', 1, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:28:47', 4, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:28:47', 5, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:28:47', 6, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:28:47', 7, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:28:47', 8, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:28:47', 9, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:28:47', 12, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 19:30:28', 13, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 20:25:20', 14, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 20:25:20', 15, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 20:27:21', 16, NULL),
	(1, '1999-01-08 04:05:06', 14, '2020-12-30 20:39:33', 17, NULL);


--
-- Data for Name: orders_in_queue; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--



--
-- Data for Name: telemetry_datas; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.telemetry_datas VALUES
	(1, 78, 1, 'heat-sensor'),
	(2, 81, 1, 'heat-sensor2');


--
-- Data for Name: telemtry_datasets; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.telemtry_datasets VALUES
	(1, '2020-12-30 19:30:28', 1);


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--



--
-- Data for Name: user_coffee_settings; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.user_coffee_settings VALUES
	(1, 1, 233, NULL),
	(1, 2, 15, NULL),
	(7, 1, 300, NULL);


--
-- Data for Name: users; Type: TABLE DATA; Schema: app_shema; Owner: postgres
--

INSERT INTO app_shema.users VALUES
	('coffee_expert123', 'asdasd@gmail.com', 'dsad1d1d', true, 1),
	('coffee_ex', 'a34sd@gmaisdl.com', 'd24d1d', true, 8),
	('user', 'user@gmail.com', 'güncellendi', true, 48),
	('yeni user', 'yeni@mail', '1234567', true, 50),
	('dsfsdf', 'sdfsdf', 'dsfsdf', true, 15),
	('fdsfvsafd', 'fasdvfvsa', 'svadfvsd', true, 16),
	('sdfds', 'sdf', 'sdf654', true, 7),
	('Deneme1', 'Deneme1@gmail.com', 'lalala', true, 36),
	('asdf', 'asdasd', 'asdasd', false, 14),
	('babanana', 'babanana', 'ara', true, 38),
	('dddd', 'dmail', 'dddd', false, 41),
	('zzz', 'asdas', 'zzz', true, 44);


--
-- Name: coffee_settings_coffee_setting_id_seq; Type: SEQUENCE SET; Schema: app_shema; Owner: postgres
--

SELECT pg_catalog.setval('app_shema.coffee_settings_coffee_setting_id_seq', 2, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: app_shema; Owner: postgres
--

SELECT pg_catalog.setval('app_shema.orders_order_id_seq', 18, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: app_shema; Owner: postgres
--

SELECT pg_catalog.setval('app_shema.users_user_id_seq', 56, true);


--
-- Name: business_owner business_owner_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.business_owner
    ADD CONSTRAINT business_owner_pk PRIMARY KEY (business_owner_id);


--
-- Name: catalog_options catalog_options_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.catalog_options
    ADD CONSTRAINT catalog_options_pk PRIMARY KEY (catalog_option_id);


--
-- Name: catalog_types catalog_types_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.catalog_types
    ADD CONSTRAINT catalog_types_pk PRIMARY KEY (type_id);


--
-- Name: coffee_setting_options coffee_setting_options_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.coffee_setting_options
    ADD CONSTRAINT coffee_setting_options_pk PRIMARY KEY (catalog_option_id, coffee_setting_id);


--
-- Name: coffee_settings coffee_settings_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.coffee_settings
    ADD CONSTRAINT coffee_settings_pk PRIMARY KEY (coffee_setting_id);


--
-- Name: device_catalog_options device_catalog_options_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.device_catalog_options
    ADD CONSTRAINT device_catalog_options_pk PRIMARY KEY (device_set_id, catalog_option_id);


--
-- Name: device_modules device_modules_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.device_modules
    ADD CONSTRAINT device_modules_pk PRIMARY KEY (module_id);


--
-- Name: device_sets device_sets_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.device_sets
    ADD CONSTRAINT device_sets_pk PRIMARY KEY (device_set_id);


--
-- Name: licanced_coffee_settings licanced_coffee_settings_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.licanced_coffee_settings
    ADD CONSTRAINT licanced_coffee_settings_pk PRIMARY KEY (coffee_setting_id);


--
-- Name: models models_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.models
    ADD CONSTRAINT models_pk PRIMARY KEY (model_id);


--
-- Name: non_licanced_coffee_settings non_licanced_coffee_settings_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.non_licanced_coffee_settings
    ADD CONSTRAINT non_licanced_coffee_settings_pk PRIMARY KEY (coffee_setting_id);


--
-- Name: orders_in_queue orders_in_queue_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.orders_in_queue
    ADD CONSTRAINT orders_in_queue_pk PRIMARY KEY (order_id);


--
-- Name: orders orders_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.orders
    ADD CONSTRAINT orders_pk PRIMARY KEY (order_id);


--
-- Name: telemetry_datas telemetry_datas_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.telemetry_datas
    ADD CONSTRAINT telemetry_datas_pk PRIMARY KEY (telemtry_data_id, telemtry_dataset_id);


--
-- Name: telemtry_datasets telemtry_datasets_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.telemtry_datasets
    ADD CONSTRAINT telemtry_datasets_pk PRIMARY KEY (telemtry_dataset_id);


--
-- Name: tokens tokens_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.tokens
    ADD CONSTRAINT tokens_pk PRIMARY KEY (token_id, user_id);


--
-- Name: user_coffee_settings user_coffee_settings_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.user_coffee_settings
    ADD CONSTRAINT user_coffee_settings_pk PRIMARY KEY (user_id, coffee_setting_id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.users
    ADD CONSTRAINT users_pk PRIMARY KEY (user_id);


--
-- Name: users users_un; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.users
    ADD CONSTRAINT users_un UNIQUE (email);


--
-- Name: users users_un_1; Type: CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.users
    ADD CONSTRAINT users_un_1 UNIQUE (username);


--
-- Name: orders new_order; Type: TRIGGER; Schema: app_shema; Owner: postgres
--

CREATE TRIGGER new_order AFTER INSERT ON app_shema.orders FOR EACH ROW EXECUTE FUNCTION app_shema.new_order();


--
-- Name: orders_in_queue order_is_ready; Type: TRIGGER; Schema: app_shema; Owner: postgres
--

CREATE TRIGGER order_is_ready AFTER DELETE ON app_shema.orders_in_queue FOR EACH ROW EXECUTE FUNCTION app_shema.order_is_ready();


--
-- Name: orders sold_coffee_count_update; Type: TRIGGER; Schema: app_shema; Owner: postgres
--

CREATE TRIGGER sold_coffee_count_update AFTER UPDATE ON app_shema.orders FOR EACH ROW EXECUTE FUNCTION app_shema.sold_coffee_count();


--
-- Name: user_coffee_settings update_global_rating; Type: TRIGGER; Schema: app_shema; Owner: postgres
--

CREATE TRIGGER update_global_rating AFTER INSERT OR UPDATE ON app_shema.user_coffee_settings FOR EACH ROW EXECUTE FUNCTION app_shema.calculate_general_rating();


--
-- Name: business_owner business_owner_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.business_owner
    ADD CONSTRAINT business_owner_fk FOREIGN KEY (business_owner_id) REFERENCES app_shema.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: catalog_options catalog_options_fk_2; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.catalog_options
    ADD CONSTRAINT catalog_options_fk_2 FOREIGN KEY (type_id) REFERENCES app_shema.catalog_types(type_id);


--
-- Name: catalog_types catalog_types_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.catalog_types
    ADD CONSTRAINT catalog_types_fk FOREIGN KEY (needed_module) REFERENCES app_shema.models(model_id);


--
-- Name: coffee_setting_options coffee_setting_options_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.coffee_setting_options
    ADD CONSTRAINT coffee_setting_options_fk FOREIGN KEY (coffee_setting_id) REFERENCES app_shema.coffee_settings(coffee_setting_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: coffee_setting_options coffee_setting_options_fk_1; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.coffee_setting_options
    ADD CONSTRAINT coffee_setting_options_fk_1 FOREIGN KEY (catalog_option_id) REFERENCES app_shema.catalog_options(catalog_option_id);


--
-- Name: device_catalog_options device_catalog_options_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.device_catalog_options
    ADD CONSTRAINT device_catalog_options_fk FOREIGN KEY (device_set_id) REFERENCES app_shema.device_sets(device_set_id);


--
-- Name: device_catalog_options device_catalog_options_fk_1; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.device_catalog_options
    ADD CONSTRAINT device_catalog_options_fk_1 FOREIGN KEY (catalog_option_id) REFERENCES app_shema.catalog_options(catalog_option_id);


--
-- Name: device_modules device_modules_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.device_modules
    ADD CONSTRAINT device_modules_fk FOREIGN KEY (device_set_id) REFERENCES app_shema.device_sets(device_set_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: device_modules device_modules_fk_1; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.device_modules
    ADD CONSTRAINT device_modules_fk_1 FOREIGN KEY (model_id) REFERENCES app_shema.models(model_id);


--
-- Name: device_sets device_sets_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.device_sets
    ADD CONSTRAINT device_sets_fk FOREIGN KEY (device_set_id) REFERENCES app_shema.business_owner(business_owner_id);


--
-- Name: licanced_coffee_settings licanced_coffee_settings_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.licanced_coffee_settings
    ADD CONSTRAINT licanced_coffee_settings_fk FOREIGN KEY (coffee_setting_id) REFERENCES app_shema.coffee_settings(coffee_setting_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: licanced_coffee_settings licanced_coffee_settings_fk_1; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.licanced_coffee_settings
    ADD CONSTRAINT licanced_coffee_settings_fk_1 FOREIGN KEY (business_owner_id) REFERENCES app_shema.business_owner(business_owner_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: non_licanced_coffee_settings non_licanced_coffee_settings_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.non_licanced_coffee_settings
    ADD CONSTRAINT non_licanced_coffee_settings_fk FOREIGN KEY (user_id) REFERENCES app_shema.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: non_licanced_coffee_settings non_licanced_coffee_settings_fk_1; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.non_licanced_coffee_settings
    ADD CONSTRAINT non_licanced_coffee_settings_fk_1 FOREIGN KEY (coffee_setting_id) REFERENCES app_shema.coffee_settings(coffee_setting_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.orders
    ADD CONSTRAINT orders_fk FOREIGN KEY (coffee_setting_id) REFERENCES app_shema.coffee_settings(coffee_setting_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_fk_1; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.orders
    ADD CONSTRAINT orders_fk_1 FOREIGN KEY (device_set_id) REFERENCES app_shema.device_sets(device_set_id);


--
-- Name: orders orders_fk_2; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.orders
    ADD CONSTRAINT orders_fk_2 FOREIGN KEY (user_id) REFERENCES app_shema.users(user_id);


--
-- Name: orders_in_queue orders_in_queue_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.orders_in_queue
    ADD CONSTRAINT orders_in_queue_fk FOREIGN KEY (order_id) REFERENCES app_shema.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: telemetry_datas telemetry_datas_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.telemetry_datas
    ADD CONSTRAINT telemetry_datas_fk FOREIGN KEY (telemtry_dataset_id) REFERENCES app_shema.telemtry_datasets(telemtry_dataset_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: telemtry_datasets telemtry_datasets_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.telemtry_datasets
    ADD CONSTRAINT telemtry_datasets_fk FOREIGN KEY (module_id) REFERENCES app_shema.device_modules(module_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tokens tokens_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.tokens
    ADD CONSTRAINT tokens_fk FOREIGN KEY (user_id) REFERENCES app_shema.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_coffee_settings user_coffee_settings_fk; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.user_coffee_settings
    ADD CONSTRAINT user_coffee_settings_fk FOREIGN KEY (user_id) REFERENCES app_shema.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_coffee_settings user_coffee_settings_fk_1; Type: FK CONSTRAINT; Schema: app_shema; Owner: postgres
--

ALTER TABLE ONLY app_shema.user_coffee_settings
    ADD CONSTRAINT user_coffee_settings_fk_1 FOREIGN KEY (coffee_setting_id) REFERENCES app_shema.coffee_settings(coffee_setting_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

