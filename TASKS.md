# Development Roadmap

Below is the ordered checklist of pages and components to build for the **Vidyut** app. Mark tasks with `[x]` or ✅ when complete.

## Navigation & Core Screens
- [x] **Core Navigation Layer** (Bottom Bar / NavigationRail)
  - [x] **Home Screen**
    - [x] Address & Avatar Row
    - [x] Search Bar
    - [x] Category Chips (horizontal scroll)
    - [x] Promotional Banner Carousel
    - [x] Category Grid
    - [x] **CategoryScreen**
      - [x] Sub-Category Sidebar (Popular, New Arrivals, Best Deals, Premium)
      - [x] Product Grid
        - [x] **ProductDetail** (Image gallery, specs, add-to-cart)
  - [x] **Search Screen**
    - [x] Search Input Field
    - [x] Recent Search Chips
    - [x] Filter Drawer (Price, Brand, Rating)
    - [x] Search Results Grid ➡ ProductDetail
  - [x] **Sell Screen**
    - [ ] Sell Dashboard
    - [ ] Create Listing Form (images, title, price, stock)
    - [ ] Manage Listings (edit / pause / delete)
  - [x] **Orders Screen**
    - [x] Orders List
    - [ ] **OrderDetail** (tracking timeline, invoice, review)
  - [x] **Profile Screen**
    - [ ] Account Info
    - [ ] Addresses
    - [ ] Payment Methods
    - [ ] Order History
    - [ ] Wishlist
    - [ ] Settings (theme, notifications, help, sign-out)

## Shared Components
- [x] `_CategoryTile`
- [x] `_HorizontalCategory`
- [x] `_ProductCard`
- [ ] Reusable Buttons, Modals, Loaders

---
**Workflow**: After each feature is implemented and tested, update its checkbox to ✅.