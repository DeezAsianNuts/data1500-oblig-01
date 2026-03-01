# Besvarelse - Refleksjon og Analyse

**Student:** [Manh Duc Nguyen]

**Studentnummer:** [410401]

**Dato:** [01.03.2026]

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**

Kunde, sykkel, stasjon og utleie

**Attributter for hver entitet:**

Kunde: id, fornavn, etternavn, mobilnr og epost.
Sykkel: id, modell, innkjøpsdato.
Stasjon: id, navn, addresse.
Utleie: id, kunde id, sykkel id, start stasjon, slutt stasjon, utleie tidspunkt og innlevering tidspunkt.

---

### Oppgave 1.2: Datatyper og `CHECK`-constraints

**Valgte datatyper og begrunnelser:**
De valgte datatypene er SERIAL, VARCHAR, INT, PRIMARY KEY, DATE og TIMESTAMP, NULL, NOT NULL, UNIQUE.

**NULL** = Feltet kan stå tomt.
**NOT NULL** = Du må skrive en gyldig verdi, ellers får du feilmelding. Alle felt har NOT NULL,
bortsett fra innlevert_tidspunkt.


KUNDE:
id = **Serial** la jeg til id for at hver gang jeg lagde en ny rad med informasjon så økte id med 1, altså f.eks
kunde 33. får id nr 33. Bruker også **PRIMARY KEY**, fordi det skal unikt og det skal unngå duplikater.
fornavn = **VARCHAR** gjorde jeg får at det skulle bli en maksimum bokstaver i navnet og navn er tekst med variabel 
lengde. Jeg puttet også et høyt tall slik at man kan skrive fritt uten å stresse om å overstige maks VARCHAR.
etternavn = samme forklaring som fornavn.
mobilnr = Samme som fornavn og etternavn, kunne brukt INT. men pga. mobilnr kan inneholde '+', f.eks "+47".
'+' regnes som tekst, derfor brukte jeg også VARCHAR.
epost = Samme som de 3 ovenfor, men satte en **UNIQUE** for å unngå at flere kunder ikke registerer samme epost.

SYKKEL:
id = **Serial**, id allerede forklart.
modell = **VARCHAR**, samme forklaring som alle de med VARCHAR.
innkjopsdato = **DATE**, vi vil vite når sykkelen ble kjøpt, derfor bruker vi DATE for å få info om datoen.

STASJON: 
id = **Serial**, id allerede forklart.
navn = **VARCHAR**, samme forklaring som alle de med VARCHAR.
adresse = **VARCHAR**, samme forklaring som alle de med VARCHAR.

UTLEIE:
id = **Serial**, id allerede forklart.
kunde_id = **INT**, fremmednøkkel som peker til kunde(id). INT er tall og vi gjør dette for å koble til
data sammen. Det blir feilmelding hvis du peker på en kunde id som ikke finnes.
sykkel_id = **INT**, fremmednøkkel som peker til sykkel(id). Samme forklaring over.
start_stasjon_id = **INT**, fremmednøkkel som peker til stasjon(id). Samme forklaring over.
slutt_stasjon_id = **INT**, fremmednøkkel som peker til stasjon(id). Samme forklaring over.
utleie_tidspunkt = **TIMESTAMP**, fordi vi trenger både dato og tidspunkt for når sykkelen ble leid.
innlevert_tidspunkt = **TIMESTAMP**, samme forklaring over. Det inneholder ikke **NOT NULL** dersom sykkelen 
er fremdeles utleid. Dvs. at enten det MÅ ikke legge inn verdi, enten er det i bruk eller levert. Etter at
sykkelen har blitt levert, da legger man TIMESTAMP-en.


**`CHECK`-constraints:**
KUNDE:
mobilnr VARCHAR(15) NOT NULL CHECK (length(mobilnr) >=8),
epost VARCHAR(300) NOT NULL UNIQUE CHECK (position('@' in epost) > 1)
For mobilnr har jeg skrevet en check-constraint som sørger for at det er MINIMUM 8 siffere.
For epost har jeg skrevet en check-constraint som sørger for at epost inneholder MINST en '@'.

SYKKEL:
innkjopsdato DATE NOT NULL CHECK (innkjopsdato <= CURRENT_DATE)
For innkjopsdato har jeg skrevet en check-constraint som sørger for at datoen sykkelen ble kjøpt for dagens
dato, det er for å unngå at sykkelen "ble kjøpt i fremtidig dato" ettersom det ikke gir mening.

STASJON:
Ingen nødvendige check-constraints.

UTLEIE:
CHECK ( innlevert_tidspunkt IS NULL OR innlevert_tidspunkt >= utleie_tidspunkt )
For innlevert_tidspunkt har jeg skrevet en check-constraint som sørger for at systemet kan se om sykkelen
er fremdeles i bruk eller levert via NULL. Hvis det er tom, er den i bruk, hvis ikke er den levert. Du kan
ikke levere en sykkel før den har blitt utleid, derfor må innlevert_tidspunkt være samme eller senere.


**ER-diagram:**
[![](https://mermaid.ink/img/pako:eNqNU8lu2zAQ_RVizo4h2ZFi6VY0LtA6TQskObQQYDDlxGbERSBHRlPH_17SUjZHLcwDgZn33pCzbeGXFQgloDuXfOW4rgwLZ3FzeT5nj48nJ3bLbq4v5p_nrGQVrDeombeaKZTomH-oa1RoKuhkVz8Wi_nFoE6qGk0vYLeurelZdP3h6su3ywGVJ-6IhdvfW3MEXbX0hv46l21nxCMNMSnY98WLy5OTZsXurDN8Y975kQiHEW1vpTLuvaKxnjrv7ukjfXWO-okObVHqxS04YaCb-t42Phj2MHZflaOCD2bChUPv8SBuX97_h42uujUClwH4dAB0LR9EYnuXfb8GCbGh_yKQ1Bgg3bCW4jQuSQrftKamIU4oncINhvcOaDsYwcpJASW5Fkeg0WkeTdjnXAGtUWMFccAEd3Wcq6hpuPlprX6SOduu1lDeceWD1TaxX_1GPXsdhhK5j7Y1BGVWTPZBoNzCbyjT7HQ8meZZOj07K7J0NgvoQ2CNT5PATPMkz6cBynYj-LN_NhkXs0mSzJKiyLKsyIt0BCgkWfe12-j9Yu_-AgsOLRI?type=png)](https://mermaid.live/edit#pako:eNqNU8lu2zAQ_RVizo4h2ZFi6VY0LtA6TQskObQQYDDlxGbERSBHRlPH_17SUjZHLcwDgZn33pCzbeGXFQgloDuXfOW4rgwLZ3FzeT5nj48nJ3bLbq4v5p_nrGQVrDeombeaKZTomH-oa1RoKuhkVz8Wi_nFoE6qGk0vYLeurelZdP3h6su3ywGVJ-6IhdvfW3MEXbX0hv46l21nxCMNMSnY98WLy5OTZsXurDN8Y975kQiHEW1vpTLuvaKxnjrv7ukjfXWO-okObVHqxS04YaCb-t42Phj2MHZflaOCD2bChUPv8SBuX97_h42uujUClwH4dAB0LR9EYnuXfb8GCbGh_yKQ1Bgg3bCW4jQuSQrftKamIU4oncINhvcOaDsYwcpJASW5Fkeg0WkeTdjnXAGtUWMFccAEd3Wcq6hpuPlprX6SOduu1lDeceWD1TaxX_1GPXsdhhK5j7Y1BGVWTPZBoNzCbyjT7HQ8meZZOj07K7J0NgvoQ2CNT5PATPMkz6cBynYj-LN_NhkXs0mSzJKiyLKsyIt0BCgkWfe12-j9Yu_-AgsOLRI)
---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**
Alle entitetene har en PRIMARY KEY, dette satte jeg på attributten "id". Det er fordi det skal være et felt
med unikt identifikasjon. ENTITETENE: KUNDE, SYKKEL, STASJON, UTLEIE.

**Naturlige vs. surrogatnøkler:**
Naturlig nøkkel: virkelig data som allerede eksisterer, mer detaljert og meningsfull.
Surrogat nøkkel: nøkkel som ikke gir mening utenfor databasen, bruker kun for å identifisere rader unikt.

Naturlig nøkkel er mer spesifikt, men det kan være lange, komplisert og kan endres over tid i motsetning til
surrogat nøkkel. Det er enklere, stabilt og systematisk, men vanskelig å forstå uten å ha tabellen foran deg.

Vi har brukt Surrogat nøkkel i denne oppgaven, med bruk av SERIAL. Dette er for at det økes systematisk med
1 hver gang en rad blir lagd. Enkelt og systematisk, i tillegg unngår man misforståelser og duplikasjoner.

**Oppdatert ER-diagram:**

[![](https://mermaid.ink/img/pako:eNqNU8lu2zAQ_RVizo4h2ZFi6VY0LtA6TQskObQQYDDlxGbERSBHRlPH_17SUjZHLcwDgZn33pCzbeGXFQgloDuXfOW4rgwLZ3FzeT5nj48nJ3bLbq4v5p_nrGQVrDeombeaKZTomH-oa1RoKuhkVz8Wi_nFoE6qGk0vYLeurelZdP3h6su3ywGVJ-6IhdvfW3MEXbX0hv46l21nxCMNMSnY98WLy5OTZsXurDN8Y975kQiHEW1vpTLuvaKxnjrv7ukjfXWO-okObVHqxS04YaCb-t42Phj2MHZflaOCD2bChUPv8SBuX97_h42uujUClwH4dAB0LR9EYnuXfb8GCbGh_yKQ1Bgg3bCW4jQuSQrftKamIU4oncINhvcOaDsYwcpJASW5Fkeg0WkeTdjnXAGtUWMFccAEd3Wcq6hpuPlprX6SOduu1lDeceWD1TaxX_1GPXsdhhK5j7Y1BGVWTPZBoNzCbyjT7HQ8meZZOj07K7J0NgvoQ2CNT5PATPMkz6cBynYj-LN_NhkXs0mSzJKiyLKsyIt0BCgkWfe12-j9Yu_-AgsOLRI?type=png)](https://mermaid.live/edit#pako:eNqNU8lu2zAQ_RVizo4h2ZFi6VY0LtA6TQskObQQYDDlxGbERSBHRlPH_17SUjZHLcwDgZn33pCzbeGXFQgloDuXfOW4rgwLZ3FzeT5nj48nJ3bLbq4v5p_nrGQVrDeombeaKZTomH-oa1RoKuhkVz8Wi_nFoE6qGk0vYLeurelZdP3h6su3ywGVJ-6IhdvfW3MEXbX0hv46l21nxCMNMSnY98WLy5OTZsXurDN8Y975kQiHEW1vpTLuvaKxnjrv7ukjfXWO-okObVHqxS04YaCb-t42Phj2MHZflaOCD2bChUPv8SBuX97_h42uujUClwH4dAB0LR9EYnuXfb8GCbGh_yKQ1Bgg3bCW4jQuSQrftKamIU4oncINhvcOaDsYwcpJASW5Fkeg0WkeTdjnXAGtUWMFccAEd3Wcq6hpuPlprX6SOduu1lDeceWD1TaxX_1GPXsdhhK5j7Y1BGVWTPZBoNzCbyjT7HQ8meZZOj07K7J0NgvoQ2CNT5PATPMkz6cBynYj-LN_NhkXs0mSzJKiyLKsyIt0BCgkWfe12-j9Yu_-AgsOLRI)


---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**

1..* = en - til - mange
Kunde til Utleie = 1..* en kunde kan ha flere utleier, altså leie flere sykler over tid.
Sykkel til Utleie = 1..* en sykkel kan leies ut flere ganger.
Stasjon til Utleie (start_stasjon) = 1..* en stasjon kan være start for mange utleier
Stasjon til Utleie (slutt_stasjon) = 1..* en stasjon kan være slutt for mange utleier

**Fremmednøkler:**
Fremmednøkler, altså FK: en kolonne i en tabell som peker på PK i en annen tabell, altså sørge for å 
knytte tabeller sammen.

utleie.kunde.id peker til kunde.id, dvs at hver utleie må koble til en eksisterende kunde, hvis kunde_id ikke
finnes i kunde, kommer det feilmelding.
utleie.sykkel.id peker til sykkel.id, dvs hver utleie må koble til en eksisterende sykkel, hvis sykkel_id ikke
finnes i sykkel, kommer det feilmelding.
utleie.start.stasjon_id og utleie.slutt.stasjon.id peker til stasjon.i, dvs hver utleie må ha gyldige start-
og slutt-stasjoner.

**Oppdatert ER-diagram:**

[![](https://mermaid.ink/img/pako:eNqNU8lu2zAQ_RVizo4h2ZFi6VY0LtA6TQskObQQYDDlxGbERSBHRlPH_17SUjZHLcwDgZn33pCzbeGXFQgloDuXfOW4rgwLZ3FzeT5nj48nJ3bLbq4v5p_nrGQVrDeombeaKZTomH-oa1RoKuhkVz8Wi_nFoE6qGk0vYLeurelZdP3h6su3ywGVJ-6IhdvfW3MEXbX0hv46l21nxCMNMSnY98WLy5OTZsXurDN8Y975kQiHEW1vpTLuvaKxnjrv7ukjfXWO-okObVHqxS04YaCb-t42Phj2MHZflaOCD2bChUPv8SBuX97_h42uujUClwH4dAB0LR9EYnuXfb8GCbGh_yKQ1Bgg3bCW4jQuSQrftKamIU4oncINhvcOaDsYwcpJASW5Fkeg0WkeTdjnXAGtUWMFccAEd3Wcq6hpuPlprX6SOduu1lDeceWD1TaxX_1GPXsdhhK5j7Y1BGVWTPZBoNzCbyjT7HQ8meZZOj07K7J0NgvoQ2CNT5PATPMkz6cBynYj-LN_NhkXs0mSzJKiyLKsyIt0BCgkWfe12-j9Yu_-AgsOLRI?type=png)](https://mermaid.live/edit#pako:eNqNU8lu2zAQ_RVizo4h2ZFi6VY0LtA6TQskObQQYDDlxGbERSBHRlPH_17SUjZHLcwDgZn33pCzbeGXFQgloDuXfOW4rgwLZ3FzeT5nj48nJ3bLbq4v5p_nrGQVrDeombeaKZTomH-oa1RoKuhkVz8Wi_nFoE6qGk0vYLeurelZdP3h6su3ywGVJ-6IhdvfW3MEXbX0hv46l21nxCMNMSnY98WLy5OTZsXurDN8Y975kQiHEW1vpTLuvaKxnjrv7ukjfXWO-okObVHqxS04YaCb-t42Phj2MHZflaOCD2bChUPv8SBuX97_h42uujUClwH4dAB0LR9EYnuXfb8GCbGh_yKQ1Bgg3bCW4jQuSQrftKamIU4oncINhvcOaDsYwcpJASW5Fkeg0WkeTdjnXAGtUWMFccAEd3Wcq6hpuPlprX6SOduu1lDeceWD1TaxX_1GPXsdhhK5j7Y1BGVWTPZBoNzCbyjT7HQ8meZZOj07K7J0NgvoQ2CNT5PATPMkz6cBynYj-LN_NhkXs0mSzJKiyLKsyIt0BCgkWfe12-j9Yu_-AgsOLRI)

Jeg har samme bilde fordi jeg lagde ER-Diagrammen på slutten, gjorde det ikke underveis.
### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**
Datamodellen min tilfredsstiller 1NF fordi alle tabeller har en PRIMARY KEY som gjør hver rad unikt, i dette
tilfellet med entiteten 'id'. I tillegg er det ingen lister i samme kolonnen, det skal være en verdi per celle
(atomære verdier).

Datamodellen min tilfredsstiller 2NF fordi først og fremst, databasen må være i 1NF. Det er bare en kolonne
med PRIMARY KEY (id), det er ikke no sammensatt nøkkel og derfor er det ingen avhengighet av "noen deler".
Dermed deler vi det opp i flere separate tabeller. Dette gjør vi for å unngå duplikasjoner og mye arbeid, f.eks
hvis samme kunden "Duc" leier sykkel 1 og sykkel 2, må kundens navn lagres kun én gang i kunde-tabellen i 
stedet for å skrive "Duc" flere ganger i utleie-tabellen. På denne måten er alle kolonner avhengige av 
primærnøkkelen i hver tabell. Dessuten, er det kun 1 PK tilfredsstiller man 2NF automatisk.

**Vurdering av 3. normalform (3NF):**
Datamodellen min tilfredsstiller 3NF fordi først og fremst, databasen må være i 2NF. 3NF går ut på at ingen
kolonner skal være avhengig av andre kolonner som ikke er nøkkel. Dvs, at kunden_navn skal ligge i kune,
sykkel_modell skal ligge i sykkel osv. Alle de kolonnene ligger i sine egne tabeller.

**Eventuelle justeringer:**
Den har alltid vært i 3NF. Jeg har laget en tabell for hver av de entitene (kunde, sykkel, stasjon og utleie).
---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

Ja, jeg har lagt inn SQL-skripet i `init-scripts/01-init-database.sql`.
[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]

**Antall testdata:**

- Kunder: 3
- Sykler: 3
- Sykkelstasjoner: 2
- Låser: 0, ikke implementert.
- Utleier: 2

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**

[2026-03-01 20:03:33] postgres.public> INSERT INTO kunde (fornavn, etternavn, mobilnr, epost) VALUES
('Manh Duc','Nguyen','+4755555555','mangu4479@oslomet.no'),
('LeBron','James','+198765432','LeBron_James@NBA.com'),
('Frank','Ocean','+155555555','Franky123@gmail.com')
[2026-03-01 20:03:33] 3 rows affected in 4 ms
[2026-03-01 20:03:33] postgres.public> INSERT INTO sykkel (modell, innkjopsdato) VALUES
('AB123','2025-01-01'),
('CD3000','2021-04-28'),
('FG67','2020-05-16')
[2026-03-01 20:03:33] 3 rows affected in 4 ms
[2026-03-01 20:03:33] postgres.public> INSERT INTO stasjon (navn, adresse) VALUES
('Grønland Stasjon','Hausmanns Bru 12'),
('Tøyen Stasjon','Brinken 3')
[2026-03-01 20:03:33] 2 rows affected in 4 ms
[2026-03-01 20:03:33] postgres.public> INSERT INTO utleie (kunde_id, sykkel_id, start_stasjon_id, slutt_stasjon_id, utleie_tidspunkt, innlevert_tidspunkt) VALUES
(1,1,1,2,'2026-02-28 10:00:00','2026-02-28 10:45:00'),
(2,2,2,1,'2026-02-28 07:30:00','2026-02-28 08:15:00')
[2026-03-01 20:03:33] 2 rows affected in 4 ms

Tabellen ble lagd via:
SELECT * FROM kunde;
SELECT * FROM sykkel;
SELECT * FROM stasjon;
SELECT * FROM utleie;
Og dette viser jeg i data mappen som .csv fil.


**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**

```
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```
1. kunde
2. stasjon
3. sykkel
4. utleie
Det var resultatet da ja kopierte og limte det inn i consolen.
---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
CREATE ROLE kunde;
```

**SQL for å opprette bruker:**

```sql
CREATE USER kunde_1 WITH PASSWORD 'abc123';
```

**SQL for å tildele rettigheter:**

```sql
GRANT SELECT, INSERT ON kunde TO kunde;
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
CREATE VIEW kunde_utleie_view AS
SELECT
    utleie.id AS utleie_id,
    kunde.fornavn,
    kunde.etternavn,
    stasjon.navn AS start_stasjon,
    sykkel.modell,
    utleie.utleie_tidspunkt,
    utleie.innlevert_tidspunkt
FROM utleie
         JOIN kunde ON utleie.kunde_id = kunde.id
         JOIN sykkel ON utleie.sykkel_id = sykkel.id
         JOIN stasjon ON utleie.start_stasjon_id = stasjon.id;

**Ulempe med VIEW vs. POLICIES:**

 Ulempen med å bruke VIEW for autoirsasjon sammenlignet med POLICIES er hovedsakelig at POLICIES er mer
 strengere og sikker. Med VIEW kan du fortsatt ha tilgang til tabellene selv om du er begrenset på hva du
 kan se. POLICIES sørger for at brukeren kun får tilgang til de radene de har lov til å se eller endre.
---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

Høysesong har 5 måneder (mai, juni, juli, august, september): 20000 utleier/måned. 20000 x 5 = 100000.
Mellomsesong har 4 måneder (mars, april, oktober, november): 5000 utleier/måned. 5000 x 4 = 20000.
Lavsesong har 3 måneder (desember-februar): 500 utleier/måned. 500 x 3 = 1500.

Alle sesongene = 100000 + 20000 + 1500 = 121500 antall utleier per år.

**Estimat for lagringskapasitet:**

TABELLENE: KUNDE, SYKKEL, STASJON, UTLEIE. La oss si at 1 byte per tegn eller heltall.
KUNDE-TABELL:
La oss si id = 5 bytes,
fornavn = 100 bytes,
etternavn = 100 bytes,
mobilnr = 15 bytes,
epost = 300 bytes, jeg har estimert så mye bytes for fornavn-epost utifra hva jeg satte min VARCHAR på dem.
Det er 121500 utleier med forskjellige kunder, la oss si 20000 kunder per år. 519 bytes pr kunde fordi hver 
rad lagrer (id, fornavn, etternavn, mobilnr og epost). 20000 x 519 = ca 10,38 MB

SYKKEL-TABELL:
id = 5 bytes,
modell = 50 bytes,
innkjopsdato = 10 bytes,
la oss si antall sykler = 1000. 1000 x (5 + 50 + 10) = 1000 x 65 = 0,065 MB.
 
STASJON-TABELL:
id = 5 bytes,
navn = 100 bytes,
adresse = 100 bytes, jeg har estimert så mye bytes for navn og adresse utifra hva jeg satte min VARCHAR på dem.
La oss si antall stasjoner = 100. 100 x (100 + 100) = 100 x 200 = 0.02 MB.

UTLEIE-TABELL:
id = 5 bytes,
kunde_id = 5 bytes,
sykkel_id = 5 byte,
start_stasjon_id = 5 byte,
slutt_stasjon_id = 5 byte,
utleie_tidspunkt = 10 byte, 
innlevert_tidspunkt 10 byte,
Med 121500 utleier, gjør vi: 121500 x (5 + 5 + 5 + 5 + 10 + 10) = 121500 x 40 = 4,86 MB

**Totalt for første år:**

Kunde: 10,38 MB
Sykkel: 0,065 MB
Stasjon: 0,02 MB
Utleie: 4,86 MB
Vi legger sammen alt: 10,38 + 0,065 + 0,02 + 4,86 = 15.33 MB

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

Redundans betyr at samme data står flere steder.
Du ser klart og tydelig Ole Hansen og Kari Olsen flere ganger i CSV-en, hver av dem har lik mobilnr epost også.
Dette viser at de har leiet bysyklene flere ganger.

**Problem 2: Inkonsistens**

Redundans kan føre til inkonsistens dersom endringer skjer, hvis f.eks Ole Hansen eller Kari Olsen bytter
mobilnr eller epost-en deres, må du oppdatere alle radene med deres utleier. Ellers får databasen forskjellig
informasjon på de samme kundene.
 
**Problem 3: Oppdateringsanomalier**
Sletteanomalier: problemet med det er at dersom du sletter en rad fra utleie, mister du all informasjon om
kunden. DVS, hvis sletter du Kari Olsens siste utleie, mister du også mobilnr og eposten hennes.
 
Oppdateringsanomalier: Dersom du endrer noe informasjon fra tabellen må du endre alle rader som inneholder
det tilfellet. Hvis Ole Hansen endrer mobilnr, må du endre alle rader som inneholder han. Det blir er lett
å få feil på data dersom du ikke husker å endre på de radene.

innsettingsanomalier: Dersom du skal legge inn ny informasjon så må du fylle ut alle felter, jeg skrev jo "NOT
NULL" i SQL koden, og dette betyr at du kan ikke la feltet stå tomt. Derfor må du sette inn noe "midlertidig".
 

**Fordeler med en indeks:**

Fordeler med en indeks gjør at databasen kan finne rader uten å måtte gå gjennom hele tabellen. Du kan finne
indeks på f.eks id-kolonnen. Det er lettere og mye raskere.

 **Case 1: Indeks passer i RAM**

Ettersom indeks er liten nok til å få plass i RAM, kan databasen beholde indeksen i minnet. Da blir søk veldig
raskt fordi den slipper å lese fra harddisken som er mye tregere. Som regel har små tabeller og små indekser
ikke noe problem med å passe inn i RAM.
 
**Case 2: Indeks passer ikke i RAM**

Dersom indeks ikke passer i RAM så kan det gå veldig tregt for søk, mtp. på at nå må databasen lese fra
harddisken. Derfor kommer flettesorteringen inn, en smart og effektiv metode for å lese en stor datasett.
Det deler opp datasettet også sorterer det hver fil for seg før den endelig slår sammen de filene og gjør
det om til en ferdig sortert fil.


**Datastrukturer i DBMS:**

I Database Management System (DBMS) bruker man indekser for å hente data raskt. B+-trær og hash-indekser
er blant de vanligste indeksstrukturene i DBMS.

B+-trær: Et sortert tre der du kan se hvordan data kobles til hverandre, det er mer detaljert og lettere å
forstå. Det er lettere å jobbe med flere dataer ettersom du får visuelt en hel oversikt foran deg. Litt
tregere å finne eksakte indeksen i motsetning til hash-indekser, der det er mer effektiv.
 
hash-indekser: Brukes for å slå opp direkte den indekser du leter etter. Det er mindre detaljert og informasjon
i motsetning til B+-trær, men det er mye mer raskere. Hash-indekser er mer rett på sak, dersom du skal søke
eller jobbe med flere dater er det vanskeligere fordi dataene er ikke sortert. 
 
---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

LSM-tree

**Begrunnelse:**
Har ikke lest nok om datastruktur for å velge selv hva som er enklest for meg. Men LSM-tree har som regel
ekstremt rask skriving og litt tregere lesing, i motsetning til Heap-fil, det er enkel, men tregere for søk.
Men LSM-tree er egnet for logging fordi logging handler som regel mest om skriving, å kunne rapportere ned
alle hendelser. Man leser sjeldent på logg, dette gjør man som regel når man skal se tilbake på f.eks avvik.
 
**Skrive-operasjoner:**

LSM-tree skriver først til minnet (buffer) når man får nye logg-hendelser, som er raskt og enkelt. Fordelen
med LSM-tree er at du kan legge til mange endringer i logget raskt uten å vente på at disken skal skrive
hver gang.

**Lese-operasjoner:**

Lesing er sjeldnere og gjøres ved å flette data fra minnebufferen og diskstrukturen. Det er tregere enn å bare
søke opp direkte, men dette er noe vi takler og kan ofre fordi hensikten med logging er å skrive mye data raskt.

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**
Validering bør gjøres i alle tre lagene, de har sine egne fordeler og ulemper, men ettersom validering
handler om å sikre data og generelt sikkerhet, burde dette tas mer saklig og beskyttes gjennom flere lag.

**Validering i nettleseren:**

Fordelen med validering i nettleseren (frontend) er at det gir en rask tilbakemelding til brukeren.
Ulempen med det er at det er minst beskyttet, det er lettest å manipulere data og komme seg forbi.

**Validering i applikasjonslaget:**

Fordel med validering i applikasjonslaget (backend) er at den sikrer dataene, sjekker om de er trygge før
de sendes over til databasen. Brukere som jukser forbi frontend, sitter som regel fast i backend.
Ulempen er at det blir mer arbeid for serveren og at responsen er tregere, i motsetning til front end som
gir en rask tilbakemelding.
                                                                                                


**Validering i databasen:**

Fordel med validering i databasen er at det beskytter mot feil og skadelig data.
Ulempen er at tilbakemeldingen er ikke like forståelig som frontend. Det kommer som regel feilmelding som kan
være vanskelig for brukeren å lese, i motsetning til tilbakemelding fra frontend.
**Konklusjon:**

Validering bør gjøres i alle tre lagene, de beskytter data på forskjellige måter som er fint for både brukeren
og programmet. Frontend gir raskt tilbakemelding til brukeren, backend sørger for at data er trygge før de
sendes videre og databasen beskytter mot feil og skadelig data.
---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

Jeg har lært litt om SQL, også har jeg lært om CSV og hvordan det ser ut.
Jeg har lært litt om hvor viktig det er å ha ting sortert og fint i databaser, hvor viktig det er å besyktte
dem og hva slags metoder man kan bruke for oversiktelig søk.

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

[Skriv din refleksjon her - koble oppgaven til læringsmålene i emnet]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

Alle oppgaver har vært utfordrende, jeg har så vidt klart oppgavene på egen hånd, det er fordi jeg har fokusert
mye på blant annet Calculus som har skyvet meg bort fra databasen. Jeg har lært mye mens jeg har jobbet med
oblig innleveringen. Kunne nesten ingenting før jeg begynte å jobbe med databasen. Jeg sliter også med                                                                                                   
undervisningsplanen for i år. Vet på en måte ikke hvor jeg skal lese og føler ikke modulene/presentasjonene                                                                                                  
hjelper meg. Følte at jeg måtte finne ut av disse tingene selv.   
Nå er det for sent, fordi jeg har lite tid på å levere. Men jeg bommet noen ganger på oppgavene. Jeg var
fokusert på besvarelse-malet, men brukte så vidt OPPGAVE.md for å svaret riktig på deres krav.                                                                                                  
**Hva har du lært om databasedesign:**
Først og fremst har jeg lært om hvordan tabell fungerer, entiteter og deres attributer, hva de gjør og hvordan
du kan jobbe med dem separat, samtidig som du jobber med alle dem i helhet. Spørsmålene dere har stilt meg                                                                                                  
i besvarelse-malet har også lært meg om avviker man kan møte på og hva man kan gjøre for å unngå dem.                                                                                                
Det har vært gøy å bygge dem fra starten ettersom jeg følte det skapte interesse for meg i dette faget.                                                                                                  
Før oblig 1, synes jeg at database er vanskelig (som jeg fremdeles gjør), men jeg synes i det minste at det                                                                                                  
var gøy og egentlig ganske interessant hvordan database og databasedesign fungerer.

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

Ja noen.


**Eventuelle feil og rettelser:**

Jeg brukte KI som hjelpmidler, har svart på noen av dem fordi jeg føler jeg kunne ha klart det selv, eller 
faktumet det er forståelig. Resten ble for vanskelig for meg og jeg har får lite tid til å lære meg dem pr nå.

---

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

**SQL for trigger:**

```sql
[Skriv din SQL-kode for trigger her, hvis du har løst denne oppgaven]
```

**Forklaring:**

[Skriv ditt svar her - forklar hvordan triggeren fungerer]

**Testing:**

[Skriv ditt svar her - vis hvordan du har testet at triggeren fungerer som forventet]

---

### Oppgave 6.2: Presentasjon

**Lenke til presentasjon:**

[Legg inn lenke til video eller presentasjonsfiler her, hvis du har løst denne oppgaven]

**Hovedpunkter i presentasjonen:**

[Skriv ditt svar her - oppsummer de viktigste punktene du dekket i presentasjonen]

---

**Slutt på besvarelse**
