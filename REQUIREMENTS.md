# Bacchanal — Requirements

> **Version:** 1.0 | **Status:** DRAFT

---

## 1. Project Overview

Bacchanal is a personal hospitality and location manager. An administrator (one or more authenticated users) maintains a curated log of visited places (**Crapula**) and a wish-list of places to visit (**Comissatio**). A map view (**Forma**) displays all places geographically. A public read-only presentation of Crapula, Comissatio, and Forma is accessible to anyone without authentication. The administrative dashboard (**Triclinium**) is restricted to authenticated admin users.

### Access Modes

**Admin access** — authenticated and authorised users who maintain all application data. All write operations (create, update, delete, promote) and the Triclinium dashboard are exclusively available to admin users.

**Anonymous access** — unauthenticated, read-only access for any visitor. Anonymous users can browse Crapula (visited locations), Comissatio (wish-list), and Forma (map). No authentication is required and no write operations are exposed.

**Scope boundary:** Single-tenant, personal use. No public self-registration. No native mobile apps. No multi-tenancy.

### Module Name Map

| Internal Name     | Display Name    | Description |
|---|---|---|
| **Crapula**       | Location Log    | Visited location pages — metadata, visit timeline, ratings |
| **Comissatio**    | Wish-List       | Locations the admin plans to visit; promotable to Crapula entries |
| **Forma**         | Map             | Geographic map of all places, colour-coded by type and status |
| **Triclinium**    | Dashboard       | Analytics strip + sorted location lists (admin only) |

---

## 2. Functional Requirements

Requirement IDs are stable.

### 2.1 Crapula (Location Log)

- **R-001** Admin can create, read, update, and delete visited locations.
- **R-002** Each location stores: name, type (from extensible type list — see R-010), address (street name, house number, postal code, city, country), optional contact details (website URL, phone, email), status, coordinates (latitude/longitude — see R-013 and R-014), three dimension ratings, and a computed overall score. Opening hours are managed as a structured child entity (see R-009).
- **R-003** Location type is drawn from an extensible list maintained by the admin. The default set is: `Restaurant` | `Coffeehouse` | `Bar` | `Bakery`.
- **R-004** Each location has a visit timeline: one or more Visit records, each with a calendar date (date-only — no time component) and an optional text note.
- **R-005** The date of first visit is derived from the earliest Visit record for that location (not a stored field).
- **R-006** Each location has three dimension ratings (1–5): **Price**, **Ambience**, **Quality**. Ratings are optional.
- **R-007** Overall score is computed automatically as the average of the three dimension ratings. Returns null if any dimension is null or unset.
- **R-008** Overall score is recalculated and persisted on every update that modifies any rating field.
- **R-009** Opening hours are modelled as a structured child entity of Location, with one record per day of the week. The data model per record is:

  | Field | Description |
  |---|---|
  | Day of week (1–7, Mon–Sun) | Key — one record per day per location |
  | Opening time 1 | Start of first opening period (optional) |
  | Closing time 1 | End of first opening period (optional) |
  | Opening time 2 | Start of second opening period, e.g. dinner after a lunch break (optional) |
  | Closing time 2 | End of second opening period (optional) |
  | Closed today flag | Indicates the location is closed on this day |

  A day record with the closed flag set may omit all time fields. Both time pairs are independently optional — a location open continuously (no lunch break) only sets the first pair. Days with no record are treated as unknown / not configured.

  The UI presents opening hours as a structured inline table on the location detail view with five columns: **Day | Opens | Closes | Opens (2) | Closes (2)**. The fourth and fifth columns are shown only if at least one day has a second opening period populated. A day marked closed displays a "Closed" label spanning the time columns.

### 2.2 Comissatio (Wish-List)

- **R-020** Admin can add wish-list entries with a minimum of name, city, and country. Street name, house number, and postal code are optional at creation time.
- **R-021** All other location fields (website, phone, email, ratings) are optional at creation time for wish-list entries.
- **R-022** Wish-list entries are displayed with a visually distinct treatment from visited entries across all views. Specifically: in Forma, wish-list places use a **light/pastel** colour variant of the location-type colour; visited places use a **bold/saturated** colour variant.
- **R-023** A wish-list entry can be **promoted** to a Crapula entry. Promotion transitions the location's status from Wishlist to Visited, preserves all existing fields, and returns the updated record. No new record is created.
- **R-024** A location (whether visited or wish-list) can be marked as **Closed** to indicate the place no longer exists or is permanently shut. The status has exactly three values: `Visited`, `Wishlist`, `Closed`. Closed locations are visibly marked with a distinct treatment (e.g. strikethrough or badge) across all list and detail views. Closed locations are **excluded from Forma** — they do not appear as map pins regardless of whether coordinates are set.

### 2.3 Forma (Map)

- **R-025** Forma displays all locations (both visited and wish-list) as pins on an interactive geographic map.
- **R-026** Each location type is assigned a distinct colour. Visited places render as a **bold/saturated** version of that colour; wish-list places render as a **light/pastel** version of the same colour. A map legend explains the colour scheme.
- **R-027** Selecting a pin opens a summary card for that location (name, type, status, address, overall score for visited places).
- **R-028** The Forma view is available to both admin and anonymous users (read-only in both cases).
- **R-029** A location without resolved coordinates, or with status Closed, is excluded from the map view. Locations missing coordinates are surfaced in the admin UI with a warning indicator.

### 2.4 Triclinium (Dashboard)

- **R-030** Triclinium is the landing page for authenticated admin users.
- **R-031** An **analytics strip** displays five stats, all computed server-side:
  1. Total visited locations
  2. Total wish-list entries
  3. Total visit events (sum of all Visit records)
  4. Top visited location (location with the most Visit records)
  5. Highest-ranked location (highest overall score; null scores excluded)
- **R-032** Below the strip: two sorted lists — visited locations by most recent visit date (descending), wish-list by creation date (descending).

### 2.5 Location Type Management

- **R-010** Location types are stored in a dedicated, admin-managed list. The default set is: `Restaurant`, `Coffeehouse`, `Bar`, `Bakery`. New types can be added by an admin without any code changes.
- **R-011** Each type entry stores: a unique technical key, a display label, and a **base colour** (hex `#RRGGBB`) selectable via a colour picker in the admin UI. The hex format is validated by the application. Default seed colours: Restaurant `#E53935`, Coffeehouse `#6D4C41`, Bar `#1E88E5`, Bakery `#FBC02D` (admin-changeable).
- **R-012** The two Forma colour variants — bold/saturated for visited places and light/pastel for wish-list places — are **derived automatically** from the base colour (e.g. by adjusting HSL saturation/lightness) and are not stored separately.

### 2.6 Geocoding

- **R-013** Every location record holds a latitude and longitude field. These are the canonical coordinates used by Forma.
- **R-014** **Auto-geocoding (preferred path):** When a location is saved (create or update) and coordinates are not already set (or the address has changed), the system attempts to resolve coordinates automatically from the address fields. Geocoding failure is non-blocking: the record is saved without coordinates and a warning state is set (see R-029).
- **R-015** **Manual override:** An admin can manually enter or correct latitude/longitude directly on the location form. A manually set coordinate is not overwritten by subsequent auto-geocoding runs unless the admin explicitly triggers a re-geocode action.
- **R-016** The geocoding provider is configurable via application settings, allowing it to be swapped without code changes. The default target is **Nominatim** (OpenStreetMap).
- **R-017** A **re-geocode** action is available on individual location records in the admin interface, allowing an admin to trigger coordinate resolution on demand.

### 2.7 User Management

- **R-040** Two roles: **Admin** (full CRUD) and **Anonymous** (unauthenticated, read-only). Role assignment is managed via the application's authentication configuration.
- **R-041** Multiple admin accounts are supported. Admin users are provisioned by an existing admin or via the identity provider's admin console.
- **R-042** No public self-registration. No seeded superuser script.

### 2.8 Anonymous Read-Only Access

- **R-050** Anonymous users can browse **Crapula** (visited location list and detail pages).
- **R-051** Anonymous users can browse **Comissatio** (wish-list). The wish-list view is read-only; no promote or edit actions are exposed to anonymous users.
- **R-052** Anonymous users can access **Forma** (map). The map is read-only; no create, edit, or promote actions are available.
- **R-053** Anonymous read access does not expose the identity of admin users who recorded individual visit events.
- **R-054** Triclinium and all write operations require admin authentication and are not accessible to anonymous users.
- **R-055** The anonymous interface provides a responsive, public-facing presentation of Crapula, Comissatio, and Forma — optimised for public consumption without requiring authentication.

---

## 3. Non-Functional Requirements

### Performance

- **R-060** Initial page load < 3 seconds.
- **R-061** Simple data read responses (single entity, dashboard stats) < 500 ms.

### Scale

- **R-062** Design target: ~500 locations, ~2,000 visit records. No horizontal scaling requirement.
- **R-063** No pagination required in v1. All location list requests return the full set.

### Out of Scope (v1)

Native iOS/Android apps, image/file storage, social media integration (Instagram/Facebook), email notifications, public comments or ratings, multi-tenancy, import from Google Maps/Yelp, offline/PWA, password reset UI (managed by the identity provider).
