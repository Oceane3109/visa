# Workflow Git — Projet Visa Transformable

## Equipe

- 3 membres dans l'equipe
- Le role de TL (Tech Lead) tourne entre les membres
- Le TL gere les Pull Requests et les merges

---

## Branches principales

| Branche | Role |
|---------|------|
| `main` | Production stable, code valide et teste |
| `staging/sprint/<N>/feat/<description>` | Branche de test/integration pour un sprint |

---

## Regles de nommage des branches

### Branches de developpement (dev)
```
sprint/<N>/<description>
```
- Creee par le dev a partir de `main`
- Exemple : `sprint/1/formulaire-demande-visa`

### Branches de staging (TL)
```
staging/sprint/<N>/feat/<description>
```
- Creee par le TL via PR depuis la branche `sprint/<N>/...`
- Exemple : `staging/sprint/1/feat/formulaire-demande-visa`

### Branches de fix (bug en staging)
```
fix/sprint/<N>/<description-du-bug>
```
- Creee a partir de la branche `staging/sprint/<N>/...`
- Exemple : `fix/sprint/1/correction-validation-formulaire`

---

## Workflow pas a pas

### 1. Developpement

1. Le dev cree une branche depuis `main` :
   ```
   git checkout main
   git checkout -b sprint/1/formulaire-demande-visa
   ```
2. Le dev code et commit ses modifications
3. Le dev push sa branche :
   ```
   git push origin sprint/1/formulaire-demande-visa
   ```

### 2. Review et Staging (TL)

4. Le TL cree une **Pull Request** :
   - Source : `sprint/1/formulaire-demande-visa`
   - Destination : nouvelle branche `staging/sprint/1/feat/formulaire-demande-visa`
   - Le TL cree d'abord la branche staging, puis merge via PR
5. L'equipe teste sur la branche staging

### 3. Correction de bugs (si necessaire)

6. Si un bug est trouve en staging :
   ```
   git checkout staging/sprint/1/feat/formulaire-demande-visa
   git checkout -b fix/sprint/1/correction-validation-formulaire
   ```
7. Le dev corrige et push la branche fix
8. Le TL fait une PR pour merger le fix dans la branche staging
9. On reteste

### 4. Merge vers main (TL)

10. Une fois les tests valides en staging :
    - Le TL cree une **Pull Request** :
      - Source : `staging/sprint/1/feat/formulaire-demande-visa`
      - Destination : `main`
    - Le TL merge apres validation

---

## Resume visuel

```
main
 |
 +-- sprint/1/formulaire-demande-visa        (dev push ici)
 |       |
 |       +---> PR ---> staging/sprint/1/feat/formulaire-demande-visa   (TL merge, tests ici)
 |                          |
 |                          +-- fix/sprint/1/correction-bug            (si bug)
 |                          |       |
 |                          +<------+  PR merge fix
 |                          |
 +<-------------------------+  PR merge vers main (si tests OK)
```

---

## Regles importantes

- **Jamais de push direct sur `main`**
- **Jamais de push direct sur `staging/...`** (toujours via PR)
- Les commits doivent avoir des messages clairs et en francais
- Le TL valide chaque PR avant merge
