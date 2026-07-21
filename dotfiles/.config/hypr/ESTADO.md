# Migração bspwm → Hyprland — estado em 2026-07-20

## ESTRUTURA CONSOLIDADA (2026-07-20, mais tarde)

Tudo agora vive sob **`~/.config/hypr/`** — as pastas `~/.config/hypr-jp/`,
`~/.config/waybar-jp/` e `~/.config/wlogout/` foram **eliminadas**. Onde as
referências abaixo neste documento citarem esses caminhos antigos, leia como
histórico. Layout atual:

```
~/.config/hypr/
  hyprland.conf   hyprlock.conf   hypridle.conf   ESTADO.md
  conf/       binds.conf  rules.conf  scratchpads.conf   (source pelo hyprland.conf)
  scripts/    gaps.sh  hide-all.sh  ultrawide.sh  wallpaper.sh   ($scr)
  waybar/     config.jsonc  style.css  scripts/polybar-shim.sh
  wlogout/    layout        (waybar chama: wlogout -l ~/.config/hypr/wlogout/layout)
  guardados/  experimento Lua desativado + hyprland.conf.generico (referencia)
```

Fica FORA de `~/.config/hypr/` só o estritamente necessário, compartilhado com o
bspwm/sistema: `/etc/environment` (GTK/QT_IM_MODULE=cedilla), `~/.XCompose`,
`~/bin/*`, `~/.config/polybar/*.sh` (a waybar reusa via polybar-shim), e
`~/.local/share/applications/google-chrome*.desktop` (ç no Chrome via XWayland).

---

## Como retomar a conversa com o Claude

A sessão está salva em disco e sobrevive à troca de WM:

```
~/.claude/projects/-home-jpaulo/772e6c3b-b57d-406b-9bab-92873109f31c.jsonl
```

Depois de entrar no Hyprland, abra um terminal em `~` e rode:

```bash
claude --resume 772e6c3b-b57d-406b-9bab-92873109f31c
```

Ou só `claude --resume` e escolha na lista (é a mais recente). `claude -c`
continua a última sessão direto.

**Importante:** precisa ser a partir de `~` (`/home/jpaulo`), que é o diretório
do projeto onde a sessão foi gravada.

---

## CORREÇÃO (2026-07-20, mais tarde): a config ATIVA é hyprlang, não Lua

> **Decisão: usar hyprlang.** Config ativa = `~/.config/hypr/hyprland.conf`
> (local por máquina: monitores/workspaces) + `hypr-jp/legacy-conf/*.conf`
> (binds/rules/scratchpads, compartilhados). O Lua ficou guardado em
> `~/.config/hypr/hyprland.lua.off`. O texto da seção "(histórico)" abaixo é só
> histórico.
>
> **Por quê hyprlang e não Lua:** a config Lua **quebra o `hyprctl dispatch`
> legado** — em modo Lua o endpoint IPC `dispatch` interpreta o payload COMO
> código Lua, então `dispatch workspace N` (que a waybar e os scripts enviam) vira
> erro de sintaxe → clique de workspace na waybar não funciona no Lua. A forma
> Lua-nativa seria `hl.dsp.focus({workspace=N})`, que a waybar 0.15 não sabe
> mandar (o módulo `hyprland/workspaces` nem tem `on-click`).
>
> **Sobre os window rules (2 correções sobre versões anteriores desta nota):**
> a seção "(histórico)" estava **certa** ao dizer que o one-liner clássico
> `windowrule = float, class:...` NÃO vale mais neste build (dá "invalid field
> ...: missing a value"), mas **errada** ao concluir que isso obrigava a usar Lua.
> Este build expõe `windowrule` em hyprlang como **categoria especial em bloco**
> (chave `name`, `match` aninhado, efeitos como campos nomeados). Os
> `legacy-conf/rules.conf` e `scratchpads.conf` foram reescritos nesse formato e
> `hyprctl configerrors` está **vazio**. Exemplo:
> ```
> windowrule {
>     name = vlc-fullscreen
>     match:class = ^(vlc)$
>     float = true
>     size = 680 770
> }
> ```
> Efeitos válidos confirmados: float/center/pin/no_focus, size/move,
> workspace = N [silent], fullscreen=true, fullscreen_state=1,
> suppress_event=maximize, idle_inhibit=fullscreen. Vários efeitos e matchers
> (`match:class`, `match:title`) convivem no mesmo bloco.

## (histórico) Config reescrita em Lua (2026-07-20)

O Hyprland 0.55.4 **aposentou a sintaxe `windowrule = float, class:...`** — as
regras migraram para Lua. A config inteira foi reescrita.

- `~/.config/hypr/hyprland.lua` — loader de 2 linhas, lido pelo GDM.
  `hyprland.lua` tem precedência sobre `hyprland.conf` (verificado).
- `~/.config/hypr-jp/init.lua` — entrada real; requer os módulos abaixo
- `binds.lua` (253) · `rules.lua` (102) · `scratchpads.lua` (35) · `init.lua` (148)
- `legacy-conf/` — a versão antiga em hyprlang, guardada como referência

**Validado numa instância aninhada, pelo caminho padrão: 0 erros, 152 binds.**

### Voltar para a ML4W
```bash
mv ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.off
```
Isso reativa o `hyprland.conf`, que carrega a ML4W (já corrigida p/ 0.55.4).

---

## O que já está pronto

### `~/.config/hypr-jp/` → `~/dotfiles/.config/hypr-jp/`

| Arquivo | Linhas | Conteúdo |
|---|---|---|
| `hyprland.conf` | 138 | monitor DP-1, input, geral, dwindle, autostart |
| `binds.conf` | 287 | tradução do `sxhkdrc`, com os 2 submaps (chords) |
| `rules.conf` | 107 | as 18 `bspc rule` |
| `scratchpads.conf` | 34 | special workspaces (substituem o `tdrop`) |
| `scripts/` | — | `gaps.sh` `hide-all.sh` `ultrawide.sh` `wallpaper.sh` |

### `~/.config/waybar-jp/` → `~/dotfiles/.config/waybar-jp/`

| Arquivo | Conteúdo |
|---|---|
| `config.jsonc` | módulos na mesma ordem do polybar |
| `style.css` | cores do polybar (#222 / #dfdfdf / #ffb52a / #e60053 / #bd2c40) |
| `scripts/polybar-shim.sh` | converte `%{F#rrggbb}` → markup Pango |

Os 5 scripts do polybar rodam **sem alteração** e continuam servindo ao
bspwm/polybar normalmente.

### Backup

```
~/dotfiles/.config/hypr.ml4w-backup-2026-07-20/    (500K, 115 arquivos)
```

---

## O que FOI verificado

- Waybar subiu de verdade: config e CSS sem erro, barra em DP-1 (1920x30)
- JSON válido; todos os módulos referenciados estão definidos
- Os 3 scripts produzem Pango válido (XML validado)
- Bateria do mouse G703 renderiza o ícone U+F87C em verde (`#00cc44`)
- Os 4 scripts do hypr-jp passam em `sh -n`; filtros `jq` testados offline
- Dispatchers do Hyprland conferidos contra os símbolos do binário

## O que NÃO foi verificado

- **A config do Hyprland nunca foi carregada.** Não existe validador offline
  (diferente do `niri validate`). A validação real é no primeiro boot.
- Módulos `hyprland/workspaces` e `hyprland/window` da waybar — precisam do
  Hyprland rodando.
- Os nomes de classe em `rules.conf` são **inferidos** do bspwmrc. Sob XWayland
  o `WM_CLASS` pode diferir. Confira com:
  ```bash
  hyprctl clients | grep -E 'class|title'
  ```
  Atenção especial: Zoiper5, xfreerdp, IRPF (serpro-ppgd-app-IRPFPGD), Sxiv.

---

## Problemas encontrados no setup atual (bspwm/polybar)

1. **Módulo `consultaponto` do polybar está quebrado.** O config aponta para
   `~/.config/polybar/consultaponto.sh`, que não existe. O script real está em
   `~/bin/consultaponto.sh` e exige a matrícula. Corrigido na waybar
   (`~/bin/consultaponto.sh 30024388`).

2. **`openvpn-isrunning.sh` tem código morto.** Faz dois `echo`: o primeiro pelo
   ping ao `10.16.1.1`, o segundo pela detecção de WireGuard. O polybar usa só a
   primeira linha → **a detecção de WireGuard nunca aparece**. Comportamento
   replicado como está; se quiser corrigir, o script precisa de `exit` ou lógica
   unificada.

3. **Symlinks por toda parte, em dois repos diferentes:** `~/.dotfiles`
   (bspwm, polybar, sxhkd, wallpapers — **é repo git**) e `~/dotfiles`
   (hypr, dunst, gtk — **NÃO é repo git**). Isso já quebrou o `cp -a` do backup
   e o `find` do wallpaper.sh. Use `cp -aL` / `find -L`.

---

## Próximos passos

- [ ] Primeiro boot: `Hyprland -c ~/.config/hypr-jp/hyprland.conf` e corrigir o
      que o parser reclamar
- [ ] Ajustar `gaps_in`/`gaps_out` a olho (bspwm `window_gap 4` é distância
      total; no Hyprland `gaps_in` é a metade)
- [ ] Conferir os `class:` de `rules.conf` com `hyprctl clients`
- [ ] Portar os 3 `conky` — o caso mais chato, não falam layer-shell
- [ ] `redshift-gtk` → instalar `gammastep` (não instalado) ou usar `hyprshade`
- [ ] Avaliar `pyprland` (AUR) se quiser o dropdown animado do `tdrop`
- [ ] Considerar versionar `~/dotfiles` com git

## Sem equivalente no Hyprland (~6 dos seus 60+ atalhos)

Todos marcados com `[X]` em `binds.conf`, no ponto exato onde estavam no sxhkdrc:
equalize/balance da árvore, flip 180°, layouts grid/rgrid do `bsp-layout`,
flags marked/locked/private, navegação parent/brother.
