
# Gestion des visas transformables

## Définition

Un **visa transformable** est un visa provisoire délivré à l’aéroport, pouvant être transformé ultérieurement en un autre type de visa.

## Contraintes

- Le visa transformable doit être **traçable dans le système interne**
- Les données du visa initial ne sont pas disponibles pour le moment
- Il faut donc prévoir une **saisie manuelle via un formulaire**

---

## TAF (Travail à faire)

### Création d’un formulaire de demande de transformation de visa

Le formulaire doit inclure :

#### 1. Fiche de renseignements (état civil)

- Nom
- Prénom
- Nom de jeune fille
- Situation familiale
- Nationalité
- Adresse à Madagascar
- Profession
- Contact

#### 2. Informations sur le passeport

- Numéro
- Date de délivrance
- Date d’expiration

#### 3. Informations sur le visa transformable

- Référence du visa
- Date d’entrée
- Lieu d’entrée
- Date d’expiration

#### 4. Type de visa demandé

- Exemples : investisseur, travailleur, etc.
- Ajouter les **informations spécifiques selon le type de visa**

---

## Sprint 1

- Implémenter la **saisie de la demande**
- Enregistrer les données dans la **base de données**

---

## Objectifs de la demande

La demande peut concerner :

- Carte de résident
- Visa
- Duplicata de carte (optionnel)
- Transfert de visa uniquement

---

## Gestion des demandes

- Chaque demande possède un **statut évolutif**
- Prévoir un **marquage** pour les données absentes → nécessite une nouvelle saisie
- La **modification du type de visa** n’est pas encore prise en charge
