---
name: Aurelian Minimalism
colors:
  surface: '#f9f9f8'
  surface-dim: '#dadad9'
  surface-bright: '#f9f9f8'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f4f3'
  surface-container: '#eeeeed'
  surface-container-high: '#e8e8e7'
  surface-container-highest: '#e2e2e2'
  on-surface: '#1a1c1c'
  on-surface-variant: '#50453b'
  inverse-surface: '#2f3130'
  inverse-on-surface: '#f1f1f0'
  outline: '#827569'
  outline-variant: '#d4c4b7'
  surface-tint: '#7c572d'
  primary: '#7c572d'
  on-primary: '#ffffff'
  primary-container: '#d4a574'
  on-primary-container: '#5b3a13'
  inverse-primary: '#efbd8a'
  secondary: '#625e59'
  on-secondary: '#ffffff'
  secondary-container: '#e5ded8'
  on-secondary-container: '#66625d'
  tertiary: '#3a6477'
  on-tertiary: '#ffffff'
  tertiary-container: '#8ab4ca'
  on-tertiary-container: '#194659'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdcbc'
  primary-fixed-dim: '#efbd8a'
  on-primary-fixed: '#2c1700'
  on-primary-fixed-variant: '#614018'
  secondary-fixed: '#e8e1db'
  secondary-fixed-dim: '#ccc5bf'
  on-secondary-fixed: '#1e1b17'
  on-secondary-fixed-variant: '#4a4642'
  tertiary-fixed: '#bfe8ff'
  tertiary-fixed-dim: '#a2cde3'
  on-tertiary-fixed: '#001f2a'
  on-tertiary-fixed-variant: '#204c5f'
  background: '#f9f9f8'
  on-background: '#1a1c1c'
  surface-variant: '#e2e2e2'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '300'
    lineHeight: '1.2'
    letterSpacing: -0.5px
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '400'
    lineHeight: '1.3'
    letterSpacing: -0.02em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '500'
    lineHeight: '1.4'
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.5'
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: 0.05em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '300'
    lineHeight: '1.2'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  container-padding-mobile: 20px
  container-padding-desktop: 48px
  gutter: 24px
  section-gap: 64px
---

## Brand & Style

The design system is crafted for high-end relationship management, emphasizing discretion, clarity, and precision. It employs a **Luxury Minimalism** aesthetic blended with refined **Glassmorphism**, creating a digital environment that feels like a physical boutique office—airy, bright, and curated.

The target audience consists of wealth managers, luxury real estate agents, and executive assistants who require a tool that feels more like a premium service than a utility. The UI evokes an emotional response of "calm control" through the use of extensive whitespace, subtle translucency, and a sophisticated warm-toned palette.

## Colors

The palette is anchored by **Golden Nest Yellow**, a muted, metallic gold that serves as the primary accent. This is balanced against a base of **Warm Stone** (#FAFAF9) to avoid the sterile feel of pure white.

### Functional Palette
- **Success:** A desaturated sage green for growth and stability.
- **Warning/Pending:** Linked to the primary gold to maintain elegance even in alerts.
- **Error:** A deep terracotta red, providing clear contrast without being jarring.
- **Info:** A slate blue for professional, non-urgent data points.

### Segment Badges
- **Individual:** Sky Tint (#E8F4F8) with Slate Blue text.
- **Agency:** Champagne Tint (#FFF8E8) with Gold text.
- **VIP:** Rose Tint (#FFF5F5) with Terracotta text.

## Typography

This design system utilizes **Inter** exclusively to leverage its geometric clarity and exceptional readability in data-heavy CRM contexts. 

The typographic hierarchy is "top-heavy," using light weights for large headlines to emphasize elegance. Body text maintains a generous line height (1.6x) to ensure the interface feels breathable even when displaying complex client histories. Labels are set in uppercase with slight letter spacing to create clear distinctions between data categories and the data itself.

## Layout & Spacing

The layout follows a **Fixed-Fluid Hybrid** model. On desktop, the navigation remains fixed, while content resides within a centered container with a maximum width of 1440px to prevent excessive line lengths. 

- **Grid:** A 12-column grid with 24px gutters.
- **Rhythm:** Spacing follows an 8px base unit. 
- **Whitespace:** Use "oversized" margins (48px+) between major sections to reinforce the luxury positioning. Content should never feel cramped; if in doubt, increase the padding.

## Elevation & Depth

Depth is achieved through **Glassmorphism** rather than traditional heavy shadows. Surfaces are layered to create a sense of physical stacking:

1.  **Level 0 (Background):** The Warm Stone (#FAFAF9) base.
2.  **Level 1 (Panels/Cards):** Background of `rgba(255, 255, 255, 0.95)` with a `blur(10px)` backdrop filter. A thin `1px` border of `rgba(255, 255, 255, 0.6)` acts as a "light rim."
3.  **Level 2 (Modals/Overlays):** Same as Level 1 but with a more pronounced shadow: `0 16px 48px rgba(44, 41, 37, 0.12)`.

Shadows are never pure black; they use a tinted `#2C2925` base at very low opacities to maintain the warmth of the design.

## Shapes

The design system uses a dual-radius strategy to differentiate between structural containers and interactive elements:

- **Large Containers/Cards:** 16px (`rounded-lg`) to create a soft, welcoming frame for data.
- **Interactive Elements (Buttons/Inputs/Chips):** 10px to provide a slightly sharper, more "precise" feel for actionable items.
- **Icons:** Use thin-stroke (1.5px) linear icons to match the light typographic weight.

## Components

### Buttons
- **Primary:** Solid `#D4A574` with white text. 10px radius. No shadow, or a very soft glow on hover.
- **Secondary:** Transparent background with a 1px border of `#D4A574`.
- **Tertiary:** Text-only with an underline appearing on hover.

### Input Fields
- **Style:** Background of `rgba(255, 255, 255, 0.5)`, 10px radius, 1px border of `#E2E2E2`.
- **Focus:** Border transitions to `#D4A574` with a subtle 4px outer glow.

### Cards
- All cards must use the glassmorphic style: `rgba(255, 255, 255, 0.95)` fill, `10px` blur, and a `16px` corner radius. 
- Content inside cards should have a minimum of `24px` internal padding.

### Segment Badges
- Small, 10px rounded pills. 
- Use the specific tint backgrounds defined in the Colors section with high-contrast text for accessibility.

### Data Tables
- No vertical borders. Horizontal borders should be `1px` solid `#F1F1F0`.
- Header row should use `label-md` typography.