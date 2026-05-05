import React, { useState, useEffect } from 'react';
import { useParams, Link, useSearchParams } from 'react-router-dom';
import { rechercherParNumeroDemande, getQrCodeUrl } from '../api';

function DetailDemande() {
  const { numeroDemande } = useParams();
  const [searchParams] = useSearchParams();
  const fromQrCode = searchParams.get('from') === 'qrcode';
  const [demande, setDemande] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      try {
        const data = await rechercherParNumeroDemande(numeroDemande);
        setDemande(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [numeroDemande]);

  if (loading) {
    return (
      <div className="container py-5 text-center">
        <div className="spinner-border" role="status"></div>
        <p className="mt-2" style={{ color: 'var(--slate-500)' }}>Chargement...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container py-5">
        <div className="alert alert-danger" style={{ borderRadius: 'var(--radius)', border: 'none' }}>
          <i className="bi bi-exclamation-triangle me-2"></i>{error}
        </div>
        {!fromQrCode && (
          <Link to="/recherche" className="btn btn-outline-campus">
            <i className="bi bi-arrow-left me-1"></i> Retour
          </Link>
        )}
      </div>
    );
  }

  if (!demande) return null;

  const isDuplicata = demande.objectifDemande === 'DUPLICATA_CARTE' || demande.objectifDemande === 'TRANSFERT_VISA';

  return (
    <>
      <section className="page-hero">
        <div className="container" style={{ position: 'relative' }}>
          <div className="row align-items-center">
            <div className="col-lg-8">
              {!fromQrCode && (
                <div style={{ marginBottom: '0.75rem' }}>
                  <Link to="/recherche" style={{ color: 'rgba(255,255,255,0.6)', textDecoration: 'none', fontSize: '0.85rem' }}>
                    <i className="bi bi-arrow-left me-1"></i> Retour à la recherche
                  </Link>
                </div>
              )}
              <h1><i className="bi bi-file-text me-2"></i>Demande {demande.numeroDemande}</h1>
              <p>
                {demande.nom} {demande.prenom} — {demande.objectifDemandeLibelle}
              </p>
            </div>
            <div className="col-lg-4 text-lg-end mt-3 mt-lg-0">
              <span className={`status-badge status-${demande.statut}`} style={{ fontSize: '0.85rem', padding: '0.5rem 1.2rem' }}>
                {demande.statutLibelle}
              </span>
            </div>
          </div>
        </div>
      </section>

      <div className="container pb-5">
        <div className="row g-4">
          <div className="col-lg-8">
            {isDuplicata && (
              <div className="alert" style={{
                background: 'var(--violet-light)', color: 'var(--violet)',
                borderRadius: 'var(--radius)', border: 'none', fontWeight: 600,
                marginBottom: '1.5rem'
              }}>
                <i className="bi bi-check-circle-fill me-2"></i>
                Dossier terminé — Demande approuvée automatiquement ({demande.objectifDemandeLibelle})
              </div>
            )}

            <div className="form-section">
              <div className="form-section-title">
                <i className="bi bi-person-fill"></i> Informations du demandeur
              </div>
              <div className="row">
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Nom</div>
                    <div className="detail-value">{demande.nom}</div>
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Prénom</div>
                    <div className="detail-value">{demande.prenom}</div>
                  </div>
                </div>
                {demande.nomJeuneFille && (
                  <div className="col-md-6">
                    <div className="detail-group">
                      <div className="detail-label">Nom de jeune fille</div>
                      <div className="detail-value">{demande.nomJeuneFille}</div>
                    </div>
                  </div>
                )}
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Situation familiale</div>
                    <div className="detail-value">{demande.situationFamilialeLibelle}</div>
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Nationalité</div>
                    <div className="detail-value">{demande.nationalite}</div>
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Profession</div>
                    <div className="detail-value">{demande.profession || '—'}</div>
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Adresse à Madagascar</div>
                    <div className="detail-value">{demande.adresseMadagascar}</div>
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Contact</div>
                    <div className="detail-value">{demande.contact}</div>
                  </div>
                </div>
              </div>
            </div>

            <div className="form-section">
              <div className="form-section-title">
                <i className="bi bi-passport-fill"></i> Passeport
              </div>
              <div className="row">
                <div className="col-md-4">
                  <div className="detail-group">
                    <div className="detail-label">Numéro</div>
                    <div className="detail-value">{demande.passeportNumero}</div>
                  </div>
                </div>
                <div className="col-md-4">
                  <div className="detail-group">
                    <div className="detail-label">Date de délivrance</div>
                    <div className="detail-value">{demande.passeportDateDelivrance}</div>
                  </div>
                </div>
                <div className="col-md-4">
                  <div className="detail-group">
                    <div className="detail-label">Date d'expiration</div>
                    <div className="detail-value">{demande.passeportDateExpiration}</div>
                  </div>
                </div>
              </div>
            </div>

            <div className="form-section">
              <div className="form-section-title">
                <i className="bi bi-airplane-fill"></i> Visa transformable
              </div>
              <div className="row">
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Référence visa</div>
                    <div className="detail-value">{demande.visaReference}</div>
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Lieu d'entrée</div>
                    <div className="detail-value">{demande.visaLieuEntree}</div>
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Date d'entrée</div>
                    <div className="detail-value">{demande.visaDateEntree}</div>
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="detail-group">
                    <div className="detail-label">Date d'expiration</div>
                    <div className="detail-value">{demande.visaDateExpiration}</div>
                  </div>
                </div>
              </div>
            </div>

            {demande.typeVisa && (
              <div className="form-section">
                <div className="form-section-title">
                  <i className="bi bi-card-text"></i> Type de visa demandé
                </div>
                <div className="detail-group">
                  <div className="detail-label">Type</div>
                  <div className="detail-value">{demande.typeVisa.libelle}</div>
                </div>
              </div>
            )}

            {demande.informationsComplementaires && (
              <div className="form-section">
                <div className="form-section-title">
                  <i className="bi bi-chat-left-text-fill"></i> Informations complémentaires
                </div>
                <div className="detail-value">{demande.informationsComplementaires}</div>
              </div>
            )}

            {demande.donneesIncompletes && demande.remarques && (
              <div className="alert" style={{
                background: 'var(--amber-light)', color: 'var(--amber)',
                borderRadius: 'var(--radius)', border: 'none', fontWeight: 600
              }}>
                <i className="bi bi-exclamation-triangle-fill me-2"></i>
                Données incomplètes : {demande.remarques}
              </div>
            )}
          </div>

          <div className="col-lg-4">
            {!fromQrCode && (
              <div className="form-section" style={{ textAlign: 'center' }}>
                <div className="form-section-title" style={{ justifyContent: 'center' }}>
                  <i className="bi bi-qr-code"></i> QR Code
                </div>
                <div className="qr-container">
                  <img
                    src={getQrCodeUrl(demande.numeroDemande)}
                    alt="QR Code"
                    width={200}
                    height={200}
                  />
                </div>
                <p style={{ fontSize: '0.82rem', color: 'var(--slate-500)', marginTop: '0.75rem' }}>
                  Scannez ce QR code pour accéder au suivi
                </p>
              </div>
            )}

            <div className="form-section">
              <div className="form-section-title">
                <i className="bi bi-info-circle-fill"></i> Résumé
              </div>
              <div className="detail-group">
                <div className="detail-label">Numéro de demande</div>
                <div className="detail-value" style={{ fontSize: '0.9rem' }}>{demande.numeroDemande}</div>
              </div>
              <div className="detail-group">
                <div className="detail-label">Date de création</div>
                <div className="detail-value" style={{ fontSize: '0.9rem' }}>
                  {demande.dateCreation ? new Date(demande.dateCreation).toLocaleString('fr-FR') : '—'}
                </div>
              </div>
              <div className="detail-group">
                <div className="detail-label">Statut</div>
                <div><span className={`status-badge status-${demande.statut}`}>{demande.statutLibelle}</span></div>
              </div>
              <div className="detail-group">
                <div className="detail-label">Objectif</div>
                <div className="detail-value" style={{ fontSize: '0.9rem' }}>{demande.objectifDemandeLibelle}</div>
              </div>
              {demande.dossier && (
                <div className="detail-group">
                  <div className="detail-label">Dossier</div>
                  <div className="detail-value" style={{ fontSize: '0.9rem' }}>{demande.dossier.numeroDossier}</div>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

export default DetailDemande;
