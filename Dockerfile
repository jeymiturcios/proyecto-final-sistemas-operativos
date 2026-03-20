# ================================
# Dockerfile Optimizado - Multi-stage Build
# ================================

# Stage 1: Dependencias
FROM node:20-alpine AS deps
WORKDIR /app

# Copiar solo archivos de dependencias para cache eficiente
COPY package*.json ./

# Instalar solo dependencias de producción
RUN npm ci --only=production && npm cache clean --force

# ================================
# Stage 2: Producción
FROM node:20-alpine AS production
WORKDIR /app

# Crear usuario no-root por seguridad
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodeuser -u 1001 -G nodejs

# Copiar dependencias del stage anterior
COPY --from=deps /app/node_modules ./node_modules

# Copiar código fuente
COPY --chown=nodeuser:nodejs . .

# Variables de entorno
ENV NODE_ENV=production
ENV PORT=3000

# Exponer puerto
EXPOSE 3000

# Cambiar a usuario no-root
USER nodeuser

# Healthcheck para verificar que la app responde
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD node -e "fetch('http://localhost:3000/').then(r => process.exit(r.ok ? 0 : 1)).catch(() => process.exit(1))"

# Comando de inicio
CMD ["node", "app.js"]
