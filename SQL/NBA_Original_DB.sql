-- =============================================
-- Crear Base de Datos
-- =============================================
CREATE DATABASE [NBA_Original_DB];
GO

USE [NBA_Original_DB];
GO

-- =============================================
-- Tablas Base
-- =============================================

CREATE TABLE team (
    id INT NOT NULL PRIMARY KEY,
    full_name VARCHAR(255),
    abbreviation VARCHAR(10),
    nickname VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    year_founded INT
);
GO

CREATE TABLE player (
    id INT NOT NULL PRIMARY KEY,
    full_name VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    is_active BIT
);
GO

CREATE TABLE game_summary (
    game_id INT NOT NULL PRIMARY KEY,
    home_team_id INT NOT NULL,
    visitor_team_id INT NOT NULL,
    game_date_est DATE,
    FOREIGN KEY (home_team_id) REFERENCES team(id),
    FOREIGN KEY (visitor_team_id) REFERENCES team(id)
);
GO

-- =============================================
-- Tablas Detalladas
-- =============================================

CREATE TABLE team_details (
    team_id INT NOT NULL PRIMARY KEY,
    abbreviation VARCHAR(10),
    nickname VARCHAR(100),
    yearfounded INT,
    city VARCHAR(100),
    arena VARCHAR(255),
    arenacapacity INT,
    owner VARCHAR(255),
    generalmanager VARCHAR(255),
    headcoach VARCHAR(255),
    dleagueaffiliation VARCHAR(255),
    facebook VARCHAR(255),
    instagram VARCHAR(255),
    twitter VARCHAR(255),
    FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

CREATE TABLE common_player_info (
    person_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    player_slug VARCHAR(100),
    birthdate DATE,
    height VARCHAR(10),
    weight VARCHAR(10),
    season_exp INT,
    position VARCHAR(50),
    team_id INT,
    from_year INT,
    to_year INT,
    draft_year VARCHAR(10),
    draft_round VARCHAR(10),
    draft_number VARCHAR(10),
    FOREIGN KEY (person_id) REFERENCES player(id),
    FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

CREATE TABLE draft_history (
    person_id INT NOT NULL,
    season VARCHAR(10) NOT NULL,
    team_id INT,
    round_number INT,
    round_pick INT,
    overall_pick INT,
    PRIMARY KEY (person_id, season),
    FOREIGN KEY (person_id) REFERENCES player(id),
    FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

CREATE TABLE draft_combine_stats (
    season VARCHAR(10) NOT NULL,
    player_id INT NOT NULL,
    height_wo_shoes DECIMAL(4, 2),
    height_w_shoes DECIMAL(4, 2),
    weight DECIMAL(5, 1),
    wingspan DECIMAL(4, 2),
    standing_reach DECIMAL(4, 2),
    body_fat_pct DECIMAL(4, 2),
    bench_press INT,
    three_quarter_sprint DECIMAL(5, 2),
    max_vertical_leap DECIMAL(4, 1),
    PRIMARY KEY (player_id, season),
    FOREIGN KEY (player_id) REFERENCES player(id)
);
GO

-- =============================================
-- Tablas de Juegos
-- =============================================

CREATE TABLE game (
    game_id INT NOT NULL PRIMARY KEY,
    season_id VARCHAR(20),
    team_id_home INT NOT NULL,
    team_id_away INT NOT NULL,
    pts_home INT,
    pts_away INT,
    season_type VARCHAR(50),
    FOREIGN KEY (game_id) REFERENCES game_summary(game_id),
    FOREIGN KEY (team_id_home) REFERENCES team(id),
    FOREIGN KEY (team_id_away) REFERENCES team(id)
);
GO

CREATE TABLE other_stats (
    game_id INT NOT NULL PRIMARY KEY,
    team_id_home INT NOT NULL,
    team_id_away INT NOT NULL,
    pts_paint_home INT,
    pts_paint_away INT,
    FOREIGN KEY (game_id) REFERENCES game_summary(game_id),
    FOREIGN KEY (team_id_home) REFERENCES team(id),
    FOREIGN KEY (team_id_away) REFERENCES team(id)
);
GO

CREATE TABLE line_score (
    game_id INT NOT NULL PRIMARY KEY,
    team_id_home INT NOT NULL,
    team_id_away INT NOT NULL,
    pts_qtr1_home INT,
    pts_qtr2_home INT,
    pts_qtr3_home INT,
    pts_qtr4_home INT,
    pts_qtr1_away INT,
    pts_qtr2_away INT,
    pts_qtr3_away INT,
    pts_qtr4_away INT,
    FOREIGN KEY (game_id) REFERENCES game_summary(game_id),
    FOREIGN KEY (team_id_home) REFERENCES team(id),
    FOREIGN KEY (team_id_away) REFERENCES team(id)
);
GO

CREATE TABLE play_by_play (
    game_id INT NOT NULL,
    eventnum INT NOT NULL,
    eventmsgtype INT,
    eventmsgactiontype INT,
    period INT,
    wctimestring VARCHAR(10),
    pctimestring VARCHAR(10),
    homedescription VARCHAR(1000),
    visitordescription VARCHAR(1000),
    PRIMARY KEY (game_id, eventnum),
    FOREIGN KEY (game_id) REFERENCES game_summary(game_id)
);
GO
