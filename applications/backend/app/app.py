from flask import Flask, jsonify
import mysql.connector
import os
from datetime import datetime

app = Flask(__name__)


def get_env_var(key: str) -> str:
    """Fetch required environment variable or raise error if missing."""
    value = os.getenv(key)
    if not value:
        raise RuntimeError(f"❌ Missing required environment variable: {key}")
    return value


# Database config from environment variables (provided by Kubernetes Secrets)
db_config = {
    "host": get_env_var("MYSQL_HOST"),
    "port": int(get_env_var("MYSQL_PORT")),
    "user": get_env_var("MYSQL_USER"),
    "password": get_env_var("MYSQL_PASSWORD"),
    "database": get_env_var("MYSQL_DATABASE"),
}


def get_connection():
    try:
        return mysql.connector.connect(**db_config)
    except mysql.connector.Error as e:
        raise RuntimeError(f"❌ Database connection failed: {e}")


@app.route("/health", methods=["GET"])
def health():
    return {"status": "ok"}, 200


@app.route("/readiness", methods=["GET"])
def readiness():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT 1")
        cursor.close()
        conn.close()
        return {"status": "ready"}, 200
    except Exception as e:
        return {"status": "not ready", "details": str(e)}, 500


@app.route("/leaderboard", methods=["GET"])
def get_leaderboard():
    query = (
        """
        SELECT
            player_id,
            gamer_tag,
            region,
            player_level,
            total_matches,
            win_rate,
            avg_session_length,
            favorite_mode,
            last_login
        FROM player_leaderboard
        ORDER BY win_rate DESC, total_matches DESC
        LIMIT 15
        """
    )

    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(query)
        leaderboard = cursor.fetchall()
        for row in leaderboard:
            last_login = row.get("last_login")
            if isinstance(last_login, datetime):
                row["last_login"] = last_login.isoformat()
        return jsonify(leaderboard), 200
    except mysql.connector.Error as e:
        return jsonify({"error": f"Failed to fetch leaderboard: {e}"}), 500
    finally:
        if "cursor" in locals():
            cursor.close()
        if "conn" in locals() and conn.is_connected():
            conn.close()


if __name__ == "__main__":
    port = int(os.getenv("PORT", 8081))
    app.run(host="0.0.0.0", port=port, debug=False)
