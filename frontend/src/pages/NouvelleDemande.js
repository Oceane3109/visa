import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { creerDemande, getTypesVisa, getObjectifs, getSituationsFamiliales, getQrCodeUrl } from '../api';

function NouvelleDemande() {
  const navigate = useNavigate();
  const [typesVisa, setTypesVisa] = useState([]);
  const [objectifs, setObjectifs] = useState([]);
  const [situations, setSituations] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(null);

  const [form, setForm] = useState({
    nom: '', prenom: '', nomJeuneFille: '', situationFamiliale: '',
    nationalite: '', adresseMadagascar: '', profession: '', contact: '',
    passeportNumero: '', passeportDateDelivrance: '', passeportDateExpiration: '',
    visaReference: '', visaDateEntree: '', visaLieuEntree: '', visaDateExpiration: '',
    typeVisaId: '', objectifDemande: '', informationsComplementaires: ''
  });

  useEffect(() => {
    async function loadData() {
      try {
        const [tv, obj, sit] = await Promise.all([getTypesVisa(), getObjectifs(), getSituationsFamiliales()]);
        setTypesVisa(tv);
        setObjectifs(obj);
        setSituations(sit);
      } catch (err) {
        setError('Erreur lors du chargement des données de référence');
      }
    }
    loadData();
  }, []);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    try {
      const result = await creerDemande(form);
      setSuccess(result);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  if (success) {
    return (
      <>
        <section className="page-hero" style={{ textAlign: 'center' }}>
          <div className="container" style={{ position: 'relative' }}>
            <h1><i className="bi bi-check-circle me-2"></i>Demande créée</h1>
            <p>Votre demande a été enregistrée avec succès</p>
          </div>
        </section>
        <div className="container pb-5">
          <div className="row justify-content-center">
            <div className="col-lg-6">
              <div className="form-section" style={{ textAlign: 'center' }}>
                <div style={{
                  width: 90, height: 90, borderRadius: '50%',
                  background: 'linear-gradient(135deg, var(--emerald-light), rgba(5,150,105,0.15))',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  margin: '0 auto 1.5rem', fontSize: '2.25rem', color: 'var(--emerald)'
                }}>
                  <i className="bi bi-check-lg"></i>
                </div>
                <h4 style={{ fontWeight: 800, color: 'var(--primary)', marginBottom: '0.5rem' }}>
                  {success.numeroDemande}
                </h4>
                <p style={{ color: 'var(--slate-500)', marginBottom: '1.5rem' }}>
                  Conservez ce numéro pour suivre l'avancement de votre demande
                </p>
                <div className="qr-container mb-3">
                  <img
                    src={getQrCodeUrl(success.numeroDemande)}
                    alt="QR Code"
                    width={200}
                    height={200}
                  />
                </div>
                <p style={{ fontSize: '0.82rem', color: 'var(--slate-500)', marginBottom: '1.5rem' }}>
                  Scannez ce QR code pour accéder au suivi de votre demande
                </p>
                <div className="d-flex gap-2 justify-content-center">
                  <button className="btn btn-campus" onClick={() => navigate('/demandes/' + success.numeroDemande)}>
                    <i className="bi bi-eye me-1"></i> Voir la demande
                  </button>
                  <button className="btn btn-outline-campus" onClick={() => { setSuccess(null); setForm({
                    nom: '', prenom: '', nomJeuneFille: '', situationFamiliale: '',
                    nationalite: '', adresseMadagascar: '', profession: '', contact: '',
                    passeportNumero: '', passeportDateDelivrance: '', passeportDateExpiration: '',
                    visaReference: '', visaDateEntree: '', visaLieuEntree: '', visaDateExpiration: '',
                    typeVisaId: '', objectifDemande: '', informationsComplementaires: ''
                  }); }}>
                    <i className="bi bi-plus-circle me-1"></i> Nouvelle demande
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </>
    );
  }

  return (
    <>
      <section className="page-hero">
        <div className="container" style={{ position: 'relative' }}>
          <div className="row align-items-center">
            <div className="col-lg-8">
              <h1><i className="bi bi-file-earmark-plus me-2"></i>Nouvelle demande</h1>
              <p>Remplissez le formulaire ci-dessous pour soumettre votre demande de transformation de visa</p>
            </div>
            <div className="col-lg-4 text-lg-end mt-3 mt-lg-0">
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: '0.5rem', background: 'rgba(255,255,255,0.08)', border: '1px solid rgba(255,255,255,0.12)', borderRadius: 10, padding: '0.5rem 1rem', fontSize: '0.82rem', backdropFilter: 'blur(10px)' }}>
                <i className="bi bi-shield-check"></i> Formulaire sécurisé
              </span>
            </div>
          </div>
        </div>
      </section>

      <div className="container pb-5">
        {error && (
          <div className="alert alert-danger d-flex align-items-center mb-4" style={{ borderRadius: 12, border: 'none', boxShadow: '0 2px 8px rgba(225,29,72,0.1)' }}>
            <i className="bi bi-exclamation-triangle-fill me-2"></i>
            <span>{error}</span>
          </div>
        )}

        {/* Stepper */}
        <div className="card-modern mb-4" style={{ border: 'none', background: 'var(--white)' }}>
          <div className="card-body py-3 px-0">
            <ul className="form-stepper mb-0">
              <li className="step active"><span className="d-none d-sm-inline">État civil</span><span className="d-sm-none">1</span></li>
              <li className="step-line"></li>
              <li className="step active"><span className="d-none d-sm-inline">Passeport</span><span className="d-sm-none">2</span></li>
              <li className="step-line"></li>
              <li className="step active"><span className="d-none d-sm-inline">Visa actuel</span><span className="d-sm-none">3</span></li>
              <li className="step-line"></li>
              <li className="step active"><span className="d-none d-sm-inline">Demande</span><span className="d-sm-none">4</span></li>
            </ul>
          </div>
        </div>

        <form onSubmit={handleSubmit}>
          <div className="row g-4">
            <div className="col-lg-8">
              {/* Section 1: État civil */}
              <div className="form-section">
                <div className="form-section-title">
                  <i className="bi bi-person-vcard"></i> État civil
                </div>
                <div className="row g-3">
                  <div className="col-sm-6">
                    <label className="form-label">Nom <span className="text-danger">*</span></label>
                    <input type="text" className="form-control" name="nom" value={form.nom} onChange={handleChange} required placeholder="Votre nom" />
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Prénom <span className="text-danger">*</span></label>
                    <input type="text" className="form-control" name="prenom" value={form.prenom} onChange={handleChange} required placeholder="Votre prénom" />
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Nom de jeune fille</label>
                    <input type="text" className="form-control" name="nomJeuneFille" value={form.nomJeuneFille} onChange={handleChange} placeholder="Si applicable" />
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Situation familiale <span className="text-danger">*</span></label>
                    <select className="form-select" name="situationFamiliale" value={form.situationFamiliale} onChange={handleChange} required>
                      <option value="">— Sélectionnez —</option>
                      {situations.map(s => <option key={s.code} value={s.code}>{s.libelle}</option>)}
                    </select>
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Nationalité <span className="text-danger">*</span></label>
                    <input type="text" className="form-control" name="nationalite" value={form.nationalite} onChange={handleChange} required placeholder="Ex: Française" />
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Profession</label>
                    <input type="text" className="form-control" name="profession" value={form.profession} onChange={handleChange} placeholder="Votre profession" />
                  </div>
                  <div className="col-12">
                    <label className="form-label">Adresse à Madagascar <span className="text-danger">*</span></label>
                    <input type="text" className="form-control" name="adresseMadagascar" value={form.adresseMadagascar} onChange={handleChange} required placeholder="Adresse complète à Madagascar" />
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Contact <span className="text-danger">*</span></label>
                    <input type="text" className="form-control" name="contact" value={form.contact} onChange={handleChange} required placeholder="Téléphone / Email" />
                  </div>
                </div>
              </div>

              {/* Section 2: Passeport */}
              <div className="form-section">
                <div className="form-section-title">
                  <i className="bi bi-journal-bookmark"></i> Passeport
                </div>
                <div className="row g-3">
                  <div className="col-sm-12 col-md-4">
                    <label className="form-label">Numéro <span className="text-danger">*</span></label>
                    <input type="text" className="form-control" name="passeportNumero" value={form.passeportNumero} onChange={handleChange} required placeholder="Ex: 12AB34567" />
                  </div>
                  <div className="col-sm-6 col-md-4">
                    <label className="form-label">Date de délivrance <span className="text-danger">*</span></label>
                    <input type="date" className="form-control" name="passeportDateDelivrance" value={form.passeportDateDelivrance} onChange={handleChange} required />
                  </div>
                  <div className="col-sm-6 col-md-4">
                    <label className="form-label">Date d'expiration <span className="text-danger">*</span></label>
                    <input type="date" className="form-control" name="passeportDateExpiration" value={form.passeportDateExpiration} onChange={handleChange} required />
                  </div>
                </div>
              </div>

              {/* Section 3: Visa transformable */}
              <div className="form-section">
                <div className="form-section-title">
                  <i className="bi bi-passport"></i> Visa transformable
                </div>
                <div className="row g-3">
                  <div className="col-sm-6">
                    <label className="form-label">Référence du visa <span className="text-danger">*</span></label>
                    <input type="text" className="form-control" name="visaReference" value={form.visaReference} onChange={handleChange} required placeholder="Réf. visa" />
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Lieu d'entrée <span className="text-danger">*</span></label>
                    <input type="text" className="form-control" name="visaLieuEntree" value={form.visaLieuEntree} onChange={handleChange} required placeholder="Ex: Ivato" />
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Date d'entrée <span className="text-danger">*</span></label>
                    <input type="date" className="form-control" name="visaDateEntree" value={form.visaDateEntree} onChange={handleChange} required />
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Date d'expiration <span className="text-danger">*</span></label>
                    <input type="date" className="form-control" name="visaDateExpiration" value={form.visaDateExpiration} onChange={handleChange} required />
                  </div>
                </div>
              </div>

              {/* Section 4: Type de visa */}
              <div className="form-section">
                <div className="form-section-title">
                  <i className="bi bi-card-checklist"></i> Transformation demandée
                </div>
                <div className="row g-3">
                  <div className="col-sm-6">
                    <label className="form-label">Objectif de la demande <span className="text-danger">*</span></label>
                    <select className="form-select" name="objectifDemande" value={form.objectifDemande} onChange={handleChange} required>
                      <option value="">— Sélectionnez —</option>
                      {objectifs.map(o => <option key={o.code} value={o.code}>{o.libelle}</option>)}
                    </select>
                  </div>
                  <div className="col-sm-6">
                    <label className="form-label">Type de visa souhaité <span className="text-danger">*</span></label>
                    <select className="form-select" name="typeVisaId" value={form.typeVisaId} onChange={handleChange} required>
                      <option value="">— Sélectionnez —</option>
                      {typesVisa.map(tv => <option key={tv.id} value={tv.id}>{tv.libelle} ({tv.code})</option>)}
                    </select>
                  </div>
                  <div className="col-12">
                    <label className="form-label">Informations complémentaires</label>
                    <textarea className="form-control" name="informationsComplementaires" value={form.informationsComplementaires} onChange={handleChange} rows={3} placeholder="Précisez toute information utile liée à votre demande"></textarea>
                  </div>
                </div>
              </div>
            </div>

            {/* Sidebar */}
            <div className="col-lg-4">
              <div style={{ position: 'sticky', top: 90 }}>
                <div className="card-modern mb-4">
                  <div className="card-header">
                    <i className="bi bi-info-circle" style={{ color: 'var(--sky)' }}></i>
                    <strong>Récapitulatif</strong>
                  </div>
                  <div className="card-body" style={{ padding: '1.25rem' }}>
                    <div className="d-flex align-items-center gap-3 mb-3 pb-3" style={{ borderBottom: '1px solid var(--slate-100)' }}>
                      <div style={{ width: 36, height: 36, borderRadius: 10, background: 'var(--slate-100)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                        <i className="bi bi-1-circle" style={{ color: 'var(--primary)' }}></i>
                      </div>
                      <div>
                        <div style={{ fontWeight: 700, fontSize: '0.85rem' }}>Remplissez le formulaire</div>
                        <div style={{ fontSize: '0.75rem', color: 'var(--slate-400)' }}>Tous les champs requis (*)</div>
                      </div>
                    </div>
                    <div className="d-flex align-items-center gap-3 mb-3 pb-3" style={{ borderBottom: '1px solid var(--slate-100)' }}>
                      <div style={{ width: 36, height: 36, borderRadius: 10, background: 'var(--slate-100)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                        <i className="bi bi-2-circle" style={{ color: 'var(--primary)' }}></i>
                      </div>
                      <div>
                        <div style={{ fontWeight: 700, fontSize: '0.85rem' }}>Soumettez la demande</div>
                        <div style={{ fontSize: '0.75rem', color: 'var(--slate-400)' }}>Vérification automatique</div>
                      </div>
                    </div>
                    <div className="d-flex align-items-center gap-3">
                      <div style={{ width: 36, height: 36, borderRadius: 10, background: 'var(--emerald-light)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                        <i className="bi bi-3-circle" style={{ color: 'var(--emerald)' }}></i>
                      </div>
                      <div>
                        <div style={{ fontWeight: 700, fontSize: '0.85rem' }}>Recevez votre référence</div>
                        <div style={{ fontSize: '0.75rem', color: 'var(--slate-400)' }}>Pour suivre l'avancement</div>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="card-modern">
                  <div className="card-body text-center" style={{ padding: '1.5rem' }}>
                    <i className="bi bi-question-circle" style={{ fontSize: '1.5rem', color: 'var(--slate-300)', display: 'block', marginBottom: '0.75rem' }}></i>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem', color: 'var(--slate-600)', marginBottom: '0.25rem' }}>Besoin d'aide ?</div>
                    <div style={{ fontSize: '0.78rem', color: 'var(--slate-400)' }}>Contactez la DGIE pour toute question relative à votre demande</div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="d-flex flex-column flex-sm-row justify-content-end gap-2 mt-4">
            <button type="button" className="btn btn-outline-secondary" onClick={() => navigate('/')} style={{ borderRadius: 10 }}>
              <i className="bi bi-x-lg me-1"></i> Annuler
            </button>
            <button type="submit" className="btn btn-campus btn-lg px-5" disabled={loading} style={{ borderRadius: 12 }}>
              {loading ? <><i className="bi bi-hourglass-split me-1"></i> Envoi...</> : <><i className="bi bi-send me-1"></i> Soumettre la demande</>}
            </button>
          </div>
        </form>
      </div>
    </>
  );
}

export default NouvelleDemande;
