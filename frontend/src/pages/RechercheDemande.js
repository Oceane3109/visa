import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { rechercherParPasseport, rechercherParNumeroDemande } from '../api';

function ResultatDemandeCard({ demande, navigate }) {
  const [showQr, setShowQr] = useState(false);
  return (
    <div className="result-card">
      <div onClick={() => navigate('/demandes/' + demande.numeroDemande)} style={{ cursor: 'pointer', flex: 1 }}>
        <div style={{ fontWeight: 700, fontSize: '0.95rem', marginBottom: 4 }}>
          {demande.numeroDemande}
        </div>
        <div style={{ fontSize: '0.82rem', color: 'var(--slate-500)' }}>
          {demande.nom} {demande.prenom} — {demande.objectifDemandeLibelle}
          {demande.dateCreation && <span> — {new Date(demande.dateCreation).toLocaleDateString('fr-FR')}</span>}
        </div>
      </div>
      <div className="d-flex align-items-center gap-2">
        <span className={`status-badge status-${demande.statut}`}>{demande.statutLibelle}</span>
        <button
          onClick={(e) => { e.stopPropagation(); setShowQr(!showQr); }}
          className="btn btn-sm"
          style={{ padding: '0.3rem 0.6rem', borderRadius: 8, border: '1px solid var(--slate-200)', background: showQr ? 'var(--slate-100)' : 'white' }}
        >
          <i className={`bi bi-qr-code${showQr ? '-fill' : ''}`} style={{ fontSize: '0.9rem' }}></i>
        </button>
        <i className="bi bi-chevron-right" style={{ color: 'var(--slate-400)' }}></i>
      </div>
      {showQr && (
        <div className="mt-3 text-center" style={{ paddingTop: '0.75rem', borderTop: '1px solid var(--slate-100)' }}>
          <img
            src={`/visa-back4/api/demandes/${demande.numeroDemande}/qrcode`}
            alt="QR Code"
            style={{ width: 120, height: 120, borderRadius: 8 }}
          />
          <div style={{ fontSize: '0.75rem', color: 'var(--slate-500)', marginTop: '0.5rem' }}>
            Scannez pour voir le détail
          </div>
        </div>
      )}
    </div>
  );
}

function RechercheDemande() {
  const [mode, setMode] = useState('passeport');
  const [query, setQuery] = useState('');
  const [resultats, setResultats] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSearch = async (e) => {
    e.preventDefault();
    if (!query.trim()) return;
    setLoading(true);
    setError('');
    setResultats(null);

    try {
      if (mode === 'passeport') {
        const data = await rechercherParPasseport(query.trim());
        setResultats(data);
      } else {
        const data = await rechercherParNumeroDemande(query.trim());
        navigate('/demandes/' + data.numeroDemande);
      }
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      <section className="page-hero" style={{ textAlign: 'center' }}>
        <div className="container" style={{ position: 'relative' }}>
          <div style={{
            display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
            width: 60, height: 60, borderRadius: 16,
            background: 'rgba(255,255,255,0.08)', marginBottom: '1rem',
            border: '1px solid rgba(255,255,255,0.1)'
          }}>
            <i className="bi bi-search" style={{ fontSize: '1.5rem' }}></i>
          </div>
          <h1>Suivi de demande</h1>
          <p>Recherchez par numéro de passeport ou numéro de demande</p>
        </div>
      </section>

      <div className="container pb-5">
        <div className="row justify-content-center">
          <div className="col-lg-8">
            <div className="search-box mb-4">
              <div className="d-flex gap-2 mb-3">
                <button
                  className={mode === 'passeport' ? 'btn btn-campus' : 'btn btn-outline-campus'}
                  onClick={() => { setMode('passeport'); setResultats(null); setError(''); setQuery(''); }}
                >
                  <i className="bi bi-passport me-1"></i> Par passeport
                </button>
                <button
                  className={mode === 'demande' ? 'btn btn-campus' : 'btn btn-outline-campus'}
                  onClick={() => { setMode('demande'); setResultats(null); setError(''); setQuery(''); }}
                >
                  <i className="bi bi-file-text me-1"></i> Par n° demande
                </button>
              </div>

              <form onSubmit={handleSearch}>
                <div className="input-group">
                  <input
                    type="text"
                    className="form-control"
                    placeholder={mode === 'passeport' ? 'Entrez le numéro de passeport...' : 'Entrez le numéro de demande (ex: VT-202604-0001)...'}
                    value={query}
                    onChange={(e) => setQuery(e.target.value)}
                    style={{ borderRadius: '10px 0 0 10px', border: '1.5px solid var(--slate-200)', padding: '0.75rem 1rem', fontSize: '0.95rem' }}
                  />
                  <button className="btn btn-accent" type="submit" disabled={loading}
                    style={{ borderRadius: '0 10px 10px 0', padding: '0.75rem 1.5rem' }}>
                    {loading ? <><i className="bi bi-hourglass-split me-1"></i> Recherche...</> : <><i className="bi bi-search me-1"></i> Rechercher</>}
                  </button>
                </div>
              </form>
            </div>

            {error && (
              <div className="alert alert-danger" style={{ borderRadius: 'var(--radius)', border: 'none' }}>
                <i className="bi bi-exclamation-triangle me-2"></i>{error}
              </div>
            )}

            {resultats && resultats.demandes && resultats.demandes.length === 0 && (
              <div className="empty-state">
                <div className="empty-icon"><i className="bi bi-inbox"></i></div>
                <h5 style={{ fontWeight: 700, color: 'var(--slate-700)' }}>Aucune demande trouvée</h5>
                <p style={{ color: 'var(--slate-500)' }}>Aucune demande associée au passeport <strong>{query}</strong></p>
              </div>
            )}

            {resultats && resultats.demandes && resultats.demandes.length > 0 && (
              <>
                <div className="d-flex align-items-center justify-content-between mb-3">
                  <h5 style={{ fontWeight: 800, color: 'var(--primary)', margin: 0 }}>
                    <i className="bi bi-passport me-2" style={{ color: 'var(--accent)' }}></i>
                    Passeport {resultats.passeportNumero}
                  </h5>
                  <span className="badge bg-dark" style={{ borderRadius: 50, padding: '0.4rem 0.8rem', fontSize: '0.75rem' }}>
                    {resultats.nombreDemandes} demande{resultats.nombreDemandes > 1 ? 's' : ''}
                  </span>
                </div>

                {resultats.dossier && (
                  <div className="card-modern mb-3" style={{ animation: 'none' }}>
                    <div className="card-body" style={{ padding: '1rem 1.25rem' }}>
                      <div className="d-flex align-items-center gap-3">
                        <div style={{
                          width: 40, height: 40, borderRadius: 10,
                          background: 'linear-gradient(135deg, rgba(8,145,178,0.12), rgba(8,145,178,0.04))',
                          display: 'flex', alignItems: 'center', justifyContent: 'center',
                          color: '#0891b2', fontSize: '1.1rem'
                        }}>
                          <i className="bi bi-folder-fill"></i>
                        </div>
                        <div>
                          <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Dossier {resultats.dossier.numeroDossier}</div>
                          <div style={{ fontSize: '0.78rem', color: 'var(--slate-500)' }}>
                            Scan : {resultats.dossier.scanTermine ?
                              <span style={{ color: 'var(--emerald)', fontWeight: 700 }}>Terminé</span> :
                              <span style={{ color: 'var(--amber)', fontWeight: 700 }}>En cours</span>}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                )}

                {resultats.demandes.map((d, i) => (
                  <ResultatDemandeCard key={i} demande={d} navigate={navigate} />
                ))}
              </>
            )}
          </div>
        </div>
      </div>
    </>
  );
}

export default RechercheDemande;
