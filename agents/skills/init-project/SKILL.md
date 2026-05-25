---
name: init-project
description: Inyecta un CONTEXT.md base en el repositorio actual para establecer el Local Context del proyecto. Úsalo cada vez que empieces un nuevo repositorio o proyecto para separar las reglas globales de las locales.
---

<what-to-do>
Vas a crear un archivo llamado `CONTEXT.md` en la raíz del espacio de trabajo o directorio actual. Este archivo actuará como el glosario de dominio y registro de decisiones de arquitectura (Local Context) exclusivo para este proyecto.

Si el archivo ya existe, no lo sobrescribas. Simplemente informa al usuario de que el proyecto ya tiene un `CONTEXT.md` inicializado.

Usa el contenido de la sección `<template>` para crear el archivo. Reemplaza `[Nombre del Proyecto]` por el nombre real de la carpeta raíz.
</what-to-do>

<template>
# [Nombre del Proyecto] - Local Context

Este archivo define el glosario de dominio específico de este proyecto y las reglas locales (frameworks, convenciones arquitectónicas) que sobreescriben o complementan a los Universal Standards del sistema.

## Glosario de Dominio (Language)

_Define aquí los términos críticos de tu lógica de negocio (Domain-Driven Design)._

**EjemploTermino**:
Definición de qué es esto en el contexto de este proyecto.
_Avoid_: Terminos alternativos confusos.

## Arquitectura y Stack

- **Stack Principal:** (ej. Next.js, FastAPI, etc.)
- **Estrategia de Estilos:** (ej. Vanilla CSS, Tailwind)
- **Base de Datos:** (ej. PostgreSQL, Supabase)
- **Convenciones Específicas:** (Cualquier regla de código que solo aplique a este repo y no esté en tus Universal Standards).
</template>
