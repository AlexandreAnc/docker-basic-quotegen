# Guide Docker - Quotegen

## Étape 1 : Informations système

➜ **Objectif** : Noter les informations importantes : version du serveur, drivers, nombre d'images/containers, configuration réseau.

### Commande `docker version`

```bash
docker version
```

**Client:**
```
Version:           28.5.1
API version:       1.51
Go version:        go1.24.8
Git commit:        e180ab8
Built:             Wed Oct  8 12:16:17 2025
OS/Arch:           darwin/arm64
Context:           desktop-linux
```

**Server: Docker Desktop 4.49.0 (208700)**
```
Engine:
  Version:          28.5.1
  API version:      1.51 (minimum version 1.24)
  Go version:       go1.24.8
  Git commit:       f8215cc
  Built:            Wed Oct  8 12:18:25 2025
  OS/Arch:          linux/arm64
  Experimental:     false
containerd:
  Version:          1.7.27
  GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
runc:
  Version:          1.2.5
  GitCommit:        v1.2.5-0-g59923ef
docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

### Commande `docker info`

```bash
docker info
```

**Client:**
```
Version:    28.5.1
Context:    desktop-linux
Debug Mode: false
Plugins:
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.9.11
    Path:     /Users/alaix/.docker/cli-plugins/docker-ai
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1-desktop.1
    Path:     /Users/alaix/.docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3-desktop.1
    Path:     /Users/alaix/.docker/cli-plugins/docker-compose
  debug: Get a shell into any image or container (Docker Inc.)
    Version:  0.0.45
    Path:     /Users/alaix/.docker/cli-plugins/docker-debug
  desktop: Docker Desktop commands (Docker Inc.)
    Version:  v0.2.0
    Path:     /Users/alaix/.docker/cli-plugins/docker-desktop
  extension: Manages Docker extensions (Docker Inc.)
    Version:  v0.2.31
    Path:     /Users/alaix/.docker/cli-plugins/docker-extension
  init: Creates Docker-related starter files for your project (Docker Inc.)
    Version:  v1.4.0
    Path:     /Users/alaix/.docker/cli-plugins/docker-init
  mcp: Docker MCP Plugin (Docker Inc.)
    Version:  v0.24.0
    Path:     /Users/alaix/.docker/cli-plugins/docker-mcp
  model: Docker Model Runner (Docker Inc.)
    Version:  v0.1.46
    Path:     /Users/alaix/.docker/cli-plugins/docker-model
  offload: Docker Offload (Docker Inc.)
    Version:  v0.5.1
    Path:     /Users/alaix/.docker/cli-plugins/docker-offload
  sandbox: Docker Sandbox (Docker Inc.)
    Version:  v0.3.1
    Path:     /Users/alaix/.docker/cli-plugins/docker-sandbox
  sbom: View the packaged-based Software Bill Of Materials (SBOM) for an image (Anchore Inc.)
    Version:  0.6.0
    Path:     /Users/alaix/.docker/cli-plugins/docker-sbom
  scout: Docker Scout (Docker Inc.)
    Version:  v1.18.3
    Path:     /Users/alaix/.docker/cli-plugins/docker-scout
```

**Server:**
```
Containers: 3
  Running: 1
  Paused: 0
  Stopped: 2
Images: 20
Server Version: 28.5.1
Storage Driver: overlayfs
  driver-type: io.containerd.snapshotter.v1
Logging Driver: json-file
Cgroup Driver: cgroupfs
Cgroup Version: 2
Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
CDI spec directories:
  /etc/cdi
  /var/run/cdi
Discovered Devices:
  cdi: docker.com/gpu=webgpu
Swarm: inactive
Runtimes: io.containerd.runc.v2 runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 05044ec0a9a75232cad458027ca83437aae3f4da
runc version: v1.2.5-0-g59923ef
init version: de40ad0
Security Options:
  seccomp
   Profile: builtin
  cgroupns
Kernel Version: 6.10.14-linuxkit
Operating System: Docker Desktop
OSType: linux
Architecture: aarch64
CPUs: 8
Total Memory: 3.828GiB
Name: docker-desktop
ID: adb79218-8976-4fa2-b643-594545cde3b0
Docker Root Dir: /var/lib/docker
Debug Mode: false
HTTP Proxy: http.docker.internal:3128
HTTPS Proxy: http.docker.internal:3128
No Proxy: hubproxy.docker.internal
Labels:
  com.docker.desktop.address=unix:///Users/alaix/Library/Containers/com.docker.docker/Data/docker-cli.sock
Experimental: false
Insecure Registries:
  hubproxy.docker.internal:5555
  ::1/128
  127.0.0.0/8
Live Restore Enabled: false
```

---

## Étape 2 : Commandes de base

### Liste des conteneurs

```bash
docker ps
```

**Sortie :**
```
CONTAINER ID   IMAGE            COMMAND                  CREATED         STATUS         PORTS                                         NAMES
d63b748a10bf   quotegen:1.1.1   "gunicorn --bind 0.0…"   2 minutes ago   Up 2 minutes   0.0.0.0:8081->5000/tcp, [::]:8081->5000/tcp   quotegen
```

```bash
docker ps -a
```

**Sortie :**
```
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS                        PORTS                                         NAMES
d63b748a10bf   quotegen:1.1.1   "gunicorn --bind 0.0…"   2 minutes ago    Up 2 minutes                  0.0.0.0:8081->5000/tcp, [::]:8081->5000/tcp   quotegen
46233ac53a96   nginx            "/docker-entrypoint.…"   38 minutes ago   Exited (0) 14 minutes ago                                                   pedantic_shaw
2ea9812e090b   nginx            "/docker-entrypoint.…"   38 minutes ago   Exited (127) 38 minutes ago                                                 optimistic_almeida
```

### Liste des images

```bash
docker image ls
```

**Sortie :**
```
REPOSITORY              TAG       IMAGE ID       CREATED          SIZE
quotegen                1.1.1     46e4ce2e5eb0   2 minutes ago    225MB
quotegen                1.1.0     3696c01ce47c   19 minutes ago    225MB
quotegen                1.0.0     571d0a0ca906   19 minutes ago    225MB
nginx                   latest    f547e3d0d5d0   2 days ago       244MB
soxoj/maigret           latest    a94a9192950a   5 weeks ago      766MB
odoo16-sk-odoo          latest    2e0317d465c0   5 weeks ago      2.93GB
warmcream-laravel-php   latest    1d7e910c8bbc   7 weeks ago      565MB
warmcream-web           latest    efff2bd98c54   7 weeks ago      190MB
odoo                    16        0f36a5002a20   7 weeks ago      2.52GB
odoo                    16.0      0f36a5002a20   7 weeks ago      2.52GB
mysql                   8.4       6e60ad6d61d8   7 weeks ago      1.07GB
postgres                14        e84397672fce   7 weeks ago      645MB
postgres                13        fb11a641ba92   7 weeks ago      641MB
postgres                15        1cd9dd548427   7 weeks ago      650MB
composer                2         68e926a47700   2 months ago     306MB
odoo                    18.0      8e262fde438a   2 months ago     3.03GB
postgres                16        66a5efb5677f   2 months ago     659MB
nginx                   alpine    42a516af16b8   2 months ago     80.2MB
phpmyadmin              latest    06cf0af50c04   9 months ago     820MB
nginx                   1.25      a484819eb602   18 months ago    275MB
```

### Liste des volumes

```bash
docker volume ls
```

**Sortie :**
```
DRIVER    VOLUME NAME
local     odoo16-sk_odoo-data
local     odoo-18_odoo18_db_data
local     odoodev16_db_data
local     warmcream_cache
local     warmcream_mysql-data
local     warmcream_vendor
local     warmcream_warmcream_mysql_data
local     warmcream_warmcream_storage
local     warmcream_warmcream_vendor
```

---

## Étape 3 : Dockerfile

➜ **Objectif** : Justifier chaque instruction dans le rapport (base image, workdir, copy, etc.).

FROM : définit l’image de base (ici Python) pour avoir un environnement prêt.

WORKDIR : fixe le dossier de travail où seront copiés et exécutés les fichiers.

COPY : ajoute les fichiers du projet dans l’image.

RUN : exécute des commandes lors du build (ex : installation des dépendances).

EXPOSE : indique le port utilisé par l’application.

CMD : précise la commande lancée au démarrage du conteneur.

---

## Étape 4 : Gestion des conteneurs

➜ **Objectif** : Expliquer la différence entre `stop`, `rm`, `prune`.

stop arrête un conteneur,
rm le supprime,
prune nettoie tous les conteneurs, images ou volumes inutilisés.

---

## Étape 5 : COPY vs Volumes

➜ **Objectif** : Documenter la différence entre `COPY` (image immuable) et `-v` (montage dynamique).

COPY ajoute les fichiers dans l’image au moment du build (fixe et immuable), tandis que -v monte un dossier du système hôte dans le conteneur pour voir les changements en direct.

---

## Étape 6 : Tags et historique

➜ **Objectif** : Expliquer l'intérêt des tags multiples (ex. `:1.1.0`, `:latest`, `:staging`).
Les tags multiples servent à identifier différentes versions d’une même image (ex : 1.1.0 pour une version précise, latest pour la plus récente, staging pour les tests).

➜ **Objectif** : Identifier les instructions qui pèsent le plus.

### Historique de l'image

```bash
docker history quotegen:1.1.0
```

**Sortie :**
```
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
3696c01ce47c   36 minutes ago   CMD ["gunicorn" "--bind" "0.0.0.0:5000" "app…   0B        buildkit.dockerfile.v0
<missing>      36 minutes ago   EXPOSE [5000/tcp]                               0B        buildkit.dockerfile.v0
<missing>      36 minutes ago   COPY data ./data # buildkit                     16.4kB    buildkit.dockerfile.v0
<missing>      36 minutes ago   COPY app.py . # buildkit                        12.3kB    buildkit.dockerfile.v0
<missing>      36 minutes ago   RUN /bin/sh -c pip install --no-cache-dir -r…   16.7MB    buildkit.dockerfile.v0
<missing>      36 minutes ago   COPY requirements.txt . # buildkit              12.3kB    buildkit.dockerfile.v0
<missing>      36 minutes ago   WORKDIR /app                                    8.19kB    buildkit.dockerfile.v0
<missing>      3 weeks ago      CMD ["python3"]                                 0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      RUN /bin/sh -c set -eux;  for src in idle3 p…   16.4kB    buildkit.dockerfile.v0
<missing>      3 weeks ago      RUN /bin/sh -c set -eux;   savedAptMark="$(a…   44.6MB    buildkit.dockerfile.v0
<missing>      3 weeks ago      ENV PYTHON_SHA256=fb85a13414b028c49ba18bbd52…   0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      ENV PYTHON_VERSION=3.12.12                      0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      ENV GPG_KEY=7169605F62C751356D054A26A821E680…   0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      RUN /bin/sh -c set -eux;  apt-get update;  a…   4.99MB    buildkit.dockerfile.v0
<missing>      3 weeks ago      ENV LANG=C.UTF-8                                0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      ENV PATH=/usr/local/bin:/usr/local/sbin:/usr…   0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      # debian.sh --arch 'arm64' out/ 'trixie' '@1…   109MB     debuerreotype 0.16
```

**Analyse des instructions les plus lourdes :**
- **109MB** : Image de base Debian (debuerreotype 0.16)
- **44.6MB** : Installation des dépendances système (apt-get)
- **16.7MB** : Installation des packages Python (pip install)
- **4.99MB** : Mise à jour des packages système (apt-get update)

➜ **Note** : Insister sur la prudence avec `prune` et la différence entre volumes nommés et bind mounts.

---

## Étape 7 : Questions de réflexion

1. **Quelle est la différence entre ENTRYPOINT et CMD ?**
   → ENTRYPOINT définit le programme principal du conteneur, CMD indique les arguments ou la commande par défaut à exécuter.

2. **Comment inspecter les variables d'environnement d'un conteneur en cours d'exécution ?**
   → docker exec <nom> env ou docker inspect <nom> --format '{{json .Config.Env}}'

3. **Comment diagnostiquer un build qui échoue derrière un proxy d'entreprise ?**
   → Utiliser --build-arg http_proxy=... et définir ARG / ENV dans le Dockerfile.

4. **Quelle commande permet de voir l'espace disque occupé par Docker ?**
   → docker system df

5. **Pourquoi `--rm` est-il utile en développement ?**
   → Supprime automatiquement le conteneur après son arrêt pour éviter d’en accumuler.
