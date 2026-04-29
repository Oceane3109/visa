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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/nouvelle-demande"><i class="bi bi-plus-circle me-1"></i> Nouvelle demande</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/suivi"><i class="bi bi-search me-1"></i> Suivi</a></li>
                <li class="nav-item ms-lg-3"><a class="nav-link" href="/visa-back3/"><span class="badge-env">Administration</span></a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="page-hero" style="text-align:center;">
    <div class="container" style="position:relative;">
        <div style="display:inline-flex;align-items:center;justify-content:center;width:60px;height:60px;border-radius:16px;background:rgba(255,255,255,0.08);margin-bottom:1rem;backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);">
            <i class="bi bi-search" style="font-size:1.5rem;"></i>
        </div>
        <h1>Suivi de demande</h1>
        <p style="max-width:500px;margin:0 auto;">Retrouvez l'&eacute;tat d'avancement de votre demande de transformation de visa</p>
    </div>
</section>

<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Search bar -->
            <div class="card-modern mb-4" style="margin-top:-2rem;position:relative;z-index:10;">
                <div class="card-body" style="padding:1.5rem;">
                    <form action="${pageContext.request.contextPath}/suivi" method="post">
                        <label style="font-weight:700;font-size:0.82rem;color:var(--slate-500);text-transform:uppercase;letter-spacing:0.5px;display:block;margin-bottom:0.6rem;">
                            <i class="bi bi-hash me-1"></i> Num&eacute;ro de demande
                        </label>
                        <div class="d-flex flex-column flex-sm-row gap-2">
                            <input type="text" name="numeroDemande" class="form-control form-control-lg"
                                   placeholder="Ex: VT-202604-0001"
                                   value="${numeroDemande}" required
                                   style="border-radius:12px;border:2px solid var(--slate-200);font-size:1rem;font-weight:600;padding:0.8rem 1rem;">
                            <button class="btn btn-campus btn-lg flex-shrink-0" type="submit" style="border-radius:12px;white-space:nowrap;">
                                <i class="bi bi-search me-1"></i> Rechercher
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="card-modern mb-4" style="border-color:var(--amber-light);">
                    <div class="card-body d-flex align-items-center gap-3" style="padding:1.25rem;">
                        <div style="width:44px;height:44px;border-radius:12px;background:var(--amber-light);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="bi bi-exclamation-triangle-fill" style="color:var(--amber);font-size:1.1rem;"></i>
                        </div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;color:var(--slate-700);">Demande introuvable</div>
                            <div style="font-size:0.82rem;color:var(--slate-500);">${error}</div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty demande}">
                <div class="card-modern">
                    <div class="card-header d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center gap-2">
                        <div>
                            <i class="bi bi-file-earmark-text me-1"></i>
                            <strong>Demande N&deg; ${demande.numeroDemande}</strong>
                        </div>
                        <span class="badge badge-statut ${demande.statutBadge}" style="font-size:0.78rem;">${demande.statutLibelle}</span>
                    </div>
                    <div class="card-body" style="padding:1.5rem;">
                        <div class="row g-0">
                            <div class="col-sm-6" style="padding:1rem;">
                                <div class="detail-group">
                                    <div class="detail-label">Demandeur</div>
                                    <div class="detail-value">${demande.nom} ${demande.prenom}</div>
                                </div>
                            </div>
                            <div class="col-sm-6" style="padding:1rem;">
                                <div class="detail-group">
                                    <div class="detail-label">Date de soumission</div>
                                    <div class="detail-value">${demande.dateCreation}</div>
                                </div>
                            </div>
                            <div class="col-sm-6" style="padding:1rem;">
                                <div class="detail-group">
                                    <div class="detail-label">Type de visa demand&eacute;</div>
                                    <div class="detail-value">${demande.typeVisaLibelle}</div>
                                </div>
                            </div>
                            <div class="col-sm-6" style="padding:1rem;">
                                <div class="detail-group">
                                    <div class="detail-label">Objectif</div>
                                    <div class="detail-value">${demande.objectifLibelle}</div>
                                </div>
                            </div>
                            <div class="col-sm-6" style="padding:1rem;">
                                <div class="detail-group">
                                    <div class="detail-label">R&eacute;f&eacute;rence visa</div>
                                    <div class="detail-value">${demande.visaReference}</div>
                                </div>
                            </div>
                            <div class="col-sm-6" style="padding:1rem;">
                                <div class="detail-group">
                                    <div class="detail-label">N&deg; Passeport</div>
                                    <div class="detail-value">${demande.passeportNumero}</div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty demande.numeroDossier}">
                            <div class="d-flex align-items-center gap-3 mt-3 p-3" style="background:var(--violet-light);border-radius:12px;">
                                <div style="width:40px;height:40px;border-radius:10px;background:rgba(124,58,237,0.15);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                    <i class="bi bi-folder-fill" style="color:var(--violet);"></i>
                                </div>
                                <div>
                                    <div style="font-weight:700;font-size:0.85rem;color:var(--violet);">Dossier li&eacute;</div>
                                    <div style="font-size:0.82rem;color:var(--slate-600);">N&deg; ${demande.numeroDossier}</div>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${demande.donneesIncompletes}">
                            <div class="d-flex align-items-start gap-3 mt-3 p-3" style="background:var(--rose-light);border-radius:12px;">
                                <div style="width:40px;height:40px;border-radius:10px;background:rgba(225,29,72,0.15);display:flex;align-items:center;justify-content:center;flex-shrink:0;margin-top:2px;">
                                    <i class="bi bi-exclamation-octagon-fill" style="color:var(--rose);"></i>
                                </div>
                                <div>
                                    <div style="font-weight:700;font-size:0.85rem;color:var(--rose);">Donn&eacute;es incompl&egrave;tes</div>
                                    <div style="font-size:0.82rem;color:var(--slate-600);">${demande.remarques}</div>
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
