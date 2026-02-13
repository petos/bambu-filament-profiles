# Bambu Studio – Filament Git Sync (Linux / Flatpak)

Tento repozitář slouží ke sdílení **custom filament profilů** mezi více stroji pomocí Git.

Cloud synchronizace Bambu Studio aktuálně **nesynchronizuje lokální filament profily**, proto je řešení postaveno na verzování JSON souborů přímo z Flatpak úložiště.

---

## 📂 Kde Bambu Studio ukládá filamenty (Flatpak)

U Flatpak verze jsou custom filamenty zde:

```
~/.var/app/com.bambulab.BambuStudio/config/BambuStudio/USERID/filament/base/
```

Každý filament je uložen jako samostatný `.json` soubor. `USERID` je číslo přiřazené profilu. 

---

# Setup po `git clone`

Git **nesynchronizuje lokální config ani hooky** (bezpečnostní důvod).
Proto je potřeba po každém novém klonu provést inicializaci.

## Nastavení verzovaných hooků
Poté co pustíte `git clone` spustit:

```
git config alias.pull '!./scripts/git-pull-safe.sh'
```
tím se nastaví alias pro pull, který pustí `git-pull-safe` script namísto `git pull`

## Nastavení úložiště filamentu (flatpak) do repa

0. VYPNOUT BAMBU STUDIO
1. Najděte `ID` uživatele v `~/.var/app/com.bambulab.BambuStudio/config/BambuStudio/`
2. V něm je adresář `filaments` -- smazat
3. `$REPOPATH` je samozřejmě cesta k tomuto repozitáři na disku
```
ln -s $REPOPATH/filaments
```
4. Profit

## Doporučený workflow

1. Zavři Bambu Studio
2. Commitni změny filamentů
3. Proveď `git pull` + merge
4. Proveď `git push`
5. Na druhém stroji: `git pull`
6. Spusť Bambu Studio

**Nikdy neprovádět pull/push při běžícím Bambu Studio.**

---

## Ochrana proti pull při otevřeném Bambu Studio

Repo obsahuje lokální wrapper, který:

- přepisuje `git pull` pouze v tomto repozitáři
- kontroluje, zda má Bambu Studio otevřené filament JSON soubory
- pokud ano, operaci zablokuje

---

Hotovo

Tento setup je bezpečný, reprodukovatelný a dobře auditovatelný.

Tento readme vygeneroval chatgpt, protoze psani tohoto nemam rad. 
