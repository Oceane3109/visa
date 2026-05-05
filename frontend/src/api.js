const API_BASE = '/visa-back4/api';

export async function rechercherParPasseport(numero) {
    const res = await fetch(`${API_BASE}/demandes/passeport/${encodeURIComponent(numero)}`);
    if (!res.ok) throw new Error('Erreur lors de la recherche');
    return res.json();
}

export async function rechercherParNumeroDemande(numero) {
    const res = await fetch(`${API_BASE}/demandes/${encodeURIComponent(numero)}`);
    if (!res.ok) {
        if (res.status === 404) throw new Error('Demande introuvable');
        throw new Error('Erreur lors de la recherche');
    }
    return res.json();
}

export async function creerDemande(data) {
    const res = await fetch(`${API_BASE}/demandes`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    if (!res.ok) {
        const err = await res.json();
        throw new Error(err.error || 'Erreur lors de la création');
    }
    return res.json();
}

export async function getTypesVisa() {
    const res = await fetch(`${API_BASE}/types-visa`);
    return res.json();
}

export async function getObjectifs() {
    const res = await fetch(`${API_BASE}/objectifs`);
    return res.json();
}

export async function getSituationsFamiliales() {
    const res = await fetch(`${API_BASE}/situations-familiales`);
    return res.json();
}

export function getQrCodeUrl(numeroDemande) {
    return `${API_BASE}/demandes/${encodeURIComponent(numeroDemande)}/qrcode`;
}
