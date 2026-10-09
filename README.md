# Mattias CRT for Dolphin

Bring the classic Mattias CRT look to Dolphin, with scanlines, glow, color separation, and curved-screen effects.

Choose **Original**, **Soft**, or **Strong**, available in both full-quality and performance editions. Each shader has just three controls: **curvature, scanline speed, and brightness**.

## Choose your style

| Style | Look |
|---|---|
| Original | Closest to the classic Mattias CRT effect. |
| Soft | Gentler scanlines, glow, noise, and color separation. |
| Strong | More pronounced CRT effects. |

All three styles share the same default curvature and control settings.

The **Performance** edition trades a little fidelity for a little extra speed. The difference in performance was small on my devices, so try both and see which you prefer.

## Download

Get the shaders from [Releases](https://github.com/pakovm-git/Mattias-CRT-Dolphin/releases/latest):

- **Original ZIP:** includes full-quality Original, Soft, and Strong. Start here if you’re unsure.
- **Performance ZIP:** includes Performance, Performance Soft, and Performance Strong.

Each ZIP includes three standalone shaders, instructions, and credits.

## Installation

Extract the ZIP, then copy the `.glsl` files from its `Shaders` folder into:

- **Windows:** `%APPDATA%\Dolphin Emulator\Shaders\`
- **macOS:** `~/Library/Application Support/Dolphin/Shaders/`
- **Linux — Native:** `~/.local/share/dolphin-emu/Shaders/`
- **Linux — Flatpak:** `~/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/Shaders/`
- **Linux — RetroDECK:** `~/retrodeck/shaders/Dolphin/` — use your RetroDECK data folder if you installed it elsewhere.
- **Android:** `Android/data/org.dolphinemu.dolphinemu/files/Shaders/`

Create the `Shaders` folder if it is missing. Restart Dolphin, then select the shader under **Graphics → Enhancements → Post-Processing Effect**.

For custom or portable installations, use the `Shaders` folder inside your active Dolphin user folder.

## Configuration

On desktop, use Dolphin’s shader configuration dialog when available. You can also edit the settings directly in the shader file.

**On Android, edit the file before installing it**, since Dolphin’s Android interface does not expose these shader controls.

| Control | Name in the file | Default | Range |
|---|---|---:|---|
| Curvature | `M_CURVATURE` | 0.5 | 0–1 |
| Scanline speed | `M_SCAN_SPEED` | 1.0 | 0–10 |
| Brightness | `M_EXPOSURE` | 0.0 | −2 to +2 |

Open the `.glsl` file in a plain-text editor. Near the top, find the control’s `OptionName` and change the `DefaultValue` in that section.

For example, this sets curvature to zero for a flat image:

```ini
[OptionRangeFloat]
GUIName = Curvature
OptionName = M_CURVATURE
MinValue = 0.0
MaxValue = 1.0
DefaultValue = 0.0
StepAmount = 0.05
```

For scanline speed, `0.0` stops scrolling. For brightness, negative values darken the image and positive values brighten it.

Save the file with its `.glsl` extension, then copy it into Dolphin’s shader folder. Use decimal points, such as `0.5`.

If Dolphin keeps using previously saved settings, give the edited shader a new filename, restart Dolphin, and select that version.

## Comparison gallery

Screenshots coming soon.

| Shader | Screenshot |
|---|---|
| No Shader | <img width="1280" height="960" alt="Screenshot_20261009-163234" src="https://github.com/user-attachments/assets/ab2c35ec-9263-45bb-8730-d63411762d29" /> |
| Original | <img width="1280" height="960" alt="Screenshot_20261009-163301" src="https://github.com/user-attachments/assets/67288b78-7298-43b1-979d-2a3227dbbf0c" /> |
| Soft | <img width="1280" height="960" alt="Screenshot_20261009-163346" src="https://github.com/user-attachments/assets/c97e64c5-5cca-4b82-87b4-5e2283e76e77" /> |
| Strong | <img width="1280" height="960" alt="Screenshot_20261009-163411" src="https://github.com/user-attachments/assets/fbfea99a-3fb6-44f6-a2eb-a5e453a7fb78" /> |
| Performance | <img width="1280" height="960" alt="Screenshot_20261009-163434" src="https://github.com/user-attachments/assets/012644fd-e7ef-4bcf-8814-f32c0f9c5503" /> |
| Performance Soft | <img width="1280" height="960" alt="Screenshot_20261009-163500" src="https://github.com/user-attachments/assets/4cb481a3-4392-480f-9123-825b3706f765" /> |
| Performance Strong | <img width="1280" height="960" alt="Screenshot_20261009-163522" src="https://github.com/user-attachments/assets/13c21ae7-5955-484f-9f4f-3eb74080838d" /> |

## Compatibility

I’ve tested all six shaders on Linux and an Android handheld. Windows and macOS feedback is welcome.

The shaders are intended for SDR displays. If you find a problem, include your shader filename, Dolphin version, device, graphics backend, and a screenshot if possible.

## Credits

The original CRT Emulation shader is by **Mattias Gustavsson**, adapted for RetroArch/Libretro.

I developed this Dolphin port with help from **OpenAI Codex**.

See [NOTICE.md](NOTICE.md) for source attribution and the unresolved licensing details.

## Technical details

### Full quality and Performance

The full-quality shaders use a 25-sample blur. Performance shaders use nine samples with bilinear filtering, reducing source-level texture reads from 225 to 81 per in-bounds pixel.

That reduction does not translate directly into an equivalent speedup. Actual performance depends on the device, graphics backend, and resolution. The simpler sampling also changes blur, fine detail, and contrast slightly.

### Differences between styles

These effect multipliers are fixed in each shader:

| Effect | Original | Soft | Strong |
|---|---:|---:|---:|
| Scanlines | 1 | 0.65 | 1.15 |
| Blur radius | 1 | 0.8 | 1.15 |
| Glow | 1 | 0.65 | 1.25 |
| RGB separation | 1 | 0.5 | 1.3 |
| Ghosting | 1 | 0.3 | 1.3 |
| Noise | 1 | 0.35 | 1.15 |
| Column pattern | 1 | 0.6 | 1.25 |

All styles share the same default curvature, vignette, zoom, scanline density, flicker, and color settings. Strong has no separate corner-smoothing feature. Soft reduces the CRT effects, including blur; weaker scanline dimming can make it appear brighter.

### Controls and animation

- Curvature `0` produces a flat image.
- Scanline speed `0` stops scrolling; noise and flicker remain animated.
- Brightness is measured in stops: `+1` doubles output RGB before display clipping.
- Animation follows elapsed time, so pausing and changing emulation speed may behave differently from RetroArch.
- Dolphin’s saved control values take priority over defaults edited in the file.

### Testing

The development interface target was Dolphin 2609. Automated checks used Mesa llvmpipe software OpenGL for compilation and synthetic rendering.

The checks covered default settings and combined control extremes, verified finite output, and confirmed that the controls and styles changed the rendered image. Hardware testing covered Linux and an Android handheld.

HDR, stereoscopic output, and every graphics backend have not been tested.

### Folder notes

Older native Linux setups may still use `~/.dolphin-emu/Shaders/`. When available, **File → Open User Folder** shows the active Dolphin directory.

If Android blocks direct access to `Android/data`, use a file manager that exposes Dolphin’s storage-provider entry, then open **Dolphin Emulator → Shaders**.

### References

- [Original shader by Mattias Gustavsson](https://github.com/libretro/glsl-shaders/blob/master/crt/shaders/crt-mattias.glsl)
- [Dolphin user-directory selection](https://github.com/dolphin-emu/dolphin/blob/master/Source/Core/UICommon/UICommon.cpp)
- [Dolphin platform paths](https://github.com/dolphin-emu/dolphin/blob/master/Source/Core/Common/CommonPaths.h)
- [Dolphin Flatpak packaging](https://github.com/flathub/org.DolphinEmu.dolphin-emu)
- [RetroDECK Dolphin shader folder](https://retrodeck.readthedocs.io/en/latest/wiki_rd_versions/version_0.10.0b/0.10.0b/)
- [Dolphin Android storage-provider support](https://dolphin-emu.org/blog/2023/05/21/dolphin-progress-report-february-march-april-2023/)
