// server.js
const express = require("express");
const mysql = require("mysql2");
const bcrypt = require("bcrypt");
const cors = require("cors");
const dotenv = require("dotenv");

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Database connection
const db = mysql.createConnection({
	host: process.env.DB_HOST || "localhost",
	user: process.env.DB_USER || "root",
	password: process.env.DB_PASSWORD || "",
	database: process.env.DB_NAME || "unity_game_db",
	port: process.env.DB_PORT || 3307,
});

db.connect((err) => {
	if (err) {
		console.error("Error connecting to the database:", err);
		return;
	}
	console.log("Connected to database");
});

// Routes

// Create new user
app.post("/api/auth/register", async (req, res) => {
	const { username, password } = req.body;

	// Validation
	if (!username || !password) {
		return res
			.status(400)
			.json({ error: "Username and password are required" });
	}

	try {
		// Check if username already exists
		const checkUser = "SELECT id FROM users WHERE username = ?";
		db.query(checkUser, [username], async (err, results) => {
			if (err) {
				console.error("Database error:", err);
				return res.status(500).json({ error: "Internal server error" });
			}

			if (results.length > 0) {
				return res.status(409).json({ error: "Username already exists" });
			}

			// Hash password
			const saltRounds = 10;
			const hashedPassword = await bcrypt.hash(password, saltRounds);

			// Insert new user
			const insertUser = "INSERT INTO users (username, password) VALUES (?, ?)";
			db.query(insertUser, [username, hashedPassword], async (err, result) => {
				if (err) {
					console.error("Database error:", err);
					return res.status(500).json({ error: "Internal server error" });
				}

				// Initialize player stats
				const initStats =
					"INSERT INTO player_stats (player_id, games_played, wins, losses, score) VALUES (?, 0, 0, 0, 0)";
				db.query(initStats, [result.insertId], (err) => {
					if (err) {
						console.error("Error initializing player stats:", err);
						// Note: User is still created even if stats initialization fails
					}
				});

				res.status(201).json({
					success: true,
					message: "User created successfully",
					userId: result.insertId,
				});
			});
		});
	} catch (error) {
		console.error("Server error:", error);
		res.status(500).json({ error: "Internal server error" });
	}
});

// Authentication
app.post("/api/auth/login", async (req, res) => {
	const { username, password } = req.body;

	if (!username || !password) {
		return res
			.status(400)
			.json({ error: "Username and password are required" });
	}

	const query = "SELECT * FROM users WHERE username = ?";

	db.query(query, [username], async (err, results) => {
		if (err) {
			console.error("Database error:", err);
			return res.status(500).json({ error: "Internal server error" });
		}

		if (results.length === 0) {
			return res.status(401).json({ error: "Invalid credentials" });
		}

		const user = results[0];
		const validPassword = await bcrypt.compare(password, user.password);

		if (!validPassword) {
			return res.status(401).json({ error: "Invalid credentials" });
		}

		// Send user data (excluding password)
		const { password: _, ...userData } = user;
		res.json({
			success: true,
			user: userData,
		});
	});
});

// Get player statistics
app.get('/api/players/stats', (req, res) => {
    const query = `
        SELECT 
            u.username as playerName,
            s.games_played as gamesPlayed,
            s.wins as gamesWon,
            s.losses as gamesLost,
            s.score
        FROM users u
        JOIN player_stats s ON u.id = s.player_id
        ORDER BY s.score DESC
    `;

    db.query(query, (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ error: 'Internal server error' });
        }

        res.json({ stats: results });
    });
});

// Save player feedback
app.post("/api/feedback", (req, res) => {
	const { playerId, comment } = req.body;

	if (!playerId || !comment) {
		return res
			.status(400)
			.json({ error: "Player ID and comment are required" });
	}

	const query =
		"INSERT INTO player_feedback (player_id, comment, created_at) VALUES (?, ?, NOW())";

	db.query(query, [playerId, comment], (err, result) => {
		if (err) {
			console.error("Database error:", err);
			return res.status(500).json({ error: "Internal server error" });
		}

		res.json({
			success: true,
			feedbackId: result.insertId,
		});
	});
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
	console.log(`Server is running on port ${PORT}`);
});