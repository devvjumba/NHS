create database NHS_completed;

select * from [dbo].[HES_Wide]

-- Profiling where certain columns are examined for anomalous data. For example, distinct values are found to match the descriptions from the data dictionary. Then any values
--that fall out this range are eliminated. Another example would be using max/min functions, which determine which quantiative values fall out the range from the 
--data dictionary. 
Select bedyear from [dbo].[HES_Wide]

select distinct epitype from [dbo].[HES_Wide]

select distinct sex from [dbo].[HES_Wide]

SELECT Distinct bedyear from [dbo].[HES_Wide]
where bedyear > 300

SELECT Distinct epidur from [dbo].[HES_Wide]
where epidur > 29200

SELECT min(epidur), max(epidur) from [dbo].[HES_Wide]

SELECT Distinct epistat from [dbo].[HES_Wide]

SELECT Distinct spellbgin from [dbo].[HES_Wide]

SELECT Distinct admincat from [dbo].[HES_Wide]

SELECT Distinct admincatst from [dbo].[HES_Wide]

SELECT Distinct category from [dbo].[HES_Wide]

SELECT DOB from [dbo].[HES_Wide]

SELECT Distinct ethnos from [dbo].[HES_Wide]

SELECT MAX(hesid), MIN(hesid) FROM [dbo].[HES_Wide]

SELECT Distinct leglcat from [dbo].[HES_Wide]

SELECT mydob FROM [dbo].[HES_Wide]

SELECT newnhsno FROM [dbo].[HES_Wide]
WHERE newnhsno <= '999999999'

SELECT newnhsno_check from [dbo].[HES_Wide]

SELECT admistart from [dbo].[HES_Wide]

SELECT admimeth from [dbo].[HES_Wide]

SELECT MAX(elecdur_calc), MIN(elecdur_calc) from [dbo].[HES_Wide]
SELECT DISTINCT elecdur_calc FROM [dbo].[HES_Wide]

SELECT DISTINCT classpat FROM [dbo].[HES_Wide]

SELECT * FROM [dbo].[HES_Wide]
/*-------------------------------------*/

---This ensures the date format remains in the day/month/year structure when uploaded as a CSV file into SQL. This is because SQL's default setting is in the American format,
--epistart, epiend and dob are cast as date to change them from text so they have a consistent year/month/day format.
set dateformat dmy
SELECT [spell]
      ,[episode]
      ,[epiorder]
	  ,cast([epistart] as date) EpiStart1 
	  ,cast([epiend] as date) EpiEnd1
      ,[epitype]
      ,[sex]
      ,[bedyear]
      ,[epidur]
      ,[epistat]
      ,[spellbgin]
      ,[activage]
      ,[admiage]
      ,[admincat]
      ,[admincatst]
      ,[category]
	  ,cast(dob as date) DOB1
      ,[endage]
      ,[ethnos]
      ,[hesid]
      ,[leglcat]
      ,[lopatid]
      ,[newnhsno]
      ,[newnhsno_check]
      ,[startage]
	  ,cast([admistart] as date) AdmiStart1 
      ,[admimeth]
      ,[admisorc]
	  ,cast([elecdate] as date) ElecDate1
      ,[elecdur]
      ,[elecdur_calc]
      ,[classpat]
      ,[diag_01]
	  INTO HES_F

  FROM [NHS_completed].[dbo].[HES_Wide]

  select * from HES_F
  ---------------------------------------------

--- This section is cleansing the data by adding leading zeros to the administrative categories as-well as returning nulls to values that fall out the range from the data
--dictionary provided.
  UPDATE [dbo].[HES_F] 
SET [admincat] = '01'
WHERE [admincat] = '1'

UPDATE [dbo].[HES_F]
SET [admincat] = '02'
WHERE [admincat] = '2'

UPDATE [dbo].[HES_F] 
SET [admincat] = '03'
WHERE [admincat] = '3'

UPDATE [dbo].[HES_F]
SET [admincat] = '04'
WHERE [admincat] = '4'

UPDATE [dbo].[HES_F] 
SET [admincatst] = '01'
WHERE [admincatst] = '1'

UPDATE [dbo].[HES_F]
SET [admincatst] = '02'
WHERE [admincatst] = '2'

UPDATE [dbo].[HES_F] 
SET [admincatst] = '03'
WHERE [admincatst] = '3'

UPDATE [dbo].[HES_F]
SET [admincatst] = '04'
WHERE [admincatst] = '4'

--removes '0' with nulls
update [dbo].[HES_F]
set [epitype] = null
where [epitype] = 0

--newnhsno must be 10 characters, hence anything shorter should return as a null
UPDATE [dbo].[HES_F]
SET newnhsno = null
WHERE LEN(newnhsno)<10
 
UPDATE [dbo].[HES_F]
SET newnhsno = null
WHERE ISNUMERIC(newnhsno) <> 1
 
 
UPDATE [dbo].[HES_F]
SET elecdur_calc = null
WHERE elecdur_calc = 9999 OR elecdur_calc = 9998

UPDATE [dbo].[HES_F]
SET endage = NULL
WHERE endage = ''

UPDATE [dbo].[HES_F]
SET ethnos = NULL
WHERE ethnos = ''

--replace false dates with nulls
Update [dbo].[HES_F]
SET DOB1 =NULL
WHERE DOB1= '01/01/1800'

Update [dbo].[HES_F]
SET DOB1 = NULL
WHERE DOB1= '01/01/1801'

Update [dbo].[HES_F]
SET EpiStart1 =NULL
WHERE EpiStart1 = '01/01/1800'

Update [dbo].[HES_F]
SET EpiStart1 =NULL
WHERE EpiStart1= '01/01/1801'

Update [dbo].[HES_F]
SET EpiEnd1 =NULL
WHERE EpiEnd1= '01/01/1800'

Update [dbo].[HES_F]
SET EpiEnd1 =NULL
WHERE EpiEnd1= '01/01/1801'

Update [dbo].[HES_F]
SET [AdmiStart1] =NULL
WHERE [AdmiStart1]= '01/01/1800'

Update [dbo].[HES_F]
SET [AdmiStart1] =NULL
WHERE [AdmiStart1]= '01/01/1801'

Update [dbo].[HES_F]
SET [ElecDate1] =NULL
WHERE [ElecDate1]= '01/01/1800'

Update [dbo].[HES_F]
SET [ElecDate1] =NULL
WHERE [ElecDate1]= '01/01/1801'

-------------------------------------------------------------------

set dateformat dmy
--creates new table with columns that have been profiled and cleansed so it is easier to handle later. 
SELECT [spell]
      ,[episode]
      ,[epiorder]
      ,[EpiStart1]
      ,[EpiEnd1]
      ,[epitype]
      ,[sex]
      ,[bedyear]
      ,[epidur]
      ,[epistat]
      ,[spellbgin]
      ,[activage]
      ,[admiage]
      ,[admincat]
      ,[admincatst]
      ,[category]
      ,[DOB1]
      ,[endage]
      ,[ethnos]
      ,[hesid]
      ,[leglcat]
      ,[lopatid]
      ,[newnhsno]
      ,[newnhsno_check]
      ,[startage]
      ,[AdmiStart1]
      ,[admimeth]
      ,[admisorc]
      ,[ElecDate1]
      ,[elecdur]
      ,[elecdur_calc]
      ,[classpat]
      ,[diag_01]
	  INTO HES_Completed
  FROM [NHS_completed].[dbo].[HES_F]

  SELECT * FROM HES_Completed

--------------------------------------------------------------------------------------------------------
--Creating tables with primary keys for all the columns. In these tables, the code falls next to the description, so when a query is executed, it can find the result by
--using these new tables containing keys. Only column headings found in the data dictionary with descriptions were used to create the tables. 


create table epitype_t (epi_code int not null primary key, [Episode Description] varchar (320))
insert into epitype_t (epi_code, [Episode Description])
VALUES ('1', 'General episode'),
('2', 'Delivery episode'),
('3', 'Birth episode'),
('4', 'Formally detained under the provisions of mental health legislation or long-term (over one year)
psychiatric patients who should have additional information recorded on the psychiatric census. This value can only appear in unfinished 
records (Episode Status (EPISTAT) = 1)'),
('5','Other delivery event'),
('6','Other birth event')

create table sex_t (sex_code int not null primary key, [Gender] varchar (20))
insert into sex_t (sex_code, [Gender])
VALUES ('1', 'Male'),
('2', 'Female'),
('9', 'Not specified'),
('0', 'Not known')

create table epistat_t (epistat_code int not null primary key, [status] varchar (320))
insert into epistat_t (epistat_code, [status])
VALUES ('1', 'Unfinished'),
('3', 'Finished'),
('9', 'Derived unfinished (not present on processed data')

create table admincat_t (admincat_code int not null primary key, [Patient Type] varchar (300))
insert into admincat_t (admincat_code, [Patient Type])
VALUES ('01', ' NHS patient, including overseas visitors charged under Section 121 of the
NHS Act 1977 as amended by Section 7(12) and (14) of the Health and Medicine
Act 1988.'),
('02', ' Private patient: one who uses accommodation or services authorised under
section 65 and/or 66 of the NHS Act 1977 (Section 7(10) of Health and Medicine
Act 1988 refers) as amended by Section 26 of the National Health Service and
Community Care Act 1990'),
('03','Amenity patient: one who pays for the use of a single room or small ward in
accord with section 12 of the NHS Act 1977, as amended by section 7(12) and (14)
of the Health and Medicine Act 1988.'),
('04','A category II patient: one for whom work is undertaken by hospital medical or
dental staff within categories II as defined in paragraph 37 of the Terms and
Conditions of Service of Hospital Medical and Dental Staff.'),
('98','Not applicable'),
('99','Not known:a validation error')


create table category_t (category_code int not null primary key, [Administrative & legal status of patient] varchar (300))
insert into category_t (category_code, [Administrative & legal status of patient])
VALUES ('10', ' NHS patient: not formally detained'),
('11', ' NHS patient: formally detained under Part II of the Mental Health Act 1983 '),
('12','NHS patient: formally detained under Part III of the Mental Health Act 1983 or
under other Acts'),
('13','NHS patient: formally detained under part X, Mental Health Act 1983*'),
('20','Private patient: not formally detained'),
('21','Private patient: formally detained under Part II of the Mental Health Act 1983'),
('22','Private patient: formally detained under Part III of the Mental Health Act 1983
or under other Acts'),
('23','Private patient: formally detained under part X, Mental health Act 1983*'), 
('30','Amenity patient: not formally detained'),
('31','Amenity patient: formally detained under Part II of the Mental Health Act 1983'),
('32','Amenity patient: formally detained under Part III of the Mental Health Act
1983 or under other Acts'),
('33','Amenity patient: formally detained under part X, Mental health Act 1983*')

create table endage_t (endage_code int not null primary key, [Age at end of episode] varchar (300))
insert into endage_t (endage_code, [Age at end of episode])
VALUES ('7001', 'Less than 1 day'),
('7002', ' NHS patient: formally detained under Part II of the Mental Health Act 1983 '),
('7003','7 to 28 days'),
('7004','29 to 90 days (under 3 months)'),
('7005','91 to 181 days (approximately 3 months to under 6 months)'),
('7006','182 to 272 days (approximately 6 months to under 9 months)'),
('7007', '273 to 365 days (approximately 9 months to under 1 year)')

CREATE TABLE ethnos_t (enthnos_code varchar(300) NOT NULL PRIMARY KEY, [Ethnic category] varchar (300))
INSERT INTO ethnos_t (enthnos_code, [Ethnic category])
VALUES ('A', 'British (White)'),
('B', 'Irish (White)'),
('C', 'Any other White background'),
('D', 'White and Black Caribbean (Mixed)'), 
('E', 'White and Black African (Mixed)'),
('F', 'White and Asian (Mixed)'),
('G', 'Any other Mixed background'),    
('H', 'Indian (Asian or Asian British)'),
('J', 'Pakistani (Asian or Asian British)'),
('K', 'Bangladeshi (Asian or Asian British)'), 
('L','Any other Asian background'), 
('M', 'Caribbean (Black or Black British)'), 
('N', 'African (Black or Black British)'),
('P', 'Any other Black background'), 
('R', 'Chinese (other ethnic group)'),
('S', 'Any other ethnic group'), 
('Z', 'Not stated'),
('X', 'Not known (prior to 2013)'), 
('0', 'White'), 
('1','Black - Caribbean'),
('2','Black - African'),
('3','Black - Other'),
('4','Indian'),
('5','Pakistani'),
('6','Bangladeshi'),
('7','Chinese'),
('8','Any other ethnic group'),
('9','Not given'),
('99','Not known')


CREATE TABLE admimeth_t (admimeth_code CHAR(2) NOT NULL PRIMARY KEY, [Admimeth Description] VARCHAR(1000))
INSERT INTO admimeth_t ([admimeth_code], [Admimeth Description])
VALUES  ('11', 'Waiting list. . A Patient admitted electively from a waiting list having been given no date of admission at a time a decision was made to admit'),
  ('12', 'Booked. A Patient admitted having been given a date at the time the decision to admit was made, determined mainly on the grounds of resource availability'),
  ('13', 'Planned. A Patient admitted, having been given a date or approximate date at the time that the decision to admit was made. This is usually part of a planned sequence of clinical care determined mainly on social or clinical criteria (e.g. check cystoscopy). A planned admission is one where the date of admission is determined by the needs of the treatment, rather than by the availability of resources.'),
  ('21', 'Accident and emergency or dental casualty department of the Health Care Provider'),
  ('22', 'General Practitioner: after a request for immediate admission has been made direct to a Hospital Provider, i.e. not through a Bed bureau, by a General Practitioner: or deputy'),
  ('23', 'Bed bureau'),
  ('24', 'Consultant Clinic, of this or another Health Care Provider'), 
  ('25', 'Admission via Mental Health Crisis Resolution Team (available from 2013/14)'),
  ('2A', 'Accident and Emergency Department of another provider where the patient had not been admitted (available from 2013/14)'),
  ('2B', 'Transfer of an admitted patient from another Hospital Provider in an emergency (available from 2013/14)'),
  ('2C', 'Baby born at home as intended (available from 2013/14)'),
  ('2D', 'Other emergency admission (available from 2013/14)'),
  ('28', 'Other means, examples are:
 [Admitted from the Accident and Emergency Department of another provider where they had not been admitted],
 [Transfer of an admitted patient from another Hospital Provider in an emergency],
 [Baby born at home as intended]')

CREATE TABLE AdminCatST_t
(
AdminCatST_Code CHAR(2) NOT NULL PRIMARY KEY,
[Description] VARCHAR(50) NOT NULL
)
INSERT INTO AdminCatST_t(AdminCatST_Code, [Description])
VALUES('01', 'NHS patient'),
('02', 'Private patient'),
('03', 'Amenity patient'),
('04', 'Category II patient'),
('98', 'Not applicable'),
('99', 'Not known: a validation error')

CREATE TABLE AdmiSorc_T
(
AdmiSorc_Code CHAR(2) NOT NULL PRIMARY KEY,
[Description] VARCHAR(1000) NOT NULL
)
INSERT INTO AdmiSorc_T(AdmiSorc_Code, [Description])
VALUES('19', 'The usual place of residence, unless listed below, for example, a private dwelling whether owner occupied or owned by Local Authority, housing association or other landlord. This includes wardened accommodation but not residential accommodation where health care is provided. It also includes PATIENTS with no fixed abode.'),
   ('29', 'Temporary place of residence when usually resident elsewhere, for example, hotels and residential educational establishments'),
      ('30', 'Repatriation from high security psychiatric hospital (1999-00 to 2006-07)'), 
      ('37', 'Penal establishment: court (1999-00 to 2006-07)'),
      ('38', 'Penal establishment: police station (1999-00 to 2006-07)'),
      ('39', 'Penal establishment, Court or Police Station /  Police Custody Suite'),
      ('48', 'High security psychiatric hospital, Scotland (1999-00 to 2006-07)'),
      ('49', 'NHS other hospital provider: high security psychiatric accommodation in an NHS hospital provider (NHS trust or NHS Foundation Trust)'),
      ('50', 'NHS other hospital provider: medium secure unit (1999-00 to 2006-07)'),
      ('51', 'NHS other hospital provider: ward for general patients or the younger physically disabled or A&E department'),
      ('52', 'NHS other hospital provider: ward for maternity patients or neonates'),
      ('53', 'NHS other hospital provider: ward for patients who are mentally ill or have learning disabilities'),
      ('54', 'NHS run Care Home'),
      ('65', 'Local authority residential accommodation i.e. where care is provided'),
      ('66', 'Local authority foster care, but not in residential accommodation i.e. where care is provided'),
      ('69', 'Local authority home or care (1989-90 to 1995-96)'),
      ('79', 'Babies born in or on the way to hospital'),
      ('85', 'Non-NHS (other than Local Authority) run care home'),
      ('86', 'Non-NHS (other than Local Authority) run nursing home'),
      ('87', 'Non-NHS run hospital'),
      ('88', 'Non-NHS (other than Local Authority) run hospice'),
      ('89', 'Non-NHS institution (1989-90 to 1995-96)'),
      ('98', 'Not applicable'),
      ('99', 'Not known')

CREATE TABLE ElecDur_T
(
ElecDur_Code CHAR(4) NOT NULL PRIMARY KEY,
[Error Description] VARCHAR(100) NOT NULL
)
INSERT INTO ElecDur_T(ElecDur_Code, [Error Description])
VALUES('9998', 'Not applicable'),
   ('9999', 'Not known (i.e no date known for decision to admit): a validation error')
 
 
CREATE TABLE EpiOrder_T
(
EpiOrder_Code CHAR(2) NOT NULL PRIMARY KEY,
[Error Description] VARCHAR(100) NOT NULL
)
INSERT INTO EpiOrder_T(EpiOrder_Code, [Error Description])
VALUES('98', 'Not applicable'),
   ('99', 'Not known: a validation error')

CREATE TABLE NEWNHSCHECK_NO_t (Valid_NHS_Number_Check CHAR(2) NOT NULL PRIMARY KEY, [Valid] VARCHAR(3))
INSERT INTO  NEWNHSCHECK_NO_t (Valid_NHS_Number_Check, [Valid])
VALUES  ('Y', 'Yes'),
  ('N', 'No')
CREATE TABLE StartAge_T
(
StartAge_Code CHAR(4) NOT NULL PRIMARY KEY,
[Age in Days] VARCHAR(100) NOT NULL
)
INSERT INTO StartAge_T(StartAge_Code, [Age in Days])
VALUES('7001', 'Less than 1 day'),
   ('7002', '1 to 6 days'),
   ('7003', '7 to 28 days'),
   ('7004', '29 to 90 days (under 3 months)'),
   ('7005', '91 to 181 days (approximately 3 month to under 6 months)'),
   ('7006', '182 to 272 days (approximately 6 months to under 9 months)'),
   ('7007', '273 days to 364 days (approximately 9 months to under 1 year)')

 
   
   CREATE TABLE LegalCategoryOfPatient (LeglCat CHAR(2)  NOT NULL PRIMARY KEY, LeglCatDescription TEXT)
INSERT INTO LegalCategoryOfPatient (LeglCat, LeglCatDescription)
VALUES 
('01', 'Informal'),  
('02','Formally detained under the Mental Health Act, Section 2'),  
('03','Formally detained under the Mental Health Act, Section 3'),  
('04','Formally detained under the Mental Health Act, Section 4'),  
('05','Formally detained under the Mental Health Act, Section 5(2)'),  
('06','Formally detained under the Mental Health Act, Section 5(4)'), 
('07','Formally detained under the Mental Health Act, Section 35'),
('08','Formally detained under the Mental Health Act, Section 36'),
('09','Formally detained under the Mental Health Act, Section 37 with Section 41 restrictions'),
('10','Formally detained under the Mental Health Act, Section 37 excluding Section 37(4)'),
('11','Formally detained under the Mental Health Act, Section 37(4)'),
('12','Formally detained under the Mental Health Act, Section 38'),
('13','Formally detained under the Mental Health Act, Section 44'),
('14','Formally detained under the Mental Health Act, Section 46'),
('15','Formally detained under the Mental Health Act, Section 47 with Section 49 restrictions'),
('16','Formally detained under the Mental Health Act, Section 47'),
('17','Formally detained under the Mental Health Act, Section 48 with Section 49 restrictions'),
('18','Formally detained under the Mental Health Act, Section 48'),
('19','Formally detained under the Mental Health Act, Section 135'),
('20','Formally detained under the Mental Health Act, Section 136'),  
('21','Formally detained under the previous legislation (fifth schedule)'),
('22','Formally detained under Criminal Procedure (Insanity) Act 1964 as amended by the Criminal Procedures (Insanity and Unfitness to Plead) Act 1991'),
('23','Formally detained under other Acts'),
('24','Supervised discharge under the Mental Health (Patients in the Community) Act 1995'),
('25','Formally detained under the Mental Health Act, Section 45A'),
('26','Not applicable'),
('27','Not known')

CREATE TABLE PatientClassification (ClassPat CHAR(1) NOT NULL PRIMARY KEY, PatientClassificationDesc TEXT)
INSERT INTO PatientClassification (ClassPat, PatientClassificationDesc)
VALUES
('1','Ordinary admission'),
('2','Day case admission'),
('3','Regular day attender'),  
('4','Regular night attender'),
('5','Mothers and babies using only delivery facilities'),
('8','Not applicable (other maternity event)'),
('9','Not known')


SELECT * FROM EpiOrder_T


--Imported diagnosis codes table as an excel file.
-----------------------------------
--This changes the data types for the columns, and gives character limits as defined from the data dictionary. 
ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [Spell] CHAR(1);
 
ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [Episode] CHAR(1);

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [EpiOrder] CHAR(2);

/* should be converted to '01' according to data dictionary. Therefore, has to be CHAR as float and int doesn't allow the
data to start with 0 when it's a numerical type */


ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [EpiStart1] Date
/* we would need to change to UK date, 'datetime' was converted to date as time was not relevant it would also
take up more memory space and reduce efficiency (will also slow down other users in database)
 and datetime is a legacy function
'datetime2' would be used in a case where date and time is needed. We need to clean the dates that are previous to the date
recognised by SQL as a null. */

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [EpiEnd1] Date;
/* see comment above */

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [epitype] CHAR(1)

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [sex] CHAR(1)


ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [bedyear] INT;
/* convert from float to integer as float could take up from 32-64 bytes while integer takes up 32 bytes. Taking up less memory
and making it more efficient */

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [epidur] INT;
/* see above comment */

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [epistat] CHAR(1);
/* CHAR as it's fixed in length as it is only ever 1 character and we've changed from FLOAT which is numerical to a string value
as there will be no calculations performed. We've chosen CHAR(1) because the field has a character length of 1 */

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [spellbgin] CHAR(1);

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [activage] VARCHAR(3);
/* VARCHAR(3) as the input of the age may vary from age 1 to 100 years (for example) with differing characters. */

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [admiage] VARCHAR(3);

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [admincat] CHAR(2);

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [admincatst] CHAR(2);

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [category] CHAR(2);

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [DOB1] Date;

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [endage] VARCHAR(4);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [ethnos]VARCHAR(2);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [hesid] CHAR(12);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [leglcat] CHAR(2);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [lopatid] CHAR(12);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [newnhsno] CHAR(12);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [newnhsno_check] CHAR(2);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [startage] VARCHAR(4);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [AdmiStart1] DATE;

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [admimeth] CHAR(2);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [admisorc] CHAR(2);

 ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [ElecDate1] DATE;

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [elecdur] INT;

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [elecdur_calc] INT;

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [classpat] CHAR(1);

ALTER TABLE [dbo].[HES_Completed]
ALTER COLUMN [diag_01] VARCHAR(6);

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [USAGE_UK] VARCHAR (7)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [CODE] VARCHAR (10)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [ALT_CODE] VARCHAR (5)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [USAGE] VARCHAR (8)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [EndAge_Code] VARCHAR (100)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [status] CHAR (8)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [ethnos_code] CHAR (1)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [Ethnic category] VARCHAR (50)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [LeglCatDescription] VARCHAR (200)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [PatientClassificationDesc] VARCHAR (30)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [StartAge_Code] CHAR (4)


---------------------------------------------------------
--Now that the data types have been changed, they must be joined. The left outer join was used to allow for nulls in the main table. 
SELECT *
INTO HES_Completed1
FROM [dbo].[HES_Completed] AS A
LEFT OUTER JOIN [dbo].[admimeth_t] As B
ON A.admimeth = B.admimeth_code 

LEFT OUTER JOIN [dbo].[admincat_t] As C
ON A.admincat = C.admincat_code

LEFT OUTER JOIN [dbo].[AdminCatST_t] As D
ON A.admincatst = D.adminCatST_code

LEFT OUTER JOIN [dbo].[AdmiSorc_T] As E
ON A.admisorc = E.AdmiSorc_code

LEFT OUTER JOIN [dbo].[category_t] As F
ON A.category = F.category_code

LEFT OUTER JOIN [dbo].[DiagnosisCodes] As G
ON A.diag_01 = G.CODE

LEFT OUTER JOIN [dbo].[ElecDur_T] As H
ON A.elecdur = H.ElecDur_Code

LEFT OUTER JOIN [dbo].[endage_t] As I
ON A.endage = I.endage_Code

LEFT OUTER JOIN [dbo].[EpiOrder_T] As J
ON A.epiorder = J.EpiOrder_Code

LEFT OUTER JOIN [dbo].[epistat_t] As K
ON A.epistat = K.Epistat_Code

LEFT OUTER JOIN [dbo].[epitype_t] As L
ON A.epitype = L.Epi_Code

LEFT OUTER JOIN [dbo].[ethnos_t] As M
ON A.ethnos = M.Ethnos_Code

LEFT OUTER JOIN [dbo].[LegalCategoryOfPatient] As N
ON A.leglcat = N.leglcat_code

LEFT OUTER JOIN [dbo].[NEWNHSCHECK_NO_t] As O
ON A.newnhsno_check = O.Valid_NHS_Number_Check

LEFT OUTER JOIN [dbo].[PatientClassification] As P
ON A.classpat = P.ClassPat_code

LEFT OUTER JOIN [dbo].[sex_t] As Q
ON A.sex = Q.sex_code

LEFT OUTER JOIN [dbo].[StartAge_T] As R
ON A.startage = R.StartAge_Code

SELECT * FROM HES_Completed

----------------------------------
ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [USAGE_UK] VARCHAR (7)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [CODE] VARCHAR (10)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [ALT_CODE] VARCHAR (5)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [USAGE] VARCHAR (8)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [Age at end of episode] VARCHAR (100)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [status] CHAR (8)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [ethnos_code] CHAR (1)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [Ethnic category] VARCHAR (50)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [LeglCatDescription] VARCHAR (200)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [PatientClassificationDesc] VARCHAR (30)

ALTER TABLE [dbo].[HES_Completed1]
ALTER COLUMN [Age in Days] CHAR (4)

SELECT * FROM HES_Completed1

/*--------------------------------------------------------*/
--This is the second stage of profiling. This is done to give a comparision of data quality for before and after the cleansing. The same steps are repeated from the first
--stage
Select bedyear from [dbo].[HES_Completed1]

select distinct epitype from [dbo].[HES_Completed1]

select distinct sex from [dbo].[HES_Completed1]

SELECT Distinct bedyear from [dbo].[HES_Completed1]
where bedyear > 300

SELECT Distinct epidur from [dbo].[HES_Completed1]
where epidur > 29200

SELECT min(epidur), max(epidur) from [dbo].[HES_Completed1]

SELECT Distinct epistat from [dbo].[HES_Completed1]

SELECT Distinct spellbgin from [dbo].[HES_Completed1]

SELECT Distinct admincat from [dbo].[HES_Completed1]

SELECT Distinct admincatst from [dbo].[HES_Completed1]

SELECT Distinct category from [dbo].[HES_Completed1]

SELECT DOB1 from [dbo].[HES_Completed1]

SELECT Distinct ethnos from [dbo].[HES_Completed1]

SELECT MAX(hesid), MIN(hesid) FROM [dbo].[HES_Completed1]

SELECT Distinct leglcat from [dbo].[HES_Completed1]

SELECT newnhsno FROM [dbo].[HES_Completed1]
WHERE newnhsno <= '999999999'

SELECT newnhsno_check from [dbo].[HES_Completed1]

SELECT admistart1 from [dbo].[HES_Completed1]

SELECT admimeth from [dbo].[HES_Completed1]

SELECT MAX(elecdur_calc), MIN(elecdur_calc) from [dbo].[HES_Completed1]
SELECT DISTINCT elecdur_calc FROM [dbo].[HES_Completed1]

SELECT DISTINCT classpat FROM [dbo].[HES_Completed1]

SELECT [hesid], DATEDIFF(day, EpiStart1, EpiEnd1) AS 'Duration'  
    FROM HES_completed1;  

SELECT MAX([bedyear]), MIN([bedyear]), AVG([bedyear]), STDEV([bedyear])
FROM [dbo].[HES_Completed1]

SELECT MAX([epidur]), MIN([epidur]), AVG([epidur]), STDEV([epidur])
FROM [dbo].[HES_Completed1]

SELECT MAX([bedyear]), MIN([bedyear]), AVG([bedyear]), STDEV([bedyear])
FROM [dbo].[HES_Completed1] 

SELECT MAX([elecdur]), MIN([elecdur]), AVG([elecdur]), STDEV([elecdur])
FROM [dbo].[HES_Completed1]

SELECT MAX([elecdur_calc]), MIN([elecdur_calc]), AVG([elecdur_calc]), STDEV([elecdur_calc])
FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE epitype IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE endage IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE ethnos IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE newnhsno IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE elecdur_calc IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE ElecDur_Code IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE [ElecDur Error Description] IS NULLl. ,     
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE endage_code IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE [Age at end of episode] IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE EpiOrder_Code IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE [EpiOrder Error Description] IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE epi_code IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE [Episode Description] IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE ethnos_code IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE [Ethnic category] IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE LeglCat_Code IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE LeglCatDescription IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE StartAge_Code IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

SELECT COUNT(*)
FROM [dbo].[HES_Completed1]
WHERE [Age in Days] IS NULL
SELECT COUNT(*) FROM [dbo].[HES_Completed1]

------------------------------------------------
--This stage is simply arranging the columns in a more logical and easier to read arrangement in terms of the corresponding descriptions.

SELECT [hesid]
,[lopatid]
,[newnhsno]
      ,[newnhsno_check]
	  ,[Valid]
	  ,[category]
	  ,[Administrative & legal status of patient]
	  ,[leglcat]
	  ,[LeglCatDescription]
	  ,[admimeth]
	  ,[Admimeth Description]
      ,[admisorc]
	  ,[AdmiSorc Description]
	  ,[Gender]
	  ,[DOB1]
		,[spell]
		,[spellbgin]
      ,[episode]
      ,[epiorder]
	  ,[EpiOrder Error Description]
      ,[epitype]
	  ,[Episode Description]
	  ,[EpiStart1]
      ,[EpiEnd1]
	  ,[epidur]
	  ,[bedyear]
	  ,[epistat]
	  ,[status]
	  ,[AdmiStart1]
	  ,[admiage]
      ,[activage]
      ,[admincat]
	  ,[Patient Type]
      ,[admincatst]
	  ,[AdminCatST Description]
      ,[endage]
	  ,[Age at end of episode]
      ,[ethnos]
	  ,[Ethnic category]
      ,[startage]
	  ,[Age in Days]
      ,[ElecDate1]
      ,[elecdur]
	  ,[ElecDur Error Description]
      ,[elecdur_calc]
      ,[classpat]
	  ,[PatientClassificationDesc]
      ,[diag_01]
      ,[CODE]
      ,[ALT_CODE]
      ,[USAGE]
      ,[USAGE_UK]
      ,[Diagnosis Codes Description]
	  INTO HES_Completed0
  
  FROM [NHS_completed].[dbo].[HES_Completed1]

----------------------------------------

--Puts more user-friendly messages instead of null outputs.
SELECT * FROM [dbo].[HES_Completed0]
  SELECT * FROM [dbo].[endage_t]


ALTER TABLE [dbo].[HES_Completed0]
ALTER COLUMN [newnhsno] VARCHAR (13)

update [dbo].[HES_Completed0]
set [newnhsno] = 'Invalid Entry'
where [newnhsno] IS NULL

update [dbo].[HES_Completed0]
set [EpiOrder Error Description] = 'No Error'
where [EpiOrder Error Description] IS NULL

update [dbo].[HES_Completed0]
set [Age at end of episode] = 'Not Applicable'
where [Age at end of episode] IS NULL

update [dbo].[HES_Completed0]
set [Ethnic category] = 'Invalid Entry'
where [Ethnic category] IS NULL

ALTER TABLE [dbo].[HES_Completed0]
ALTER COLUMN [Age in Days] VARCHAR (8)

update [dbo].[HES_Completed0]
set [Age in Days] = 'No Error'
where [Age in Days] IS NULL

update [dbo].[HES_Completed0]
set [ElecDur Error Description] = 'No Error'
where [ElecDur Error Description] IS NULL


------------------------------------------------------------------------------------------------------
-- TABLEAU DESCRIPTION
-- My dashboard produces three interactive breakdowns of the NHS data. 
-- The ‘Ethnicity Split’ chart is the main switch which when selected, produces an output of both the most common diagnosis for that ethnic category by gender,
-- as-well as a proportionate distribution of NHS/Private/Category II patients. 
-- All three sheets were linked within the dashboard in order to produce a range of scenarios from the user. All null values were also removed from the dashboard too.

--------------------------------------------------------------------------------------------------------
-- DATA MODELLING

-- Creatley was used as a software to model all the different entity relationships within the NHS dataset.
-- The foreign key tables around the main table, ‘HES_Wide’, were joined and displayed via crow feet notation. 
-- The most common pairings are many-to-many apart from ‘Sex_T’ which is one-to-many, i.e. a patient can only have one gender.
-- The foreign tables only contained the code, which was the primary key, and the corresponding descriptions.
-- Many of the code keys were locked to a specific number of characters as provided by the data dictionary. 
-- The purpose of the modelling is to show how the foreign key tables are used when a search query is executed.

-----------------------------------------------------------------------------------------------------------
-------------------------------------------------------END-------------------------------------------------