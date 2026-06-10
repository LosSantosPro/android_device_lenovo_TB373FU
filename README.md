# Lenovo Idea Tab Pro (2025) - TB373FU

LineageOS 23.2 (Android 16) device tree for the **TB373FU**, the **ROW (global)
Wi-Fi variant** of the tablet sold in China as the Lenovo Xiaoxin Pad Pro 12.7
(2025). Same MediaTek Dimensity 8300 (MT6897) hardware, internal codename
`peridot`.

The **Moto Pad 60 Pro** (XT2571-1) is the same tablet re-badged, on the same firmware -
this build should run on it too, but is untested there.

## Why this tree is almost empty

TB373FU and the PRC `TB375FC` are the **same hardware** with different regional
firmware, so rather than duplicate everything, TB373FU is a **thin variant** that
inherits the entire `TB375FC` device tree, vendor blobs and prebuilt kernel. The
only build-visible differences live in this repo:

| File | What differs from TB375FC |
|------|---------------------------|
| `lineage_TB373FU.mk` | product identity (`TB373FU`); inherits `device/lenovo/TB375FC/device.mk` and the shared vendor makefiles |
| `BoardConfig.mk` | includes `device/lenovo/TB375FC/BoardConfig.mk`, then swaps in the ROW dtbo + its OEM AVB salt and the ROW `vendor.prop` |
| `vendor.prop` | ROW marketname (`Lenovo Idea Tab Pro`) and the pen name - props with spaces, which `PRODUCT_VENDOR_PROPERTIES` can't carry |
| `lineage_TB373FU.mk` lgsi block | ROW `hw.version` / `ota.model` (`TB373FU_ROW`) |
| `AndroidProducts.mk` | the `lineage_TB373FU` lunch combos |
| `lineage.dependencies` | pulls `android_device_lenovo_TB375FC` (the shared tree) plus its vendor / kernel / `hardware/mediatek` deps |

Everything else - sepolicy, HALs, overlays, kernel Image, modules, DTBs - is the
TB375FC tree. See
**[android_device_lenovo_TB375FC](https://github.com/LosSantosPro/android_device_lenovo_TB375FC)**
for the full specifications, build notes, and GApps / Play-Integrity guide. The
hardware is identical; only the stock firmware differs by region - TB373FU ships
ZUI 17.5.10.043 (ROW) versus the PRC TB375FC's ZUXOS 1.5.10.060.

The only difference the build actually cares about is the **dtbo**: the ROW
bootloader validates its own dtbo AVB hash descriptor at boot, so a TB373FU build
ships the ROW dtbo (`dtbo_TB373FU.img`) and pins the matching OEM salt; the PRC
build ships `dtbo_TB375FC.img`.

## Build

```
repo init -u https://github.com/LineageOS/android.git -b lineage-23.2
```

Add `.repo/local_manifests/TB373FU.xml` (it pulls this repo **and** the shared
TB375FC tree it inherits), then sync:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="LosSantosPro/android_device_lenovo_TB373FU" path="device/lenovo/TB373FU" remote="github" revision="lineage-23.2" />
  <project name="LosSantosPro/android_device_lenovo_TB375FC" path="device/lenovo/TB375FC" remote="github" revision="lineage-23.2" />
  <project name="LosSantosPro/android_vendor_lenovo_TB375FC" path="vendor/lenovo/TB375FC" remote="github" revision="lineage-23.2" />
  <project name="LineageOS/android_hardware_mediatek" path="hardware/mediatek" remote="github" revision="lineage-23.2" />
</manifest>
```

```
repo sync
source build/envsetup.sh
lunch lineage_TB373FU-bp4a-user
mka bacon
```

## License

Apache-2.0. See file headers for details.
