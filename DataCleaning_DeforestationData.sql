---THE BASICS
CREATE TABLE public.correctcolumnsJBSGTA AS 
SELECT id_2, "dataEmissao", origem_nome, origem_estabelecimento, origem_mun, finalidade, dest_nome, dest_estabelecimento, dest_mun 
FROM public."RDG_JBS_merged_cleaned" rjmc

--DELETE DOUBLE COLUMNS
ALTER TABLE public."correctcolumns"
DROP COLUMN id;

--rename double columns
alter table public."MARFRIG_DIRECT_GO_CLEAN" 
rename column status to statuss


--THE NEW & AND NOT SO SIMPLE WAY

CREATE TABLE public.JBS_direct_sigef_PA_1 AS
(
SELECT ssm.*, md.* 
FROM public."SIGEF_SNCR_PA" ssm 
INNER JOIN public.correctcolumnsJBSGTA md 
ON (ssm.nome_area LIKE '%' || md.origem_estabelecimento || '%' 
    OR ssm."2021_farm" LIKE '%' || md.origem_estabelecimento || '%')
AND (ssm."2021_owner" LIKE '%' || md.origem_nome || '%'
OR ssm."sigef 2019" LIKE '%' || md.origem_nome || '%')
);


--specifically Rondonia

CREATE TABLE public.Minerva_direct_sigef_RO_1 AS
(
SELECT ssm.*, md.* 
FROM public."SIGEF_SNCR_RO" ssm 
INNER JOIN public.correctcolumnsminervaGTA  md
ON (ssm."2021_owner" LIKE '%' || md.origem_nome || '%'
OR ssm."sigef 2019" LIKE '%' || md.origem_nome || '%')
);

CREATE TABLE public.Minerva_direct_sigef_RO_1 AS
(
SELECT ssm.*, md.* 
FROM public."SIGEF_SNCR_RO" ssm 
INNER JOIN public.correctcolumnsminervaGTA md
ON (
    (ssm."2021_owner" LIKE '%' || md.origem_nome || '%'
    AND (ssm."2021_owner" IS NOT NULL AND ssm."2021_owner" <> '')
    AND (md.origem_nome IS NOT NULL AND md.origem_nome <> ''))
    OR 
    (ssm."sigef 2019" LIKE '%' || md.origem_nome || '%'
    AND (ssm."sigef 2019" IS NOT NULL AND ssm."sigef 2019" <> '')
    AND (md.origem_nome IS NOT NULL AND md.origem_nome <> ''))
)
);



--create a row number counter to identify duplicate rows
CREATE TABLE final_JBS_direct_sigef_PA_1 AS 
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY geom ORDER BY id_2) AS row_num
FROM JBS_direct_sigef_PA_1
)

--delete the duplicate rows
DELETE FROM final_JBS_direct_sigef_PA_1 WHERE row_num >1;

--drop the column that is no longer needed
ALTER TABLE final_JBS_direct_sigef_PA_1
DROP COLUMN row_num;


--Repeat the process but switch the order of the farm to pick up extra matches - start here!!
CREATE TABLE public.JBS_direct_sigef_PA_2 AS
(
SELECT ssm.*, md.* 
FROM public."SIGEF_SNCR_PA" ssm 
INNER JOIN public.correctcolumnsJBSGTA md 
ON (md.origem_estabelecimento LIKE '%' || ssm.nome_area || '%' 
    OR md.origem_estabelecimento LIKE '%' || ssm."2021_farm" || '%')
AND (md.origem_nome LIKE '%' || ssm."2021_owner" || '%'
OR md.origem_nome LIKE '%' || ssm."sigef 2019" || '%')
);

--specifically Rondonia

CREATE TABLE public.Minerva_direct_sigef_RO_2 AS
(
SELECT ssm.*, md.* 
FROM public."SIGEF_SNCR_RO" ssm 
INNER JOIN public.correctcolumnsminervaGTA md
ON (
    (md.origem_nome LIKE '%' || ssm."2021_owner" || '%'
    AND (md.origem_nome IS NOT NULL AND md.origem_nome <> '')
    AND (ssm."2021_owner" IS NOT NULL AND ssm."2021_owner" <> ''))
    OR 
    (md.origem_nome LIKE '%' || ssm."sigef 2019" || '%'
    AND (md.origem_nome IS NOT NULL AND md.origem_nome <> '')
    AND (ssm."sigef 2019" IS NOT NULL AND ssm."sigef 2019" <> ''))
)
);


--create a row number counter to identify duplicate rows
CREATE TABLE final_JBS_direct_sigef_PA_2 AS 
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY geom ORDER BY id_0) AS row_num
FROM JBS_direct_sigef_PA_2
)

--delete the duplicate rows
DELETE FROM final_JBS_direct_sigef_PA_2 WHERE row_num >1;

--drop the column that is no longer needed
ALTER TABLE final_JBS_direct_sigef_PA_2
DROP COLUMN row_num;


--Create a master join by joining the two previous joins together
CREATE TABLE final_JBS_direct_sigef_PA AS 
SELECT * FROM final_JBS_direct_sigef_PA_1
UNION 
SELECT * FROM final_JBS_direct_sigef_PA_2

--Control for duplicate rows by creating a row number and deleting duplicate rows
CREATE TABLE final_JBS_direct_sigef_PA_unique AS 
SELECT *, ROW_NUMBER() OVER(PARTITION BY geom ORDER BY id_2) AS row_num
FROM final_JBS_direct_sigef_PA_2

--Delete
DELETE FROM final_JBS_direct_sigef_PA_unique WHERE row_num>1;

ALTER TABLE final_JBS_direct_sigef_PA_unique
DROP COLUMN row_num;



--- SNCI


---THE BASICS
CREATE TABLE public.correctcolumnsmarfriggta AS 
SELECT id_2, "dataEmissao", origem_nome, origem_estabelecimento, origem_mun, finalidade, dest_nome, dest_estabelecimento, dest_mun 
FROM public."__RDG_Minerva_merged__CLEANED" rmmc 


--DELETE DOUBLE COLUMNS
ALTER TABLE public."correctcolumnsmarfrig"
DROP COLUMN id;


--THE NEW & AND NOT SO SIMPLE WAY

CREATE TABLE public.Marfrig_direct_SNCI_PA_1 AS
(
SELECT ssm.*, md.* 
FROM public."SNCI_SNCR_PA" ssm 
INNER JOIN public.correctcolumnsmarfriggta md 
ON (ssm.nome_area LIKE '%' || md.origem_estabelecimento || '%' 
    OR ssm."2021_farm" LIKE '%' || md.origem_estabelecimento || '%')
AND (ssm."2021_owner" LIKE '%' || md.origem_nome || '%')
);


--specifically Rondonia

CREATE TABLE public.Minerva_direct_SNCI_RO_1 AS
(
SELECT ssm.*, md.* 
FROM public."SNCI_SNCR_RO" ssm 
INNER JOIN public.correctcolumnsminervaGTA  md
ON (ssm."2021_owner" LIKE '%' || md.origem_nome || '%')
);

CREATE TABLE public.Minerva_direct_snci_RO_1 AS
(
SELECT ssm.*, md.* 
FROM public."SNCI_SNCR_RO" ssm 
INNER JOIN public.correctcolumnsminervaGTA md
ON (
    (ssm."2021_owner" LIKE '%' || md.origem_nome || '%'
    AND (ssm."2021_owner" IS NOT NULL AND ssm."2021_owner" <> '')
    AND (md.origem_nome IS NOT NULL AND md.origem_nome <> ''))
)
);
---

--create a row number counter to identify duplicate rows
CREATE TABLE final_Marfrig_direct_SNCI_PA_1 AS 
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY geom ORDER BY id_2) AS row_num
FROM Marfrig_direct_SNCI_PA_1
)


--delete the duplicate rows
DELETE FROM final_Marfrig_direct_SNCI_PA_1 WHERE row_num >1;

--drop the column that is no longer needed
ALTER TABLE final_Marfrig_direct_SNCI_PA_1
DROP COLUMN row_num;


--Repeat the process but switch the order of the farm to pick up extra matches
CREATE TABLE public.Marfrig_direct_SNCI_PA_2 AS
(
SELECT ssm.*, md.* 
FROM public."SNCI_SNCR_PA" ssm 
INNER JOIN public.correctcolumnsmarfriggta md 
ON (md.origem_estabelecimento LIKE '%' || ssm.nome_area || '%' 
    OR md.origem_estabelecimento LIKE '%' || ssm."2021_farm" || '%')
AND (md.origem_nome LIKE '%' || ssm."2021_owner" || '%')
);

--specifically Rondonia

CREATE TABLE public.Minerva_direct_SNCI_RO_2 AS
(
SELECT ssm.*, md.* 
FROM public."SNCI_SNCR_RO" ssm 
INNER JOIN public.correctcolumnsminervaGTA md 
ON (md.origem_nome LIKE '%' || ssm."2021_owner" || '%')
);

CREATE TABLE public.Minerva_direct_snci_RO_2 AS
(
SELECT ssm.*, md.* 
FROM public."SNCI_SNCR_RO" ssm 
INNER JOIN public.correctcolumnsminervaGTA md
ON (
    (md.origem_nome LIKE '%' || ssm."2021_owner" || '%'
    AND (md.origem_nome IS NOT NULL AND md.origem_nome <> '')
    AND (ssm."2021_owner" IS NOT NULL AND ssm."2021_owner" <> ''))
)
);
--

--create a row number counter to identify duplicate rows
CREATE TABLE final_Marfrig_direct_SNCI_PA_2 AS 
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY geom ORDER BY id_2) AS row_num
FROM Marfrig_direct_SNCI_PA_2
)

--delete the duplicate rows
DELETE FROM final_Marfrig_direct_SNCI_PA_2 WHERE row_num >1;

--drop the column that is no longer needed
ALTER TABLE final_Marfrig_direct_SNCI_PA_2
DROP COLUMN row_num;


--Create a master join by joining the two previous joins together
CREATE TABLE final_Marfrig_direct_SNCI_PA AS 
SELECT * FROM final_Marfrig_direct_SNCI_PA_1
UNION 
SELECT * FROM final_Marfrig_direct_SNCI_PA_2

--Control for duplicate rows by creating a row number and deleting duplicate rows
CREATE TABLE final_Marfrig_direct_SNCI_PA__unique AS 
SELECT *, ROW_NUMBER() OVER(PARTITION BY geom ORDER BY id_2) AS row_num
FROM final_Marfrig_direct_SNCI_PA

--Delete
DELETE FROM final_Marfrig_direct_SNCI_PA__unique WHERE row_num>1;

ALTER TABLE final_Marfrig_direct_SNCI_PA__unique
DROP COLUMN row_num;

