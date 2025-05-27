-- =============================================
-- Crear la Base de Datos
-- =============================================
CREATE DATABASE [NBA_Original_DB]; -- Puedes cambiar este nombre
GO

USE [NBA_Original_DB];
GO

-- =============================================
-- Crear Tablas Base (Team, Player)
-- =============================================

CREATE TABLE team (
    id INT NOT NULL,
    full_name VARCHAR(255) NULL,
    abbreviation VARCHAR(10) NULL,
    nickname VARCHAR(100) NULL,
    city VARCHAR(100) NULL,
    state VARCHAR(100) NULL,
    year_founded INT NULL,
    CONSTRAINT PK_team PRIMARY KEY (id)
);
GO

CREATE TABLE player (
    id INT NOT NULL,
    full_name VARCHAR(255) NULL,
    first_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NULL,
    is_active BIT NULL,
    CONSTRAINT PK_player PRIMARY KEY (id)
);
GO

-- =============================================
-- Crear Tablas de Detalles y Historia
-- =============================================

CREATE TABLE team_details (
    team_id INT NOT NULL,
    abbreviation VARCHAR(10) NULL,
    nickname VARCHAR(100) NULL,
    yearfounded INT NULL,
    city VARCHAR(100) NULL,
    arena VARCHAR(255) NULL,
    arenacapacity INT NULL,
    owner VARCHAR(255) NULL,
    generalmanager VARCHAR(255) NULL,
    headcoach VARCHAR(255) NULL,
    dleagueaffiliation VARCHAR(255) NULL,
    facebook VARCHAR(255) NULL,
    instagram VARCHAR(255) NULL,
    twitter VARCHAR(255) NULL,
    CONSTRAINT PK_team_details PRIMARY KEY (team_id),
    CONSTRAINT FK_team_details_team FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

CREATE TABLE team_history (
    team_id INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    nickname VARCHAR(100) NULL,
    year_founded INT NOT NULL,
    year_active_till INT NULL,
    CONSTRAINT PK_team_history PRIMARY KEY (team_id, year_founded),
    CONSTRAINT FK_team_history_team FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

CREATE TABLE common_player_info (
    person_id INT NOT NULL,
    first_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NULL,
    display_first_last VARCHAR(255) NULL,
    display_last_comma_first VARCHAR(255) NULL,
    display_fi_last VARCHAR(255) NULL,
    player_slug VARCHAR(100) NULL,
    birthdate DATE NULL,
    school VARCHAR(100) NULL,
    country VARCHAR(100) NULL,
    last_affiliation VARCHAR(100) NULL,
    height VARCHAR(10) NULL,
    weight VARCHAR(10) NULL,
    season_exp INT NULL,
    jersey VARCHAR(5) NULL,
    position VARCHAR(50) NULL,
    rosterstatus VARCHAR(50) NULL,
    games_played_current_season_flag VARCHAR(1) NULL,
    team_id INT NULL,
    team_name VARCHAR(100) NULL,
    team_abbreviation VARCHAR(10) NULL,
    team_code VARCHAR(50) NULL,
    team_city VARCHAR(100) NULL,
    playercode VARCHAR(100) NULL,
    from_year INT NULL,
    to_year INT NULL,
    dleague_flag VARCHAR(1) NULL,
    nba_flag VARCHAR(1) NULL,
    games_played_flag VARCHAR(1) NULL,
    draft_year VARCHAR(10) NULL,
    draft_round VARCHAR(10) NULL,
    draft_number VARCHAR(10) NULL,
    greatest_75_flag BIT NULL,
    CONSTRAINT PK_common_player_info PRIMARY KEY (person_id),
    CONSTRAINT FK_common_player_info_player FOREIGN KEY (person_id) REFERENCES player(id),
    CONSTRAINT FK_common_player_info_team FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

CREATE TABLE draft_history (
    person_id INT NOT NULL,
    player_name VARCHAR(255) NULL,
    season VARCHAR(10) NOT NULL,
    round_number INT NULL,
    round_pick INT NULL,
    overall_pick INT NULL,
    draft_type VARCHAR(50) NULL,
    team_id INT NULL,
    team_city VARCHAR(100) NULL,
    team_name VARCHAR(100) NULL,
    team_abbreviation VARCHAR(10) NULL,
    organization VARCHAR(100) NULL,
    organization_type VARCHAR(50) NULL,
    player_profile_flag BIT NULL,
    CONSTRAINT PK_draft_history PRIMARY KEY (person_id, season),
    CONSTRAINT FK_draft_history_player FOREIGN KEY (person_id) REFERENCES player(id),
    CONSTRAINT FK_draft_history_team FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

CREATE TABLE draft_combine_stats (
    season VARCHAR(10) NOT NULL,
    player_id INT NOT NULL,
    first_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NULL,
    player_name VARCHAR(255) NULL,
    position VARCHAR(50) NULL,
    height_wo_shoes DECIMAL(4, 2) NULL,
    height_wo_shoes_ft_in VARCHAR(10) NULL,
    height_w_shoes DECIMAL(4, 2) NULL,
    height_w_shoes_ft_in VARCHAR(10) NULL,
    weight DECIMAL(5, 1) NULL,
    wingspan DECIMAL(4, 2) NULL,
    wingspan_ft_in VARCHAR(10) NULL,
    standing_reach DECIMAL(4, 2) NULL,
    standing_reach_ft_in VARCHAR(10) NULL,
    body_fat_pct DECIMAL(4, 2) NULL,
    hand_length DECIMAL(4, 2) NULL,
    hand_width DECIMAL(4, 2) NULL,
    standing_vertical_leap DECIMAL(4, 1) NULL,
    max_vertical_leap DECIMAL(4, 1) NULL,
    lane_agility_time DECIMAL(5, 2) NULL,
    modified_lane_agility_time DECIMAL(5, 2) NULL,
    three_quarter_sprint DECIMAL(5, 2) NULL,
    bench_press INT NULL,
    spot_fifteen_corner_left DECIMAL(4, 3) NULL,
    spot_fifteen_break_left DECIMAL(4, 3) NULL,
    spot_fifteen_top_key DECIMAL(4, 3) NULL,
    spot_fifteen_break_right DECIMAL(4, 3) NULL,
    spot_fifteen_corner_right DECIMAL(4, 3) NULL,
    spot_college_corner_left DECIMAL(4, 3) NULL,
    spot_college_break_left DECIMAL(4, 3) NULL,
    spot_college_top_key DECIMAL(4, 3) NULL,
    spot_college_break_right DECIMAL(4, 3) NULL,
    spot_college_corner_right DECIMAL(4, 3) NULL,
    spot_nba_corner_left DECIMAL(4, 3) NULL,
    spot_nba_break_left DECIMAL(4, 3) NULL,
    spot_nba_top_key DECIMAL(4, 3) NULL,
    spot_nba_break_right DECIMAL(4, 3) NULL,
    spot_nba_corner_right DECIMAL(4, 3) NULL,
    off_drib_fifteen_break_left DECIMAL(4, 3) NULL,
    off_drib_fifteen_top_key DECIMAL(4, 3) NULL,
    off_drib_fifteen_break_right DECIMAL(4, 3) NULL,
    off_drib_college_break_left DECIMAL(4, 3) NULL,
    off_drib_college_top_key DECIMAL(4, 3) NULL,
    off_drib_college_break_right DECIMAL(4, 3) NULL,
    on_move_fifteen DECIMAL(4, 3) NULL,
    on_move_college DECIMAL(4, 3) NULL,
    CONSTRAINT PK_draft_combine_stats PRIMARY KEY (player_id, season),
    CONSTRAINT FK_draft_combine_stats_player FOREIGN KEY (player_id) REFERENCES player(id)
);
GO

CREATE TABLE team_info_common (
    team_id INT NOT NULL,
    season_year VARCHAR(10) NOT NULL,
    team_city VARCHAR(100) NULL,
    team_name VARCHAR(100) NULL,
    team_abbreviation VARCHAR(10) NULL,
    team_conference VARCHAR(50) NULL,
    team_division VARCHAR(50) NULL,
    team_code VARCHAR(50) NULL,
    team_slug VARCHAR(100) NULL,
    w INT NULL,
    l INT NULL,
    pct DECIMAL(4, 3) NULL,
    conf_rank INT NULL,
    div_rank INT NULL,
    min_year INT NULL,
    max_year INT NULL,
    league_id VARCHAR(10) NULL,
    season_id VARCHAR(20) NULL,
    pts_rank INT NULL,
    pts_pg DECIMAL(5, 1) NULL,
    reb_rank INT NULL,
    reb_pg DECIMAL(5, 1) NULL,
    ast_rank INT NULL,
    ast_pg DECIMAL(5, 1) NULL,
    opp_pts_rank INT NULL,
    opp_pts_pg DECIMAL(5, 1) NULL,
    CONSTRAINT PK_team_info_common PRIMARY KEY (team_id, season_year),
    CONSTRAINT FK_team_info_common_team FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

-- =============================================
-- Crear Tablas de Partidos (Games) - Usando game_id
-- =============================================

CREATE TABLE game_summary (
    game_id INT NOT NULL,
    game_date_est DATE NULL,
    game_sequence INT NULL,
    game_status_id INT NULL,
    game_status_text VARCHAR(50) NULL,
    gamecode VARCHAR(50) NULL,
    home_team_id INT NOT NULL,
    visitor_team_id INT NOT NULL,
    season VARCHAR(10) NULL,
    live_period INT NULL,
    live_pc_time VARCHAR(10) NULL,
    natl_tv_broadcaster_abbreviation VARCHAR(50) NULL,
    live_period_time_bcast VARCHAR(50) NULL,
    wh_status INT NULL,
    CONSTRAINT PK_game_summary PRIMARY KEY (game_id),
    CONSTRAINT FK_game_summary_home_team FOREIGN KEY (home_team_id) REFERENCES team(id),
    CONSTRAINT FK_game_summary_away_team FOREIGN KEY (visitor_team_id) REFERENCES team(id)
);
GO

-- Para las siguientes tablas (game, other_stats, game_info, line_score),
-- game_id es tanto PK como FK a game_summary, forzando una relación 1:1.

CREATE TABLE game (
    game_id INT NOT NULL,
    season_id VARCHAR(20) NULL,
    team_id_home INT NOT NULL,
    team_abbreviation_home VARCHAR(10) NULL,
    team_name_home VARCHAR(100) NULL,
    game_date DATE NULL,
    matchup_home VARCHAR(100) NULL,
    wl_home VARCHAR(1) NULL,
    min INT NULL,
    fgm_home INT NULL,
    fga_home INT NULL,
    fg_pct_home DECIMAL(5, 3) NULL,
    fg3m_home INT NULL,
    fg3a_home INT NULL,
    fg3_pct_home DECIMAL(5, 3) NULL,
    ftm_home INT NULL,
    fta_home INT NULL,
    ft_pct_home DECIMAL(5, 3) NULL,
    oreb_home INT NULL,
    dreb_home INT NULL,
    reb_home INT NULL,
    ast_home INT NULL,
    stl_home INT NULL,
    blk_home INT NULL,
    tov_home INT NULL,
    pf_home INT NULL,
    pts_home INT NULL,
    plus_minus_home INT NULL,
    video_available_home BIT NULL,
    team_id_away INT NOT NULL,
    team_abbreviation_away VARCHAR(10) NULL,
    team_name_away VARCHAR(100) NULL,
    matchup_away VARCHAR(100) NULL,
    wl_away VARCHAR(1) NULL,
    fgm_away INT NULL,
    fga_away INT NULL,
    fg_pct_away DECIMAL(5, 3) NULL,
    fg3m_away INT NULL,
    fg3a_away INT NULL,
    fg3_pct_away DECIMAL(5, 3) NULL,
    ftm_away INT NULL,
    fta_away INT NULL,
    ft_pct_away DECIMAL(5, 3) NULL,
    oreb_away INT NULL,
    dreb_away INT NULL,
    reb_away INT NULL,
    ast_away INT NULL,
    stl_away INT NULL,
    blk_away INT NULL,
    tov_away INT NULL,
    pf_away INT NULL,
    pts_away INT NULL,
    plus_minus_away INT NULL,
    video_available_away BIT NULL,
    season_type VARCHAR(50) NULL,
    CONSTRAINT PK_game PRIMARY KEY (game_id),
    CONSTRAINT FK_game_game_summary FOREIGN KEY (game_id) REFERENCES game_summary(game_id),
    CONSTRAINT FK_game_home_team FOREIGN KEY (team_id_home) REFERENCES team(id),
    CONSTRAINT FK_game_away_team FOREIGN KEY (team_id_away) REFERENCES team(id)
);
GO

CREATE TABLE other_stats (
    game_id INT NOT NULL,
    league_id VARCHAR(10) NULL,
    team_id_home INT NOT NULL,
    team_abbreviation_home VARCHAR(10) NULL,
    team_city_home VARCHAR(100) NULL,
    pts_paint_home INT NULL,
    pts_2nd_chance_home INT NULL,
    pts_fb_home INT NULL,
    largest_lead_home INT NULL,
    lead_changes INT NULL,
    times_tied INT NULL,
    team_turnovers_home INT NULL,
    total_turnovers_home INT NULL,
    team_rebounds_home INT NULL,
    pts_off_to_home INT NULL,
    team_id_away INT NOT NULL,
    team_abbreviation_away VARCHAR(10) NULL,
    team_city_away VARCHAR(100) NULL,
    pts_paint_away INT NULL,
    pts_2nd_chance_away INT NULL,
    pts_fb_away INT NULL,
    largest_lead_away INT NULL,
    team_turnovers_away INT NULL,
    total_turnovers_away INT NULL,
    team_rebounds_away INT NULL,
    pts_off_to_away INT NULL,
    CONSTRAINT PK_other_stats PRIMARY KEY (game_id),
    CONSTRAINT FK_other_stats_game_summary FOREIGN KEY (game_id) REFERENCES game_summary(game_id),
    CONSTRAINT FK_other_stats_home_team FOREIGN KEY (team_id_home) REFERENCES team(id),
    CONSTRAINT FK_other_stats_away_team FOREIGN KEY (team_id_away) REFERENCES team(id)
);
GO

CREATE TABLE game_info (
    game_id INT NOT NULL,
    game_date DATE NULL,
    attendance INT NULL,
    game_time VARCHAR(50) NULL,
    CONSTRAINT PK_game_info PRIMARY KEY (game_id),
    CONSTRAINT FK_game_info_game_summary FOREIGN KEY (game_id) REFERENCES game_summary(game_id)
);
GO

CREATE TABLE line_score (
    game_id INT NOT NULL,
    game_date_est DATE NULL,
    game_sequence INT NULL,
    team_id_home INT NOT NULL,
    team_abbreviation_home VARCHAR(10) NULL,
    team_city_name_home VARCHAR(100) NULL,
    team_nickname_home VARCHAR(100) NULL,
    team_wins_losses_home VARCHAR(10) NULL,
    pts_qtr1_home INT NULL,
    pts_qtr2_home INT NULL,
    pts_qtr3_home INT NULL,
    pts_qtr4_home INT NULL,
    pts_ot1_home INT NULL,
    pts_ot2_home INT NULL,
    pts_ot3_home INT NULL,
    pts_ot4_home INT NULL,
    pts_ot5_home INT NULL,
    pts_ot6_home INT NULL,
    pts_ot7_home INT NULL,
    pts_ot8_home INT NULL,
    pts_ot9_home INT NULL,
    pts_ot10_home INT NULL,
    pts_home INT NULL,
    team_id_away INT NOT NULL,
    team_abbreviation_away VARCHAR(10) NULL,
    team_city_name_away VARCHAR(100) NULL,
    team_nickname_away VARCHAR(100) NULL,
    team_wins_losses_away VARCHAR(10) NULL,
    pts_qtr1_away INT NULL,
    pts_qtr2_away INT NULL,
    pts_qtr3_away INT NULL,
    pts_qtr4_away INT NULL,
    pts_ot1_away INT NULL,
    pts_ot2_away INT NULL,
    pts_ot3_away INT NULL,
    pts_ot4_away INT NULL,
    pts_ot5_away INT NULL,
    pts_ot6_away INT NULL,
    pts_ot7_away INT NULL,
    pts_ot8_away INT NULL,
    pts_ot9_away INT NULL,
    pts_ot10_away INT NULL,
    pts_away INT NULL,
    CONSTRAINT PK_line_score PRIMARY KEY (game_id),
    CONSTRAINT FK_line_score_game_summary FOREIGN KEY (game_id) REFERENCES game_summary(game_id),
    CONSTRAINT FK_line_score_home_team FOREIGN KEY (team_id_home) REFERENCES team(id),
    CONSTRAINT FK_line_score_away_team FOREIGN KEY (team_id_away) REFERENCES team(id)
);
GO

-- =============================================
-- Crear Tablas de Eventos y Participantes
-- =============================================

CREATE TABLE officials (
    game_id INT NOT NULL,
    official_id INT NOT NULL,
    first_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NULL,
    jersey_num VARCHAR(5) NULL,
    CONSTRAINT PK_officials PRIMARY KEY (game_id, official_id),
    CONSTRAINT FK_officials_game_summary FOREIGN KEY (game_id) REFERENCES game_summary(game_id)
);
GO

CREATE TABLE inactive_players (
    game_id INT NOT NULL,
    player_id INT NOT NULL,
    first_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NULL,
    jersey_num VARCHAR(5) NULL,
    team_id INT NOT NULL,
    team_city VARCHAR(100) NULL,
    team_name VARCHAR(100) NULL,
    team_abbreviation VARCHAR(10) NULL,
    CONSTRAINT PK_inactive_players PRIMARY KEY (game_id, player_id),
    CONSTRAINT FK_inactive_players_game_summary FOREIGN KEY (game_id) REFERENCES game_summary(game_id),
    CONSTRAINT FK_inactive_players_player FOREIGN KEY (player_id) REFERENCES player(id),
    CONSTRAINT FK_inactive_players_team FOREIGN KEY (team_id) REFERENCES team(id)
);
GO

CREATE TABLE play_by_play (
    game_id INT NOT NULL,
    eventnum INT NOT NULL,
    eventmsgtype INT NULL,
    eventmsgactiontype INT NULL,
    period INT NULL,
    wctimestring VARCHAR(10) NULL,
    pctimestring VARCHAR(10) NULL,
    homedescription VARCHAR(1000) NULL,
    neutraldescription VARCHAR(1000) NULL,
    visitordescription VARCHAR(1000) NULL,
    score VARCHAR(10) NULL,
    scoremargin VARCHAR(10) NULL,
    person1type INT NULL,
    player1_id INT NULL,
    player1_name VARCHAR(255) NULL,
    player1_team_id INT NULL,
    player1_team_city VARCHAR(100) NULL,
    player1_team_nickname VARCHAR(100) NULL,
    player1_team_abbreviation VARCHAR(10) NULL,
    person2type INT NULL,
    player2_id INT NULL,
    player2_name VARCHAR(255) NULL,
    player2_team_id INT NULL,
    player2_team_city VARCHAR(100) NULL,
    player2_team_nickname VARCHAR(100) NULL,
    player2_team_abbreviation VARCHAR(10) NULL,
    person3type INT NULL,
    player3_id INT NULL,
    player3_name VARCHAR(255) NULL,
    player3_team_id INT NULL,
    player3_team_city VARCHAR(100) NULL,
    player3_team_nickname VARCHAR(100) NULL,
    player3_team_abbreviation VARCHAR(10) NULL,
    video_available_flag BIT NULL,
    CONSTRAINT PK_play_by_play PRIMARY KEY (game_id, eventnum),
    CONSTRAINT FK_play_by_play_game_summary FOREIGN KEY (game_id) REFERENCES game_summary(game_id),
    CONSTRAINT FK_play_by_play_player1 FOREIGN KEY (player1_id) REFERENCES player(id),
    CONSTRAINT FK_play_by_play_player2 FOREIGN KEY (player2_id) REFERENCES player(id),
    CONSTRAINT FK_play_by_play_player3 FOREIGN KEY (player3_id) REFERENCES player(id),
    CONSTRAINT FK_play_by_play_team1 FOREIGN KEY (player1_team_id) REFERENCES team(id),
    CONSTRAINT FK_play_by_play_team2 FOREIGN KEY (player2_team_id) REFERENCES team(id),
    CONSTRAINT FK_play_by_play_team3 FOREIGN KEY (player3_team_id) REFERENCES team(id)
);
GO

PRINT 'Base de datos y tablas (estructura original) creadas exitosamente.';