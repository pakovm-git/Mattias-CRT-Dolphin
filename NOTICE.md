# Attribution and source provenance

The shaders retain these original author comments:

```text
CRT Emulation
by Mattias
https://www.shadertoy.com/view/lsB3DV
```

The author is identified as Mattias Gustavsson in [Libretro's discussion of this shader](https://github.com/libretro/slang-shaders/issues/134).

## Sources used

- [Classic Libretro shader](https://github.com/libretro/glsl-shaders/blob/435612fe4f1023117b3aae48c88603fb413404a3/crt/shaders/crt-mattias.glsl), commit `435612fe4f1023117b3aae48c88603fb413404a3`.
- The supplied original matched that file byte-for-byte. SHA-256: `b6de4b3a951662697826e864303e91835c38b645e9d06f093aa97c17a937c083`.
- [Original preset](https://github.com/libretro/glsl-shaders/blob/435612fe4f1023117b3aae48c88603fb413404a3/crt/crt-mattias.glslp): single pass, nearest filtering.
- [Dolphin 2609 post-processing interface](https://github.com/dolphin-emu/dolphin/blob/f84df02055ab9610feec48e65648cac5a3c098fa/Source/Core/VideoCommon/PostProcessing.cpp), commit `f84df02055ab9610feec48e65648cac5a3c098fa`.

## Adaptation

Changes include Dolphin input/output bindings; source-rectangle mapping; elapsed-time animation; guarded power operations; fixed Original/Soft/Strong styling; three shared controls; and a separate reduced-sampling performance approximation. The original author is not represented as endorsing these changes.

## Unresolved licensing

The exact classic shader's header contains attribution but no explicit license grant. The Shadertoy page could not be retrieved during verification. The author's newer CRT implementations exist, but their terms must not automatically be assigned to this older source or Libretro modifications.

No license grant for the underlying work is created by this repository. Confirm the applicable terms with authoritative source material or the relevant rights holders before treating this as a freely redistributable or sublicensable package. This notice documents uncertainty; it is not a substitute for permission.
