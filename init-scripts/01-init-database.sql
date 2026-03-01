-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller
    CREATE TABLE kunde (
        id SERIAL PRIMARY KEY,
        fornavn VARCHAR(100) NOT NULL,
        etternavn VARCHAR(100) NOT NULL,
        mobilnr VARCHAR(15) NOT NULL CHECK (length(mobilnr) >=8),
        epost VARCHAR(300) NOT NULL UNIQUE CHECK (position('@' in epost) > 1)
    );
    CREATE TABLE sykkel (
        id SERIAL PRIMARY KEY,
        modell VARCHAR(100) NOT NULL,
        innkjopsdato DATE NOT NULL CHECK (innkjopsdato <= CURRENT_DATE)
    );
    CREATE TABLE stasjon (
        id SERIAL PRIMARY KEY,
        navn VARCHAR(100) NOT NULL,
        adresse VARCHAR(100) NOT NULL
    );
    CREATE TABLE utleie (
        id SERIAL PRIMARY KEY,
        kunde_id INT NOT NULL REFERENCES kunde(id),
        sykkel_id INT NOT NULL REFERENCES sykkel(id),
        start_stasjon_id INT NOT NULL REFERENCES stasjon(id),
        slutt_stasjon_id INT NOT NULL REFERENCES stasjon(id),
        utleie_tidspunkt TIMESTAMP NOT NULL,
        innlevert_tidspunkt TIMESTAMP,
        CHECK (
            innlevert_tidspunkt IS NULL
            OR innlevert_tidspunkt >= utleie_tidspunkt
            )
    );


-- Sett inn testdata
    INSERT INTO kunde (fornavn, etternavn, mobilnr, epost) VALUES
    ('Manh Duc','Nguyen','+4755555555','mangu4479@oslomet.no'),
    ('LeBron','James','+198765432','LeBron_James@NBA.com'),
    ('Frank','Ocean','+155555555','Franky123@gmail.com');
    INSERT INTO sykkel (modell, innkjopsdato) VALUES
    ('AB123','2025-01-01'),
    ('CD3000','2021-04-28'),
    ('FG67','2020-05-16');
    INSERT INTO stasjon (navn, adresse) VALUES
    ('Grønland Stasjon','Hausmanns Bru 12'),
    ('Tøyen Stasjon','Brinken 3');
    INSERT INTO utleie (kunde_id, sykkel_id, start_stasjon_id, slutt_stasjon_id, utleie_tidspunkt, innlevert_tidspunkt) VALUES
    (1,1,1,2,'2026-02-28 10:00:00','2026-02-28 10:45:00'),
    (2,2,2,1,'2026-02-28 07:30:00','2026-02-28 08:15:00');
-- Fortsett for resten av radene




-- DBA setninger (rolle: kunde, bruker: kunde_1)
-- **SQL for å opprette rolle:**
CREATE ROLE kunde;

-- **SQL for å opprette bruker:**
CREATE USER kunde_1 WITH PASSWORD 'abc123';

-- **SQL for å tildele rettigheter:**
GRANT SELECT, INSERT ON kunde TO kunde;


-- Eventuelt: Opprett indekser for ytelse



-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;
