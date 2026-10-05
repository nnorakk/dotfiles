# Atalhos Hyprland — dia a dia

> `Super` = tecla mod. Terminal = `kitty`. Gerado a partir de
> `conf/binds.conf` e `conf/scratchpads.conf`. Herança direta do antigo `sxhkdrc`.

## Essencial
| Atalho | Ação |
|---|---|
| `Super + Return` | Abre o terminal (kitty) |
| `Super + Space` | Launcher (rofi drun/run) |
| `Super + Alt + Space` | Alternar entre janelas (rofi window) |
| `Super + W`, `Super + Q` **ou** `Alt + W` | Fecha a janela |
| `Super + Shift + W/Q` **ou** `Alt + Shift + W` | Mata a janela à força |
| `Super + Shift + E` | **Encerra a sessão** |
| `Super + Escape` / `Super + Alt + R` | Recarrega o Hyprland |

## Foco e mover janelas (Vim hjkl)
| Atalho | Ação |
|---|---|
| `Super + H/J/K/L` | Move o **foco** (esq/baixo/cima/dir) |
| `Super + Shift + H/J/K/L` | **Troca** a janela de lugar |
| `Super + Tab` | Volta pra última janela focada |
| `Super + C` / `Super + Shift + C` | Cicla próxima / anterior (leva o fullscreen/monocle junto) |
| `Alt + C` / `Alt + Shift + C` | Idem (conjunto alternativo) |
| `Super + I` / `Super + O` | Cicla próxima / anterior no histórico de foco |
| `Alt` + arrastar (botão esq/dir) | Move / redimensiona com o mouse |

## Estados da janela
| Atalho | Ação |
|---|---|
| `Super + F` | Fullscreen |
| `Super + M` | Maximiza (monocle) |
| `Super + S` | Flutuante (volta com `Super + T`) |
| `Super + T` / `Super + Shift + T` | Tiled / pseudo-tiled |
| `Super + Ctrl + Y` | Pin (sticky, fixa em todos os workspaces) |

## Preselect e split
| Atalho | Ação |
|---|---|
| `Super + Ctrl + H/J/K/L` | Preseleciona onde a próxima janela abre (com bloco translúcido de dica) |
| `Super + Ctrl + Space` | Cancela o preselect |
| `Super + Ctrl + 1..9` | Ajusta o ratio do split (0.1–0.9) |
| `Super + Shift + R` | Inverte o split do nó atual |
| `Super + Shift + D` / `Super + Shift + A` | Rola as janelas (próxima / anterior) — **só no layout master** |
| `Super + Y` | Manda a janela para a raiz da árvore |

## Redimensionar / mover
| Atalho | Ação |
|---|---|
| `Super + Alt + H/J/K/L` | Redimensiona a janela |
| `Super + Alt + Shift + H/J/K/L` | Redimensiona no sentido inverso |
| `Super + setas` | Move janela flutuante |
| `Super + Alt + [ ` / `] ` | Diminui / aumenta os gaps (runtime) |

## Workspaces
| Atalho | Ação |
|---|---|
| `Super + 1..0` **ou** `Alt + 1..0` | Vai para o workspace 1–10 |
| `Super + Shift + 1..0` | Manda a janela pro workspace (silencioso) |
| `Super + Shift + Alt + 1..0` | Manda a janela **e segue** |
| `Super + [ ` / `] ` | Workspace anterior / próximo |
| `Super + Shift + =` | Manda a janela pro outro monitor |

## Scratchpads / dropdown
| Atalho | Ação |
|---|---|
| `Super + Ctrl + Return` | Terminal dropdown (pyprland, desce do topo) |
| `Super + Shift + Return` | tmux-scratch (special workspace) |
| `Super + Shift + Escape` | Fecha o tmux-scratch |
| `Super + Shift + I` | Esconde a janela na "gaveta" |
| `Alt + I` | Abre/fecha a gaveta de janelas ocultas |
| `Super + D` | Esconde **todas** as janelas do workspace |

## Submap **apps** — `Super + X`, depois:
| Tecla | Abre |
|---|---|
| `B` | bashtop |
| `R` | ranger |
| `C` | calendário (testecal) |
| `V` | vim |
| `O` | fzf search |
| `P` | VPN SonicWall (tmux) |
| `M` | consulta marcação (ponto) |
| `K` | kitty flutuante |
| `Esc` | sai do submap |

## Submap **layout** — `Super + E`, depois:
| Tecla | Layout |
|---|---|
| `1` | tiled (dwindle) |
| `2` | monocle |
| `3` | even (master) |
| `6` / `7` | rtall / rwide — **só no layout master** |
| `8` / `9` | tall / wide — **só no layout master** |
| `Esc` | sai do submap |

Fora do submap: `Super + PageDown` / `Super + PageUp` cicla a orientação do
layout (próxima / anterior) — **só no layout master**.

> O layout padrão é o **dwindle**, que ignora as mensagens de orientação e de
> roll (`Unknown dwindle layoutmsg`). Esses atalhos só têm efeito depois de
> trocar para o master (`Super + E`, `3`). A troca vale para **todos** os
> workspaces, e ir e voltar (`Super + E`, `1`) não restaura o arranjo
> anterior: as janelas são redistribuídas e o fullscreen é desfeito.

## Screenshot
| Atalho | Ação |
|---|---|
| `Print` | Área + editor de anotação (satty) |
| `Shift + Print` | Tela toda + editor |
| `Ctrl + Print` | Área rápida, copia+salva sem editor |

## Tela / lock / notificações
| Atalho | Ação |
|---|---|
| `Alt + Shift + X` **ou** `Ctrl + Alt + L` | Bloqueia a tela (hyprlock) |
| `Alt + Shift + C` | Desliga a tela (dpms off) |
| `Super + Shift + N` | Central de notificações (swaync) |
| `Super + Ctrl + N` | Não-perturbe (toggle) |
| `Super + N` | Ajuste de padding p/ ultrawide (monocle) |
| `Super + Shift + Space` | Rofi remote desktops |

## Mídia (teclas dedicadas)
| Atalho | Ação |
|---|---|
| `XF86Audio Raise/Lower` | Volume ± (pamixer) |
| Botões laterais do mouse | Volume ± |
| `XF86AudioMute` / `MicMute` | Muta saída / microfone |
| `XF86MonBrightness Up/Down` | Brilho ± |
| `XF86Audio Play/Next/Prev` | Controle de mídia (playerctl) |
