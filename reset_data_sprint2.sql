-- Reset Sprint 2 : données réalistes malagasy
DELETE FROM demande;
DELETE FROM dossier;

-- Reset sequences
SELECT setval(pg_get_serial_sequence('dossier', 'id'), 1, false);
SELECT setval(pg_get_serial_sequence('demande', 'id'), 1, false);

-- Dossiers
INSERT INTO dossier (id, numero_dossier, date_creation, passeport_numero, nom, prenom, nationalite, type_dossier) VALUES
(1, 'DOS-202604-0001', '2026-04-10 08:30:00', 'MG-2024-00451', 'RAKOTOMALALA', 'Andrianaivo', 'Malgache', 'DUPLICATA_CARTE'),
(2, 'DOS-202604-0002', '2026-04-12 10:15:00', 'MG-2023-01287', 'RASOAMANANA', 'Volatiana', 'Malgache', 'TRANSFERT_VISA'),
(3, 'DOS-202604-0003', '2026-04-18 14:00:00', 'MG-2022-00893', 'ANDRIANTSITOHAINA', 'Fenosoa', 'Malgache', 'DUPLICATA_CARTE');

SELECT setval(pg_get_serial_sequence('dossier', 'id'), 3);

-- Demandes
INSERT INTO demande (id, numero_demande, date_creation, statut, nom, prenom, nom_jeune_fille, situation_familiale, nationalite, adresse_madagascar, profession, contact, passeport_numero, passeport_date_delivrance, passeport_date_expiration, visa_reference, visa_date_entree, visa_lieu_entree, visa_date_expiration, type_visa_id, informations_complementaires, objectif_demande, donnees_incompletes, remarques, dossier_id) VALUES
(1, 'VT-202604-0001', '2026-04-02 09:15:00', 'VALIDEE',
 'RAZAFINDRAKOTO', 'Harinomena', NULL, 'MARIE', 'Malgache',
 'Lot IVG 123 Analakely, Antananarivo 101', 'Ingenieur informatique',
 '+261 34 12 345 67', 'MG-2025-00234', '2025-01-15', '2035-01-15',
 'VT-2025-0891', '2025-06-10', 'Ivato', '2026-06-10',
 1, 'Installation definitive a Madagascar', 'CARTE_RESIDENT', false, NULL, NULL),

(2, 'VT-202604-0002', '2026-04-05 11:30:00', 'EN_COURS',
 'RANAIVOSOA', 'Miora Lalaina', 'RABEMANANJARA', 'MARIE', 'Malgache',
 'Villa 45B Ambatobe, Antananarivo 103', 'Medecin generaliste',
 '+261 33 98 765 43', 'MG-2024-01102', '2024-03-20', '2034-03-20',
 'VT-2025-1456', '2025-09-01', 'Ivato', '2026-09-01',
 2, 'Renouvellement pour raison professionnelle', 'VISA', false, NULL, NULL),

(3, 'VT-202604-0003', '2026-04-10 08:45:00', 'APPROUVEE',
 'RAKOTOMALALA', 'Andrianaivo', NULL, 'CELIBATAIRE', 'Malgache',
 'Lot II M 78 Antsahavola, Antananarivo 101', 'Comptable',
 '+261 32 45 678 90', 'MG-2024-00451', '2024-06-01', '2034-06-01',
 'VT-2024-0723', '2024-08-15', 'Ivato', '2025-08-15',
 1, 'Carte perdue suite a un vol - declaration de police jointe', 'DUPLICATA_CARTE', false, NULL, 1),

(4, 'VT-202604-0004', '2026-04-12 10:20:00', 'APPROUVEE',
 'RASOAMANANA', 'Volatiana', 'RAHARIMANANA', 'MARIE', 'Malgache',
 'Lot 12 Ambatonakanga, Antananarivo 101', 'Professeur universite',
 '+261 34 56 789 01', 'MG-2023-01287', '2023-11-10', '2033-11-10',
 'VT-2023-2104', '2023-12-20', 'Toamasina', '2025-12-20',
 3, 'Changement de passeport - ancien passeport expire', 'TRANSFERT_VISA', false, NULL, 2),

(5, 'VT-202604-0005', '2026-04-15 14:00:00', 'SOUMISE',
 'RABEARIVELO', 'Tianasoa', NULL, 'CELIBATAIRE', 'Malgache',
 'Lot 7 Bis Isoraka, Antananarivo 101', 'Architecte',
 '+261 33 11 222 33', 'MG-2025-00678', '2025-02-28', '2035-02-28',
 'VT-2026-0045', '2026-01-10', 'Ivato', '2026-07-10',
 1, 'Premiere demande de carte de resident', 'CARTE_RESIDENT', false, NULL, NULL),

(6, 'VT-202604-0006', '2026-04-08 16:45:00', 'REJETEE',
 'ANDRIAMAHEFA', 'Toavina Ny Aina', NULL, 'DIVORCE', 'Malgache',
 'Lot 234 Ambohijatovo, Antananarivo 101', 'Commercant',
 '+261 32 00 111 22', 'MG-2024-00999', '2024-09-05', '2034-09-05',
 'VT-2025-0333', '2025-04-20', 'Nosy Be', '2026-04-20',
 2, NULL, 'VISA', false, 'Dossier rejete : visa transformable expire au moment du depot', NULL),

(7, 'VT-202604-0007', '2026-04-18 14:10:00', 'APPROUVEE',
 'ANDRIANTSITOHAINA', 'Fenosoa', NULL, 'MARIE', 'Malgache',
 'Lot 90 Ambohimanarina, Antananarivo 104', 'Avocat',
 '+261 34 77 888 99', 'MG-2022-00893', '2022-07-15', '2032-07-15',
 'VT-2022-1890', '2022-10-01', 'Ivato', '2024-10-01',
 1, 'Duplicata suite a deterioration de la carte originale', 'DUPLICATA_CARTE', false, NULL, 3),

(8, 'VT-202604-0008', '2026-04-20 09:00:00', 'INCOMPLETE',
 'RAVELOJAONA', 'Fitahiana', 'RASOANANDRASANA', 'MARIE', 'Malgache',
 'Lot 15 Andohan Mandroseza, Antananarivo 101', 'Sage-femme',
 '+261 33 44 555 66', 'MG-2025-01450', '2025-04-10', '2035-04-10',
 'VT-2026-0112', '2026-02-14', 'Ivato', '2026-08-14',
 2, NULL, 'CARTE_RESIDENT', true, 'Photo identite manquante. Copie du visa transformable illisible.', NULL),

(9, 'VT-202604-0009', '2026-04-22 10:30:00', 'SOUMISE',
 'RAHARINIRINA', 'Voahirana Mampionona', NULL, 'CELIBATAIRE', 'Malgache',
 'Lot 3 Ter Ankadifotsy, Antananarivo 101', 'Journaliste',
 '+261 34 22 333 44', 'MG-2025-01600', '2025-05-20', '2035-05-20',
 'VT-2026-0198', '2026-03-05', 'Ivato', '2026-09-05',
 3, 'Demande urgente pour raison familiale', 'VISA', false, NULL, NULL),

(10, 'VT-202604-0010', '2026-04-21 08:00:00', 'EN_COURS',
 'RAKOTONIRINA', 'Haja Fanomezantsoa', NULL, 'MARIE', 'Malgache',
 'Lot 88 Ambohijanahary, Antananarivo 101', 'Pharmacien',
 '+261 32 55 666 77', 'MG-2024-01800', '2024-12-01', '2034-12-01',
 'VT-2025-2200', '2025-07-15', 'Toamasina', '2026-07-15',
 1, 'Demande en cours de verification', 'CARTE_RESIDENT', false, NULL, NULL);

SELECT setval(pg_get_serial_sequence('demande', 'id'), 10);
