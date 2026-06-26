from flask import Flask
import pymysql
import os
import socket

app = Flask(__name__)

@app.route("/")
def home():

    hostname = socket.gethostname()

    try:
        conn = pymysql.connect(
            host=os.getenv("DB_HOST"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            database=os.getenv("DB_NAME")
        )

        cursor = conn.cursor()

        cursor.execute("""
        CREATE TABLE IF NOT EXISTS visitors(
            id INT AUTO_INCREMENT PRIMARY KEY,
            hostname VARCHAR(100)
        )
        """)

        cursor.execute(
            "INSERT INTO visitors(hostname) VALUES(%s)",
            (hostname,)
        )

        conn.commit()

        cursor.execute("SELECT COUNT(*) FROM visitors")
        count = cursor.fetchone()[0]

        conn.close()

        status = "Connected ✅"

    except Exception as e:

        status = f"Failed ❌ {e}"
        count = 0

    return f"""
    <h1>🚀 DevOps Project</h1>

    <h2>{status}</h2>

    <h3>Hostname : {hostname}</h3>

    <h2>Total Visits : {count}</h2>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
