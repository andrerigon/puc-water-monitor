#!/bin/bash
set -e

# Remova um servidor de PID antigo, se existir.
rm -f /app/tmp/pids/server.pid

# Verificar se já existe um arquivo de lock para migrações
if [ -f /app/tmp/migration.lock ]; then
  echo "Migration lock file exists. Waiting for migrations to complete..."
  while [ -f /app/tmp/migration.lock ]; do
    sleep 1
  done
  echo "Migration lock file removed. Proceeding..."
else
  # Criar arquivo de lock para migrações
  touch /app/tmp/migration.lock
  # Crie, migre e rode o seed do banco de dados.
  bundle exec rails db:create || true
  bundle exec rails db:migrate || true
  bundle exec rails db:seed || true
  # Remover arquivo de lock para migrações
  rm -f /app/tmp/migration.lock
fi

# Execute o comando principal (iniciar o servidor Rails).
exec "$@"