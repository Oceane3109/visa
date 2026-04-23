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
                <li class="nav-item ms-lg-3"><a class="nav-link" href="/visa-back/"><span class="badge-env">Administration</span></a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="page-hero">
    <div class="container">
        <h1><i class="bi bi-file-earmark-plus me-2"></i>Nouvelle demande de transformation</h1>
        <p>Remplissez le formulaire ci-dessous pour soumettre votre demande de transformation de visa</p>
    </div>
</section>

<div class="container pb-5">
    <c:if test="${not empty error}">
        <div class="alert alert-danger d-flex align-items-center mb-4" style="border-radius:10px;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <ul class="form-stepper">
        <li class="step active">&Eacute;tat civil</li>
        <li class="step-line"></li>
        <li class="step active">Passeport</li>
        <li class="step-line"></li>
        <li class="step active">Visa actuel</li>
        <li class="step-line"></li>
        <li class="step active">Demande</li>
    </ul>

    <form action="${pageContext.request.contextPath}/nouvelle-demande" method="post">

        <!-- Section 1: État civil -->
        <div class="form-section">
            <div class="form-section-title">
                <i class="bi bi-person-vcard"></i> Fiche de renseignements — &Eacute;tat civil
            </div>
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Nom <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="nom" required placeholder="Votre nom">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Pr&eacute;nom <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="prenom" required placeholder="Votre pr&eacute;nom">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Nom de jeune fille</label>
                    <input type="text" class="form-control" name="nomJeuneFille" placeholder="Si applicable">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Situation familiale <span class="text-danger">*</span></label>
                    <select class="form-select" name="situationFamiliale" required>
                        <option value="">— S&eacute;lectionnez —</option>
                        <option value="CELIBATAIRE">C&eacute;libataire</option>
                        <option value="MARIE">Mari&eacute;(e)</option>
                        <option value="DIVORCE">Divorc&eacute;(e)</option>
                        <option value="VEUF">Veuf/Veuve</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Nationalit&eacute; <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="nationalite" required placeholder="Ex: Fran&ccedil;aise">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Profession</label>
                    <input type="text" class="form-control" name="profession" placeholder="Votre profession">
                </div>
                <div class="col-md-8">
                    <label class="form-label">Adresse &agrave; Madagascar <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="adresseMadagascar" required placeholder="Adresse compl&egrave;te">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Contact <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="contact" required placeholder="T&eacute;l&eacute;phone / Email">
                </div>
            </div>
        </div>

        <!-- Section 2: Passeport -->
        <div class="form-section">
            <div class="form-section-title">
                <i class="bi bi-journal-bookmark"></i> Informations sur le passeport
            </div>
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Num&eacute;ro de passeport <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="passeportNumero" required placeholder="Ex: 12AB34567">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Date de d&eacute;livrance <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" name="passeportDateDelivrance" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Date d'expiration <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" name="passeportDateExpiration" required>
                </div>
            </div>
        </div>

        <!-- Section 3: Visa transformable -->
        <div class="form-section">
            <div class="form-section-title">
                <i class="bi bi-passport"></i> Informations sur le visa transformable
            </div>
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">R&eacute;f&eacute;rence du visa <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="visaReference" required placeholder="R&eacute;f. visa">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Date d'entr&eacute;e <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" name="visaDateEntree" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Lieu d'entr&eacute;e <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="visaLieuEntree" required placeholder="Ex: Ivato">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Date d'expiration <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" name="visaDateExpiration" required>
                </div>
            </div>
        </div>

        <!-- Section 4: Type de visa -->
        <div class="form-section">
            <div class="form-section-title">
                <i class="bi bi-card-checklist"></i> Type de visa demand&eacute;
            </div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Objectif de la demande <span class="text-danger">*</span></label>
                    <select class="form-select" name="objectifDemande" required>
                        <option value="">— S&eacute;lectionnez —</option>
                        <option value="CARTE_RESIDENT">Carte de r&eacute;sident</option>
                        <option value="VISA">Visa</option>
                        <option value="DUPLICATA_CARTE">Duplicata de carte</option>
                        <option value="TRANSFERT_VISA">Transfert de visa</option>
                    </select>
                </div>
                <div class="col-md-6">
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
                              placeholder="Pr&eacute;cisez toute information sp&eacute;cifique li&eacute;e au type de visa demand&eacute;"></textarea>
                </div>
            </div>
        </div>

        <div class="text-end mt-4">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary me-2">
                <i class="bi bi-x-lg me-1"></i> Annuler
            </a>
            <button type="submit" class="btn btn-campus btn-lg px-5">
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
