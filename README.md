# RSS SaaS — Backend skeleton


## Requisitos
- Docker & docker-compose
- Ruby 3.4.7


## Levantar en local
1. Copia `.env.example` a `.env` y ajusta variables.
2. `docker-compose up --build`
3. Accede a `http://localhost:3000`


## Notas
- Sidekiq corre en el servicio `worker`.
- `FetchFeedJob` es un ejemplo muy básico; sustituir por fetchers más robustos con caching y headless rendering para sites JS-heavy.