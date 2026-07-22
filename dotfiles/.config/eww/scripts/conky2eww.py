#!/usr/bin/env python3
"""Converte markup em formato conky (stdin) numa arvore de widgets eww (stdout).

O coletor analisa_saldo_semanal.sh emite texto com tokens de conky (${colorN},
${color}, ${font ...}, ${font}, ${voffset N}, ${hr}, ${alignr}). O eww nao
entende esse markup, entao aqui traduzimos:

  - ${colorN}/${color}/${font ...}/${font}  -> spans Pango (label :markup)
  - ${alignr}   -> quebra a linha em coluna esquerda e direita (spacer hexpand)
  - ${hr}       -> regua horizontal que preenche o resto da linha
  - ${voffset N}-> classe "voff" (margin-top via CSS)

A saida e uma unica arvore de widgets consumida por (literal :content ...).
O modelo de cor do conky e "plano" (uma cor vale ate o proximo token); o Pango
e aninhado, entao reabrimos um <span> fechado a cada troca de estado para nunca
cruzar tags.
"""
import html
import re
import sys

# Paleta de cores (indices 1-9 usados nos tokens ${colorN} da entrada).
COLORS = {
    "1": "#FF0000",
    "2": "#00FF00",
    "3": "#d68a58",
    "4": "#FFFF00",
    "5": "#74a892",
    "6": "#00FFFF",
    "7": "#FFFFFF",
    "8": "#FFA500",
    "9": "#adc178",
}
DEFAULT_COLOR = "#D9FFE2"          # cor padrao do texto

TOKEN = re.compile(r"\$\{([^}]*)\}")


def span(text, color, font):
    """Envolve um trecho de texto num <span> Pango com o estado atual."""
    if text == "":
        return ""
    attrs = ["foreground='%s'" % color]
    if font:
        attrs.append("font='%s'" % font)
    return "<span %s>%s</span>" % (" ".join(attrs), html.escape(text, quote=False))


def parse_font(arg):
    """'font Roboto:size=30' -> 'Roboto 30' (descricao de fonte do Pango)."""
    m = re.match(r"font\s+(.+?)(?::size=(\d+))?$", arg)
    if not m:
        return None
    family, size = m.group(1), m.group(2)
    return "%s %s" % (family, size) if size else family


def convert_line(line):
    """Uma linha de markup conky -> (left_markup, right_markup, has_hr, has_voff)."""
    color, font = DEFAULT_COLOR, None
    left, right = [], []
    active = left                  # antes de ${alignr} escreve na esquerda
    has_hr = has_voff = False
    pos = 0
    for m in TOKEN.finditer(line):
        active.append(span(line[pos:m.start()], color, font))
        pos = m.end()
        tok = m.group(1).strip()
        if tok == "color":
            color = DEFAULT_COLOR
        elif tok in ("color" + k for k in COLORS):
            color = COLORS[tok[5:]]
        elif tok == "font":
            font = None
        elif tok.startswith("font"):
            font = parse_font(tok)
        elif tok == "alignr":
            active = right
        elif tok == "hr":
            has_hr = True
        elif tok.startswith("voffset"):
            has_voff = True
        # tokens desconhecidos sao ignorados silenciosamente
    active.append(span(line[pos:], color, font))
    return "".join(left), "".join(right), has_hr, has_voff


def row_widget(left, right, has_hr, has_voff):
    cls = "row voff" if has_voff else "row"
    parts = ['(box :class "%s" :orientation "h" :space-evenly false' % cls]
    parts.append('  (label :halign "start" :xalign 0 :markup "%s")' % left)
    if has_hr:
        parts.append('  (box :class "hr" :hexpand true :valign "center")')
    if right:
        if not has_hr:
            parts.append('  (box :hexpand true)')
        parts.append('  (label :halign "end" :xalign 1 :markup "%s")' % right)
    parts.append(")")
    return "\n".join(parts)


def main():
    rows = []
    for raw in sys.stdin.read().splitlines():
        if raw.strip() == "":
            rows.append('(box :class "gap")')
            continue
        left, right, has_hr, has_voff = convert_line(raw)
        rows.append(row_widget(left, right, has_hr, has_voff))
    body = "\n".join(rows) if rows else '(label :text "sem dados")'
    print('(box :class "saldo" :orientation "v" :space-evenly false\n%s\n)' % body)


if __name__ == "__main__":
    main()
