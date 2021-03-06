PGDMP     7    (                x           ssahi017    11.6    12.0 7               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    232318    ssahi017    DATABASE     f   CREATE DATABASE ssahi017 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE ssahi017;
                ssahi017    false                       0    0    DATABASE ssahi017    ACL     0   GRANT CONNECT ON DATABASE ssahi017 TO mhard023;
                   ssahi017    false    3353                        2615    832162    courseproject    SCHEMA        CREATE SCHEMA courseproject;
    DROP SCHEMA courseproject;
                ssahi017    false            �            1259    832163    account    TABLE     8  CREATE TABLE courseproject.account (
    user_id integer NOT NULL,
    street_address character varying(100),
    city character varying(100),
    province character(2),
    first_name character varying(50),
    middle_name character varying(50),
    last_name character varying(50),
    email_address character varying(50),
    phone_num character(10),
    CONSTRAINT account_province_check CHECK ((province = ANY (ARRAY['ON'::bpchar, 'QC'::bpchar, 'NS'::bpchar, 'NB'::bpchar, 'MB'::bpchar, 'BC'::bpchar, 'PE'::bpchar, 'SK'::bpchar, 'AB'::bpchar, 'NL'::bpchar])))
);
 "   DROP TABLE courseproject.account;
       courseproject            ssahi017    false    7                       0    0    TABLE account    ACL     Y   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.account TO mhard023;
          courseproject          ssahi017    false    198            �            1259    832308    branch    TABLE     s   CREATE TABLE courseproject.branch (
    branch_id integer NOT NULL,
    overseen_country character varying(100)
);
 !   DROP TABLE courseproject.branch;
       courseproject            ssahi017    false    7                       0    0    TABLE branch    ACL     X   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.branch TO mhard023;
          courseproject          ssahi017    false    205            �            1259    832313    employee    TABLE     �  CREATE TABLE courseproject.employee (
    employee_id integer NOT NULL,
    street_address character varying(100),
    city character varying(100),
    province character(2),
    first_name character varying(50),
    middle_name character varying(50),
    last_name character varying(50),
    email_address character varying(50),
    phone_num character(10),
    salary numeric(14,2),
    job_position character varying(50),
    branch_id integer,
    manager_id integer
);
 #   DROP TABLE courseproject.employee;
       courseproject            ssahi017    false    7                       0    0    TABLE employee    ACL     Z   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.employee TO mhard023;
          courseproject          ssahi017    false    206            �            1259    832170    host    TABLE     9   CREATE TABLE courseproject.host (
    host_id integer
);
    DROP TABLE courseproject.host;
       courseproject            ssahi017    false    7                       0    0 
   TABLE host    ACL     V   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.host TO mhard023;
          courseproject          ssahi017    false    199            �            1259    832275    payment    TABLE     �   CREATE TABLE courseproject.payment (
    payment_id integer NOT NULL,
    amount numeric(6,2),
    payment_type character varying(20),
    payment_status character varying(20),
    ra_id integer,
    host_id integer
);
 "   DROP TABLE courseproject.payment;
       courseproject            ssahi017    false    7                       0    0    TABLE payment    ACL     Y   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.payment TO mhard023;
          courseproject          ssahi017    false    203            �            1259    832229    pricing    TABLE     �   CREATE TABLE courseproject.pricing (
    price numeric(6,2) NOT NULL,
    num_guests integer NOT NULL,
    rules character varying(500) NOT NULL,
    property_id integer NOT NULL
);
 "   DROP TABLE courseproject.pricing;
       courseproject            ssahi017    false    7                        0    0    TABLE pricing    ACL     Y   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.pricing TO mhard023;
          courseproject          ssahi017    false    201            �            1259    832206    property    TABLE     �  CREATE TABLE courseproject.property (
    property_id integer NOT NULL,
    street_address character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    province character(2) NOT NULL,
    property_type character varying(50) NOT NULL,
    room_type character varying(50) NOT NULL,
    accomodates integer,
    amenities character varying(200),
    bathrooms integer NOT NULL,
    bedrooms integer NOT NULL,
    beds character varying(100),
    host_id integer
);
 #   DROP TABLE courseproject.property;
       courseproject            ssahi017    false    7            !           0    0    TABLE property    ACL     Z   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.property TO mhard023;
          courseproject          ssahi017    false    200            �            1259    832249    rentalagreement    TABLE       CREATE TABLE courseproject.rentalagreement (
    ra_id integer NOT NULL,
    signing_date date,
    start_date date NOT NULL,
    end_date date NOT NULL,
    price numeric(6,2),
    num_guests integer,
    rules character varying(500),
    property_id integer,
    user_id integer
);
 *   DROP TABLE courseproject.rentalagreement;
       courseproject            ssahi017    false    7            "           0    0    TABLE rentalagreement    ACL     a   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.rentalagreement TO mhard023;
          courseproject          ssahi017    false    202            �            1259    832288    reviews    TABLE     �   CREATE TABLE courseproject.reviews (
    user_id integer NOT NULL,
    property_id integer NOT NULL,
    rating integer NOT NULL,
    feedback character varying(500)
);
 "   DROP TABLE courseproject.reviews;
       courseproject            ssahi017    false    7            #           0    0    TABLE reviews    ACL     Y   GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE courseproject.reviews TO mhard023;
          courseproject          ssahi017    false    204                      0    832163    account 
   TABLE DATA           �   COPY courseproject.account (user_id, street_address, city, province, first_name, middle_name, last_name, email_address, phone_num) FROM stdin;
    courseproject          ssahi017    false    198   �G                 0    832308    branch 
   TABLE DATA           D   COPY courseproject.branch (branch_id, overseen_country) FROM stdin;
    courseproject          ssahi017    false    205   BH                 0    832313    employee 
   TABLE DATA           �   COPY courseproject.employee (employee_id, street_address, city, province, first_name, middle_name, last_name, email_address, phone_num, salary, job_position, branch_id, manager_id) FROM stdin;
    courseproject          ssahi017    false    206   _H                 0    832170    host 
   TABLE DATA           .   COPY courseproject.host (host_id) FROM stdin;
    courseproject          ssahi017    false    199   |H                 0    832275    payment 
   TABLE DATA           j   COPY courseproject.payment (payment_id, amount, payment_type, payment_status, ra_id, host_id) FROM stdin;
    courseproject          ssahi017    false    203   �H                 0    832229    pricing 
   TABLE DATA           O   COPY courseproject.pricing (price, num_guests, rules, property_id) FROM stdin;
    courseproject          ssahi017    false    201   �H                 0    832206    property 
   TABLE DATA           �   COPY courseproject.property (property_id, street_address, city, province, property_type, room_type, accomodates, amenities, bathrooms, bedrooms, beds, host_id) FROM stdin;
    courseproject          ssahi017    false    200   �H                 0    832249    rentalagreement 
   TABLE DATA           �   COPY courseproject.rentalagreement (ra_id, signing_date, start_date, end_date, price, num_guests, rules, property_id, user_id) FROM stdin;
    courseproject          ssahi017    false    202   !I                 0    832288    reviews 
   TABLE DATA           P   COPY courseproject.reviews (user_id, property_id, rating, feedback) FROM stdin;
    courseproject          ssahi017    false    204   >I       r           2606    832169    account account_user_id_key 
   CONSTRAINT     `   ALTER TABLE ONLY courseproject.account
    ADD CONSTRAINT account_user_id_key UNIQUE (user_id);
 L   ALTER TABLE ONLY courseproject.account DROP CONSTRAINT account_user_id_key;
       courseproject            ssahi017    false    198            �           2606    832312    branch branch_branch_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY courseproject.branch
    ADD CONSTRAINT branch_branch_id_key UNIQUE (branch_id);
 L   ALTER TABLE ONLY courseproject.branch DROP CONSTRAINT branch_branch_id_key;
       courseproject            ssahi017    false    205            �           2606    832317 !   employee employee_employee_id_key 
   CONSTRAINT     j   ALTER TABLE ONLY courseproject.employee
    ADD CONSTRAINT employee_employee_id_key UNIQUE (employee_id);
 R   ALTER TABLE ONLY courseproject.employee DROP CONSTRAINT employee_employee_id_key;
       courseproject            ssahi017    false    206            t           2606    832205    host host_host_id_key 
   CONSTRAINT     Z   ALTER TABLE ONLY courseproject.host
    ADD CONSTRAINT host_host_id_key UNIQUE (host_id);
 F   ALTER TABLE ONLY courseproject.host DROP CONSTRAINT host_host_id_key;
       courseproject            ssahi017    false    199            |           2606    832236    pricing pricing_property_id_key 
   CONSTRAINT     h   ALTER TABLE ONLY courseproject.pricing
    ADD CONSTRAINT pricing_property_id_key UNIQUE (property_id);
 P   ALTER TABLE ONLY courseproject.pricing DROP CONSTRAINT pricing_property_id_key;
       courseproject            ssahi017    false    201            v           2606    832213 )   property property_property_id_host_id_key 
   CONSTRAINT     {   ALTER TABLE ONLY courseproject.property
    ADD CONSTRAINT property_property_id_host_id_key UNIQUE (property_id, host_id);
 Z   ALTER TABLE ONLY courseproject.property DROP CONSTRAINT property_property_id_host_id_key;
       courseproject            ssahi017    false    200    200            x           2606    832228 !   property property_property_id_key 
   CONSTRAINT     j   ALTER TABLE ONLY courseproject.property
    ADD CONSTRAINT property_property_id_key UNIQUE (property_id);
 R   ALTER TABLE ONLY courseproject.property DROP CONSTRAINT property_property_id_key;
       courseproject            ssahi017    false    200            z           2606    832248 "   property property_property_id_key1 
   CONSTRAINT     k   ALTER TABLE ONLY courseproject.property
    ADD CONSTRAINT property_property_id_key1 UNIQUE (property_id);
 S   ALTER TABLE ONLY courseproject.property DROP CONSTRAINT property_property_id_key1;
       courseproject            ssahi017    false    200            ~           2606    832274 )   rentalagreement rentalagreement_ra_id_key 
   CONSTRAINT     l   ALTER TABLE ONLY courseproject.rentalagreement
    ADD CONSTRAINT rentalagreement_ra_id_key UNIQUE (ra_id);
 Z   ALTER TABLE ONLY courseproject.rentalagreement DROP CONSTRAINT rentalagreement_ra_id_key;
       courseproject            ssahi017    false    202            �           2606    832297    reviews reviews_property_id_key 
   CONSTRAINT     h   ALTER TABLE ONLY courseproject.reviews
    ADD CONSTRAINT reviews_property_id_key UNIQUE (property_id);
 P   ALTER TABLE ONLY courseproject.reviews DROP CONSTRAINT reviews_property_id_key;
       courseproject            ssahi017    false    204            �           2606    832295    reviews reviews_user_id_key 
   CONSTRAINT     `   ALTER TABLE ONLY courseproject.reviews
    ADD CONSTRAINT reviews_user_id_key UNIQUE (user_id);
 L   ALTER TABLE ONLY courseproject.reviews DROP CONSTRAINT reviews_user_id_key;
       courseproject            ssahi017    false    204            �           2606    832318     employee employee_branch_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.employee
    ADD CONSTRAINT employee_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES courseproject.branch(branch_id);
 Q   ALTER TABLE ONLY courseproject.employee DROP CONSTRAINT employee_branch_id_fkey;
       courseproject          ssahi017    false    3204    206    205            �           2606    832323 !   employee employee_manager_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.employee
    ADD CONSTRAINT employee_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES courseproject.employee(employee_id);
 R   ALTER TABLE ONLY courseproject.employee DROP CONSTRAINT employee_manager_id_fkey;
       courseproject          ssahi017    false    206    3206    206            �           2606    832173    host host_host_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.host
    ADD CONSTRAINT host_host_id_fkey FOREIGN KEY (host_id) REFERENCES courseproject.account(user_id);
 G   ALTER TABLE ONLY courseproject.host DROP CONSTRAINT host_host_id_fkey;
       courseproject          ssahi017    false    199    198    3186            �           2606    832283    payment payment_host_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.payment
    ADD CONSTRAINT payment_host_id_fkey FOREIGN KEY (host_id) REFERENCES courseproject.host(host_id);
 M   ALTER TABLE ONLY courseproject.payment DROP CONSTRAINT payment_host_id_fkey;
       courseproject          ssahi017    false    3188    199    203            �           2606    832278    payment payment_ra_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.payment
    ADD CONSTRAINT payment_ra_id_fkey FOREIGN KEY (ra_id) REFERENCES courseproject.rentalagreement(ra_id);
 K   ALTER TABLE ONLY courseproject.payment DROP CONSTRAINT payment_ra_id_fkey;
       courseproject          ssahi017    false    203    3198    202            �           2606    832237     pricing pricing_property_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.pricing
    ADD CONSTRAINT pricing_property_id_fkey FOREIGN KEY (property_id) REFERENCES courseproject.property(property_id);
 Q   ALTER TABLE ONLY courseproject.pricing DROP CONSTRAINT pricing_property_id_fkey;
       courseproject          ssahi017    false    200    3192    201            �           2606    832214    property property_host_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.property
    ADD CONSTRAINT property_host_id_fkey FOREIGN KEY (host_id) REFERENCES courseproject.host(host_id);
 O   ALTER TABLE ONLY courseproject.property DROP CONSTRAINT property_host_id_fkey;
       courseproject          ssahi017    false    200    3188    199            �           2606    832255 0   rentalagreement rentalagreement_property_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.rentalagreement
    ADD CONSTRAINT rentalagreement_property_id_fkey FOREIGN KEY (property_id) REFERENCES courseproject.property(property_id);
 a   ALTER TABLE ONLY courseproject.rentalagreement DROP CONSTRAINT rentalagreement_property_id_fkey;
       courseproject          ssahi017    false    202    3192    200            �           2606    832260 ,   rentalagreement rentalagreement_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.rentalagreement
    ADD CONSTRAINT rentalagreement_user_id_fkey FOREIGN KEY (user_id) REFERENCES courseproject.account(user_id);
 ]   ALTER TABLE ONLY courseproject.rentalagreement DROP CONSTRAINT rentalagreement_user_id_fkey;
       courseproject          ssahi017    false    3186    202    198            �           2606    832303     reviews reviews_property_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.reviews
    ADD CONSTRAINT reviews_property_id_fkey FOREIGN KEY (property_id) REFERENCES courseproject.property(property_id);
 Q   ALTER TABLE ONLY courseproject.reviews DROP CONSTRAINT reviews_property_id_fkey;
       courseproject          ssahi017    false    200    204    3192            �           2606    832298    reviews reviews_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY courseproject.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES courseproject.account(user_id);
 M   ALTER TABLE ONLY courseproject.reviews DROP CONSTRAINT reviews_user_id_fkey;
       courseproject          ssahi017    false    3186    198    204               8   x�340�42T,MM�S.)JM-��/)I,O��CC\�F�&�0��
c���� }��            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �         >   x�35�41Qp�)MU.��/)I,O����L,H,*�M�+�,�H,JM��!C ��b���� 8g�            x������ � �            x������ � �     