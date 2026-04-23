<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation — Visa Madagascar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-campus">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <span class="brand-icon"><i class="bi bi-globe2"></i></span>
            <span>Visa Madagascar</span>
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navFront">
            <i class="bi bi-list text-white fs-4"></i>
        </button>
        <div class="collapse navbar-collapse" id="navFront">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"><i class="bi bi-house-door me-1"></i> Accueil</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/nouvelle-demande"><i class="bi bi-plus-circle me-1"></i> Nouvelle demande</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/suivi"><i class="bi bi-search me-1"></i> Suivi</a></li>
                <li class="nav-item ms-lg-3"><a class="nav-link" href="/visa-back2/"><span class="badge-env">Administration</span></a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" style="padding-top:4rem;padding-bottom:4rem;">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card-modern" style="border:none;box-shadow:var(--shadow-xl);">
                <div class="card-body" style="padding:3rem 2.5rem;text-align:center;">
                    <div class="check-circle" style="width:90px;height:90px;border-radius:50%;background:linear-gradient(135deg,var(--emerald-light),rgba(5,150,105,0.15));display:flex;align-items:center;justify-content:center;margin:0 auto 2rem;box-shadow:0 8px 30px rgba(5,150,105,0.15);">
                        <i class="bi bi-check-lg" style="font-size:2.5rem;color:var(--emerald);"></i>
                    </div>
                    <h2 style="font-weight:800;color:var(--primary);margin-bottom:0.5rem;font-size:1.6rem;letter-spacing:-0.03em;">Demande soumise !</h2>
                    <p style="color:var(--slate-500);font-size:0.95rem;margin-bottom:2rem;">Votre demande de transformation de visa a &eacute;t&eacute; enregistr&eacute;e avec succ&egrave;s.</p>

                    <% if (request.getAttribute("numeroDemande") != null) { %>
                    <div style="background:var(--slate-50);border:2px dashed var(--slate-200);border-radius:14px;padding:1.25rem 1.5rem;margin-bottom:1.5rem;display:inline-block;">
                        <div style="font-size:0.72rem;font-weight:700;color:var(--slate-400);text-transform:uppercase;letter-spacing:0.8px;margin-bottom:0.4rem;">Votre num&eacute;ro de r&eacute;f&eacute;rence</div>
                        <div style="font-size:1.5rem;font-weight:900;color:var(--primary);letter-spacing:-0.02em;"><%= request.getAttribute("numeroDemande") %></div>
                    </div>
                    <% } %>

                    <p style="color:var(--slate-400);font-size:0.82rem;margin-bottom:2rem;max-width:380px;margin-left:auto;margin-right:auto;">
                        <i class="bi bi-shield-check me-1" style="color:var(--emerald);"></i>
                        Conservez ce num&eacute;ro pr&eacute;cieusement. Il vous permettra de suivre l'avancement de votre demande.
                    </p>

                    <div class="d-flex flex-column flex-sm-row justify-content-center gap-3">
                        <a href="${pageContext.request.contextPath}/suivi" class="btn btn-campus" style="border-radius:12px;">
                            <i class="bi bi-search me-1"></i> Suivre ma demande
                        </a>
                        <a href="${pageContext.request.contextPath}/nouvelle-demande" class="btn btn-outline-campus" style="border-radius:12px;">
                            <i class="bi bi-plus-circle me-1"></i> Nouvelle demande
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer-campus">
    <div class="container text-center">
        <p class="mb-0">&copy; 2026 — Minist&egrave;re de l'Int&eacute;rieur — Direction G&eacute;n&eacute;rale de l'Immigration et de l'&Eacute;migration — Madagascar</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
