-- Script para crear un esquema de base de datos NBA en SQL Server con 8 tablas seleccionadas.
CREATE DATABASE NBA_Stats;
GO

USE NBA_Stats;
GO
-- Tabla: common_player_info (JUGADORES)
-- Almacena información detallada y común de los jugadores.
-- Esta tabla será la fuente principal para los IDs de jugadores (person_id).
CREATE TABLE common_player_info (
    person_id INT PRIMARY KEY,                      -- Identificador único de la persona/jugador.
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    display_first_last NVARCHAR(200),
    display_last_comma_first NVARCHAR(200),
    display_fi_last NVARCHAR(200),
    player_slug NVARCHAR(255),
    birthdate DATE,
    school NVARCHAR(100),
    country NVARCHAR(100),
    last_affiliation NVARCHAR(200),
    height NVARCHAR(20),
    weight NVARCHAR(20),
    season_exp INT,
    jersey NVARCHAR(10),
    position NVARCHAR(50),
    rosterstatus NVARCHAR(50),
    games_played_current_season_flag BIT,
    team_id INT,                                    -- ID del equipo actual del jugador. Se referenciará más adelante.
    team_name NVARCHAR(100),
    team_abbreviation NVARCHAR(10),
    team_code NVARCHAR(50),
    team_city NVARCHAR(100),
    playercode NVARCHAR(100),
    from_year INT,
    to_year INT,
    dleague_flag BIT,
    nba_flag BIT,
    games_played_flag BIT,
    draft_year INT,
    draft_round INT,
    draft_number INT,
    greatest_75_flag BIT
    -- La FK a team_details se añadirá después de crear team_details.
);
GO

-- Tabla: team_details (EQUIPOS)
-- Almacena detalles adicionales de los equipos.
-- Esta tabla será la fuente principal para los IDs de equipos (team_id).
CREATE TABLE team_details (
    team_id INT PRIMARY KEY,
    abbreviation NVARCHAR(10) UNIQUE, -- Es buena práctica mantener la abreviatura única.
    nickname NVARCHAR(100),
    yearfounded INT,
    city NVARCHAR(100),
    arena NVARCHAR(100),
    arenacapacity INT,
    owner NVARCHAR(255),
    generalmanager NVARCHAR(255),
    headcoach NVARCHAR(255),
    dleagueaffiliation NVARCHAR(100),
    facebook NVARCHAR(255),
    instagram NVARCHAR(255),
    twitter NVARCHAR(255)
);
GO

-- Ahora podemos añadir la FK de common_player_info a team_details.
ALTER TABLE common_player_info
ADD CONSTRAINT FK_common_player_info_team FOREIGN KEY (team_id) REFERENCES team_details(team_id);
GO

-- Tabla: game (JUEGOS)
-- Almacena información de cada partido y estadísticas agregadas por equipo.
CREATE TABLE game (
    game_id BIGINT PRIMARY KEY,
    season_id VARCHAR(10),
    team_id_home INT NOT NULL,
    team_abbreviation_home NVARCHAR(10),
    team_name_home NVARCHAR(100),
    game_date DATE NOT NULL,
    matchup_home NVARCHAR(100),
    wl_home BIT,
    min DECIMAL(5,1),
    fgm_home INT,
    fga_home INT,
    fg_pct_home DECIMAL(5,3),
    fg3m_home INT,
    fg3a_home INT,
    fg3_pct_home DECIMAL(5,3),
    ftm_home INT,
    fta_home INT,
    ft_pct_home DECIMAL(5,3),
    oreb_home INT,
    dreb_home INT,
    reb_home INT,
    ast_home INT,
    stl_home INT,
    blk_home INT,
    tov_home INT,
    pf_home INT,
    pts_home INT,
    plus_minus_home INT,
    video_available_home BIT,
    team_id_away INT NOT NULL,
    team_abbreviation_away NVARCHAR(10),
    team_name_away NVARCHAR(100),
    matchup_away NVARCHAR(100),
    wl_away BIT,
    fgm_away INT,
    fga_away INT,
    fg_pct_away DECIMAL(5,3),
    fg3m_away INT,
    fg3a_away INT,
    fg3_pct_away DECIMAL(5,3),
    ftm_away INT,
    fta_away INT,
    ft_pct_away DECIMAL(5,3),
    oreb_away INT,
    dreb_away INT,
    reb_away INT,
    ast_away INT,
    stl_away INT,
    blk_away INT,
    tov_away INT,
    pf_away INT,
    pts_away INT,
    plus_minus_away INT,
    video_available_away BIT,
    season_type NVARCHAR(50),
    CONSTRAINT FK_game_team_home FOREIGN KEY (team_id_home) REFERENCES team_details(team_id),
    CONSTRAINT FK_game_team_away FOREIGN KEY (team_id_away) REFERENCES team_details(team_id)
);
GO

-- Tabla: play_by_play (JUEGOS)
-- Detalle de cada evento ocurrido durante el partido.
CREATE TABLE play_by_play (
    game_id BIGINT NOT NULL,
    eventnum INT NOT NULL,
    eventmsgtype INT,
    eventmsgactiontype INT,
    period INT,
    wctimestring NVARCHAR(20),
    pctimestring NVARCHAR(20),
    homedescription NVARCHAR(MAX),
    neutraldescription NVARCHAR(MAX),
    visitordescription NVARCHAR(MAX),
    score NVARCHAR(20),
    scoremargin NVARCHAR(10),
    person1type INT,
    player1_id INT,
    player1_name NVARCHAR(255),
    player1_team_id INT,
    player1_team_city NVARCHAR(100),
    player1_team_nickname NVARCHAR(100),
    player1_team_abbreviation NVARCHAR(10),
    person2type INT,
    player2_id INT,
    player2_name NVARCHAR(255),
    player2_team_id INT,
    player2_team_city NVARCHAR(100),
    player2_team_nickname NVARCHAR(100),
    player2_team_abbreviation NVARCHAR(10),
    person3type INT,
    player3_id INT,
    player3_name NVARCHAR(255),
    player3_team_id INT,
    player3_team_city NVARCHAR(100),
    player3_team_nickname NVARCHAR(100),
    player3_team_abbreviation NVARCHAR(10),
    video_available_flag BIT,
    PRIMARY KEY (game_id, eventnum),
    CONSTRAINT FK_play_by_play_game FOREIGN KEY (game_id) REFERENCES game(game_id),
    CONSTRAINT FK_play_by_play_player1 FOREIGN KEY (player1_id) REFERENCES common_player_info(person_id),
    CONSTRAINT FK_play_by_play_team1 FOREIGN KEY (player1_team_id) REFERENCES team_details(team_id),
    CONSTRAINT FK_play_by_play_player2 FOREIGN KEY (player2_id) REFERENCES common_player_info(person_id),
    CONSTRAINT FK_play_by_play_team2 FOREIGN KEY (player2_team_id) REFERENCES team_details(team_id),
    CONSTRAINT FK_play_by_play_player3 FOREIGN KEY (player3_id) REFERENCES common_player_info(person_id),
    CONSTRAINT FK_play_by_play_team3 FOREIGN KEY (player3_team_id) REFERENCES team_details(team_id)
);
GO

-- Tabla: other_stats (JUEGOS)
-- Otras estadísticas del partido a nivel de equipo.
CREATE TABLE other_stats (
    game_id BIGINT PRIMARY KEY,
    league_id NVARCHAR(10),
    team_id_home INT,
    team_abbreviation_home NVARCHAR(10),
    team_city_home NVARCHAR(100),
    pts_paint_home INT,
    pts_2nd_chance_home INT,
    pts_fb_home INT,
    largest_lead_home INT,
    lead_changes INT,
    times_tied INT,
    team_turnovers_home INT,
    total_turnovers_home INT,
    team_rebounds_home INT,
    pts_off_to_home INT,
    team_id_away INT,
    team_abbreviation_away NVARCHAR(10),
    team_city_away NVARCHAR(100),
    pts_paint_away INT,
    pts_2nd_chance_away INT,
    pts_fb_away INT,
    largest_lead_away INT,
    team_turnovers_away INT,
    total_turnovers_away INT,
    team_rebounds_away INT,
    pts_off_to_away INT,
    CONSTRAINT FK_other_stats_game FOREIGN KEY (game_id) REFERENCES game(game_id),
    CONSTRAINT FK_other_stats_team_home FOREIGN KEY (team_id_home) REFERENCES team_details(team_id),
    CONSTRAINT FK_other_stats_team_away FOREIGN KEY (team_id_away) REFERENCES team_details(team_id)
);
GO

-- Tabla: line_score (JUEGOS)
-- Puntuación por cuarto y total para cada equipo en un partido.
CREATE TABLE line_score (
    game_id BIGINT PRIMARY KEY,
    game_date_est DATE,
    game_sequence INT,
    team_id_home INT,
    team_abbreviation_home NVARCHAR(10),
    team_city_name_home NVARCHAR(100),
    team_nickname_home NVARCHAR(100),
    team_wins_losses_home NVARCHAR(20),
    pts_qtr1_home INT,
    pts_qtr2_home INT,
    pts_qtr3_home INT,
    pts_qtr4_home INT,
    pts_ot1_home INT,
    pts_ot2_home INT,
    pts_ot3_home INT,
    pts_ot4_home INT,
    pts_ot5_home INT,
    pts_ot6_home INT,
    pts_ot7_home INT,
    pts_ot8_home INT,
    pts_ot9_home INT,
    pts_ot10_home INT,
    pts_home INT,
    team_id_away INT,
    team_abbreviation_away NVARCHAR(10),
    team_city_name_away NVARCHAR(100),
    team_nickname_away NVARCHAR(100),
    team_wins_losses_away NVARCHAR(20),
    pts_qtr1_away INT,
    pts_qtr2_away INT,
    pts_qtr3_away INT,
    pts_qtr4_away INT,
    pts_ot1_away INT,
    pts_ot2_away INT,
    pts_ot3_away INT,
    pts_ot4_away INT,
    pts_ot5_away INT,
    pts_ot6_away INT,
    pts_ot7_away INT,
    pts_ot8_away INT,
    pts_ot9_away INT,
    pts_ot10_away INT,
    pts_away INT,
    CONSTRAINT FK_line_score_game FOREIGN KEY (game_id) REFERENCES game(game_id),
    CONSTRAINT FK_line_score_team_home FOREIGN KEY (team_id_home) REFERENCES team_details(team_id),
    CONSTRAINT FK_line_score_team_away FOREIGN KEY (team_id_away) REFERENCES team_details(team_id)
);
GO

-- Tabla: draft_history (DRAFT)
-- Historial del Draft de la NBA.
CREATE TABLE draft_history (
    _rowid INTEGER PRIMARY KEY IDENTITY, -- Clave primaria sintética para asegurar unicidad por fila.
    person_id INT NOT NULL,
    player_name NVARCHAR(255),
    season INT NOT NULL,
    round_number INT,
    round_pick INT,
    overall_pick INT, -- Considerar hacerlo UNIQUE con season si es el caso: UNIQUE(season, overall_pick)
    draft_type NVARCHAR(50),
    team_id INT,
    team_city NVARCHAR(100),
    team_name NVARCHAR(100),
    team_abbreviation NVARCHAR(10),
    organization NVARCHAR(100),
    organization_type NVARCHAR(50),
    player_profile_flag BIT,
    CONSTRAINT FK_draft_history_person FOREIGN KEY (person_id) REFERENCES common_player_info(person_id),
    CONSTRAINT FK_draft_history_team FOREIGN KEY (team_id) REFERENCES team_details(team_id)
);
GO
-- Índice único para la combinación de temporada y elección general, si aplica.
CREATE UNIQUE INDEX UX_draft_history_season_overall_pick ON draft_history (season, overall_pick) WHERE overall_pick IS NOT NULL;
CREATE INDEX IX_draft_history_person_id ON draft_history (person_id);
GO

-- Tabla: draft_combine_stats (DRAFT)
-- Estadísticas de los jugadores del Draft Combine.
CREATE TABLE draft_combine_stats (
    _rowid INTEGER PRIMARY KEY IDENTITY, -- Clave primaria sintética.
    season INT NOT NULL,
    player_id INT NOT NULL, -- Este es el person_id del jugador.
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    player_name NVARCHAR(255),
    position NVARCHAR(50),
    height_wo_shoes DECIMAL(5,2),
    height_wo_shoes_ft_in NVARCHAR(20),
    height_w_shoes DECIMAL(5,2),
    height_w_shoes_ft_in NVARCHAR(20),
    weight DECIMAL(6,2),
    wingspan DECIMAL(5,2),
    wingspan_ft_in NVARCHAR(20),
    standing_reach DECIMAL(5,2),
    standing_reach_ft_in NVARCHAR(20),
    body_fat_pct DECIMAL(4,2),
    hand_length DECIMAL(4,2),
    hand_width DECIMAL(4,2),
    standing_vertical_leap DECIMAL(4,2),
    max_vertical_leap DECIMAL(4,2),
    lane_agility_time DECIMAL(5,2),
    modified_lane_agility_time DECIMAL(5,2),
    three_quarter_sprint DECIMAL(5,2),
    bench_press INT,
    spot_fifteen_corner_left NVARCHAR(10),
    spot_fifteen_break_left NVARCHAR(10),
    spot_fifteen_top_key NVARCHAR(10),
    spot_fifteen_break_right NVARCHAR(10),
    spot_fifteen_corner_right NVARCHAR(10),
    spot_college_corner_left NVARCHAR(10),
    spot_college_break_left NVARCHAR(10),
    spot_college_top_key NVARCHAR(10),
    spot_college_break_right NVARCHAR(10),
    spot_college_corner_right NVARCHAR(10),
    spot_nba_corner_left NVARCHAR(10),
    spot_nba_break_left NVARCHAR(10),
    spot_nba_top_key NVARCHAR(10),
    spot_nba_break_right NVARCHAR(10),
    spot_nba_corner_right NVARCHAR(10),
    off_drib_fifteen_break_left NVARCHAR(10),
    off_drib_fifteen_top_key NVARCHAR(10),
    off_drib_fifteen_break_right NVARCHAR(10),
    off_drib_college_break_left NVARCHAR(10),
    off_drib_college_top_key NVARCHAR(10),
    off_drib_college_break_right NVARCHAR(10),
    on_move_fifteen NVARCHAR(10),
    on_move_college NVARCHAR(10),
    CONSTRAINT FK_draft_combine_stats_player FOREIGN KEY (player_id) REFERENCES common_player_info(person_id)
);
GO
-- Índice único para la combinación de temporada y jugador.
CREATE UNIQUE INDEX UX_draft_combine_stats_season_player ON draft_combine_stats (season, player_id);
GO

/*
Consideraciones Clave en este Diseño de 8 Tablas:

1.  **Tablas Base para Jugadores y Equipos:**
    * `common_player_info` actúa como la tabla principal para los datos de jugadores, usando `person_id` como clave primaria.
    * `team_details` actúa como la tabla principal para los datos de equipos, usando `team_id` como clave primaria.

2.  **Relaciones (Claves Foráneas):**
    * Las tablas relacionadas con partidos (`game`, `play_by_play`, `other_stats`, `line_score`) se vinculan a `game.game_id`.
    * `game` se vincula a `team_details` para los equipos local y visitante.
    * `play_by_play` se vincula a `common_player_info` para los jugadores involucrados y a `team_details` para sus respectivos equipos.
    * `other_stats` y `line_score` se vinculan a `team_details` para la información de los equipos.
    * `draft_history` se vincula a `common_player_info` (para el jugador) y a `team_details` (para el equipo que lo seleccionó).
    * `draft_combine_stats` se vincula a `common_player_info` (para el jugador).
    * `common_player_info` tiene una referencia a `team_details` para el equipo actual del jugador.

3.  **Claves Primarias Sintéticas:** En `draft_history` y `draft_combine_stats`, he mantenido la columna `_rowid IDENTITY` como clave primaria para garantizar una identificación única por fila, y he añadido índices `UNIQUE` en las combinaciones de columnas que probablemente deberían ser únicas (como `season` y `overall_pick` en `draft_history`).

4.  **Integridad Referencial:** Las claves foráneas aseguran que las relaciones entre las tablas sean consistentes.

Este esquema debería ser un buen punto de partida para tu base de datos con las 8 tablas especificadas.
*/
