# 🧠 Résultat global du projet

Le système final permet :

- Gestion complète des visas transformables
- Suivi des demandes et documents
- Traçabilité des étrangers
- Gestion des cartes et duplicata
- Interface moderne connectée via API
- Accès rapide via QR code

---

## 📋 Vue d'ensemble des sprints

| Sprint | Thème principal | Statut |
|--------|----------------|--------|
| Sprint 1 | Formulaire de demande + base de données | ✅ Complété |
| Sprint 2 | Duplicata et transfert de dossier | ⏳ À venir |
| Sprint 3 | Gestion des pièces justificatives | ⏳ À venir |
| Sprint 4 | Application frontend + QR code | ⏳ À venir |

---

## 🏗️ Architecture actuelle

### Back Office (Spring Boot)
- Gestion administrative des demandes
- Validation des statuts
- Marquage des dossiers incomplets
- Filtres et statistiques

### Front Office (Framework custom + JSP)
- Formulaire de demande publique
- Suivi par numéro de demande
- Interface professionnelle style Campus France

### Base de données (PostgreSQL)
- Tables : `demande`, `type_visa`
- Gestion des statuts évolutifs
- Traçabilité via numéro unique

---

## 🔄 Workflow Git

- Branche dev : `sprint/N/description`
- Branche staging : `staging/sprint/N/feat/description`
- Branche fix : `fix/sprint/N/description`
- Voir `GIT_WORKFLOW.md` pour les détails
