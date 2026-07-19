#!/usr/bin/env bash

# ── SSH agent tradicional persistente ─────────────────────────────
SSH_AGENT_ENV="$HOME/.ssh/agent/ssh-agent.env"
SSH_AGENT_SOCK="$HOME/.ssh/agent/ssh-agent.sock"

mkdir -p "$HOME/.ssh/agent"
chmod 700 "$HOME/.ssh/agent"

if [ -f "$SSH_AGENT_ENV" ]; then
  source "$SSH_AGENT_ENV" > /dev/null
fi

if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
  # agente morto ou inexistente — iniciar novo
  rm -f "$SSH_AGENT_SOCK"
  ssh-agent -a "$SSH_AGENT_SOCK" > "$SSH_AGENT_ENV"
  source "$SSH_AGENT_ENV" > /dev/null
  chmod 600 "$SSH_AGENT_ENV"
fi

export SSH_AUTH_SOCK="$SSH_AGENT_SOCK"

# ── Carrega chaves a cada inicialização ───────────────────────────
# if ! ssh-add -l &>/dev/null; then
#   for key in $HOME/.ssh/*.pub; do
#     ssh-add -t 43200 "${key%.pub}"
#   done
# fi

# ── Carrega chaves a cada inicialização ───────────────────────────
for key in $HOME/.ssh/*.pub; do
  priv="${key%.pub}"
  [ -f "$priv" ] || continue

  # pula chaves sem senha (não precisam de cache)
  if ssh-keygen -y -f "$priv" -P "" &>/dev/null; then
    continue
  fi

  # verifica se o fingerprint já está no agente
  fingerprint=$(ssh-keygen -l -f "$key" | awk '{print $2}')
  if ! ssh-add -l | grep -q "$fingerprint"; then
    ssh-add -t 86400 "$priv"
  fi
done

# ── Função de conexão SSH inteligente ─────────────────────────────
# Tenta chave primeiro; se falhar, usa senha do pass
ssh_infra() {
  local host="$1"
  local entry="$host"
  if ssh -o BatchMode=yes -o ConnectTimeout=5 "$host" exit 2>/dev/null; then
    echo "if"
  else
    local passw=$(pass "$entry" | head -1)
    SSHPASS="$passw" sshpass -e ssh -o StrictHostKeyChecking=accept-new "$host"
  fi
}

