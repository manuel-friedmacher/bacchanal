# 🍷 Bacchanal

**Bacchanal** is a self-hosted, personal hospitality and location manager designed for modern epicureans. Named after the ancient Roman festivals of Bacchus—the god of wine, revelry, and fine hosting—this application serves as your private digital ledger to curate, map, and share the extraordinary places you have experienced or dream of discovering. 

Whether tracking high-end restaurants, boutique hotels, hidden cocktail dens, or world-class wineries, Bacchanal organizes your hospitality journey into a beautiful, seamless interface.

---

## 🏛️ Application Architecture & Core Concepts

Bacchanal translates complex geographic and status data into an elegant, thematic ecosystem split across four core modules:

### 🍇 Crapula (The Visited Log)
Named after the legendary aftermath of a grand Roman feast, the **Crapula** is your curated archive of past experiences. It acts as a historical diary where the administrator logs visited venues, complete with personal notes, ratings, and tags. This is the public-facing evidence of your hospitality conquests.

### 🥂 Comissatio (The Wishlist)
Inspired by the wild, post-dinner Roman drinking rituals where guests toasted to future pleasures, the **Comissatio** is your dedicated wishlist. It allows you to log aspirational destinations, upcoming reservations, and recommended hotspots that you intend to experience.

### 🗺️ Forma (The Geographic Map View)
The **Forma**—referencing the grand master stone maps of ancient Rome—unifies your entire database into a single, interactive geographic interface. It plots coordinates from both the *Crapula* and *Comissatio* using distinct visual markers, allowing users to browse your hospitality footprint spatially.

### 🔑 Triclinium (The Admin Dashboard)
The **Triclinium** was the exclusive, formal Roman dining room where the host orchestrated the entire feast behind closed doors. In this application, it serves as the secure, authenticated administrative dashboard. Restricted entirely from public view, it gives the administrator full CRUD capabilities to manage locations, system configurations, and authentication settings.

---

## 🌐 Public vs. Administrative Access

Bacchanal is built with a "public showcase, private management" philosophy:

* **The Open Forum (Unauthenticated):** Anyone visiting the root application can freely browse a read-only presentation of your **Crapula**, **Comissatio**, and **Forma**. It functions as a sleek, personal travel and hospitality portfolio without requiring user registration or login.
* **The Imperial Palace (Authenticated):** Access to the **Triclinium** is strictly guarded by robust authentication mechanisms. Only the designated administrator can enter to add new venues, edit existing logs, or alter application data.
