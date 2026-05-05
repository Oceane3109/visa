import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link, useLocation, useSearchParams } from 'react-router-dom';
import Accueil from './pages/Accueil';
import RechercheDemande from './pages/RechercheDemande';
import DetailDemande from './pages/DetailDemande';
import NouvelleDemande from './pages/NouvelleDemande';
import './App.css';

function AppContent() {
  const [searchParams] = useSearchParams();
  const fromQrCode = searchParams.get('from') === 'qrcode';

  return (
    <>
      <Navbar showNavbar={!fromQrCode} />
      <Routes>
        <Route path="/" element={<Accueil />} />
        <Route path="/recherche" element={<RechercheDemande />} />
        <Route path="/demandes/:numeroDemande" element={<DetailDemande />} />
        <Route path="/nouvelle-demande" element={<NouvelleDemande />} />
      </Routes>
      <Footer showFooter={!fromQrCode} />
    </>
  );
}

function App() {
  return (
    <Router basename={process.env.PUBLIC_URL}>
      <AppContent />
    </Router>
  );
}

function Navbar({ showNavbar = true }) {
  const location = useLocation();
  const isActive = (path) => location.pathname === path ? 'nav-link active' : 'nav-link';

  if (!showNavbar) return null;

  return (
    <nav className="navbar navbar-expand-lg navbar-campus">
      <div className="container px-4">
        <Link className="navbar-brand" to="/">
          <span className="brand-icon"><i className="bi bi-globe2"></i></span>
          <span>Visa Madagascar</span>
        </Link>
        <button className="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
          <i className="bi bi-list text-white fs-4"></i>
        </button>
        <div className="collapse navbar-collapse" id="navMain">
          <ul className="navbar-nav ms-auto">
            <li className="nav-item">
              <Link className={isActive('/')} to="/"><i className="bi bi-house-door me-1"></i> Accueil</Link>
            </li>
            <li className="nav-item">
              <Link className={isActive('/recherche')} to="/recherche"><i className="bi bi-search me-1"></i> Suivi</Link>
            </li>
            <li className="nav-item">
              <Link className={isActive('/nouvelle-demande')} to="/nouvelle-demande"><i className="bi bi-plus-circle me-1"></i> Nouvelle demande</Link>
            </li>
            <li className="nav-item ms-lg-3">
              <a className="nav-link" href="/visa-back4/"><span className="badge-env">Administration</span></a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  );
}

function Footer({ showFooter = true }) {
  if (!showFooter) return null;

  return (
    <footer className="footer-campus">
      <div className="container text-center">
        <p className="mb-0">&copy; 2026 — Ministère de l'Intérieur — Direction Générale de l'Immigration et de l'Émigration — Madagascar</p>
      </div>
    </footer>
  );
}

export default App;
