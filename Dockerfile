FROM astrocrpublic.azurecr.io/runtime:3.1-13

# 2. Instalação do uv dentro do container (vindo da imagem oficial do uv)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

USER root

# 3. Copia os arquivos de definição do seu projeto local para o container
COPY pyproject.toml uv.lock ./

# O uv detectará o uv.lock na pasta e respeitará as versões ali contidas
RUN uv pip install --system --no-cache -r pyproject.toml

USER astro