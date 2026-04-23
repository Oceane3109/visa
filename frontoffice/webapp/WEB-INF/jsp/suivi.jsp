<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Suivi de demande — Visa Madagascar</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/nouvelle-demande"><i class="bi bi-plus-circle me-1"></i> Nouvelle demande</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/suivi"><i class="bi bi-search me-1"></i> Suivi</a></li>
                <li class="nav-item ms-lg-3"><a class="nav-link" href="/visa-back2/"><span class="badge-env">Administration</span></a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="page-hero">
    <div class="container">
        <h1><i class="bi bi-search me-2"></i>Suivi de demande</h1>
        <p>Retrouvez l'&eacute;tat d'avancement de votre demande de transformation de visa</p>
    </div>
</section>

<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card-modern mb-4">
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/suivi" method="post">
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-white border-end-0" style="border-radius: 8px 0 0 8px;">
                                <i class="bi bi-hash text-primary"></i>
                            </span>
                            <input type="text" name="numeroDemande" class="form-control border-start-0"
                                   placeholder="Entrez votre num&eacute;ro de demande (ex: VT-202604-0001)"
                                   value="${numeroDemande}" required style="border-radius: 0;">
                            <button class="btn btn-campus" type="submit" style="border-radius: 0 8px 8px 0;">
                                <i class="bi bi-search me-1"></i> Rechercher
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-warning d-flex align-items-center" style="border-radius: 10px;">
                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <c:if test="${not empty demande}">
                <div class="card-modern">
                    <div class="card-header">
                        <i class="bi bi-file-earmark-text"></i>
                        Demande N&deg; ${demande.numeroDemande}
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <span class="badge badge-statut fs-6 ${demande.statutBadge}">${demande.statutLibelle}</span>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="detail-group">
                                    <div class="detail-label">Demandeur</div>
                                    <div class="detail-value">${demande.nom} ${demande.prenom}</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="detail-group">
                                    <div class="detail-label">Date de soumission</div>
                                    <div class="detail-value">${demande.dateCreation}</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="detail-group">
                                    <div class="detail-label">Type de visa demand&eacute;</div>
                                    <div class="detail-value">${demande.typeVisaLibelle}</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="detail-group">
                                    <div class="detail-label">Objectif</div>
                                    <div class="detail-value">${demande.objectifLibelle}</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="detail-group">
                                    <div class="detail-label">R&eacute;f&eacute;rence visa transformable</div>
                                    <div class="detail-value">${demande.visaReference}</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="detail-group">
                                    <div class="detail-label">N&deg; Passeport</div>
                                    <div class="detail-value">${demande.passeportNumero}</div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty demande.numeroDossier}">
                            <div class="alert alert-primary mt-4 d-flex align-items-start" style="border-radius: 10px;">
                                <i class="bi bi-folder-fill me-2 mt-1"></i>
                                <div>
                                    <strong>Dossier li&eacute;</strong><br>
                                    <span>N&deg; ${demande.numeroDossier}</span>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${demande.donneesIncompletes}">
                            <div class="alert alert-danger mt-4 d-flex align-items-start" style="border-radius: 10px;">
                                <i class="bi bi-exclamation-octagon-fill me-2 mt-1"></i>
                                <div>
                                    <strong>Donn&eacute;es incompl&egrave;tes</strong><br>
                                    <span>${demande.remarques}</span>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
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
