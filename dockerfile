FROM node:22-slim AS base

# Stage 1: Install dependencies
FROM base AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install

# Stage 2: Build the app
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# Force STANDALONE output just in case
ENV NEXT_OUTPUT_STANDALONE=true
RUN npm run build
# Verify build output
RUN ls -la .next/standalone

# Stage 3: Run the app
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080
ENV HOSTNAME="0.0.0.0"

# Standard non-root user for security
RUN groupadd --system --gid 1001 nodejs
RUN useradd --system --uid 1001 nextjs

# Copy essential files
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Permissions for Nextjs cache
RUN mkdir -p .next && chown nextjs:nodejs .next

USER nextjs

EXPOSE 8080

# Explicitly log startup for Dokploy visibility
CMD ["sh", "-c", "echo 'Sisol_Sistema Starting... Internal Port: 8080'; node server.js"]
