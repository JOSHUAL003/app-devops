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

    background:url("/static/devops-bg.jpg") no-repeat center center fixed;
    background-size:cover;

    color:white;
    position:relative;
    overflow:hidden;
}

/* Dark overlay */

body::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:rgba(0,0,0,.55);
    z-index:0;
}

.card{
    position:relative;
    z-index:1;

    width:700px;

    text-align:center;

    padding:50px;

    border-radius:20px;

    background:rgba(25,25,35,.85);

    backdrop-filter:blur(15px);

    box-shadow:0 15px 40px rgba(0,0,0,.6);
}

h1{
    font-size:50px;
    margin-bottom:20px;
    color:white;
}

h2{
    color:#d8b4fe;
    margin-bottom:30px;
}

p{
    font-size:18px;
    margin-bottom:25px;
}

.badge{

    display:inline-block;

    margin:8px;

    padding:10px 18px;

    border-radius:30px;

    background:#6d28d9;

    font-weight:bold;

    transition:.3s;
}

.badge:hover{

    background:#8b5cf6;

    transform:scale(1.08);

}

footer{

    margin-top:40px;

    color:#ddd;

    font-size:15px;

}

.button{

    display:inline-block;

    margin-top:30px;

    padding:12px 25px;

    border-radius:30px;

    background:#2563eb;

    color:white;

    text-decoration:none;

    font-weight:bold;

    transition:.3s;

}

.button:hover{

    background:#1d4ed8;

    transform:translateY(-2px);

}

</style>

</head>

<body>

<div class="card">

<h1>DevOps Portfolio</h1>

<h2>Flask Application Running Successfully</h2>

<p>End-to-End CI/CD Pipeline on AWS</p>

<div>

<span class="badge">Docker</span>
<span class="badge">GitHub Actions</span>
<span class="badge">Terraform</span>
<span class="badge">AWS ECS</span>
<span class="badge">Amazon ECR</span>
<span class="badge">Amazon RDS</span>
<span class="badge">CloudWatch</span>
<span class="badge">IAM</span>
<span class="badge">VPC</span>
<span class="badge">ALB</span>

</div>

<footer>

Built by <b>Joshual Poulose</b> ❤️

</footer>

</div>

</body>

</html>

"""

@app.route("/health")
def health():
    return {
        "status": "healthy",
        "application": "DevOps Portfolio",
        "author": "Joshual Poulose"
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
