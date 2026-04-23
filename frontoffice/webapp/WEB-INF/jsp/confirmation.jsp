<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation — Visa Madagascar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card-modern">
                <div class="card-body confirmation-box">
                    <div class="check-circle">
                        <i class="bi bi-check-lg"></i>
                    </div>
                    <h2 class="fw-bold text-success mb-3">Demande soumise avec succ&egrave;s</h2>
                    <p class="text-muted mb-4">Votre demande de transformation de visa a &eacute;t&eacute; enregistr&eacute;e.</p>

                    <% if (request.getAttribute("numeroDemande") != null) { %>
                    <div class="alert alert-info d-inline-block px-4 py-3 mb-4" style="border-radius:10px;">
                        <small class="d-block text-muted mb-1">Votre num&eacute;ro de r&eacute;f&eacute;rence</small>
                        <strong class="fs-4"><%= request.getAttribute("numeroDemande") %></strong>
                    </div>
                    <% } %>

                    <p class="text-muted small mb-4">
                        <i class="bi bi-info-circle me-1"></i>
                        Conservez ce num&eacute;ro pr&eacute;cieusement. Il vous permettra de suivre l'avancement de votre demande.
                    </p>

                    <div class="d-flex justify-content-center gap-3">
                        <a href="${pageContext.request.contextPath}/suivi" class="btn btn-campus">
                            <i class="bi bi-search me-1"></i> Suivre ma demande
                        </a>
                        <a href="${pageContext.request.contextPath}/nouvelle-demande" class="btn btn-outline-campus">
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
