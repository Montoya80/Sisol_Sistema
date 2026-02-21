FROM node:22-alpine AS base

# Dependencias para Alpine
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Instalación de dependencias
FROM base AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
# Usamos install --legacy-peer-deps para evitar conflictos de versiones en entornos limpios
RUN npm install --legacy-peer-deps

# Construcción
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Desactivar telemetría y configurar producción
ENV NEXT_TELEMETRY_DISABLED 1
ENV NODE_ENV production

# Ejecutar build con verbose para capturar errores
RUN npm run build

# Imagen final
FROM base AS runner
WORKDIR /app

ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
RUN mkdir .next
RUN chown nextjs:nodejs .next

COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"

# Healthcheck que no bloquee el build
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node -e "fetch('http://localhost:3000').then(r => process.exit(r.ok ? 0 : 1)).catch(() => process.exit(1))"

# TRIGGER: 2026-02-21-14-45
CMD ["node", "server.js"]
