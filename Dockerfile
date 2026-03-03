FROM astrocrpublic.azurecr.io/runtime:3.1-13

# 2. Instalação do uv dentro do container (vindo da imagem oficial do uv)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

USER root

# 3. Copia os arquivos de definição do seu projeto local para o container
COPY pyproject.toml uv.lock ./

# O uv export garante que as versões sejam idênticas ao seu local
# O --system instala onde o Airflow já está esperando
RUN uv export --format requirements-txt > requirements.txt && \
    uv pip install --system -r requirements.txt

USER astro