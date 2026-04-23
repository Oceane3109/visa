<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visa Madagascar — Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- Navbar -->
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/"><i class="bi bi-house-door me-1"></i> Accueil</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/nouvelle-demande"><i class="bi bi-plus-circle me-1"></i> Nouvelle demande</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/suivi"><i class="bi bi-search me-1"></i> Suivi</a></li>
                <li class="nav-item ms-lg-3"><a class="nav-link" href="/visa-back2/"><span class="badge-env">Administration</span></a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero -->
<section class="page-hero text-center">
    <div class="container">
        <h1><i class="bi bi-globe2 me-2"></i>Transformation de Visa</h1>
        <p class="lead">Plateforme officielle de gestion des demandes de transformation de visa — R&eacute;publique de Madagascar</p>
    </div>
</section>

<div class="container pb-5">
    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon" style="background: rgba(0,40,85,0.08); color: var(--primary);">
                    <i class="bi bi-file-earmark-plus"></i>
                </div>
                <h5>Nouvelle demande</h5>
                <p>Soumettez votre demande de transformation de visa transformable en quelques &eacute;tapes simples.</p>
                <a href="${pageContext.request.contextPath}/nouvelle-demande" class="btn btn-campus">
                    <i class="bi bi-arrow-right me-1"></i> Commencer
                </a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon" style="background: rgba(13,202,240,0.1); color: var(--info);">
                    <i class="bi bi-search"></i>
                </div>
                <h5>Suivi de demande</h5>
                <p>Consultez l'&eacute;tat d'avancement de votre demande &agrave; l'aide de votre num&eacute;ro de r&eacute;f&eacute;rence.</p>
                <a href="${pageContext.request.contextPath}/suivi" class="btn btn-outline-campus">
                    <i class="bi bi-arrow-right me-1"></i> Suivre
                </a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon" style="background: rgba(25,135,84,0.1); color: var(--success);">
                    <i class="bi bi-info-circle"></i>
                </div>
                <h5>Informations</h5>
                <p>Un visa transformable est un visa provisoire d&eacute;livr&eacute; &agrave; l'a&eacute;roport, pouvant &ecirc;tre transform&eacute; ult&eacute;rieurement.</p>
                <span class="btn btn-outline-secondary disabled"><i class="bi bi-book me-1"></i> En savoir plus</span>
            </div>
        </div>
    </div>

    <div class="card-modern">
        <div class="card-header">
            <i class="bi bi-exclamation-triangle-fill text-warning"></i>
            Informations importantes
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h6 class="fw-bold text-primary mb-3">Types de demandes accept&eacute;es</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Carte de r&eacute;sident</li>
                        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Visa long s&eacute;jour</li>
                        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Duplicata de carte</li>
                        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Transfert de visa</li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <h6 class="fw-bold text-primary mb-3">Documents n&eacute;cessaires</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2"><i class="bi bi-folder-fill text-primary me-2"></i> Passeport en cours de validit&eacute;</li>
                        <li class="mb-2"><i class="bi bi-folder-fill text-primary me-2"></i> Visa transformable original</li>
                        <li class="mb-2"><i class="bi bi-folder-fill text-primary me-2"></i> Justificatif selon le type de visa</li>
                        <li class="mb-2"><i class="bi bi-folder-fill text-primary me-2"></i> Photo d'identit&eacute; r&eacute;cente</li>
                    </ul>
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
