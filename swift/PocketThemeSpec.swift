//
//  PocketThemeSpec.swift — REFERENCE SNAPSHOT (do not edit here)
//
//  Canonical source: the Pocket Agent app repo (`pocketagent`),
//  `Packages/PocketDesign/Sources/PocketDesign/PocketThemeSpec.swift`.
//  This copy exists so theme authors can read the 53-role schema and the
//  3-value generator without checking out the app.
//
//  Sync rule: the app repo wins. This snapshot is refreshed manually when
//  the schema version or generator behaviour changes (see ROADMAP.md);
//  never patch it here — fix it upstream, then re-copy.
//
//
//  PocketThemeSpec.swift
//  Pocket Design System — cross-platform semantic theme spec + 3-value generator.
//
//  Schema aligned with t3code's `themePalettes.ts` 61-role semantic palette,
//  minus the 8 `sidebar*` roles (Pocket has no persistent sidebar; sidebar
//  surfaces collapse into the `surface` family) → 53 roles. One JSON spec is
//  shared by the iOS (Swift) and Android (Kotlin) lines; the schema document
//  lives at `docs/THEME_SPEC.md`.
//
//  The 3-value generator (`PocketThemeGenerator.generate`) is a Swift rewrite
//  of t3code's `createVividThemeColors`: appearance + canvas + accent →
//  a full spec, built on an OKLCH lightness ladder with binary-search
//  contrast solving so every Foreground/Surface pair lands ≥ 4.6:1
//  (WCAG AA) and body text on canvas targets 7:1.
//
//  Pure Foundation — no SwiftUI types in the spec or generator — so the
//  whole pipeline is unit-testable off-device. The SwiftUI bridge
//  (`PocketTheme.init(spec:)`) lives at the bottom of the file.
//

import Foundation
import SwiftUI

// MARK: - Appearance

public enum PocketThemeAppearance: String, Codable, Sendable, CaseIterable {
    case light
    case dark
}

// MARK: - Semantic roles (t3code 61-role schema minus the sidebar family)

public enum PocketThemeRole: String, Codable, Sendable, CaseIterable {
    // Canvas / chrome
    case canvas, chrome, toolbar
    case toolbarForeground, toolbarBorder
    case toolbarControl, toolbarControlForeground, toolbarControlHover
    // Surfaces
    case surface, surfaceRaised, surfaceOverlay
    // Text / lines
    case text, textMuted, border, input, focus
    // Accent 三件組
    case accent, accentForeground
    case accentSurface, accentSurfaceForeground
    // Secondary / muted families
    case secondary, secondaryForeground
    case muted, mutedForeground
    case placeholder, secondaryLabel, iconMuted
    // Status 三件組 (X / XForeground / XSurface)
    case error, errorForeground, errorSurface
    case warning, warningForeground, warningSurface
    case update, updateForeground, updateSurface
    // Message (user bubble / primary send action)
    case messageSurface, messageForeground
    case messageAction, messageActionForeground, messageActionHover
    // Code
    case codeBackground, codeForeground
    // Search match
    case searchMatchBackground, searchMatchForeground
    case searchMatchActiveBackground, searchMatchActiveForeground
    // Terminal 族
    case terminalBackground, terminalForeground, terminalCursor
    case terminalSelection, terminalScrollbar, terminalScrollbarHover
}

// MARK: - Spec (JSON codable; shared iOS/Android)

public struct PocketThemeSpec: Codable, Sendable, Equatable {
    public struct Seed: Codable, Sendable, Equatable {
        /// `#RRGGBB` canvas (page background) seed.
        public var canvas: String
        /// `#RRGGBB` accent seed.
        public var accent: String
        public init(canvas: String, accent: String) {
            self.canvas = canvas
            self.accent = accent
        }
    }

    public var version: Int
    public var id: String
    public var name: String
    public var appearance: PocketThemeAppearance
    /// Present when the spec was produced by the 3-value generator; lets an
    /// editor re-open in guided mode and regenerate from the seeds.
    public var seed: Seed?
    /// role rawValue → `#RRGGBB`. Complete: every `PocketThemeRole` has a key.
    public var colors: [String: String]

    public init(version: Int = 1, id: String, name: String,
                appearance: PocketThemeAppearance,
                seed: Seed? = nil, colors: [String: String]) {
        self.version = version
        self.id = id
        self.name = name
        self.appearance = appearance
        self.seed = seed
        self.colors = colors
    }

    public func hex(_ role: PocketThemeRole) -> String? { colors[role.rawValue] }
}

// MARK: - Color math (sRGB ↔ OKLCH, luminance, contrast)

/// Namespaced color math + the 3-value generator. All math operates on
/// 0–255 sRGB channels and OKLCH; public pieces exist for tests.
public enum PocketThemeGenerator {

    public struct RGB: Sendable, Equatable {
        public var r: Double, g: Double, b: Double
        public init(_ r: Double, _ g: Double, _ b: Double) {
            self.r = r; self.g = g; self.b = b
        }
    }

    public struct OKLCH: Sendable, Equatable {
        public var L: Double, C: Double, h: Double
        public init(L: Double, C: Double, h: Double) {
            self.L = L; self.C = C; self.h = h
        }
    }

    // MARK: Hex

    public static func parseHex(_ value: String) -> RGB? {
        var s = value.trimmingCharacters(in: .whitespacesAndNewlines)
        if s.hasPrefix("#") { s.removeFirst() }
        guard s.count == 6, let v = UInt32(s, radix: 16) else { return nil }
        return RGB(Double((v >> 16) & 0xFF), Double((v >> 8) & 0xFF), Double(v & 0xFF))
    }

    public static func formatHex(_ rgb: RGB) -> String {
        let clamp = { (c: Double) -> Int in Int(min(255, max(0, c)).rounded()) }
        return String(format: "#%02x%02x%02x", clamp(rgb.r), clamp(rgb.g), clamp(rgb.b))
    }

    // MARK: sRGB transfer

    static func srgbChannelToLinear(_ channel: Double) -> Double {
        let c = channel / 255
        return c <= 0.04045 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4)
    }

    static func linearChannelToSrgb(_ channel: Double) -> Double {
        let c = channel <= 0.0031308 ? channel * 12.92 : 1.055 * pow(channel, 1 / 2.4) - 0.055
        return min(1, max(0, c)) * 255
    }

    // MARK: OKLCH ↔ sRGB (matrices match culori / t3code themePalette.ts)

    public static func rgbToOklch(_ color: RGB) -> OKLCH {
        let r = srgbChannelToLinear(color.r)
        let g = srgbChannelToLinear(color.g)
        let b = srgbChannelToLinear(color.b)
        let l = cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b)
        let m = cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b)
        let s = cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b)
        let L = 0.2104542553 * l + 0.793617785 * m - 0.0040720468 * s
        let a = 1.9779984951 * l - 2.428592205 * m + 0.4505937099 * s
        let bb = 0.0259040371 * l + 0.7827717662 * m - 0.808675766 * s
        return OKLCH(L: L, C: (a * a + bb * bb).squareRoot(), h: atan2(bb, a) * 180 / .pi)
    }

    static func oklchToLinearRgbUnclamped(_ color: OKLCH) -> (r: Double, g: Double, b: Double) {
        let hr = color.h * .pi / 180
        let a = color.C * cos(hr)
        let bb = color.C * sin(hr)
        let l = pow(color.L + 0.3963377774 * a + 0.2158037573 * bb, 3)
        let m = pow(color.L - 0.1055613458 * a - 0.0638541728 * bb, 3)
        let s = pow(color.L - 0.0894841775 * a - 1.291485548 * bb, 3)
        return (
            r: 4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
            g: -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
            b: -0.0041960863 * l - 0.7034186147 * m + 1.707614701 * s
        )
    }

    /// Shrink chroma (binary search) until the color fits the sRGB gamut, so
    /// out-of-gamut ladder stops keep their hue instead of clipping channels.
    static func mapToSrgbGamut(_ color: OKLCH) -> OKLCH {
        func inGamut(_ C: Double) -> Bool {
            let linear = oklchToLinearRgbUnclamped(OKLCH(L: color.L, C: C, h: color.h))
            return [linear.r, linear.g, linear.b].allSatisfy { $0 >= -0.0001 && $0 <= 1.0001 }
        }
        if inGamut(color.C) { return color }
        var low = 0.0
        var high = color.C
        for _ in 0..<24 {
            let mid = (low + high) / 2
            if inGamut(mid) { low = mid } else { high = mid }
        }
        return OKLCH(L: color.L, C: low, h: color.h)
    }

    public static func oklchToRgb(_ color: OKLCH) -> RGB {
        let linear = oklchToLinearRgbUnclamped(mapToSrgbGamut(color))
        return RGB(
            linearChannelToSrgb(linear.r),
            linearChannelToSrgb(linear.g),
            linearChannelToSrgb(linear.b)
        )
    }

    // MARK: Luminance / contrast (WCAG)

    public static func relativeLuminance(_ color: RGB) -> Double {
        func linearize(_ channel: Double) -> Double {
            let n = channel / 255
            return n <= 0.03928 ? n / 12.92 : pow((n + 0.055) / 1.055, 2.4)
        }
        return 0.2126 * linearize(color.r) + 0.7152 * linearize(color.g) + 0.0722 * linearize(color.b)
    }

    public static func contrastRatio(_ first: RGB, _ second: RGB) -> Double {
        let l1 = relativeLuminance(first)
        let l2 = relativeLuminance(second)
        return (max(l1, l2) + 0.05) / (min(l1, l2) + 0.05)
    }

    /// WCAG contrast between two `#RRGGBB` strings; 0 when either fails to parse.
    public static func contrastRatio(hex first: String, _ second: String) -> Double {
        guard let a = parseHex(first), let b = parseHex(second) else { return 0 }
        return contrastRatio(a, b)
    }

    // MARK: Contrast solving

    enum LightnessDirection { case lighter, darker }

    /// Move only the lightness of `base` until it clears `minContrast`
    /// against every surface — hue survives instead of collapsing to
    /// black/white. (Port of t3code `solveOklchLightness`.)
    static func solveLightness(
        _ base: OKLCH,
        against surfaces: [RGB],
        minContrast: Double,
        direction: LightnessDirection
    ) -> OKLCH {
        func contrastOf(_ color: OKLCH) -> Double {
            let rgb = oklchToRgb(color)
            return surfaces.map { contrastRatio(rgb, $0) }.min() ?? 0
        }
        var low = direction == .lighter ? base.L : 0
        var high = direction == .lighter ? 1 : base.L
        var candidate = base
        if contrastOf(candidate) >= minContrast { return candidate }
        for _ in 0..<18 {
            let mid = (low + high) / 2
            candidate = OKLCH(L: mid, C: base.C, h: base.h)
            if contrastOf(candidate) >= minContrast {
                if direction == .lighter { high = mid } else { low = mid }
            } else {
                if direction == .lighter { low = mid } else { high = mid }
            }
        }
        return OKLCH(L: direction == .lighter ? high : low, C: base.C, h: base.h)
    }

    static func mix(_ base: RGB, _ overlay: RGB, _ amount: Double) -> RGB {
        RGB(
            base.r + (overlay.r - base.r) * amount,
            base.g + (overlay.g - base.g) * amount,
            base.b + (overlay.b - base.b) * amount
        )
    }

    // Soft brand foregrounds first; hard white/black only when soft can't
    // reach 4.5. (Port of t3code `readableThemeForeground`.)
    static let lightForeground = RGB(255, 250, 255)
    static let darkForeground = RGB(36, 21, 35)
    static let whiteForeground = RGB(255, 255, 255)
    static let blackForeground = RGB(0, 0, 0)

    static func readableForeground(on background: RGB) -> RGB {
        let lightContrast = contrastRatio(background, lightForeground)
        let darkContrast = contrastRatio(background, darkForeground)
        if max(lightContrast, darkContrast) >= 4.5 {
            return lightContrast >= darkContrast ? lightForeground : darkForeground
        }
        return contrastRatio(background, whiteForeground) >= contrastRatio(background, blackForeground)
            ? whiteForeground : blackForeground
    }

    /// Soften `foreground` toward `background` as far as contrast allows,
    /// backing off (binary search) until `minimumRatio` holds.
    static func readableText(
        on background: RGB, foreground: RGB,
        amount: Double, minimumRatio: Double
    ) -> RGB {
        let softened = mix(foreground, background, amount)
        if contrastRatio(softened, background) >= minimumRatio { return softened }
        var readable = foreground
        var lower = 0.0
        var upper = amount
        for _ in 0..<12 {
            let candidateAmount = (lower + upper) / 2
            let candidate = mix(foreground, background, candidateAmount)
            if contrastRatio(candidate, background) >= minimumRatio {
                readable = candidate
                lower = candidateAmount
            } else {
                upper = candidateAmount
            }
        }
        return readable
    }

    static let standardLightMutedContrast = 4.705
    static let standardDarkMutedContrast = 5.082

    static func standardMutedText(on background: RGB, foreground: RGB) -> RGB {
        let target = relativeLuminance(background) < 0.179
            ? standardDarkMutedContrast : standardLightMutedContrast
        return readableText(on: background, foreground: foreground, amount: 1, minimumRatio: target)
    }

    // MARK: Status colors (error / warning share fixed hues; surfaces mix on canvas)

    private struct StatusSeed { let error: RGB, errorFg: RGB, warning: RGB, warningFg: RGB }

    private static let lightStatus = StatusSeed(
        error: RGB(0xFB, 0x2C, 0x36), errorFg: RGB(0xC1, 0x00, 0x07),
        warning: RGB(0xFE, 0x9A, 0x00), warningFg: RGB(0xBB, 0x4D, 0x00)
    )
    private static let darkStatus = StatusSeed(
        error: RGB(0xFB, 0x41, 0x4A), errorFg: RGB(0xFF, 0x64, 0x67),
        warning: RGB(0xFE, 0x9A, 0x00), warningFg: RGB(0xFF, 0xB9, 0x00)
    )

    private static func statusColors(canvas: RGB) -> [PocketThemeRole: RGB] {
        let dark = relativeLuminance(canvas) < 0.179
        let standard = dark ? darkStatus : lightStatus
        let surfaceMix = dark ? 0.16 : 0.08
        func readableOn(_ foreground: RGB, surface: RGB) -> RGB {
            let solved = solveLightness(
                rgbToOklch(foreground), against: [surface],
                minContrast: 4.6, direction: dark ? .lighter : .darker
            )
            return oklchToRgb(solved)
        }
        let errorSurface = mix(canvas, standard.error, surfaceMix)
        let warningSurface = mix(canvas, standard.warning, surfaceMix)
        return [
            .error: standard.error,
            .errorForeground: readableOn(standard.errorFg, surface: errorSurface),
            .errorSurface: errorSurface,
            .warning: standard.warning,
            .warningForeground: readableOn(standard.warningFg, surface: warningSurface),
            .warningSurface: warningSurface,
        ]
    }

    // MARK: - 3-value generator (port of t3code createVividThemeColors)

    /// appearance + canvas + accent → a complete 53-role spec. Lightness
    /// ladder off the canvas, hue borrowed from the accent, every
    /// foreground contrast-solved against its surface.
    public static func generate(
        appearance: PocketThemeAppearance,
        canvasHex: String,
        accentHex: String,
        id: String = "custom",
        name: String = "Custom"
    ) -> PocketThemeSpec {
        let canvasRgb = parseHex(canvasHex)
            ?? (appearance == .dark ? RGB(24, 15, 27) : RGB(250, 245, 250))
        let accentRgb = parseHex(accentHex) ?? RGB(168, 67, 112)
        let canvas = rgbToOklch(canvasRgb)
        let accent = rgbToOklch(accentRgb)
        // At luminance 0.179, black and white text have equal contrast.
        let dark = relativeLuminance(canvasRgb) < 0.179
        let hue = accent.C < 0.02 ? canvas.h : accent.h
        let tintC = min(0.045, max(0.008, accent.C * 0.22))
        let step: Double = dark ? 1 : -1

        func surfaceAt(_ deltaL: Double, _ chroma: Double? = nil) -> OKLCH {
            OKLCH(
                L: min(0.98, max(0.05, canvas.L + step * deltaL)),
                C: chroma ?? tintC,
                h: hue
            )
        }

        let textBase = OKLCH(L: dark ? 0.95 : 0.2, C: min(0.035, accent.C * 0.25), h: hue)
        let text = solveLightness(textBase, against: [canvasRgb], minContrast: 7,
                                  direction: dark ? .lighter : .darker)
        let textRgb = oklchToRgb(text)
        let textMutedRgb = standardMutedText(on: canvasRgb, foreground: textRgb)

        let action = OKLCH(
            L: min(0.85, max(0.35, accent.L + (dark ? 0.06 : -0.02))),
            C: max(accent.C * 0.9, 0.06),
            h: (hue + 50).truncatingRemainder(dividingBy: 360)
        )
        let actionRgb = oklchToRgb(action)
        let actionForeground = readableForeground(on: actionRgb)
        let accentForeground = readableForeground(on: accentRgb)

        let surface = surfaceAt(0.015)
        let surfaceRaised = surfaceAt(0.05)
        let surfaceRaisedRgb = oklchToRgb(surfaceRaised)
        let surfaceOverlay = surfaceAt(0.075)
        let border = surfaceAt(dark ? 0.16 : 0.12, min(0.07, accent.C * 0.35))
        let input = surfaceAt(dark ? 0.21 : 0.16, min(0.08, accent.C * 0.4))
        let secondary = surfaceAt(dark ? 0.1 : 0.06, min(0.09, accent.C * 0.5))
        let secondaryRgb = oklchToRgb(secondary)
        let muted = surfaceAt(dark ? 0.06 : 0.04, min(0.06, accent.C * 0.35))
        let mutedRgb = oklchToRgb(muted)
        let accentSurface = surfaceAt(dark ? 0.13 : 0.08, min(0.11, accent.C * 0.55))
        let accentSurfaceRgb = oklchToRgb(accentSurface)
        let messageSurface = surfaceAt(dark ? 0.16 : 0.1, min(0.13, accent.C * 0.6))
        let messageSurfaceRgb = oklchToRgb(messageSurface)
        let codeBackground = surfaceAt(0.035, tintC * 0.8)
        let updateSurface = surfaceAt(dark ? 0.14 : 0.09, min(0.12, accent.C * 0.55))
        let updateSurfaceRgb = oklchToRgb(updateSurface)

        func foregroundOn(_ surfaceRgb: RGB) -> RGB {
            oklchToRgb(solveLightness(textBase, against: [surfaceRgb], minContrast: 4.6,
                                      direction: dark ? .lighter : .darker))
        }
        let mutedForeground = readableText(on: mutedRgb, foreground: textRgb, amount: 1, minimumRatio: 4.6)
        let placeholder = readableText(on: surfaceRaisedRgb, foreground: textRgb, amount: 1, minimumRatio: 4.6)

        let searchMatch = oklchToRgb(surfaceAt(0.22, min(0.12, accent.C)))
        let searchMatchActive = oklchToRgb(surfaceAt(0.4, min(0.18, accent.C)))

        let actionHover = OKLCH(L: action.L + (dark ? 0.06 : -0.06), C: action.C, h: action.h)

        var colors: [PocketThemeRole: RGB] = statusColors(canvas: canvasRgb)
        colors[.canvas] = canvasRgb
        colors[.chrome] = canvasRgb
        colors[.toolbar] = canvasRgb
        colors[.toolbarForeground] = textRgb
        colors[.toolbarBorder] = oklchToRgb(surfaceAt(dark ? 0.14 : 0.1, min(0.08, accent.C * 0.4)))
        colors[.toolbarControl] = oklchToRgb(surfaceAt(dark ? 0.09 : 0.05, tintC * 1.3))
        colors[.toolbarControlForeground] = textRgb
        colors[.toolbarControlHover] = oklchToRgb(surfaceAt(dark ? 0.14 : 0.09, tintC * 1.6))
        colors[.surface] = oklchToRgb(surface)
        colors[.surfaceRaised] = surfaceRaisedRgb
        colors[.surfaceOverlay] = oklchToRgb(surfaceOverlay)
        colors[.text] = textRgb
        colors[.textMuted] = textMutedRgb
        colors[.border] = oklchToRgb(border)
        colors[.input] = oklchToRgb(input)
        colors[.focus] = accentRgb
        colors[.accent] = accentRgb
        colors[.accentForeground] = accentForeground
        colors[.secondary] = secondaryRgb
        colors[.secondaryForeground] = foregroundOn(secondaryRgb)
        colors[.muted] = mutedRgb
        colors[.mutedForeground] = mutedForeground
        colors[.placeholder] = placeholder
        colors[.secondaryLabel] = textMutedRgb
        colors[.iconMuted] = textMutedRgb
        colors[.update] = accentRgb
        colors[.updateForeground] = foregroundOn(updateSurfaceRgb)
        colors[.updateSurface] = updateSurfaceRgb
        colors[.accentSurface] = accentSurfaceRgb
        colors[.accentSurfaceForeground] = foregroundOn(accentSurfaceRgb)
        colors[.messageSurface] = messageSurfaceRgb
        colors[.messageForeground] = foregroundOn(messageSurfaceRgb)
        colors[.messageAction] = actionRgb
        colors[.messageActionForeground] = actionForeground
        colors[.messageActionHover] = oklchToRgb(actionHover)
        colors[.codeBackground] = oklchToRgb(codeBackground)
        colors[.codeForeground] = textRgb
        colors[.searchMatchBackground] = searchMatch
        colors[.searchMatchForeground] = readableForeground(on: searchMatch)
        colors[.searchMatchActiveBackground] = searchMatchActive
        colors[.searchMatchActiveForeground] = readableForeground(on: searchMatchActive)
        colors[.terminalBackground] = canvasRgb
        colors[.terminalForeground] = textRgb
        colors[.terminalCursor] = accentRgb
        colors[.terminalSelection] = oklchToRgb(surfaceAt(dark ? 0.18 : 0.12, min(0.12, accent.C * 0.55)))
        colors[.terminalScrollbar] = oklchToRgb(surfaceAt(dark ? 0.22 : 0.16, tintC))
        colors[.terminalScrollbarHover] = oklchToRgb(surfaceAt(dark ? 0.3 : 0.22, tintC))

        return PocketThemeSpec(
            id: id, name: name, appearance: appearance,
            seed: .init(canvas: formatHex(canvasRgb), accent: formatHex(accentRgb)),
            colors: Dictionary(uniqueKeysWithValues: colors.map { ($0.key.rawValue, formatHex($0.value)) })
        )
    }

    /// Lightness-shifted variant of a hex color (hover/active derivation).
    public static func shiftLightness(hex: String, by delta: Double) -> String {
        guard let rgb = parseHex(hex) else { return hex }
        var oklch = rgbToOklch(rgb)
        oklch.L = min(1, max(0, oklch.L + delta))
        return formatHex(oklchToRgb(oklch))
    }
}

// MARK: - SwiftUI bridge: spec → PocketTheme

public extension PocketTheme {
    /// Project a 53-role spec down onto Pocket's runtime theme tokens so the
    /// whole app re-skins through the existing `PocketColor.*` pipeline.
    /// Unmapped roles stay in the spec (and in the exported JSON for the
    /// Android line); this bridge only covers what `PocketTheme` carries.
    init(spec: PocketThemeSpec) {
        func color(_ role: PocketThemeRole, _ fallback: UInt32) -> Color {
            guard let hex = spec.hex(role),
                  let rgb = PocketThemeGenerator.parseHex(hex) else {
                return Color(rgb: fallback)
            }
            return Color(.sRGB, red: rgb.r / 255, green: rgb.g / 255, blue: rgb.b / 255, opacity: 1)
        }
        let isLight = spec.appearance == .light
        let accentHex = spec.hex(.accent) ?? "#ee2d2a"
        let hoverHex = PocketThemeGenerator.shiftLightness(hex: accentHex, by: isLight ? -0.06 : 0.06)
        let activeHex = PocketThemeGenerator.shiftLightness(hex: accentHex, by: isLight ? -0.12 : 0.12)
        func colorFromHex(_ hex: String) -> Color {
            guard let rgb = PocketThemeGenerator.parseHex(hex) else { return PocketBrand.red }
            return Color(.sRGB, red: rgb.r / 255, green: rgb.g / 255, blue: rgb.b / 255, opacity: 1)
        }
        // Seed-stamped instance id: the app root re-skins by flipping `.id` on
        // the theme id, so two custom themes with different seeds must not
        // share the identity "custom" (the repaint would never fire).
        let instanceID = spec.seed.map {
            "\(spec.id):\(spec.appearance.rawValue):\($0.canvas):\($0.accent)"
        } ?? spec.id
        self.init(
            id: instanceID, displayName: spec.name, isLight: isLight,
            accent: color(.accent, 0xEE2D2A),
            accentHover: colorFromHex(hoverHex),
            accentActive: colorFromHex(activeHex),
            onAccent: color(.accentForeground, 0xFFFFFF),
            accentSurface: color(.accentSurface, 0xFBDFD6),
            amber: color(.warning, 0xFBD000),
            accentDeep: colorFromHex(activeHex),
            backgroundPrimary: color(.canvas, 0xFFF2D6),
            backgroundSecondary: color(.surface, 0xFFFFFF),
            backgroundTertiary: color(.surfaceRaised, 0xE9E6DF),
            // 53-role 無 sunken;codeBackground 對位 SDS surface-sunken(規範 §2.5)。
            backgroundSunken: color(.codeBackground, 0xF7EACB),
            // PocketColor.border applies alpha on top of borderBase, so feed
            // it the solid text color like the built-ins do (ink / white).
            borderBase: color(.text, isLight ? 0x17171A : 0xFFFFFF),
            foregroundPrimary: color(.text, 0x17171A),
            foregroundMuted: color(.textMuted, 0x6B6760),
            foregroundFaint: color(.placeholder, 0x8A847A),
            // The spec has no success role (t3code schema has none); fall back
            // to the SDS fixed status greens (POCKET_DESIGN_SPEC §1.2).
            success: Color(rgb: isLight ? 0x1D7A4A : 0x6FD39D),
            danger: color(.error, 0xB42318),
            warning: color(.warning, 0x775800),
            info: color(.update, 0x1F6AA1),
            gradientStops: [
                colorFromHex(PocketThemeGenerator.shiftLightness(hex: accentHex, by: 0.12)),
                colorFromHex(accentHex),
                colorFromHex(activeHex),
            ],
            gradientSoftStops: [color(.accentSurface, 0xFFD9D4), color(.messageSurface, 0xFFB3AC)],
            font: .system, displayFont: .huninn, terminalFont: .huninn,
            style: .editorial
        )
    }
}

// MARK: - Custom theme persistence

public extension PocketTheme {
    /// The reserved id for the user's generated custom theme.
    static let customThemeID = "custom"

    internal static let customSpecStorageKey = "pocket.theme.custom.spec"

    /// The persisted custom spec, if the user has built one.
    static func storedCustomSpec(defaults: UserDefaults = .standard) -> PocketThemeSpec? {
        guard let data = defaults.data(forKey: customSpecStorageKey) else { return nil }
        return try? JSONDecoder().decode(PocketThemeSpec.self, from: data)
    }

    static func storeCustomSpec(_ spec: PocketThemeSpec, defaults: UserDefaults = .standard) {
        guard let data = try? JSONEncoder().encode(spec) else { return }
        defaults.set(data, forKey: customSpecStorageKey)
    }

    /// The user's custom theme, rebuilt from the persisted spec.
    static func customTheme(defaults: UserDefaults = .standard) -> PocketTheme? {
        storedCustomSpec(defaults: defaults).map(PocketTheme.init(spec:))
    }
}

public extension ThemeManager {
    /// Persist a generated spec and make it the live theme in one move.
    func selectCustom(spec: PocketThemeSpec) {
        PocketTheme.storeCustomSpec(spec)
        current = PocketTheme(spec: spec)
    }
}
