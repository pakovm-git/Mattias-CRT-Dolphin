# Mattias CRT for Dolphin

An AI-assisted port of the classic Mattias CRT shader from RetroArch/Libretro to Dolphin Emulator. Choose Original, Soft, or Strong CRT styling, with just three shared controls and separate full-quality and performance editions.

Developed by **PakoVM with assistance from OpenAI Codex** for adaptation, iteration, documentation, and automated checks. The maintainer tested the shaders on Linux and an Android handheld. The original CRT shader is by **Mattias Gustavsson**; AI assistance does not replace or diminish that authorship.

**Release: [26.10.09](https://github.com/pakovm-git/Mattias-CRT-Dolphin/releases/tag/26.10.09)** — October 9, 2026 (`YY.MM.DD`).

**Reported working on Linux and an Android handheld.** All six shaders also passed independent software OpenGL compilation and synthetic rendering checks. This is a community port, not an official Dolphin or Mattias release.

## Choose a shader

| Style | Appearance |
|---|---|
| Original | Original-style blur, scanlines, glow, noise, and color separation. |
| Soft | Gentler scanlines, less blur, glow, noise, ghosting, and color separation. |
| Strong | More pronounced CRT effects. |

Start with `full-quality/crt-mattias-original.glsl`.

- **[Full quality](full-quality/):** 25 samples per blur, closest to the original sampling approach.
- **[Performance](performance/):** nine samples per blur and bilinear filtering; a cheaper approximation that changes fine detail and contrast.

Performance is a modest tradeoff: it is intended to be a little faster, at the cost of a little fidelity in blur, fine detail, and contrast. On the maintainer's devices the performance difference was not major. The code uses 81 rather than 225 source-level texture reads per in-bounds pixel, but this does **not** imply a proportional speedup or guarantee a measurable benefit on every device.

## Download

Open [Releases](https://github.com/pakovm-git/Mattias-CRT-Dolphin/releases) and choose:

- **`Mattias-CRT-Dolphin-Original-26.10.09.zip`**: full-quality Original, Soft, and Strong shaders. Recommended starting point.
- **`Mattias-CRT-Dolphin-Performance-26.10.09.zip`**: Performance, Performance Soft, and Performance Strong.

“Original” in the first archive's name identifies the full-quality family; it contains all three styles. GitHub's automatically generated source archives contain the whole repository instead.

## Installation

Extract the chosen ZIP and copy the desired `.glsl` files from its `Shaders` folder into Dolphin's **user** `Shaders` directory. Do not copy the ZIP itself or edit the application's bundled system shaders. Start Dolphin once to create its user directories. After copying, restart Dolphin if needed and select the shader under **Graphics → Enhancements → Post-Processing Effect** (wording can vary by build).

When available, **File → Open User Folder** is the most reliable way to find your active directory. Custom user paths and portable mode override standard locations. Create `Shaders` inside the active user/data directory if absent.

### Linux — native packages / traditional installation

For current native builds, use:

```text
~/.local/share/dolphin-emu/Shaders/
```

If `XDG_DATA_HOME` is customized, use `$XDG_DATA_HOME/dolphin-emu/Shaders/`. Do not confuse this data directory with `~/.config/dolphin-emu`, which normally stores settings.

**Legacy user directory:** if your existing installation uses `~/.dolphin-emu`, place the files in:

```text
~/.dolphin-emu/Shaders/
```

Dolphin may continue using that older directory when it exists. Check the active user folder rather than installing into both locations.

### Linux — Dolphin Flatpak

For the official/Flathub application ID `org.DolphinEmu.dolphin-emu`, use:

```text
~/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/Shaders/
```

Show hidden folders in your file manager if `.var` is not visible. Do not modify files under `/var/lib/flatpak/app/`; those are application files replaced by updates. Other forks/application IDs may use a different directory.

### RetroDECK

On recent RetroDECK releases, copy shaders to:

```text
<your RetroDECK data folder>/shaders/Dolphin/
```

For a default data location, this is commonly `~/retrodeck/shaders/Dolphin/`. If you moved RetroDECK to another drive, use that location instead. The capital `D` in `Dolphin` matters on Linux.

RetroDECK exposes the bundled Dolphin shader directory here. Older layouts may instead use `~/.var/app/net.retrodeck.retrodeck/data/dolphin-emu/Shaders/`; follow its link to the actual data location if present. Open Dolphin through RetroDECK's configurator to select the effect, then return to your game.

### macOS

In Finder, choose **Go → Go to Folder** and enter:

```text
~/Library/Application Support/Dolphin/Shaders/
```

Copy the `.glsl` files there, reopen Dolphin, and select the effect. Do not place them inside `Dolphin.app`. A custom/portable installation may use a different user directory.

### Windows

Use Dolphin's **Open User Folder** command first. Common locations are:

| Installation | Shader folder |
|---|---|
| Current default | `%APPDATA%\Dolphin Emulator\Shaders\` |
| Existing legacy installation | Your **Documents** folder → `Dolphin Emulator\Shaders\` |
| Portable installation | `User\Shaders\` beside `Dolphin.exe` |

You can paste the `%APPDATA%` path into File Explorer's address bar. Documents may be redirected to OneDrive or another drive, so use its actual location. Show filename extensions and ensure the files end in `.glsl`, not `.glsl.txt`.

### Android handhelds

**Prepare your settings in a text editor before copying the shader.** The Android UI used for this project can select an effect but does not expose the desktop shader-parameter configuration dialog. See the editing guide below.

1. Extract the ZIP somewhere accessible, such as Downloads, on your handheld or computer.
2. Edit the desired `.glsl` file's defaults, save it as plain text, and keep the `.glsl` extension.
3. Copy the edited file into Dolphin's user `Shaders` directory. On current official Dolphin builds, use an Android file manager/system file picker that supports **document providers**: find the **Dolphin Emulator** storage entry, open `Shaders`, and copy the file there. Availability and UI wording depend on the file manager and Android version.
4. Restart Dolphin and select the shader in **Graphics Settings → Enhancements → Post-Processing Effect**, or the equivalent per-game setting.

The official application's typical underlying location is:

```text
Internal storage/Android/data/org.dolphinemu.dolphinemu/files/Shaders/
```

Modern Android restricts direct access to `Android/data`; use Dolphin's document-provider entry when direct browsing is blocked. Some older builds used `Internal storage/dolphin-emu/Shaders/`. Forks and custom user-folder setups differ—use the active folder for your installed build. No root access or APK modification is required for Dolphin's document-provider method.

## Comparison gallery

Screenshots will be added by the maintainer. These rows are placeholders, not measured equivalence claims. Use the same game, scene, aspect ratio, output resolution, curvature, and brightness where possible; animated noise can still differ between captures.

| Emulator | Shader / style | Rendering approach | Screenshot |
|---|---|---|---|
| RetroArch | Original CRT Mattias | Classic upstream reference | To be added |
| Dolphin | Original | Full-quality reference-style settings | To be added |
| Dolphin | Soft | Full quality, gentler fixed effects | To be added |
| Dolphin | Strong | Full quality, stronger fixed effects | To be added |
| Dolphin | Performance | Reduced-sampling original-style approximation | To be added |
| Dolphin | Performance Soft | Reduced sampling, gentler fixed effects | To be added |
| Dolphin | Performance Strong | Reduced sampling, stronger fixed effects | To be added |

To add pictures later, upload them to `docs/images/` and replace a cell with Markdown such as `![Dolphin Original](docs/images/dolphin-original.png)`.

## Three shared controls

| Control | Internal name | Default | Range |
|---|---|---:|---|
| Curvature | `M_CURVATURE` | 0.5 | 0–1 |
| Scanline speed | `M_SCAN_SPEED` | 1.0 | 0–10 |
| Brightness (stops) | `M_EXPOSURE` | 0.0 | −2 to +2 |

Curvature 0 is flat. Scanline speed 0 stops scrolling, but noise and flicker remain animated. Brightness +1 doubles output RGB before display clipping.

### Editing defaults in a text editor — especially Android

Near the top of each shader, locate its `[configuration]` block. Change **`DefaultValue`** in the section with the corresponding `OptionName`. For a flat image:

```ini
[OptionRangeFloat]
GUIName = Curvature
OptionName = M_CURVATURE
MinValue = 0.0
MaxValue = 1.0
DefaultValue = 0.0
StepAmount = 0.05
```

For scanline speed, find `OptionName = M_SCAN_SPEED` and change its `DefaultValue`; use `0.0` to stop scrolling. For brightness, find `OptionName = M_EXPOSURE`; `0.0` is unchanged, `-0.5` is darker, and `0.5` is brighter. Change the value within that specific section—do not replace every `DefaultValue` in the file. Keep the option names, ranges, and shader code intact.

Save as plain text with decimal points (`0.5`, not `0,5`). On Android, edit the accessible copy first and then install that already edited file. On desktop, edit the installed copy while Dolphin is closed or copy your edited project file into the shader directory afterward. **Dolphin's saved settings override file defaults.** To load fresh defaults without editing Dolphin's settings files, close Dolphin, save the shader under a new unique filename, reopen Dolphin, and select that new shader.

The three controls use names distinct from the earlier 27-control edition, so that edition's saved values do not migrate. New three-control adjustments are saved normally.

## What distinguishes the styles?

The values below are fixed in shader code, not extra configuration sliders:

| Effect multiplier | Original | Soft | Strong |
|---|---:|---:|---:|
| Scanlines | 1 | 0.65 | 1.15 |
| Blur radius | 1 | 0.8 | 1.15 |
| Glow | 1 | 0.65 | 1.25 |
| RGB separation | 1 | 0.5 | 1.3 |
| Ghosting | 1 | 0.3 | 1.3 |
| Noise | 1 | 0.35 | 1.15 |
| Column pattern | 1 | 0.6 | 1.25 |

All styles share the same default curvature, vignette, zoom, scanline density, flicker, and color settings. Strong has no exclusive corner smoothing. Soft means a subtler effect, not more blur; weaker scanline dimming can make it brighter.

## Compatibility and limitations

- The maintainer reports the current six shaders working on Linux and an Android handheld. Exact Android device/backend details are not recorded.
- The development interface target was Dolphin 2609. Independent checks used Mesa llvmpipe software OpenGL, not a complete Dolphin test environment.
- Defaults and combined parameter extremes produced finite output; controls affected the rendered image and fixed styles remained distinct.
- Intended for SDR. HDR, every graphics backend, stereoscopic output, and hardware performance are not comprehensively validated.
- Animation uses elapsed time rather than emulated frame count. Pausing and speed changes may behave differently from RetroArch.
- No black-frame insertion or frame-generation feature is included.

For a bug report, include the shader filename, Dolphin version, OS/device, graphics backend, output resolution, control values, and the error or a comparison screenshot.

## Credits and licensing status

Original CRT Shader by **Mattias Gustavsson**, [Shadertoy source](https://github.com/libretro/glsl-shaders/blob/master/crt/shaders/crt-mattias.glsl). This port uses the classic shader distributed by Libretro.

**The redistribution terms for the exact classic source have not been verified.** No MIT, GPL, or other license is asserted for this derivative. Attribution is retained, but attribution alone does not establish permission. See [NOTICE.md](NOTICE.md) for source provenance and the outstanding question.

## Installation references

- [Dolphin user-directory selection source](https://github.com/dolphin-emu/dolphin/blob/master/Source/Core/UICommon/UICommon.cpp)
- [Dolphin platform path definitions](https://github.com/dolphin-emu/dolphin/blob/master/Source/Core/Common/CommonPaths.h)
- [Official Dolphin Flatpak packaging](https://github.com/flathub/org.DolphinEmu.dolphin-emu)
- [RetroDECK 0.10.0b: exposed Dolphin shader folder](https://retrodeck.readthedocs.io/en/latest/wiki_rd_versions/version_0.10.0b/0.10.0b/)
- [Dolphin Android document-provider support](https://dolphin-emu.org/blog/2023/05/21/dolphin-progress-report-february-march-april-2023/)
