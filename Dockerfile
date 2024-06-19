# Use a imagem base do Ruby 3.0.2
FROM ruby:3.0.2

# Instale dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Instale a versão específica do Bundler
RUN gem install bundler -v 2.4.22

# Defina o diretório de trabalho
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Instale as gems usando a versão específica do Bundler
RUN bundle _2.4.22_ install

# Copie todo o código da aplicação para o contêiner
COPY . /app

# Copie o script de entrypoint
COPY entrypoint.sh /usr/bin/

# Defina o entrypoint
ENTRYPOINT ["entrypoint.sh"]

# Exponha a porta que a aplicação irá rodar
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]