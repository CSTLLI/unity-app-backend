-- Create database
CREATE DATABASE IF NOT EXISTS unity_game_db;
USE unity_game_db;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Player statistics table
CREATE TABLE IF NOT EXISTS player_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    games_played INT DEFAULT 0,
    wins INT DEFAULT 0,
    losses INT DEFAULT 0,
    score INT DEFAULT 0,
    FOREIGN KEY (player_id) REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Player feedback table
CREATE TABLE IF NOT EXISTS player_feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES users(id)
);

-- Add indexes for better performance
CREATE INDEX idx_player_stats_score ON player_stats(score);
CREATE INDEX idx_player_feedback_date ON player_feedback(created_at);
