# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Bacchanal** is a personal hospitality and location manager for curating, mapping, and sharing exceptional hospitality experiences. The application is built with a "public showcase, private management" philosophy:

- **Public Interface**: Read-only presentation of venues (Crapula, Comissatio, Forma) accessible without authentication
- **Administrative Interface** (Triclinium): Authenticated dashboard for CRUD operations, restricted to the administrator

### Core Modules

1. **Crapula** — Visited venues archive with notes, ratings, and tags
2. **Comissatio** — Wishlist of aspirational destinations and upcoming reservations
3. **Forma** — Interactive geographic map unifying Crapula and Comissatio data
4. **Triclinium** — Authenticated admin dashboard for system management

## Repository Purpose

This repository contains **specification and documentation files only**. No application code is written or stored here. This is a specifications-only repository where all work produces `.md` files.

## Creating Specifications

When working in this repository:

- Create specification documents as `.md` files following the project's architectural concepts (Crapula, Comissatio, Forma, Triclinium)
- Reference the core modules and public vs. authenticated access patterns defined in README.md
- Organize specifications by module or functional area
- Keep specifications clear and detailed enough to guide implementation in a separate repository

## Git Workflow

- Primary branch: `main`
- User: Manuel Friedmacher
- Commits include co-author attribution: `Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>`
- Only `.md` files should be committed to this repository

## Files to Know

- `README.md` — Application architecture, core concepts, and module definitions (Crapula, Comissatio, Forma, Triclinium)
- `CLAUDE.md` — This guidance file
