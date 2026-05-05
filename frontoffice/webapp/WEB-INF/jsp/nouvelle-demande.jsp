<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle demande — Visa Madagascar</title>
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
                <li class="nav-item ms-lg-3"><a class="nav-link" href="/visa-back4/"><span class="badge-env">Administration</span></a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="page-hero">
    <div class="container" style="position:relative;">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1><i class="bi bi-file-earmark-plus me-2"></i>Nouvelle demande</h1>
                <p>Remplissez le formulaire ci-dessous pour soumettre votre demande de transformation de visa</p>
            </div>
            <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                <span style="display:inline-flex;align-items:center;gap:0.5rem;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.12);border-radius:10px;padding:0.5rem 1rem;font-size:0.82rem;backdrop-filter:blur(10px);">
                    <i class="bi bi-shield-check"></i> Formulaire s&eacute;curis&eacute;
                </span>
            </div>
        </div>
    </div>
</section>

<div class="container pb-5">
    <c:if test="${not empty error}">
        <div class="alert alert-danger d-flex align-items-center mb-4" style="border-radius:12px;border:none;box-shadow:0 2px 8px rgba(225,29,72,0.1);">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- Stepper -->
    <div class="card-modern mb-4" style="border:none;background:var(--white);">
        <div class="card-body py-3 px-0">
            <ul class="form-stepper mb-0">
                <li class="step active"><span class="d-none d-sm-inline">&Eacute;tat civil</span><span class="d-sm-none">1</span></li>
                <li class="step-line"></li>
                <li class="step active"><span class="d-none d-sm-inline">Passeport</span><span class="d-sm-none">2</span></li>
                <li class="step-line"></li>
                <li class="step active"><span class="d-none d-sm-inline">Visa actuel</span><span class="d-sm-none">3</span></li>
                <li class="step-line"></li>
                <li class="step active"><span class="d-none d-sm-inline">Demande</span><span class="d-sm-none">4</span></li>
            </ul>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/nouvelle-demande" method="post">

        <div class="row g-4">
            <div class="col-lg-8">
                <!-- Section 1: &Eacute;tat civil -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="bi bi-person-vcard"></i> &Eacute;tat civil
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <label class="form-label">Nom <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="nom" required placeholder="Votre nom">
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Pr&eacute;nom <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="prenom" required placeholder="Votre pr&eacute;nom">
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Nom de jeune fille</label>
                            <input type="text" class="form-control" name="nomJeuneFille" placeholder="Si applicable">
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Situation familiale <span class="text-danger">*</span></label>
                            <select class="form-select" name="situationFamiliale" required>
                                <option value="">— S&eacute;lectionnez —</option>
                                <option value="CELIBATAIRE">C&eacute;libataire</option>
                                <option value="MARIE">Mari&eacute;(e)</option>
                                <option value="DIVORCE">Divorc&eacute;(e)</option>
                                <option value="VEUF">Veuf/Veuve</option>
                            </select>
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Nationalit&eacute; <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="nationalite" required placeholder="Ex: Fran&ccedil;aise">
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Profession</label>
                            <input type="text" class="form-control" name="profession" placeholder="Votre profession">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Adresse &agrave; Madagascar <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="adresseMadagascar" required placeholder="Adresse compl&egrave;te &agrave; Madagascar">
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Contact <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="contact" required placeholder="T&eacute;l&eacute;phone / Email">
                        </div>
                    </div>
                </div>

                <!-- Section 2: Passeport -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="bi bi-journal-bookmark"></i> Passeport
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-12 col-md-4">
                            <label class="form-label">Num&eacute;ro <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="passeportNumero" required placeholder="Ex: 12AB34567">
                        </div>
                        <div class="col-sm-6 col-md-4">
                            <label class="form-label">Date de d&eacute;livrance <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" name="passeportDateDelivrance" required>
                        </div>
                        <div class="col-sm-6 col-md-4">
                            <label class="form-label">Date d'expiration <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" name="passeportDateExpiration" required>
                        </div>
                    </div>
                </div>

                <!-- Section 3: Visa transformable -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="bi bi-passport"></i> Visa transformable
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <label class="form-label">R&eacute;f&eacute;rence du visa <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="visaReference" required placeholder="R&eacute;f. visa">
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Lieu d'entr&eacute;e <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="visaLieuEntree" required placeholder="Ex: Ivato">
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Date d'entr&eacute;e <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" name="visaDateEntree" required>
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Date d'expiration <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" name="visaDateExpiration" required>
                        </div>
                    </div>
                </div>

                <!-- Section 4: Type de visa -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="bi bi-card-checklist"></i> Transformation demand&eacute;e
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <label class="form-label">Objectif de la demande <span class="text-danger">*</span></label>
                            <select class="form-select" name="objectifDemande" required>
                                <option value="">— S&eacute;lectionnez —</option>
                                <option value="CARTE_RESIDENT">Carte de r&eacute;sident</option>
                                <option value="VISA">Visa</option>
                                <option value="DUPLICATA_CARTE">Duplicata de carte</option>
                                <option value="TRANSFERT_VISA">Transfert de visa</option>
                            </select>
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label">Type de visa souhait&eacute; <span class="text-danger">*</span></label>
                            <select class="form-select" name="typeVisaId" required>
                                <option value="">— S&eacute;lectionnez —</option>
                                <c:forEach var="tv" items="${typesVisa}">
                                    <option value="${tv.id}">${tv.libelle} (${tv.code})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Informations compl&eacute;mentaires</label>
                            <textarea class="form-control" name="informationsComplementaires" rows="3"
                                      placeholder="Pr&eacute;cisez toute information utile li&eacute;e &agrave; votre demande"></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <div style="position:sticky;top:90px;">
                    <div class="card-modern mb-4">
                        <div class="card-header">
                            <i class="bi bi-info-circle" style="color:var(--sky);"></i>
                            <strong>R&eacute;capitulatif</strong>
                        </div>
                        <div class="card-body" style="padding:1.25rem;">
                            <div class="d-flex align-items-center gap-3 mb-3 pb-3" style="border-bottom:1px solid var(--slate-100);">
                                <div style="width:36px;height:36px;border-radius:10px;background:var(--slate-100);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                    <i class="bi bi-1-circle" style="color:var(--primary);"></i>
                                </div>
                                <div>
                                    <div style="font-weight:700;font-size:0.85rem;">Remplissez le formulaire</div>
                                    <div style="font-size:0.75rem;color:var(--slate-400);">Tous les champs requis (*)</div>
                                </div>
                            </div>
                            <div class="d-flex align-items-center gap-3 mb-3 pb-3" style="border-bottom:1px solid var(--slate-100);">
                                <div style="width:36px;height:36px;border-radius:10px;background:var(--slate-100);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                    <i class="bi bi-2-circle" style="color:var(--primary);"></i>
                                </div>
                                <div>
                                    <div style="font-weight:700;font-size:0.85rem;">Soumettez la demande</div>
                                    <div style="font-size:0.75rem;color:var(--slate-400);">V&eacute;rification automatique</div>
                                </div>
                            </div>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width:36px;height:36px;border-radius:10px;background:var(--emerald-light);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                    <i class="bi bi-3-circle" style="color:var(--emerald);"></i>
                                </div>
                                <div>
                                    <div style="font-weight:700;font-size:0.85rem;">Recevez votre r&eacute;f&eacute;rence</div>
                                    <div style="font-size:0.75rem;color:var(--slate-400);">Pour suivre l'avancement</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card-modern">
                        <div class="card-body text-center" style="padding:1.5rem;">
                            <i class="bi bi-question-circle" style="font-size:1.5rem;color:var(--slate-300);display:block;margin-bottom:0.75rem;"></i>
                            <div style="font-weight:700;font-size:0.9rem;color:var(--slate-600);margin-bottom:0.25rem;">Besoin d'aide ?</div>
                            <div style="font-size:0.78rem;color:var(--slate-400);">Contactez la DGIE pour toute question relative &agrave; votre demande</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="d-flex flex-column flex-sm-row justify-content-end gap-2 mt-4">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary" style="border-radius:10px;">
                <i class="bi bi-x-lg me-1"></i> Annuler
            </a>
            <button type="submit" class="btn btn-campus btn-lg px-5" style="border-radius:12px;">
                <i class="bi bi-send me-1"></i> Soumettre la demande
            </button>
        </div>
    </form>
</div>

<footer class="footer-campus">
    <div class="container text-center">
        <p class="mb-0">&copy; 2026 — Minist&egrave;re de l'Int&eacute;rieur — Direction G&eacute;n&eacute;rale de l'Immigration et de l'&Eacute;migration — Madagascar</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
