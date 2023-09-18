# Magisk

https://github.com/shakalaca/MagiskOnEmulator

[Magisk](https://github.com/topjohnwu/Magisk/releases?page=2)

[HMA](https://github.com/Dr-TSNG/Hide-My-Applist/releases)

[hma guide](https://github.com/mModule/guide_hma)

[how to install lsposed](https://github.com/mModule/guide_hma/blob/master/Install-LSPosed.md)

[how to install hma](https://github.com/mModule/guide_hma/blob/master/Install-HMA.md)

```
adb push LSPosed-v1.9.1-6990-zygisk-release.zip /sdcard
adb push Hide-My-Applist-3.2.zip /sdcard
adb push HMA-V3.2.apk /sdcard
adb push Magisk.zip /data/local/tmp
```

## MagiskOnEmulator
```
./patch.sh manager
<continue setup on device>
./patch.sh pull
```

## Android emulator
AVD directory: `$ANDROID_SDK_ROOT/system-images/android-29/default/x86_64`
Patching file: `ramdisk.img`

Save original: `cp ramdisk.img origin_ramdisk.img`

## Magisk
- v21.4 worked but missing Zygisk
- V24.0 works and have Zygisk
- V26.3 did not work

## LSPosed
`LSPosed-v1.9.1-6990-zygisk-release.zip` works

## HMA
One of the following: 
```
Hide-My-Applist-3.2.zip
HMA-V3.2.apk
```