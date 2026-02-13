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

## 🧭 Doporučený workflow

1. Zavři Bambu Studio
2. Commitni změny filamentů
3. Proveď `git pull`
4. Proveď `git push`
5. Na druhém stroji: `git pull`
6. Spusť Bambu Studio

⚠️ **Nikdy neprováděj pull/push při běžícím Bambu Studio.**

---

## 🛡 Ochrana proti pull při otevřeném Bambu Studio

Repo obsahuje lokální wrapper, který:

- přepisuje `git pull` pouze v tomto repozitáři
- kontroluje, zda má Bambu Studio otevřené filament JSON soubory
- pokud ano, operaci zablokuje


### Nastavení (provedeno jednou v repu)

```bash
git config alias.pull '!./scripts/git-pull-safe.sh'
```

### Wrapper skript

Umístění:

```
scripts/git-pull-safe.sh
```

---

## 🔄 Synchronizace filament adresáře

Symlink z bambu addr do tohoto repa
```bash
mv ~/.var/app/com.bambulab.BambuStudio/data/bambu-studio/storage/user/filament ~/bambu-filaments
ln -s ~/bambu-filaments ~/.var/app/com.bambulab.BambuStudio/data/bambu-studio/storage/user/filament
```

Tím pádem Git verzionuje přímo aktivní data.

---

Hotovo

Tento setup je bezpečný, reprodukovatelný a dobře auditovatelný.

Tento readme vygeneroval chatgpt, protoze psani tohoto nemam rad. 
