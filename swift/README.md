# Swift reference

**正典不在這裡。** The canonical, compiled-and-tested implementation lives in
the Pocket Agent app repo (`pocketagent`), package `PocketDesign`:

- `Packages/PocketDesign/Sources/PocketDesign/PocketThemeSpec.swift`
  — the 53-role spec type, the 3-value generator
  (`PocketThemeGenerator.generate`), and the SwiftUI bridge
  (`PocketTheme.init(spec:)`).
- `Packages/PocketDesign/Sources/PocketDesign/PocketTheme.swift`
  — the hand-tuned built-in themes (pocket / white / dark) and
  `PocketThemeStyle` (the non-color personality: pill controls, radius,
  border weight, shadow character).
- `Packages/PocketDesign/Tests/PocketDesignTests/PocketThemeGeneratorTests.swift`
  — the contrast gate: six seed themes × 14 foreground/surface pairs all
  asserted ≥ 4.5:1, body text on canvas ≥ 6.8. Port these seeds and
  assertions with any new platform implementation so generators can't drift.

## What's here

`PocketThemeSpec.swift` — a **reference snapshot** of the canonical file, so
theme authors and porters can read the schema and generator without checking
out the app. The file header states the sync rule: the app repo wins; this
copy is refreshed manually on schema/generator changes and must never be
patched here.

## Consuming the spec elsewhere

- **iOS**: `PocketTheme.init(spec:)` projects the 53 roles down onto the
  runtime tokens (`PocketColor.*`); unmapped roles stay in the JSON for other
  platforms.
- **Android**: implement the Kotlin twin per the app repo's
  `docs/THEME_SPEC.md` — same JSON, field-for-field.
- **Web**: the console's L2 `--color-*` naming is already role-aligned; a
  spec→CSS generator is roadmap work (see `../ROADMAP.md`).
