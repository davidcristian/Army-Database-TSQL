USE [army]
GO

-- START INSERT

INSERT INTO [locations]
	([precise], [latitude], [longitude], [desc])
VALUES
	(1, 46.7833642, 23.5463014, 'Cluj-Napoca'),
	(1, 47.8030943, 22.8134306, 'Satu Mare'),
	(1, 44.4378042, 26.0244264, 'Bucharest'),
	(1, 50.401951, 30.3922657, 'Kyiv'),
	(1, 55.5807419, 36.8237724, 'Moscow'),
	(1, 52.5200066, 13.404954, 'Berlin'),
	(1, 48.8566969, 2.3514616, 'Paris'),
	(1, 51.5073219, -0.1276474, 'London'),
	(1, 40.4167754, -3.7037902, 'Madrid'),
	(1, 41.9027835, 12.4963655, 'Rome'),
	(1, 41.0082376, 28.9783589, 'Istanbul'),
	(1, 52.2296756, 21.0122287, 'Warsaw'),
	(1, 48.2083537, 16.3725042, 'Vienna'),
	(1, 50.0755381, 14.4378005, 'Prague'),
	(1, 59.3293235, 18.0685808, 'Stockholm'),
	(1, 52.3702157, 4.8951679, 'Amsterdam'),
	(1, 60.1698557, 24.9383791, 'Helsinki'),
	(1, 47.1561159, 27.5167593, 'Iasi')



INSERT INTO [award_type]
	([name])
VALUES
	('ribbon'),
	('medal')


INSERT INTO [awards]
	([atid], [desc], [abbr])
VALUES
	(1, 'Medal of Honor', 'MOH'),
	(1, 'Army Distinguished Service Cross', 'ADSC'),
	(1, 'Navy Cross', 'NC'),
	(1, 'Air Force Cross', 'AFC'),
	(1, 'Distinguished Service Medal', 'DSM'),
	(1, 'Navy Distinguished Service Medal', 'NDSM'),
	(1, 'Air Force Distinguished Service Medal', 'AFDSM'),
	(1, 'Silver Star', 'SS'),
	(1, 'Legion of Merit', 'LM'),
	(1, 'Distinguished Flying Cross', 'DFC'),
	(1, 'Bronze Star Medal', 'BSM'),
	(1, 'Air Medal', 'AM'),
	(1, 'Purple Heart', 'PH'),
	(1, 'Defense Superior Service Medal', 'DSSM'),
	(1, 'Navy and Marine Corps Medal', 'NMCM'),
	(1, 'Air Force Cross Medal', 'AFCM'),
	(1, 'Meritorious Service Medal', 'MSM'),
	(1, 'Navy and Marine Corps Commendation Medal', 'NMCCM'),
	(1, 'Air Force Commendation Medal', 'AFCM'),
	(1, 'Joint Service Commendation Medal', 'JSCM'),
	(1, 'Army Commendation Medal', 'ACM'),
	(1, 'Army Achievement Medal', 'AAM'),
	(1, 'Joint Meritorious Unit Award', 'JMUA'),
	(1, 'Meritorious Unit Commendation', 'MUC'),
	(1, 'Army Good Conduct Medal', 'AGCM'),
	(1, 'National Defense Service Medal', 'NDSM'),
	(1, 'Armed Forces Expeditionary Medal', 'AFEM'),
	(2, 'Army Service Ribbon', 'ASR'),
	(2, 'Army Overseas Service Ribbon', 'AOSR'),
	(2, 'Army Reserve Components Achievement Medal', 'ARCAM'),
	(2, 'Army Reserve Components Overseas Training Ribbon', 'ARCOTR'),
	(2, 'Air Force Recognition Ribbon', 'AFRR'),
	(2, 'Air Force Longevity Service Award', 'AFLSA'),
	(2, 'Air Force Overseas Short Tour Service Ribbon', 'AFOSSTR'),
	(2, 'Air Force Overseas Long Tour Service Ribbon', 'AFOSLTR'),
	(2, 'Air Force Outstanding Unit Award', 'AFOUA'),
	(2, 'Air Force Good Conduct Medal', 'AFGCM'),
	(2, 'Air Force Expeditionary Service Ribbon', 'AFESR'),
	(2, 'Air Force Combat Action Medal', 'AFCAM'),
	(2, 'Air Force Basic Military Training Ribbon', 'AFBMT'),
	(2, 'Air Force Achievement Medal', 'AFA')


INSERT INTO [equipment_category]
	([name])
VALUES
	('weapon'),
	('ammunition'),
	('explosive'),
	('medicine'),
	('nutrition'),
	('hydration'),
	('communication'),
	('clothing'),
	('miscellaneous')


INSERT INTO [equipment]
	([ecid], [desc])
VALUES
	(1, 'M9 Pistol'),
	(2, '9mm'),
	(1, 'M4A1 Carbine'),
	(2, '5.56x45mm'),
	(1, 'M240B Machine Gun'),
	(2, '7.62x51mm'),
	(1, 'M136 AT4'),
	(2, 'Rocket Projectile'),
	(3, 'M18 Claymore'),
	(3, 'M67 Frag Grenade'),
	(3, 'M18 Smoke Grenade'),
	(4, 'First Aid Kit'),
	(4, 'Combat Gauze'),
	(4, 'Tourniquet'),
	(4, 'Morphine'),
	(4, 'Adrenaline'),
	(4, 'Epinephrine'),
	(5, 'MRE'),
	(6, '500ML Water Bottle'),
	(7, 'Radio'),
	(8, 'Uniform'),
	(8, 'Bulletproof Vest'),
	(8, 'Tactical Backpack'),
	(9, 'Compass'),
	(9, 'Knife'),
	(9, 'Flashlight')


INSERT INTO [disputes]
	([lid], [dsd], [ded], [desc])
VALUES
	(1, ('20190101 12:01:05 AM'), NULL, 'World War I'),
	(2, ('20200202 01:02:10 AM'), NULL, 'World War II'),
	(3, ('20210303 02:03:15 AM'), NULL, 'World War III'),
	(4, ('20220404 03:04:20 AM'), ('20220927 08:24:35 AM'), 'World War IV')


INSERT INTO [persons]
	([ssn], [fname], [lname], [sex], [height], [weight], [pob], [dob], [pod], [dod])
VALUES
	(1000, 'John', 'Smith', 'M', 185, 80, 1, ('19800101 01:00:00 AM'), NULL, NULL),
	(1001, 'Jane', 'Williams', 'F', 165, 60, 2, ('19810202 02:00:00 AM'), NULL, NULL),
	(1002, 'Liam', 'Brown', 'M', 175, 70, 3, ('19820303 03:00:00 AM'), NULL, NULL),
	(1003, 'Olivia', 'Jones', 'F', 165, 60, 4, ('19830404 04:00:00 AM'), NULL, NULL),
	(1004, 'Noah', 'Garcia', 'M', 185, 80, 5, ('19840505 05:00:00 AM'), NULL, NULL),
	(1005, 'Emma', 'Miller', 'F', 165, 60, 6, ('19850606 06:00:00 AM'), NULL, NULL),
	(1006, 'Oliver', 'Davis', 'M', 175, 70, 7, ('19860707 07:00:00 AM'), NULL, NULL),
	(1007, 'Amelia', 'Rodriguez', 'F', 165, 60, 8, ('19870808 08:00:00 AM'), NULL, NULL),
	(1008, 'Elijah', 'Martinez', 'M', 185, 80, 9, ('19880909 09:00:00 AM'), NULL, NULL),
	(1009, 'Ava', 'Hernandez', 'F', 165, 60, 10, ('19891010 10:00:00 AM'), NULL, NULL),
	(1010, 'James', 'Lopez', 'M', 175, 70, 11, ('19901111 11:00:00 AM'), NULL, NULL),
	(1011, 'Sophia', 'Gonzalez', 'F', 165, 60, 12, ('19911212 12:00:00 PM'), NULL, NULL),
	(1012, 'William', 'Wilson', 'M', 185, 80, 13, ('19920113 01:00:00 PM'), NULL, NULL),
	(1013, 'Isabella', 'Anderson', 'F', 165, 60, 14, ('19930214 02:00:00 PM'), NULL, NULL),
	(1014, 'Benjamin', 'Thomas', 'M', 175, 70, 15, ('19940315 03:00:00 PM'), NULL, NULL),
	(1015, 'Luna', 'Taylor', 'F', 165, 60, 16, ('19950416 04:00:00 PM'), NULL, NULL),
	(1016, 'Lucas', 'Moore', 'M', 185, 80, 17, ('19960517 05:00:00 PM'), NULL, NULL),
	(1017, 'Mia', 'Jackson', 'F', 165, 60, 1, ('19970618 06:00:00 PM'), NULL, NULL),
	(1018, 'Henry', 'Martin', 'M', 175, 70, 2, ('19980719 07:00:00 PM'), NULL, NULL),
	(1019, 'Charlotte', 'Lee', 'F', 165, 60, 3, ('19990820 08:00:00 PM'), NULL, NULL),
	(1020, 'Theodore', 'Perez', 'M', 185, 80, 4, ('20000921 09:00:00 PM'), NULL, NULL),
	(1021, 'Evelyn', 'Thompson', 'F', 165, 60, 5, ('20011022 10:00:00 PM'), NULL, NULL),
	(1022, 'Logan', 'White', 'M', 175, 70, 6, ('20021123 11:00:00 PM'), NULL, NULL),
	(1023, 'Harper', 'Harris', 'F', 165, 60, 7, ('20031224 12:00:00 AM'), NULL, NULL),
	(1024, 'Lincoln', 'Sanchez', 'M', 185, 80, 8, ('20040125 01:00:00 AM'), NULL, NULL),
	(1025, 'Scarlett', 'Clark', 'F', 165, 60, 9, ('20050226 02:00:00 AM'), NULL, NULL),
	(1026, 'Alexander', 'Ramirez', 'M', 195, 80, 10, ('20000327 03:00:00 AM'), NULL, NULL),
	(1028, 'Sebastian', 'Robinson', 'M', 200, 85, 11, ('20000529 05:00:00 AM'), NULL, NULL),
	(1029, 'Aria', 'Lewis', 'F', 50, 10, 12, ('20220630 06:00:00 AM'), NULL, NULL)


INSERT INTO [ranks]
	([name], [abbr], [salary], [currency])
VALUES
	('Private', 'PVT', 150, 'EUR'),
	('Private First Class', 'PFC', 200, 'CAD'),
	('Specialist', 'SPC', 500, 'USD'),
	('Corporal', 'CPL', 600, 'USD'),
	('Sergeant', 'SGT', 700, 'USD'),
	('Staff Sergeant', 'SSG', 800, 'USD'),
	('Sergeant First Class', 'SFC', 900, 'USD'),
	('Master Sergeant', 'MSG', 1000, 'USD'),
	('First Sergeant', '1SG', 1100, 'USD'),
	('Sergeant Major', 'SGM', 1200, 'USD'),
	('Command Sergeant Major', 'CSM', 1300, 'USD'),
	('Sergeant Major of the Army', 'SMA', 1400, 'USD'),
	('Senior Enlisted Advisor to the Chairman', 'SEAC', 1500, 'USD')


INSERT INTO [soldiers]
	([ssn], [rid], [sos], [eos])
VALUES
	(1000, 13, ('19980102 08:00:00 AM'), NULL),
	(1001, 12, ('19990203 08:00:00 AM'), NULL),
	(1002, 11, ('20000304 08:00:00 AM'), NULL),
	(1003, 10, ('20010405 08:00:00 AM'), NULL),
	(1004, 9, ('20020506 08:00:00 AM'), NULL),
	(1005, 8, ('20030607 08:00:00 AM'), NULL),
	(1006, 7, ('20040708 08:00:00 AM'), NULL),
	(1007, 6, ('20050809 08:00:00 AM'), NULL),
	(1008, 6, ('20060910 08:00:00 AM'), NULL),
	(1009, 5, ('20071011 08:00:00 AM'), NULL),
	(1010, 5, ('20081112 08:00:00 AM'), NULL),
	(1011, 5, ('20091213 08:00:00 AM'), NULL),
	(1012, 4, ('20100114 08:00:00 AM'), NULL),
	(1013, 4, ('20110215 08:00:00 AM'), NULL),
	(1014, 4, ('20120316 08:00:00 AM'), NULL),
	(1015, 4, ('20130417 08:00:00 AM'), NULL),
	(1016, 3, ('20140518 08:00:00 AM'), NULL),
	(1017, 3, ('20150619 08:00:00 AM'), NULL),
	(1018, 3, ('20160720 08:00:00 AM'), NULL),
	(1019, 3, ('20170821 08:00:00 AM'), NULL),
	(1020, 2, ('20180922 08:00:00 AM'), NULL),
	(1021, 2, ('20191023 08:00:00 AM'), NULL),
	(1022, 2, ('20201124 08:00:00 AM'), NULL),
	(1023, 2, ('20211225 08:00:00 AM'), NULL),
	(1024, 1, ('20220126 08:00:00 AM'), NULL)


-- skipping [desc] for now, default value is ''
INSERT INTO [decorations]
	([ssn], [aid])
VALUES
	(1000, 1),
	(1000, 2),
	(1000, 3),
	(1000, 4),
	(1000, 5),
	(1000, 6),
	(1000, 7),
	(1000, 8),
	(1000, 9),
	(1000, 10),

	(1001, 1),
	(1001, 2),
	(1001, 3),
	(1001, 4),
	(1001, 5),
	(1001, 6),
	(1001, 8),

	(1002, 1),
	(1002, 2),
	(1002, 3),
	(1002, 4),
	(1002, 5),
	(1002, 6),

	(1003, 1),
	(1003, 2),
	(1003, 3),
	(1003, 4),

	(1004, 1),
	(1004, 2),
	(1004, 3),
	(1004, 4),

	(1005, 1),
	(1005, 2),
	(1005, 3),

	(1006, 1),
	(1006, 2),
	(1006, 3),

	(1007, 1),
	(1007, 2),
	(1008, 1),
	(1008, 2),

	(1009, 1),
	(1010, 1),
	(1011, 1)


INSERT INTO [inventories]
	([ssn], [eid], [quantity])
VALUES
	-- Sergeants
	-- EQUIPMENT
	(1009, 20, 1),
	(1009, 21, 1),
	(1009, 22, 1),
	(1009, 23, 1),
	(1009, 24, 1),
	(1009, 25, 1),
	(1009, 26, 1),
	-- ARMAMENT
	(1009, 1, 1),
	(1009, 2, 45),
	(1009, 3, 1),
	(1009, 4, 120),
	(1009, 10, 2),
	(1009, 11, 1),
	-- MRE
	(1009, 18, 2),
	-- WATER
	(1009, 19, 4),

	-- EQUIPMENT
	(1010, 20, 1),
	(1010, 21, 1),
	(1010, 22, 1),
	(1010, 23, 1),
	(1010, 24, 1),
	(1010, 25, 1),
	(1010, 26, 1),
	-- ARMAMENT
	(1010, 1, 1),
	(1010, 2, 45),
	(1010, 3, 1),
	(1010, 4, 90),
	(1010, 9, 2),
	-- MRE
	(1010, 18, 1),
	-- WATER
	(1010, 19, 3),

	-- EQUIPMENT
	(1011, 20, 1),
	(1011, 21, 1),
	(1011, 22, 1),
	(1011, 23, 1),
	(1011, 24, 1),
	(1011, 25, 1),
	(1011, 26, 1),
	-- ARMAMENT
	(1011, 1, 1),
	(1011, 2, 45),
	(1011, 3, 1),
	(1011, 4, 90),
	-- MEDICAL
	(1011, 12, 1),
	(1011, 13, 4),
	(1011, 14, 1),
	(1011, 15, 1),
	(1011, 16, 2),
	(1011, 17, 1),
	-- MRE
	(1011, 18, 1),
	-- WATER
	(1011, 19, 3),

	-- Corporals
	-- EQUIPMENT
	(1012, 20, 1),
	(1012, 21, 1),
	(1012, 22, 1),
	(1012, 23, 1),
	(1012, 24, 1),
	(1012, 25, 1),
	(1012, 26, 1),
	-- ARMAMENT
	(1012, 1, 1),
	(1012, 2, 45),
	(1012, 7, 1),
	(1012, 8, 3),
	-- MRE
	(1012, 18, 2),
	-- WATER
	(1012, 19, 3),

	-- EQUIPMENT
	(1013, 20, 1),
	(1013, 21, 1),
	(1013, 22, 1),
	(1013, 23, 1),
	(1013, 24, 1),
	(1013, 25, 1),
	(1013, 26, 1),
	-- ARMAMENT
	(1013, 1, 1),
	(1013, 2, 45),
	(1013, 7, 1),
	(1013, 8, 3),
	-- MRE
	(1013, 18, 2),
	-- WATER
	(1013, 19, 3),

	-- EQUIPMENT
	(1014, 20, 1),
	(1014, 21, 1),
	(1014, 22, 1),
	(1014, 23, 1),
	(1014, 24, 1),
	(1014, 25, 1),
	(1014, 26, 1),
	-- ARMAMENT
	(1014, 1, 1),
	(1014, 2, 45),
	(1014, 7, 1),
	(1014, 8, 3),
	-- MRE
	(1014, 18, 2),
	-- WATER
	(1014, 19, 3),

	-- EQUIPMENT
	(1015, 20, 1),
	(1015, 21, 1),
	(1015, 22, 1),
	(1015, 23, 1),
	(1015, 24, 1),
	(1015, 25, 1),
	(1015, 26, 1),
	-- ARMAMENT
	(1015, 1, 1),
	(1015, 2, 45),
	(1015, 7, 1),
	(1015, 8, 3),
	-- MRE
	(1015, 18, 2),
	-- WATER
	(1015, 19, 3),

	-- Specialists
	-- EQUIPMENT
	(1016, 20, 1),
	(1016, 21, 1),
	(1016, 22, 1),
	(1016, 23, 1),
	(1016, 24, 1),
	(1016, 25, 1),
	(1016, 26, 1),
	-- ARMAMENT
	(1016, 1, 1),
	(1016, 2, 45),
	(1016, 3, 1),
	(1016, 4, 90),
	-- MEDICAL
	(1016, 12, 1),
	(1016, 13, 4),
	(1016, 14, 1),
	(1016, 15, 1),
	(1016, 16, 2),
	(1016, 17, 1),
	-- MRE
	(1016, 18, 1),
	-- WATER
	(1016, 19, 2),

	-- EQUIPMENT
	(1017, 20, 1),
	(1017, 21, 1),
	(1017, 22, 1),
	(1017, 23, 1),
	(1017, 24, 1),
	(1017, 25, 1),
	(1017, 26, 1),
	-- ARMAMENT
	(1017, 1, 1),
	(1017, 2, 45),
	(1017, 3, 1),
	(1017, 4, 90),
	-- MEDICAL
	(1017, 12, 1),
	(1017, 13, 4),
	(1017, 14, 1),
	(1017, 15, 1),
	(1017, 16, 2),
	(1017, 17, 1),
	-- MRE
	(1017, 18, 1),
	-- WATER
	(1017, 19, 2),

	-- EQUIPMENT
	(1018, 20, 1),
	(1018, 21, 1),
	(1018, 22, 1),
	(1018, 23, 1),
	(1018, 24, 1),
	(1018, 25, 1),
	(1018, 26, 1),
	-- ARMAMENT
	(1018, 1, 1),
	(1018, 2, 45),
	(1018, 3, 1),
	(1018, 4, 90),
	-- MEDICAL
	(1018, 12, 1),
	(1018, 13, 4),
	(1018, 14, 1),
	(1018, 15, 1),
	(1018, 16, 2),
	(1018, 17, 1),
	-- MRE
	(1018, 18, 1),
	-- WATER
	(1018, 19, 2),

	-- EQUIPMENT
	(1019, 20, 1),
	(1019, 21, 1),
	(1019, 22, 1),
	(1019, 23, 1),
	(1019, 24, 1),
	(1019, 25, 1),
	(1019, 26, 1),
	-- ARMAMENT
	(1019, 1, 1),
	(1019, 2, 45),
	(1019, 3, 1),
	(1019, 4, 90),
	-- MEDICAL
	(1019, 12, 1),
	(1019, 13, 4),
	(1019, 14, 1),
	(1019, 15, 1),
	(1019, 16, 2),
	(1019, 17, 1),
	-- MRE
	(1019, 18, 1),
	-- WATER
	(1019, 19, 2),

	-- Privates
	-- EQUIPMENT
	(1020, 20, 1),
	(1020, 21, 1),
	(1020, 22, 1),
	(1020, 23, 1),
	(1020, 24, 1),
	(1020, 25, 1),
	(1020, 26, 1),
	-- ARMAMENT
	(1020, 1, 1),
	(1020, 2, 30),
	(1020, 5, 1),
	(1020, 6, 600),
	(1020, 10, 1),
	-- MRE
	(1020, 18, 1),
	-- WATER
	(1020, 19, 2),

	-- EQUIPMENT
	(1021, 20, 1),
	(1021, 21, 1),
	(1021, 22, 1),
	(1021, 23, 1),
	(1021, 24, 1),
	(1021, 25, 1),
	(1021, 26, 1),
	-- ARMAMENT
	(1021, 1, 1),
	(1021, 2, 30),
	(1021, 5, 1),
	(1021, 6, 600),
	(1021, 10, 1),
	-- MRE
	(1021, 18, 1),
	-- WATER
	(1021, 19, 2),

	-- EQUIPMENT
	(1022, 20, 1),
	(1022, 21, 1),
	(1022, 22, 1),
	(1022, 23, 1),
	(1022, 24, 1),
	(1022, 25, 1),
	(1022, 26, 1),
	-- ARMAMENT
	(1022, 1, 1),
	(1022, 2, 30),
	(1022, 5, 1),
	(1022, 6, 600),
	(1022, 10, 1),
	-- MRE
	(1022, 18, 1),
	-- WATER
	(1022, 19, 2),

	-- EQUIPMENT
	(1023, 20, 1),
	(1023, 21, 1),
	(1023, 22, 1),
	(1023, 23, 1),
	(1023, 24, 1),
	(1023, 25, 1),
	(1023, 26, 1),
	-- ARMAMENT
	(1023, 1, 1),
	(1023, 2, 30),
	(1023, 5, 1),
	(1023, 6, 600),
	(1023, 10, 1),
	-- MRE
	(1023, 18, 1),
	-- WATER
	(1023, 19, 2),

	-- EQUIPMENT
	(1024, 20, 1),
	(1024, 21, 1),
	(1024, 22, 1),
	(1024, 23, 1),
	(1024, 24, 1),
	(1024, 25, 1),
	(1024, 26, 1),
	-- ARMAMENT
	(1024, 1, 1),
	(1024, 2, 30),
	(1024, 5, 1),
	(1024, 6, 600),
	(1024, 10, 1),
	-- MRE
	(1024, 18, 1),
	-- WATER
	(1024, 19, 2)


INSERT INTO [squads]
	([ssn], [disid], [dsd], [ded], [sergeant])
VALUES
	(1009, 1, '20190102 12:01:05 AM', '20200417 04:08:25 PM', 1009),
	(1012, 1, '20190102 12:01:05 AM', '20200417 04:08:25 PM', 1009),
	(1016, 1, '20190102 12:01:05 AM', '20200417 04:08:25 PM', 1009),
	(1020, 1, '20190102 12:01:05 AM', '20200417 04:08:25 PM', 1009),

	(1010, 1, '20190102 12:05:10 AM', NULL, 1010),
	(1013, 1, '20190102 12:05:10 AM', NULL, 1010),
	(1017, 1, '20190102 12:05:10 AM', NULL, 1010),
	(1021, 1, '20190102 12:05:10 AM', NULL, 1010),

	(1011, 2, '20190102 12:10:15 AM', NULL, 1011),
	(1014, 2, '20190102 12:10:15 AM', NULL, 1011),
	(1018, 2, '20190102 12:10:15 AM', NULL, 1011),
	(1022, 2, '20190102 12:10:15 AM', NULL, 1011),

	(1009, 2, '20200203 12:01:05 AM', NULL, 1009),
	(1015, 2, '20200203 12:01:05 AM', NULL, 1009),
	(1019, 2, '20200203 12:01:05 AM', NULL, 1009),
	(1023, 2, '20200203 12:01:05 AM', NULL, 1009)


-- END INSERT

-- REFERENCE ERROR
-- INSERT INTO [soldiers]
-- VALUES
-- 	(999, 1, '20220101 08:00:00 AM', NULL)
