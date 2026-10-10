# QA & Debug Report — Tawana Foundation Website

Date: 2026-10-10 · Scope: full repository (`lib/`, `l10n.yaml`, `assets/content/content.json`, `web/`, `test/`)

> **Method and limits.** This was a **static code audit with fixes**. The Flutter SDK and pub.dev could not be reached from the audit environment, and terminal apps cannot be driven remotely, so `flutter analyze`, `flutter test`, Lighthouse and real-browser runs were **not executed**. Every changed Dart file was syntax-checked with a Dart parser. Layout claims come from reading the constraints in the code, not from screenshots. Run the commands in §8 to confirm.

---

## 1. Executive Summary

| | |
|---|---|
| Bugs found | **26** |
| Fixed in code | **24** |
| Partly fixed / need a product decision | **2** (BUG-022 assets, BUG-023 PDF download), plus the placeholder content in §5 |
| Regressions K1–K7 | 5 were **not** in place (K1, K2, K3, K6, K7). K4 was partial and K5 passed. All are now fixed. |
| Verdict | **Conditional pass.** The code is ready for verification. It is not production-ready until §8 is run clean and the §5 placeholder content is replaced. |

Most severe findings:
- **`/news` was an unimplemented stub** that showed "TODO: Implement this page." in English for every language.
- **`flutter analyze` / `flutter test` were guaranteed to fail.** `test/widget_test.dart` imported `package:tawanaweb/main.dart` and `MyApp`, but the package is `tawanafoundation` and that class does not exist.
- **Systematic overflow stripes.** Eight card grids used a fixed `childAspectRatio`, so cards overflowed whenever text was longer (Russian), the screen was narrower, or the text scale was larger.
- **Header overflow.** This happened at 280–430 px (K1) and also at 600–~700 px, where the full desktop nav was forced into a tablet width.

---

## 2. Test Matrix

Legend: **S** = statically reviewed, no overflow or crash source remains · **R** = needs a runtime check · N/A = not executable in the audit environment.

| Route | 280 | 320 | 360 | 390 | 430 | 768 | 1366 | 1440 | 1920 |
|---|---|---|---|---|---|---|---|---|---|
| `/` | S | S | S | S | S | S | S | S | S |
| `/about` | S | S | S | S | S | S | S | S | S |
| `/programs` | S | S | S | S | S | S | S | S | S |
| `/projects` | S | S | S | S | S | S | S | S | S |
| `/projects/:id` (valid + invalid) | S | S | S | S | S | S | S | S | S |
| `/impact` | S | S | S | S | S | S | S | S | S |
| `/news`, `/news/:id` | S | S | S | S | S | S | S | S | S |
| `/team` | S | S | S | S | S | S | S | S | S |
| `/transparency` | S | S | S | S | S | S | S | S | S |
| `/get-involved` | S | S | S | S | S | S | S | S | S |
| `/donate` | S | S | S | S | S | S | S | S | S |
| `/contact` | S | S | S | S | S | S | S | S | S |
| 404 | S | S | S | S | S | S | S | S | S |

The same grid applies to `en`, `ru`, `fa` and `ps`. RTL relies on Flutter's locale-driven `Directionality`, and no hard-coded `left`/`right` remains in `lib/`.
Browsers: Chrome, Edge, Firefox, Safari, iOS Safari and Chrome Android are **N/A (R)**. Lighthouse and Fast 3G are **N/A (R)**.

---

## 3. Bug List

Fields not listed (Device / Browser) are "all" unless stated. Confidence is how sure I am that this was a real defect.

```
BUG-001  Severity: Critical  Category: Code  Confidence: High
Route: n/a (tooling)
Steps: 1. flutter analyze  2. flutter test
Expected: no errors. Actual: uri_does_not_exist (package:tawanaweb/main.dart) and undefined class MyApp.
Root cause: default counter test never updated after the package was renamed to tawanafoundation.
File(s): test/widget_test.dart:11,16
Fix: replaced with real tests for LocaleNotifier (restore, fallback, persistence) and ResponsiveGrid at 280 px.
```
```
BUG-002  Severity: Critical  Category: Routing / Localization  Confidence: High
Route: /news   Language: all
Steps: 1. Click "News" in the header
Expected: news list. Actual: plain AppBar "News" + "TODO: Implement this page." with no site header or footer, English in every language.
File(s): lib/features/news/news_page.dart
Fix: implemented the page. Newest article is featured (uses existing `featuredLabel`), the rest show in a 1/2/3-column grid, with an empty state and localized dates.
```
```
BUG-003  Severity: High  Category: Layout (K1)  Confidence: High
Route: all   Device: 280–430 px and 600–~700 px
Expected: no overflow stripes. Actual: the long app name ("Tawana Charity & Development Foundation") was not Flexible, so the row overflowed. At 600–899 px the full 9-link nav + language + Donate was shown and overflowed.
File(s): lib/core/widgets/app_header.dart:48-117 (old)
Fix: the name ellipsizes, and the compact header (language icon + menu) is used below 900 px. On desktop the name shows only at ≥1600 px so the nav keeps its space. The nav still scrolls horizontally when labels do not fit.
```
```
BUG-004  Severity: High  Category: Layout  Confidence: High
Route: /, /programs, /impact, /team, /get-involved, /projects, /projects/:id, /news/:id
Expected: cards grow with content. Actual: GridView with fixed childAspectRatio (0.72–2.6) produced "BOTTOM OVERFLOWED" stripes on long translations or narrow widths. Programs and Get Involved cards had no truncation at all.
Fix: new lib/core/widgets/responsive_grid.dart (rows sized to content, equal height per row). Column counts are unchanged (stats 2/3/5, cards 1/2/3).
```
```
BUG-005  Severity: High  Category: Layout  Confidence: High
Route: all   Device: iPhone SE 320×568, Fold 280×653
Actual: mobile menu sheet (9 links + language + Donate ≈ 680 px) was a non-scrollable Column, so it overflowed.
Fix: the sheet scrolls, is capped at 90% of the height, and highlights the current route. Donate stays visible at the end.
```
```
BUG-006  Severity: High  Category: Localization  Confidence: High
Route: /transparency, /donate, /contact   Language: ru, fa, ps
Actual: English paragraphs hard-coded in Dart (financial split, governance, donate why/where/options, bank labels, 3 FAQ items, office hours).
Fix: 27 new ARB keys, translated into all four languages. lib/l10n/*.dart regenerated (no key renamed).
```
```
BUG-007  Severity: High  Category: Localization / A11y  Confidence: High
Route: /contact
Actual: every validation error read "Something went wrong.", and the email check accepted any string containing "@".
Fix: "This field is required." and "Please enter a valid email address." added. Proper email pattern, keyboard types, autofill hints, and required fields marked with *.
```
```
BUG-008  Severity: Medium  Category: Localization  Confidence: High
Route: /projects/:id
Actual: longDescription/challenge/approach/results were headed "Our story", "Objectives", "Our mission", "Impact".
Fix: new keys projectOverview / projectChallenge / projectApproach / projectResults.
```
```
BUG-009  Severity: Medium  Category: Localization / RTL  Confidence: High
Route: /, /news, /news/:id, /projects/:id   Language: all (esp. fa, ps)
Actual: dates printed as 2025-02-10 in every language. Beneficiaries showed as "1200", and progress was not localized.
Fix: lib/core/utils/formatters.dart. MaterialLocalizations medium date and intl NumberFormat give Persian/Pashto digits and grouping.
```
```
BUG-010  Severity: Medium  Category: Localization  Confidence: High
Language: ru   File: lib/l10n/app_ru.arb:3
Actual: "Блоговорительная" (typo). Fix: "Благотворительная".
```
```
BUG-011  Severity: Medium  Category: State  Confidence: High
Steps: 1. Select fa  2. Reload
Actual: the page rendered in English, then flipped to RTL once SharedPreferences resolved. A language picked during that window could be overwritten. Unsupported stored codes were accepted.
Fix: saved locale is read in main() before runApp and injected via `initialLocaleCodeProvider`. Codes are validated against supportedLocales, and writes are best-effort (try/catch).
```
```
BUG-012  Severity: Medium  Category: Routing  Confidence: High
Route: /projects/unknown, /news/unknown
Actual: bare "Something went wrong." with no header way back. Repository getById() fell back to the FIRST item (wrong content for a typo'd URL) and ignored the language.
Fix: shared NotFoundState (message + back button + footer). Repositories take `lang`, return null for unknown ids, and the providers now go through them (UI → Repository → JSON).
```
```
BUG-013  Severity: Medium  Category: Routing  Confidence: High
Route: /get-involved
Actual: the "Donate" card's button said "Contact" and went to /contact. Fix: goes to /donate. Buttons are aligned at the card bottom.
```
```
BUG-014  Severity: Medium  Category: Layout / UX  Confidence: High
Route: /projects — search "zzz"
Actual: the empty result showed the error string. Fix: friendly empty state (projectsEmpty). Search also matches category and location, and chips wrap with run spacing.
```
```
BUG-015  Severity: Medium  Category: Routing  Confidence: High
Route: /projects/:id, /news/:id
Actual: no nav item highlighted on detail routes, and the mobile menu never highlighted. Fix: prefix-match highlight on desktop and mobile, with Semantics(selected).
```
```
BUG-016  Severity: Medium  Category: Layout  Confidence: Medium
Route: /  Device: < 600 px
Actual: "View all" for projects/news was hidden on phones, leaving no in-page path to the full list. Fix: shown at all widths.
```
```
BUG-017  Severity: Medium  Category: Asset (K4)  Confidence: High
Actual: 11 images listed in content.json (projects/news/team) are not on disk, and each one fired a 404 in DevTools before the fallback showed.
Fix: AppImage checks the AssetManifest first, so it makes no request for missing files and shows the placeholder.
```
```
BUG-018  Severity: Low  Category: Layout  Confidence: Medium
Device: 280–599 px   Language: ru
Actual: 48 px page titles split single words mid-word (e.g. "Прозрачность" at 280 px).
Fix: displayLarge/headlineLarge scale to 34/28 px below 600 px only (app.dart builder). Tablet and desktop typography are unchanged.
```
```
BUG-019  Severity: Low  Category: Code  Confidence: High
Actual: 24 × `AppLocalizations.of(context)!` on a non-nullable getter (nullable-getter: false) → unnecessary_non_null_assertion. ColorScheme.fromSeed(background:) is deprecated. There were 3 unused imports (programs, about, footer), dynamic `List` types in the home grids, and missing const.
Fix: all corrected.
```
```
BUG-020  Severity: Low  Category: A11y  Confidence: Medium
Actual: images had no semantic label or were not marked decorative. Footer links were ~22 px tall. The logo link and icon buttons had no labels, the progress bar had no semantics, and the search field had only a hint.
Fix: semanticLabel/excludeFromSemantics on images, 44 px footer targets, 48 px nav targets, tooltips, header semantics, label on search.
```
```
BUG-021  Severity: Low  Category: SEO  Confidence: High
File: web/index.html, web/manifest.json
Actual: title "tawanaweb", description "A new Flutter project.", no <html lang>, default Flutter blue theme colour.
Fix: real title and description, lang="en", theme colour #1B5E20.
```
```
BUG-022  Severity: Low  Category: Performance  Confidence: High   (PARTIAL)
Actual: logo.png is 650 KB (shown at 40 px) and hero-community.jpg is 1.1 MB.
Fix: the logo now decodes at 160 px (cacheWidth), which saves memory but not download size. Open: compress the files (logo ≈ 20 KB PNG/WebP, hero ≈ 200 KB WebP).
```
```
BUG-023  Severity: Low  Category: UX   (PARTIAL – needs decision)
Route: /transparency
Actual: "Download PDF" did nothing. assets/reports/ is empty, and opening a file needs `url_launcher`, which is not a dependency.
Fix: the button now shows "This report will be available for download soon." Open: add PDFs and approve url_launcher.
```
```
BUG-024  Severity: Low  Category: Layout
Actual: "Related articles" heading rendered even with zero related items. Impact stories were cut to 4 lines with no way to read more.
Fix: heading hidden when empty, and full story text shown.
```
```
BUG-025  Severity: Low  Category: Console / State
File: lib/features/about/about_page.dart:53
Actual: `(a['timeline'] as List)` throws if a language omits `timeline`. Fix: null-safe.
```
```
BUG-026  Severity: Low  Category: Layout
Route: all (footer)  Device: ≤ 430 px
Actual: copyright + Privacy + Terms in one Row squeezed the copyright into a narrow column. Fix: Wrap.
```

---

## 4. Regression Verification (K1–K7)

| ID | Status before | Status now | Notes |
|---|---|---|---|
| K1 Mobile app bar overflow | **Regressed** | Fixed | See BUG-003. |
| K2 `LanguageSelector(forceList: true)` | **Missing** | Fixed | `final bool forceList;` + `onSelected` callback. Used by the new mobile language sheet. |
| K3 Font flash | **Missing** | Fixed | `GoogleFonts.pendingFonts([inter, notoSansArabic …])` before `runApp` (4 s timeout so offline never blocks). `popUpAnimationStyle: AnimationStyle.noAnimation`. Each language name uses its own script's font. |
| K4 404s on missing images | Partial | Fixed | See BUG-017. |
| K5 BOM in content.json | Pass | Pass | First bytes `{\n` with no EF BB BF. The ARB files are clean too. |
| K6 `synthetic-package` | **Present** | Fixed | Line removed from l10n.yaml. |
| K7 Selectable text | **Commented out** | Fixed | `SelectionArea` in `builder`, inside its own `Overlay`. Without it the selection toolbar throws "No Overlay widget found", which is the likely reason it had been commented out. |

---

## 5. Unresolved / Needs Decision

1. **Placeholder content shown as real.** This covers the bank details ("Example Bank", fake IBAN/SWIFT; the account holder was "Hope Foundation" and now shows the foundation's name) and the contact address, email and phone ("Example Street 1", `info@example-foundation.org`, `+00 000 000 000`). It also covers the 87% / 8% / 5% spending split, the tax-deductibility FAQ answer, and the team members in content.json (named people with bios). Confirm that these are real, or replace them before launch.
2. **Privacy / Terms footer links** do nothing because no pages exist.
3. **Report PDFs and `url_launcher`.** See BUG-023.
4. **Social icons on /contact** are decorative and not links. Real profile URLs are needed.
5. **Calendar for fa/ps.** Dates use the Gregorian calendar with Persian/Pashto digits and month names. Decide whether Afghan users should see Solar Hijri dates.
6. **Missing images.** 11 image files referenced in content.json are absent. Placeholders show cleanly.
7. **Header at 900–1400 px in Russian.** The nav scrolls horizontally (accepted behaviour per §5.1). A "More" menu would be a design change.

## 6. Recommendations

- Add golden/widget tests that render every route at 280 / 390 / 768 / 1440 px in all four languages and fail on any `FlutterError` (overflow). This automates most of the §4 matrix.
- Bundle Inter and Noto Sans Arabic as assets (`GoogleFonts.config.allowRuntimeFetching = false`). This removes the font-CDN dependency and the first-load flash entirely.
- Consider `usePathUrlStrategy()` for clean URLs. It needs a server rewrite to `index.html` for hard refresh.
- Optionally wrap `content.json` loading in an error boundary that shows a retry instead of the generic error.

## 7. Files Modified

| File | Reason |
|---|---|
| `l10n.yaml` | K6: removed `synthetic-package`. |
| `lib/main.dart` | K3 font preload; locale restored before first frame. |
| `lib/app/app.dart` | K7 SelectionArea + Overlay; validated, race-free LocaleNotifier; phone title scaling. |
| `lib/app/theme/app_theme.dart` | Removed deprecated `background`. |
| `lib/core/widgets/app_header.dart` | K1; compact header < 900 px; language sheet; scrollable mobile menu; active-route highlight; a11y. |
| `lib/core/widgets/language_selector.dart` | K2 `forceList`; K3 no animation + per-script fonts. |
| `lib/core/widgets/app_image.dart` | K4 manifest check; semantics. |
| `lib/core/widgets/cards.dart` | Localized dates; stat value scales to fit; team photo labels. |
| `lib/core/widgets/app_footer.dart` | 44 px link targets; wrapping legal row; unused import. |
| `lib/core/widgets/status_badge.dart` | Removed unnecessary `!`. |
| `lib/core/widgets/responsive_grid.dart` | **New.** Content-sized card grid (BUG-004). |
| `lib/core/widgets/not_found_state.dart` | **New.** Graceful invalid-id state. |
| `lib/core/utils/formatters.dart` | **New.** Locale-aware date/number/percent. |
| `lib/data/providers.dart` | Projects/news go through repositories. |
| `lib/data/repositories/project_repository.dart`, `news_repository.dart` | `lang` param; null for unknown id. |
| `lib/features/home/home_page.dart` | ResponsiveGrid; typed lists; const; "View all" on mobile. |
| `lib/features/news/news_page.dart` | Implemented (was a stub). |
| `lib/features/news/news_details_page.dart` | Not-found state; localized date; no empty related heading. |
| `lib/features/projects/projects_page.dart` | Empty state; search scope; grid; search label. |
| `lib/features/projects/project_details_page.dart` | Not-found state; correct headings; localized numbers/dates; grid. |
| `lib/features/programs/…`, `impact/…`, `team/…`, `get_involved/…` | ResponsiveGrid; Donate card route; full story text. |
| `lib/features/transparency/…`, `donate/…`, `contact/…` | Localized strings; PDF feedback; validation messages. |
| `lib/features/about/about_page.dart` | Null-safe timeline; unused import. |
| `lib/features/error/not_found_page.dart` | Removed unnecessary `!`. |
| `lib/l10n/app_{en,ru,fa,ps}.arb` | +27 keys (no renames); ru typo. |
| `lib/l10n/app_localizations*.dart` | Regenerated for the new keys. |
| `test/widget_test.dart` | Replaced broken template test. |
| `web/index.html`, `web/manifest.json` | Title, description, lang, theme colour. |
| `README.md` | Correct Flutter/Dart minimums (3.35 / 3.9). |

`pubspec.yaml` was **not** changed, and no packages were added.

## 8. Commands to Verify Locally

```bash
flutter clean
flutter pub get
flutter gen-l10n
flutter analyze
flutter test
flutter run -d chrome
```

Then, in Chrome DevTools: device toolbar at 280 / 320 / 360 / 390 / 430 / 768 / 1366 / 1440 / 1920, each language, plus Lighthouse.
