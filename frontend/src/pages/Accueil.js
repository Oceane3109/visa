import React from 'react';
import { Link } from 'react-router-dom';

function Accueil() {
  return (
    <>
      <section className="page-hero" style={{ padding: '4.5rem 0 4rem', textAlign: 'center' }}>
        <div className="container" style={{ position: 'relative' }}>
          <div style={{
            display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
            width: 72, height: 72, borderRadius: 20,
            background: 'rgba(255,255,255,0.08)', marginBottom: '1.5rem',
            border: '1px solid rgba(255,255,255,0.1)'
          }}>
            <i className="bi bi-globe2" style={{ fontSize: '2rem' }}></i>
          </div>
          <h1 style={{ fontSize: '2.5rem', letterSpacing: '-0.04em', marginBottom: '0.75rem' }}>Transformation de Visa</h1>
          <p style={{ maxWidth: 600, margin: '0 auto 2rem', fontSize: '1.05rem' }}>
            Plateforme officielle de gestion des demandes de transformation de visa — République de Madagascar
          </p>
          <div className="d-flex flex-column flex-sm-row justify-content-center gap-3">
            <Link to="/nouvelle-demande" className="btn btn-accent btn-lg px-4" style={{ borderRadius: 12 }}>
              <i className="bi bi-file-earmark-plus me-2"></i> Déposer une demande
            </Link>
            <Link to="/recherche" className="btn btn-outline-light btn-lg px-4" style={{ borderRadius: 12 }}>
              <i className="bi bi-search me-2"></i> Suivre ma demande
            </Link>
          </div>
        </div>
      </section>

      <div className="container pb-5">
        <div className="row g-4 mb-5" style={{ marginTop: '-3rem', position: 'relative', zIndex: 10 }}>
          <div className="col-md-4">
            <div className="feature-card">
              <div className="feature-icon" style={{ background: 'linear-gradient(135deg,rgba(15,23,42,0.08),rgba(15,23,42,0.03))', color: 'var(--primary)' }}>
                <i className="bi bi-file-earmark-plus"></i>
              </div>
              <h5>Nouvelle demande</h5>
              <p>Soumettez votre demande de transformation de visa en quelques étapes simples et sécurisées.</p>
              <Link to="/nouvelle-demande" className="btn btn-campus" style={{ borderRadius: 10 }}>
                <i className="bi bi-arrow-right me-1"></i> Commencer
              </Link>
            </div>
          </div>
          <div className="col-md-4">
            <div className="feature-card">
              <div className="feature-icon" style={{ background: 'linear-gradient(135deg,rgba(2,132,199,0.12),rgba(2,132,199,0.04))', color: 'var(--sky)' }}>
                <i className="bi bi-search"></i>
              </div>
              <h5>Suivi de demande</h5>
              <p>Consultez l'état d'avancement de votre demande à l'aide de votre numéro de référence.</p>
              <Link to="/recherche" className="btn btn-outline-campus" style={{ borderRadius: 10 }}>
                <i className="bi bi-arrow-right me-1"></i> Suivre
              </Link>
            </div>
          </div>
          <div className="col-md-4">
            <div className="feature-card">
              <div className="feature-icon" style={{ background: 'linear-gradient(135deg,rgba(5,150,105,0.12),rgba(5,150,105,0.04))', color: 'var(--emerald)' }}>
                <i className="bi bi-info-circle"></i>
              </div>
              <h5>Informations</h5>
              <p>Un visa transformable est un visa provisoire délivré à l'aéroport, transformable ultérieurement.</p>
              <button className="btn btn-outline-secondary disabled" style={{ borderRadius: 10 }}>
                <i className="bi bi-book me-1"></i> En savoir plus
              </button>
            </div>
          </div>
        </div>

        <div className="row g-4">
          <div className="col-lg-6">
            <div className="card-modern h-100">
              <div className="card-header" style={{ borderBottom: '2px solid var(--emerald-light)' }}>
                <i className="bi bi-check-circle-fill" style={{ color: 'var(--emerald)' }}></i>
                <strong>Types de demandes acceptées</strong>
              </div>
              <div className="card-body" style={{ padding: '1.5rem' }}>
                <div className="d-flex align-items-center gap-3 mb-3 pb-3" style={{ borderBottom: '1px solid var(--slate-100)' }}>
                  <div style={{ width: 40, height: 40, borderRadius: 10, background: 'var(--emerald-light)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                    <i className="bi bi-card-heading" style={{ color: 'var(--emerald)' }}></i>
                  </div>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Carte de résident</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Séjour longue durée</div>
                  </div>
                </div>
                <div className="d-flex align-items-center gap-3 mb-3 pb-3" style={{ borderBottom: '1px solid var(--slate-100)' }}>
                  <div style={{ width: 40, height: 40, borderRadius: 10, background: 'var(--sky-light)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                    <i className="bi bi-passport" style={{ color: 'var(--sky)' }}></i>
                  </div>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Visa long séjour</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Extension de visa</div>
                  </div>
                </div>
                <div className="d-flex align-items-center gap-3 mb-3 pb-3" style={{ borderBottom: '1px solid var(--slate-100)' }}>
                  <div style={{ width: 40, height: 40, borderRadius: 10, background: 'var(--violet-light)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                    <i className="bi bi-files" style={{ color: 'var(--violet)' }}></i>
                  </div>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Duplicata de carte</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Remplacement de carte perdue ou endommagée</div>
                  </div>
                </div>
                <div className="d-flex align-items-center gap-3">
                  <div style={{ width: 40, height: 40, borderRadius: 10, background: 'var(--amber-light)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                    <i className="bi bi-arrow-left-right" style={{ color: 'var(--amber)' }}></i>
                  </div>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Transfert de visa</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Transfert vers un nouveau passeport</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div className="col-lg-6">
            <div className="card-modern h-100">
              <div className="card-header" style={{ borderBottom: '2px solid var(--sky-light)' }}>
                <i className="bi bi-folder-fill" style={{ color: 'var(--sky)' }}></i>
                <strong>Documents nécessaires</strong>
              </div>
              <div className="card-body" style={{ padding: '1.5rem' }}>
                <div className="d-flex align-items-start gap-3 mb-3 pb-3" style={{ borderBottom: '1px solid var(--slate-100)' }}>
                  <div style={{ width: 32, height: 32, borderRadius: 8, background: 'var(--slate-100)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0, fontWeight: 800, fontSize: '0.82rem', color: 'var(--slate-500)' }}>1</div>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Passeport en cours de validité</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Original + copie de la page d'identité</div>
                  </div>
                </div>
                <div className="d-flex align-items-start gap-3 mb-3 pb-3" style={{ borderBottom: '1px solid var(--slate-100)' }}>
                  <div style={{ width: 32, height: 32, borderRadius: 8, background: 'var(--slate-100)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0, fontWeight: 800, fontSize: '0.82rem', color: 'var(--slate-500)' }}>2</div>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Visa transformable original</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Le visa délivré à l'aéroport</div>
                  </div>
                </div>
                <div className="d-flex align-items-start gap-3 mb-3 pb-3" style={{ borderBottom: '1px solid var(--slate-100)' }}>
                  <div style={{ width: 32, height: 32, borderRadius: 8, background: 'var(--slate-100)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0, fontWeight: 800, fontSize: '0.82rem', color: 'var(--slate-500)' }}>3</div>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Justificatif selon le type</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Contrat de travail, attestation d'hébergement, etc.</div>
                  </div>
                </div>
                <div className="d-flex align-items-start gap-3">
                  <div style={{ width: 32, height: 32, borderRadius: 8, background: 'var(--slate-100)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0, fontWeight: 800, fontSize: '0.82rem', color: 'var(--slate-500)' }}>4</div>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Photos d'identité récentes</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Format 4x4, fond blanc, moins de 6 mois</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

export default Accueil;
