from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
<!DOCTYPE html>
<html>
<head>
    <title>DevOps Portfolio</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Arial, Helvetica, sans-serif;
        }

        body{
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            background:linear-gradient(135deg,#1e0033,#4b0082,#8a2be2);
            color:white;
        }

        .card{
            text-align:center;
            background:rgba(255,255,255,0.08);
            backdrop-filter:blur(15px);
            padding:50px;
            border-radius:20px;
            box-shadow:0 10px 30px rgba(0,0,0,.4);
            width:650px;
        }

        h1{
            font-size:48px;
            margin-bottom:20px;
        }

        h2{
            color:#d8b4fe;
            margin-bottom:30px;
        }

        p{
            font-size:18px;
            color:#f1f1f1;
            margin:10px;
        }

        .badge{
            display:inline-block;
            margin:8px;
            padding:10px 18px;
            background:#7c3aed;
            border-radius:30px;
            font-weight:bold;
        }

        footer{
            margin-top:35px;
            color:#cccccc;
            font-size:14px;
        }
    </style>

</head>

<body>

<div class="card">

<h1>🚀 DevOps Portfolio</h1>

<h2>Flask Application Running Successfully</h2>

<p>End-to-End CI/CD Pipeline</p>

<div>
<span class="badge">Docker</span>
<span class="badge">GitHub Actions</span>
<span class="badge">Terraform</span>
<span class="badge">AWS ECS</span>
<span class="badge">Amazon ECR</span>
<span class="badge">RDS</span>
</div>

<footer>
Built by Joshual Poulose ❤️
</footer>

</div>

</body>

</html>
"""

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
