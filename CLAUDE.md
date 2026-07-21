# CLAUDE.md

Guia para trabalhar neste repositório. Respostas e comentários em **português**.

## O que é

Dotfiles pessoais (configurações de shell, window manager e apps de terminal).
Clonado em `~/.dotfiles`. Suportado em ArchLinux/Manjaro (uso principal), Fedora e
macOS. Ambiente principal: **bspwm + zsh + neovim**.

## Estrutura

- `dotfiles/` — os arquivos de configuração de fato. Tudo aqui é **symlinkado**
  para o `$HOME` (ver mecanismo abaixo). Ex.: `dotfiles/.config/polybar/config` →
  `~/.config/polybar/config`.
  - `dotfiles/.config/` — configs por app: `bspwm`, `polybar`, `sxhkd`, `picom`,
    `rofi`, `dunst`, `conky`, `alacritty`, `kitty`, `wezterm`, `nvim`, `ranger`,
    `zathura`, `redshift`, `xbindkeys`, `karabiner` (macOS), etc.
  - `dotfiles/.config/shell.d/` — fragmentos de shell carregados pelo `.zshrc`
    (`alias.sh`, `10functions.sh`, `exports.sh`, `fzf.sh`, `pyenv.sh`,
    `ssh_agent.sh`, `zoxide.sh`, …).
    Adicione aliases/funções aqui, não direto no `.zshrc`.
    **Atenção:** o `.zshrc` tem dois fluxos. Em WezTerm/Alacritty (quando
    `$WEZTERM_EXECUTABLE` ou `$ALACRITTY_SOCKET` existe) ele carrega **apenas**
    `shell.d/wezterm/*.sh`; nos demais terminais carrega todo `shell.d/*.sh`.
    Um arquivo novo em `shell.d/` não é lido automaticamente sob WezTerm/Alacritty.
  - Raiz do `dotfiles/`: `.zshrc`, `.bashrc`, `.tmux.conf`, `.xinitrc`, `.vim`, etc.
- `init/` — provisionamento via **Ansible**. É o que instala pacotes e cria os symlinks.
- `README.md` — visão geral e instruções de instalação.

## Instalação / provisionamento

```bash
cd ~/.dotfiles/init && source bootstrap.sh
```

`bootstrap.sh` detecta o SO, instala Ansible e roda `ansible-playbook -K deploy<OS>.yml`
(`deployArch.yml`, `deployLinux.yml` para Fedora, `deployDarwin.yml`).

Os symlinks são criados por `init/tasks/dotfiles.yml`. A lista de arquivos ligados
vem de `init/vars/dotfiles.yml`. Para aplicar só os links:

```bash
cd ~/.dotfiles/init && ansible-playbook -K deployArch.yml --tags links
```

A lista de pacotes fica em `init/vars/packages<SO>.yml`, separada por origem:
`packages` (repo oficial), `aur_packages` (via yay) e `snap_packages`.

A stack Wayland (`niri`, `sway*`, `dms-shell`) mora em blocos próprios —
`wayland_packages` e `wayland_aur_packages` — instalados pelas tasks com a tag
`wayland`. O ambiente principal continua sendo bspwm/X11. Para aplicar só ela:

```bash
cd ~/.dotfiles/init && ansible-playbook -K deployArch.yml --tags wayland
```

**Atenção:** tags no Ansible *restringem* a execução, não excluem. Num run
completo (sem `--tags`) as tasks de Wayland rodam junto com o resto; a tag serve
para conseguir rodá-las isoladamente. Para pular, use `--skip-tags wayland`.

O ambiente **Hyprland** (tradução do bspwm/polybar/sxhkd para Hyprland/waybar) é
uma stack própria, aditiva ao bspwm/X11, com pacotes em `hyprland_packages` /
`hyprland_aur_packages` e tasks em `init/tasks/hyprland.yml`, todas com a tag
`hyprland`. Para aplicar só ela:

```bash
cd ~/.dotfiles/init && sudo -v && ansible-playbook -K deployArch.yml --tags hyprland
```

O `sudo -v` (que o `bootstrap.sh` já faz num deploy completo) é **necessário**
quando a tag instala pacotes AUR: o módulo `kewlfft.aur.aur` roda o `yay` como
usuário normal e o `sudo pacman -U` interno dele precisa da credencial primada —
o `-K` do Ansible cobre só as tasks `become`, não o `yay`. Vale para qualquer tag
com AUR (`hyprland`, `wayland`).

A config vive em `dotfiles/.config/hypr/` e é symlinkada inteira para
`~/.config/hypr`. Os `binds`/`rules`/`scratchpads` e os scripts são
compartilhados entre máquinas; o que varia por máquina (monitores, workspaces e
qual waybar subir) fica em `conf/host-<hostname>.conf`, escolhido pelo symlink
**`conf/host.conf`** — que é **gitignorado** (estado local) e recriado pelo
deploy a partir do hostname. Para uma máquina nova, crie o
`conf/host-<hostname>.conf` (copie de `host-darkstar.conf` p/ 2 monitores ou
`host-quasar.conf` p/ 1) antes de rodar a tag. O ç no Chrome sob Wayland é
resolvido forçando XWayland (sub-tag `chrome`); o cedilha base continua na role
`keyboard`.

Alguns comportamentos apoiam-se em ferramentas dedicadas: screenshot com
anotação (Print) usa `grimblast` + `satty` (substitui o `flameshot`); o terminal
dropdown (super+ctrl+Return) usa o **pyprland** (daemon `pypr`, config em
`~/.config/pypr/config.toml` — local canônico do pyprland 3.4+, symlinkado de
`dotfiles/.config/pypr/`; o antigo `~/.config/hypr/pyprland.toml` era o
"legacy location" que gerava aviso no login) para animar a descida e esconder
ao perder o foco. Os demais scratchpads e o hide-all (super+d) seguem nativos
do Hyprland.

Os widgets "post-it" que no bspwm eram **conky** (X11, `own_window_type=desktop`
+ `below`/`sticky`) não têm equivalente direto no Wayland: o conky não fala
`wlr-layer-shell`, então nem via XWayland fica atrás das janelas. O substituto é
o **eww** (pacote AUR `eww`, config em `~/.config/eww/`), que desenha na layer
`bg` (fundo, abaixo de tudo, em todos os workspaces). Hoje há um widget, `saldo`
— porta do `conky.conf.5` (monitor auxiliar do darkstar): `eww.yuck` faz um
`defpoll` de 300s sobre `scripts/saldo.sh`, que coleta o ponto e passa por
`scripts/conky2eww.py` — este traduz o markup do conky (`${colorN}`, `${font}`,
`${alignr}`, `${hr}`, `${voffset}`) numa árvore de widgets eww injetada via
`(literal)`. A janela sobe só no darkstar (depende do 2º monitor + coletor do
trabalho), via `exec-once = eww open saldo` no `host-darkstar.conf`.

## Como editar

- Edite os arquivos **dentro de `dotfiles/`** — como estão symlinkados, a mudança
  reflete no ambiente imediatamente (pode exigir recarregar o app: `polybar`,
  `sxhkd`, recarregar o shell, etc.).
- Ao adicionar um arquivo/pasta **novo** que precise virar symlink, registre-o em
  `init/vars/dotfiles.yml` e rode o playbook com `--tags links`.

## Convenções

- Mensagens de commit em português, curtas e imperativas, geralmente com prefixo do
  componente: `tmux: ...`, `conky: ...`, `bspwm/polybar: ...`. Alguns commits usam
  Conventional Commits (`feat(wezterm): ...`). Siga o padrão do arquivo tocado.
- Segredos **não** entram no repo. O `.gitignore` bloqueia `*.env`, `.env`,
  `.dotenv`, `*.pem`, `*.key`, `id_rsa*`, `*.ovpn`, `*.kubeconfig`, `*.bak`,
  `*.gemini_api_key.sh` e `vars/dnsmasq.yml`. Nunca force o commit desses arquivos.
- O `.zshrc` faz `source ${HOME}/.gemini_api_key.sh` — esse arquivo mora fora do
  repo (gitignorado) e precisa ser criado à mão em cada máquina.
- Evite versionar binários grandes. `dotfiles/.config/wallpapers/` já pesa dezenas
  de MB; o `bspwmrc` usa `feh --bg-fill --randomize` sobre a pasta inteira, então
  não há dependência de nomes de arquivo — prefira sincronizar imagens novas por
  fora do git.

## Git

- Remoto: `git@github.com:nnorakk/dotfiles` (SSH), branch `master`.
- Não commitar/enviar sem o usuário pedir.
