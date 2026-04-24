-- ============================================================================
-- Script complet de gestion de la base de données visa
-- ============================================================================

-- ============================================================================
-- 1. NETTOYAGE (DELETE / TRUNCATE)
-- ============================================================================

-- Supprimer toutes les demandes
DELETE FROM demande;

-- Réinitialiser la séquence d'auto-incrément
ALTER SEQUENCE demande_id_seq RESTART WITH 1;

-- Optionnel: supprimer et recréer les types de visa
DELETE FROM type_visa;
ALTER SEQUENCE type_visa_id_seq RESTART WITH 1;

-- ============================================================================
-- 2. INSERTION DES DONNÉES PAR DÉFAUT
-- ============================================================================

-- Insérer les types de visa par défaut
INSERT INTO type_visa (code, libelle, description) VALUES
('INV', 'Investisseur', 'Visa pour les investisseurs étrangers'),
('TRV', 'Travailleur', 'Visa pour les travailleurs salariés'),
('ETU', 'Étudiant', 'Visa pour les étudiants'),
('FAM', 'Regroupement familial', 'Visa pour regroupement familial'),
('RET', 'Retraité', 'Visa pour les retraités'),
('MIS', 'Missionnaire', 'Visa pour mission religieuse ou humanitaire'),
('COM', 'Commerçant', 'Visa pour activité commerciale');

-- ============================================================================
-- 3. REQUÊTES SELECT (CONSULTATION)
-- ============================================================================

-- Voir toutes les demandes
SELECT * FROM demande ORDER BY date_creation DESC;

-- Voir toutes les demandes par statut
SELECT * FROM demande WHERE statut = 'SOUMISE' ORDER BY date_creation DESC;

-- Voir une demande spécifique par numéro
SELECT * FROM demande WHERE numero_demande = 'VT-202604-0001';

-- Voir les demandes par type de visa
SELECT d.*, tv.libelle as type_visa_libelle
FROM demande d
JOIN type_visa tv ON d.type_visa_id = tv.id
ORDER BY d.date_creation DESC;

-- Voir les demandes incomplètes
SELECT * FROM demande WHERE donnees_incompletes = true;

-- Voir les statistiques par statut
SELECT statut, COUNT(*) as nombre
FROM demande
GROUP BY statut;

-- Voir tous les types de visa
SELECT * FROM type_visa ORDER BY code;

-- ============================================================================
-- 4. REQUÊTES UPDATE (MODIFICATION)
-- ============================================================================

-- Changer le statut d'une demande
UPDATE demande SET statut = 'EN_COURS' WHERE id = 1;

-- Marquer une demande comme incomplète avec remarques
UPDATE demande
SET donnees_incompletes = true, remarques = 'Manque photo d''identité'
WHERE id = 1;

-- Changer le type de visa d'une demande
UPDATE demande SET type_visa_id = 2 WHERE id = 1;

-- Modifier les informations complémentaires
UPDATE demande SET informations_complementaires = 'Mise à jour des informations' WHERE id = 1;

-- Modifier la date d'expiration du visa
UPDATE demande SET visa_date_expiration = '2026-12-31' WHERE id = 1;

-- ============================================================================
-- 5. REQUÊTES DELETE (SUPPRESSION SPÉCIFIQUE)
-- ============================================================================

-- Supprimer une demande spécifique par ID
DELETE FROM demande WHERE id = 1;

-- Supprimer une demande par numéro
DELETE FROM demande WHERE numero_demande = 'VT-202604-0001';

-- Supprimer les demandes plus vieilles de X jours
DELETE FROM demande WHERE date_creation < NOW() - INTERVAL '30 days';

-- Supprimer un type de visa (attention: vérifier qu'il n'est pas utilisé)
DELETE FROM type_visa WHERE id = 1;

-- ============================================================================
-- 6. REQUÊTES UTILES
-- ============================================================================

-- Réinitialiser toutes les demandes au statut SOUMISE
UPDATE demande SET statut = 'SOUMISE';

-- Réinitialiser le marquage incomplet
UPDATE demande SET donnees_incompletes = false, remarques = NULL;

-- Compter le nombre total de demandes
SELECT COUNT(*) as total_demandes FROM demande;

-- Trouver les demandes avec passeport expiré
SELECT * FROM demande WHERE passeport_date_expiration < CURRENT_DATE;

-- Trouver les demandes avec visa expiré
SELECT * FROM demande WHERE visa_date_expiration < CURRENT_DATE;
