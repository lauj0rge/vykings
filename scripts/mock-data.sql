    USE devdb;
    DROP TABLE IF EXISTS player_leaderboard;
    CREATE TABLE player_leaderboard (
      player_id INT AUTO_INCREMENT PRIMARY KEY,
      gamer_tag VARCHAR(50) NOT NULL,
      region VARCHAR(20) NOT NULL,
      player_level INT NOT NULL,
      total_matches INT NOT NULL,
      win_rate DECIMAL(5,2) NOT NULL,
      avg_session_length DECIMAL(4,1) NOT NULL,
      favorite_mode VARCHAR(40) NOT NULL,
      last_login DATETIME NOT NULL
    );

    INSERT INTO player_leaderboard (
      gamer_tag, region, player_level, total_matches,
      win_rate, avg_session_length, favorite_mode, last_login
    ) VALUES
      ('NebulaNinja', 'NA', 57, 842, 64.3, 38.5, 'Capture the Flag', '2025-01-14 18:22:00'),
      ('PixelPirate', 'EU', 63, 910, 68.9, 42.0, 'Battle Royale', '2025-01-13 22:10:00'),
      ('QuantumQuasar', 'APAC', 49, 730, 61.2, 35.4, 'Team Deathmatch', '2025-01-14 09:45:00'),
      ('RiftRunner', 'NA', 71, 1104, 72.5, 44.7, 'Battle Royale', '2025-01-12 21:03:00'),
      ('EchoEagle', 'SA', 44, 608, 58.0, 33.8, 'Control Point', '2025-01-15 00:11:00'),
      ('LunarLyric', 'EU', 52, 815, 66.4, 37.1, 'Capture the Flag', '2025-01-14 16:30:00'),
      ('HyperHavoc', 'NA', 68, 987, 70.1, 41.5, 'Battle Royale', '2025-01-13 19:55:00'),
      ('CircuitSpecter', 'APAC', 39, 550, 54.7, 29.9, 'Payload Escort', '2025-01-14 07:28:00'),
      ('FrostbyteFox', 'EU', 61, 899, 67.5, 40.2, 'Team Deathmatch', '2025-01-12 14:12:00'),
      ('AuroraAegis', 'NA', 58, 860, 65.2, 39.4, 'King of the Hill', '2025-01-15 02:20:00'),
      ('TurboTactician', 'SA', 47, 680, 59.1, 32.6, 'Control Point', '2025-01-11 23:43:00'),
      ('SolsticeSaber', 'EU', 53, 820, 62.9, 36.2, 'Battle Royale', '2025-01-10 17:18:00'),
      ('MysticMarauder', 'MEA', 45, 640, 57.4, 31.7, 'Capture the Flag', '2025-01-14 11:05:00'),
      ('BinaryBard', 'NA', 42, 590, 55.0, 30.5, 'Team Deathmatch', '2025-01-13 08:52:00'),
      ('ZenithZephyr', 'APAC', 66, 940, 69.7, 43.3, 'Battle Royale', '2025-01-15 04:45:00');
