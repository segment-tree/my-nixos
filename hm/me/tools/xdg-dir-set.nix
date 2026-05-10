{ config, pkgs, lib, nur, pkgs-stable, osConfig, ... }:

{
  home.sessionVariables = { # about xdg dirs
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
    PYTHONPYCACHEPREFIX = "${config.xdg.cacheHome}/python";
    PYTHONUSERBASE = "${config.xdg.dataHome}/python";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CGDB_DIR = "${config.xdg.configHome}/cgdb";

    GOPATH = "${config.xdg.dataHome}/go";
    GOMODCACHE = "${config.xdg.cacheHome}/go/mod";

    KUBECONFIG = "${config.xdg.configHome}/kube";
    KUBECACHEDIR = "${config.xdg.cacheHome}/kube";

    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";

    COPILOT_HOME = "${config.xdg.configHome}/copilot";
    CODEX_HOME = "${config.xdg.configHome}/codex";
    CLAUDE_CONFIG_DIR = "${config.xdg.configHome}/claude";

    ### reminder: below are gened.
    ACKRC = "${config.xdg.configHome}/ack/ackrc";
    ANSIBLE_HOME = "${config.xdg.configHome}/ansible";
    ANSIBLE_CONFIG = "${config.xdg.configHome}/ansible.cfg";
    ANSIBLE_GALAXY_CACHE_DIR = "${config.xdg.cacheHome}/ansible/galaxy_cache";
    ANSIBLE_LOCAL_TEMP = "${config.xdg.cacheHome}/ansible/tmp";
    ANSIBLE_SSH_CONTROL_PATH_DIR = "${config.xdg.cacheHome}/ansible/cp";
    ANSIBLE_ASYNC_DIR = "${config.xdg.cacheHome}/ansible_async";
    ASDF_CONFIG_FILE = "${config.xdg.configHome}/asdf/asdfrc";
    ASDF_DATA_DIR = "${config.xdg.dataHome}/asdf";
    AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
    AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
    AZURE_CONFIG_DIR = "${config.xdg.dataHome}/azure";
    BASH_COMPLETION_USER_FILE = "${config.xdg.configHome}/bash-completion/bash_completion";
    BOGOFILTER_DIR = "${config.xdg.dataHome}/bogofilter";
    BUNDLE_USER_CACHE = "${config.xdg.cacheHome}/bundle";
    BUNDLE_USER_CONFIG = "${config.xdg.configHome}/bundle/config";
    BUNDLE_USER_PLUGIN = "${config.xdg.dataHome}/bundle";
    BUN_INSTALL = "${config.xdg.dataHome}/bun";
    CALCHISTFILE = "${config.xdg.cacheHome}/calc_history";
    CD_BOOKMARK_FILE = "${config.xdg.configHome}/cd-bookmark/bookmarks";
    CHKTEXRC = "${config.xdg.configHome}/chktex";
    CIN_CONFIG = "${config.xdg.configHome}/bcast5";
    CRAWL_DIR = "${config.xdg.dataHome}/crawl";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    MACHINE_STORAGE_PATH = "${config.xdg.dataHome}/docker-machine";
    DUB_HOME = "${config.xdg.dataHome}/dub";
    ELAN_HOME = "${config.xdg.dataHome}/elan";
    ELECTRUMDIR = "${config.xdg.dataHome}/electrum";
    ELINKS_CONFDIR = "${config.xdg.configHome}/elinks";
    ELM_HOME = "${config.xdg.configHome}/elm";
    EM_CONFIG = "${config.xdg.configHome}/emscripten/config";
    EM_CACHE = "${config.xdg.cacheHome}/emscripten/cache";
    EM_PORTS = "${config.xdg.dataHome}/emscripten/cache";
    EASYOCR_MODULE_PATH = "${config.xdg.configHome}/EasyOCR";
    FCEUX_HOME = "${config.xdg.configHome}/fceux";
    FFMPEG_DATADIR = "${config.xdg.configHome}/ffmpeg";
    GETIPLAYERUSERPREFS = "${config.xdg.dataHome}/get_iplayer";
    GHCUP_USE_XDG_DIRS = "true";
    GR_PREFS_PATH = "${config.xdg.configHome}/gnuradio";
    GRC_PREFS_PATH = "${config.xdg.configHome}/gnuradio/grc.conf";
    GQRC = "${config.xdg.configHome}/gqrc";
    GQSTATE = "${config.xdg.dataHome}/gq/gq-state";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    GTK_RC_FILES = "${config.xdg.configHome}/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc:${config.xdg.configHome}/gtk-2.0/gtkrc.mine";
    IMAPFILTER_HOME = "${config.xdg.configHome}/imapfilter";
    IPFS_PATH = "${config.xdg.dataHome}/ipfs";
    IRBRC = "${config.xdg.configHome}/irb/irbrc";
    K9SCONFIG = "${config.xdg.configHome}/k9s";
    KDEHOME = "${config.xdg.configHome}/kde";
    KODI_DATA = "${config.xdg.dataHome}/kodi";
    KSCRIPT_CACHE_DIR = "${config.xdg.cacheHome}/kscript";
    LEIN_HOME = "${config.xdg.dataHome}/lein";
    DVDCSS_CACHE = "${config.xdg.dataHome}/dvdcss";
    LEDGER_FILE = "${config.xdg.dataHome}/hledger.journal";
    LESSHISTFILE = "${config.xdg.stateHome}/lesshst";
    LYNX_CFG = "${config.xdg.configHome}/lynx.cfg";
    MAVEN_OPTS = "-Dmaven.repo.local=${config.xdg.dataHome}/maven/repository";
    MAVEN_ARGS = "--settings ${config.xdg.configHome}/maven/settings.xml";
    MAXIMA_USERDIR = "${config.xdg.configHome}/maxima";
    MC_CONFIG_DIR = "${config.xdg.configHome}/minio-client";
    MINETEST_USER_PATH = "${config.xdg.dataHome}/luanti";
    MINIKUBE_HOME = "${config.xdg.dataHome}/minikube";
    MIX_XDG = "true";
    MOST_INITFILE = "${config.xdg.configHome}/mostrc";
    MPLAYER_HOME = "${config.xdg.configHome}/mplayer";
    MYPY_CACHE_DIR = "${config.xdg.cacheHome}/mypy";
    N_PREFIX = "${config.xdg.dataHome}/n";
    NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
    NODENV_ROOT = "${config.xdg.dataHome}/nodenv";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
    NVM_DIR = "${config.xdg.dataHome}/nvm";
    OCTAVE_HISTFILE = "${config.xdg.cacheHome}/octave-hsts";
    OCTAVE_SITE_INITFILE = "${config.xdg.configHome}/octave/octaverc";
    OLLAMA_MODELS = "${config.xdg.dataHome}/ollama/models";
    OMNISHARPHOME = "${config.xdg.configHome}/omnisharp";
    OPAMROOT = "${config.xdg.dataHome}/opam";
    PARALLEL_HOME = "${config.xdg.configHome}/parallel";
    PASSWORD_STORE_DIR = "${config.xdg.dataHome}/pass";
    PHIVE_HOME = "${config.xdg.dataHome}/phive";
    PHP_HISTFILE = "${config.xdg.stateHome}/php/history";
    PLATFORMIO_CORE_DIR = "${config.xdg.dataHome}/platformio";
    PSQLRC = "${config.xdg.configHome}/pg/psqlrc";
    PSQL_HISTORY = "${config.xdg.stateHome}/psql_history";
    PGPASSFILE = "${config.xdg.configHome}/pg/pgpass";
    PGSERVICEFILE = "${config.xdg.configHome}/pg/pg_service.conf";
    PYENV_ROOT = "${config.xdg.dataHome}/pyenv";
    PYTHON_EGG_CACHE = "${config.xdg.cacheHome}/python-eggs";
    PLTUSERHOME = "${config.xdg.dataHome}/racket";
    RBENV_ROOT = "${config.xdg.dataHome}/rbenv";
    INPUTRC = "${config.xdg.configHome}/readline/inputrc";
    RECOLL_CONFDIR = "${config.xdg.configHome}/recoll";
    REDISCLI_HISTFILE = "${config.xdg.dataHome}/redis/rediscli_history";
    REDISCLI_RCFILE = "${config.xdg.configHome}/redis/redisclirc";
    RENPY_PATH_TO_SAVES = "${config.xdg.dataHome}/renpy";
    RENPY_MULTIPERSISTENT = "${config.xdg.dataHome}/renpy_shared";
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/config";
    RLWRAP_HOME = "${config.xdg.dataHome}/rlwrap";
    RUFF_CACHE_DIR = "${config.xdg.cacheHome}/ruff";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    SDKMAN_DIR = "${config.xdg.dataHome}/sdkman";
    SINGULARITY_CONFIGDIR = "${config.xdg.configHome}/singularity";
    SINGULARITY_CACHEDIR = "${config.xdg.cacheHome}/singularity";
    SOLARGRAPH_CACHE = "${config.xdg.cacheHome}/solargraph";
    SQLITE_HISTORY = "${config.xdg.stateHome}/sqlite_history";
    STACK_XDG = "1";
    STARSHIP_CONFIG = "${config.xdg.configHome}/starship.toml";
    STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";
    TEXMFHOME = "${config.xdg.dataHome}/texmf";
    TEXMFVAR = "${config.xdg.cacheHome}/texlive/texmf-var";
    TEXMFCONFIG = "${config.xdg.configHome}/texlive/texmf-config";
    TEXMACS_HOME_PATH = "${config.xdg.stateHome}/texmacs";
    TRAVIS_CONFIG_PATH = "${config.xdg.configHome}/travis";
    TUF_ROOT = "${config.xdg.dataHome}/sigstore/root";
    UNCRUSTIFY_CONFIG = "${config.xdg.configHome}/uncrustify/uncrustify.cfg";
    UNISON = "${config.xdg.dataHome}/unison";
    VAGRANT_HOME = "${config.xdg.dataHome}/vagrant";
    VAGRANT_ALIAS_FILE = "${config.xdg.dataHome}/vagrant/aliases";
    # VSCODE_PORTABLE = "${config.xdg.dataHome}/vscode";
    W3M_DIR = "${config.xdg.stateHome}/w3m";
    WAKATIME_HOME = "${config.xdg.configHome}/wakatime";
    WGETRC = "${config.xdg.configHome}/wgetrc";
    WINEPREFIX = "${config.xdg.dataHome}/wineprefixes/default";
    WOLFRAM_USERBASE = "${config.xdg.configHome}/Wolfram";
    WORKON_HOME = "${config.xdg.dataHome}/virtualenvs";
    X3270PRO = "${config.xdg.configHome}/x3270/config";
    C3270PRO = "${config.xdg.configHome}/c3270/config";
    # XCOMPOSEFILE = "${config.xdg.configHome}/X11/xcompose";
    # XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    # XINITRC = "${config.xdg.configHome}/X11/xinitrc";
    # XSERVERRC = "${config.xdg.configHome}/X11/xserverrc";
    _Z_DATA = "${config.xdg.dataHome}/z";
  };

  xdg.configFile = {
    "npm/npmrc".text = ''
      prefix=${config.xdg.dataHome}/npm
      cache=${config.xdg.cacheHome}/npm
      init-module=${config.xdg.configHome}/npm/config/npm-init.js
      logs-dir=${config.xdg.stateHome}/npm/logs
    '';

    "wgetrc".text = ''
      hsts-file = ${config.xdg.stateHome}/wget-hsts
    '';
  };

  home.activation = {
    createCustomDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "${config.xdg.stateHome}/bash"
      mkdir -p "${config.xdg.dataHome}/gnupg"
      mkdir -p "${config.xdg.configHome}/vim"
      mkdir -p "${config.xdg.configHome}/python"
    '';
  };
}
