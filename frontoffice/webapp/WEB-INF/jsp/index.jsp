<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visa Madagascar — Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
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
                <li class="nav-item ms-lg-3"><a class="nav-link" href="/visa-back3/"><span class="badge-env">Administration</span></a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero -->
<section class="page-hero" style="padding:4.5rem 0 4rem;text-align:center;">
    <div class="container" style="position:relative;">
        <div style="display:inline-flex;align-items:center;justify-content:center;width:72px;height:72px;border-radius:20px;background:rgba(255,255,255,0.08);margin-bottom:1.5rem;backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);">
            <i class="bi bi-globe2" style="font-size:2rem;"></i>
        </div>
        <h1 style="font-size:2.5rem;letter-spacing:-0.04em;margin-bottom:0.75rem;">Transformation de Visa</h1>
        <p style="max-width:600px;margin:0 auto 2rem;font-size:1.05rem;">Plateforme officielle de gestion des demandes de transformation de visa — R&eacute;publique de Madagascar</p>
        <div class="d-flex flex-column flex-sm-row justify-content-center gap-3">
            <a href="${pageContext.request.contextPath}/nouvelle-demande" class="btn btn-accent btn-lg px-4" style="border-radius:12px;">
                <i class="bi bi-file-earmark-plus me-2"></i> D&eacute;poser une demande
            </a>
            <a href="${pageContext.request.contextPath}/suivi" class="btn btn-outline-light btn-lg px-4" style="border-radius:12px;">
                <i class="bi bi-search me-2"></i> Suivre ma demande
            </a>
        </div>
    </div>
</section>

<div class="container pb-5">
    <!-- Feature cards -->
    <div class="row g-4 mb-5" style="margin-top:-3rem;position:relative;z-index:10;">
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon" style="background:linear-gradient(135deg,rgba(15,23,42,0.08),rgba(15,23,42,0.03));color:var(--primary);">
                    <i class="bi bi-file-earmark-plus"></i>
                </div>
                <h5>Nouvelle demande</h5>
                <p>Soumettez votre demande de transformation de visa en quelques &eacute;tapes simples et s&eacute;curis&eacute;es.</p>
                <a href="${pageContext.request.contextPath}/nouvelle-demande" class="btn btn-campus" style="border-radius:10px;">
                    <i class="bi bi-arrow-right me-1"></i> Commencer
                </a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon" style="background:linear-gradient(135deg,rgba(2,132,199,0.12),rgba(2,132,199,0.04));color:var(--sky);">
                    <i class="bi bi-search"></i>
                </div>
                <h5>Suivi de demande</h5>
                <p>Consultez l'&eacute;tat d'avancement de votre demande &agrave; l'aide de votre num&eacute;ro de r&eacute;f&eacute;rence.</p>
                <a href="${pageContext.request.contextPath}/suivi" class="btn btn-outline-campus" style="border-radius:10px;">
                    <i class="bi bi-arrow-right me-1"></i> Suivre
                </a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon" style="background:linear-gradient(135deg,rgba(5,150,105,0.12),rgba(5,150,105,0.04));color:var(--emerald);">
                    <i class="bi bi-info-circle"></i>
                </div>
                <h5>Informations</h5>
                <p>Un visa transformable est un visa provisoire d&eacute;livr&eacute; &agrave; l'a&eacute;roport, transformable ult&eacute;rieurement.</p>
                <span class="btn btn-outline-secondary disabled" style="border-radius:10px;"><i class="bi bi-book me-1"></i> En savoir plus</span>
            </div>
        </div>
    </div>

    <!-- Info section -->
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="card-modern h-100">
                <div class="card-header" style="border-bottom:2px solid var(--emerald-light);">
                    <i class="bi bi-check-circle-fill" style="color:var(--emerald);"></i>
                    <strong>Types de demandes accept&eacute;es</strong>
                </div>
                <div class="card-body" style="padding:1.5rem;">
                    <div class="d-flex align-items-center gap-3 mb-3 pb-3" style="border-bottom:1px solid var(--slate-100);">
                        <div style="width:40px;height:40px;border-radius:10px;background:var(--emerald-light);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="bi bi-card-heading" style="color:var(--emerald);"></i>
                        </div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;">Carte de r&eacute;sident</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">S&eacute;jour longue dur&eacute;e</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-3 mb-3 pb-3" style="border-bottom:1px solid var(--slate-100);">
                        <div style="width:40px;height:40px;border-radius:10px;background:var(--sky-light);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="bi bi-passport" style="color:var(--sky);"></i>
                        </div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;">Visa long s&eacute;jour</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">Extension de visa</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-3 mb-3 pb-3" style="border-bottom:1px solid var(--slate-100);">
                        <div style="width:40px;height:40px;border-radius:10px;background:var(--violet-light);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="bi bi-files" style="color:var(--violet);"></i>
                        </div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;">Duplicata de carte</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">Remplacement de carte perdue ou endommag&eacute;e</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div style="width:40px;height:40px;border-radius:10px;background:var(--amber-light);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="bi bi-arrow-left-right" style="color:var(--amber);"></i>
                        </div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;">Transfert de visa</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">Transfert vers un nouveau passeport</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card-modern h-100">
                <div class="card-header" style="border-bottom:2px solid var(--sky-light);">
                    <i class="bi bi-folder-fill" style="color:var(--sky);"></i>
                    <strong>Documents n&eacute;cessaires</strong>
                </div>
                <div class="card-body" style="padding:1.5rem;">
                    <div class="d-flex align-items-start gap-3 mb-3 pb-3" style="border-bottom:1px solid var(--slate-100);">
                        <div style="width:32px;height:32px;border-radius:8px;background:var(--slate-100);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-weight:800;font-size:0.82rem;color:var(--slate-500);">1</div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;">Passeport en cours de validit&eacute;</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">Original + copie de la page d'identit&eacute;</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-start gap-3 mb-3 pb-3" style="border-bottom:1px solid var(--slate-100);">
                        <div style="width:32px;height:32px;border-radius:8px;background:var(--slate-100);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-weight:800;font-size:0.82rem;color:var(--slate-500);">2</div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;">Visa transformable original</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">Le visa d&eacute;livr&eacute; &agrave; l'a&eacute;roport</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-start gap-3 mb-3 pb-3" style="border-bottom:1px solid var(--slate-100);">
                        <div style="width:32px;height:32px;border-radius:8px;background:var(--slate-100);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-weight:800;font-size:0.82rem;color:var(--slate-500);">3</div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;">Justificatif selon le type</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">Contrat de travail, attestation d'h&eacute;bergement, etc.</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-start gap-3">
                        <div style="width:32px;height:32px;border-radius:8px;background:var(--slate-100);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-weight:800;font-size:0.82rem;color:var(--slate-500);">4</div>
                        <div>
                            <div style="font-weight:700;font-size:0.9rem;">Photos d'identit&eacute; r&eacute;centes</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">Format 4x4, fond blanc, moins de 6 mois</div>
                        </div>
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
