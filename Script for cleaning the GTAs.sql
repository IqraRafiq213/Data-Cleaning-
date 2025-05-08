	--Script was written to clean the GTA data
Un
	
	
	
	Ô = O
	Ó = O
	É = E
	Ê = E
	Ã = A
	Á = A
	Ç = C
	Í = I
	Ú = U
	Ç = S
	Õ = O
	
	
	
	

	
	
CREATE EXTENSION unaccent;

--Makes all entries capital letters
UPDATE public.gtas_jbs
SET origem_nome = upper(origem_nome);

--remove Portuguese accents from names
--origem_estabelecimento
UPDATE public.gtas_jbs 
SET origem_estabelecimento = unaccent(origem_estabelecimento);
UPDATE public.gtas_jbs 
SET origem_nome = unaccent(origem_nome);
UPDATE public."Minerva_PA_abate_engorda_quarentena_exportacao" 
SET dest_estabelecimento = unaccent(dest_estabelecimento);
UPDATE public."Minerva_PA_abate_engorda_quarentena_exportacao" 
SET dest_nome = unaccent(dest_nome);

--origem_nome

UPDATE public.gtas_jbs SET origem_nome = REPLACE(origem_nome,'.',' ') WHERE origem_nome LIKE '%.%';
UPDATE public.gtas_jbs SET origem_nome = REPLACE(origem_nome,':',' ') WHERE origem_nome LIKE '%:%';
UPDATE public.gtas_jbs SET origem_nome = REPLACE(origem_nome,'-',' ') WHERE origem_nome LIKE '%-%';
UPDATE public.gtas_jbs SET origem_nome = REPLACE(origem_nome,',',' ') WHERE origem_nome LIKE '%,%';
UPDATE public.gtas_jbs SET origem_nome = REPLACE(origem_nome,'/',' ') WHERE origem_nome LIKE '%/%';
UPDATE public.gtas_jbs SET origem_nome = REPLACE(origem_nome,'*',' ') WHERE origem_nome LIKE '%*%';
UPDATE public.gtas_jbs SET origem_nome = REPLACE(origem_nome,'`',' ') WHERE origem_nome LIKE '%`%';

UPDATE public.gtas_jbs SET origem_nome = REPLACE(origem_nome,'Âª',' ') WHERE origem_nome LIKE '%Âª%';

origem nome   



--origem_estabelecimento
UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,'.',' ') WHERE origem_estabelecimento LIKE '%.%';
UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,':',' ') WHERE origem_estabelecimento LIKE '%:%';
UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,'-',' ') WHERE origem_estabelecimento LIKE '%-%';
UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,',',' ') WHERE origem_estabelecimento LIKE '%,%';
UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,'/',' ') WHERE origem_estabelecimento LIKE '%/%';
UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,'*',' ') WHERE origem_estabelecimento LIKE '%*%';
UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,'`',' ') WHERE origem_estabelecimento LIKE '%`%';
UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,'_',' ') WHERE origem_estabelecimento LIKE '%_%';

UPDATE public.gtas_jbs  SET origem_estabelecimento = REPLACE(origem_estabelecimento,'Ã‘','N') WHERE origem_estabelecimento LIKE '%Ã‘%';
 
Ã€ A
ÃŸ A 
Ã­ I 
Ãµ O 
Ã’ O
Ãˆ E 
Ã‘ N 
Ã‚ A 
Ã¢ A 
Ã£ A 
Ãƒ A
ÃƑ A 
Ã¡ A 
Ã© E
Ã‰ E
ÃŠ E 
Ã I
Ã• O
Ã´ O
Ã” O
Ã³ O 
Ã“ O
Ã‡ C 
Ã§ C
Ãº U 
Ãš U 
Ã A 
Â° ESPACIO


UPDATE public.gtas_jbs SET origem_estabelecimento = REPLACE(origem_estabelecimento,'CHAC','CHACARA') WHERE origem_estabelecimento LIKE '%CHAC%';
UPDATE public.gtas_jbs SET origem_estabelecimento = REPLACE(origem_estabelecimento,'CHACARAARA','CHACARA') WHERE origem_estabelecimento LIKE '%CHACARAARA%';
UPDATE public.gtas_jbs SET origem_estabelecimento = REPLACE(origem_estabelecimento,'FAZ','FAZENDA') WHERE origem_estabelecimento LIKE '%FAZ%';
UPDATE public.gtas_jbs SET origem_estabelecimento = REPLACE(origem_estabelecimento,'FAZENDAENDA','FAZENDA') WHERE origem_estabelecimento LIKE '%FAZENDAENDA%';
UPDATE public.gtas_jbs SET origem_estabelecimento = REPLACE(origem_estabelecimento,'FAZENDAENDINHA','FAZENDA') WHERE origem_estabelecimento LIKE '%FAZENDAENDINHA%';

UPDATE public.gtas_jbs SET origem_estabelecimento = REPLACE(origem_estabelecimento,'FAM?LIA','FAMILIA') WHERE origem_estabelecimento LIKE '%FAM?LIA%';


LEIL?O LEILAO
RA?A RACA
FAM?LIA FAMILIA




--dest_nome
UPDATE public."to_gta_combine" SET dest_nome = REPLACE(dest_nome,'.','') WHERE dest_nome LIKE '%.%';
UPDATE public."to_gta_combine" SET dest_nome = REPLACE(dest_nome,':','') WHERE dest_nome LIKE '%:%';
UPDATE public."to_gta_combine" SET dest_nome = REPLACE(dest_nome,',','') WHERE dest_nome LIKE '%,%';
UPDATE public."to_gta_combine" SET dest_nome = REPLACE(dest_nome,'/','') WHERE dest_nome LIKE '%/%';

--dest_estabelecimento
UPDATE public."to_gta_combine" SET dest_estabelecimento = REPLACE(dest_estabelecimento,'.','') WHERE dest_estabelecimento LIKE '%.%';
UPDATE public."to_gta_combine" SET dest_estabelecimento = REPLACE(dest_estabelecimento,':','') WHERE dest_estabelecimento LIKE '%:%';
UPDATE public."to_gta_combine" SET dest_estabelecimento = REPLACE(dest_estabelecimento,',','') WHERE dest_estabelecimento LIKE '%,%';
UPDATE public."to_gta_combine" SET dest_estabelecimento = REPLACE(dest_estabelecimento,'/','') WHERE dest_estabelecimento LIKE '%/%';

UPDATE public."to_gta_combine" SET dest_estabelecimento = REPLACE(dest_estabelecimento,'FAZ','FAZENDA') WHERE dest_estabelecimento LIKE '%FAZ%';
UPDATE public."to_gta_combine" SET dest_estabelecimento = REPLACE(dest_estabelecimento,'FAZENDAENDA','FAZENDA') WHERE dest_estabelecimento LIKE '%FAZENDAENDA%';


--edit words
UPDATE public."maran test" SET origem_nome = REPLACE(origem_nome,'AGROPECUÇRIA','AGROPECUARIA') WHERE origem_nome  LIKE '%AGROPECUÇRIA%';
UPDATE public."maran test" SET origem_nome = REPLACE(origem_nome,'A','A') WHERE origem_nome  LIKE '%A%';
UPDATE public."maran test" SET origem_estabelecimento = REPLACE(origem_estabelecimento,'I','I') WHERE origem_estabelecimento LIKE '%I%';


--remove unwanted white spaces between strings
UPDATE public.gtas_jbs SET origem_nome = trim(regexp_replace(origem_nome , '\s+', ' ', 'g'));
UPDATE public.gtas_jbs SET origem_estabelecimento = trim(regexp_replace(origem_estabelecimento , '\s+', ' ', 'g'));
UPDATE public."to_gta_combine" SET dest_nome = trim(regexp_replace(dest_nome , '\s+', ' ', 'g'));
UPDATE public."to_gta_combine" SET dest_estabelecimento = trim(regexp_replace(dest_estabelecimento , '\s+', ' ', 'g'));

--divide gtas by state
CREATE TABLE JBS_TO AS
SELECT id, uf, num, serie, status, dest_id, dest_uf, dest_mun, validade, dest_nome, dest_estabelecimento,  origem_id, origem_uf, finalidade, origem_mun, "dataEmissao", origem_nome, origem_estabelecimento, estratificacao, meio_transporte, vacinas_atestados 
FROM public.gtas_jbs gij
where uf in ('to'); 

--remove a column 
ALTER TABLE "RDG_JBS_merged" 
drop column "status-------";
