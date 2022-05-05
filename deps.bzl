load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

def arduboy_dependencies():
    new_git_repository(
        name = "arduboy2",
        build_file = "//bazel:arduboy2.BUILD",
        remote = "https://github.com/MLXXXp/Arduboy2.git",
        # tag = "6.0.0", # Uncomment to update with new tag
        commit = "7dc88bed3031ab01d3227d065123740e4d938093",  # Tag 6.0.0
        shallow_since = "1601387081 -0400",  # Tag 6.0.0
    )

    # Dependency of GxEPD2
    new_git_repository(
        name = "adafruit_gfx",
        build_file = "//bazel:BUILD.adafruit_gfx",
        remote = "https://github.com/adafruit/Adafruit-GFX-Library.git",
        tag = "1.10.14",
    )

    # Dependency of adafruit_gfx
    new_git_repository(
        name = "adafruit_busio",
        build_file = "//bazel:BUILD.adafruit_busio",
        remote = "https://github.com/adafruit/Adafruit_BusIO.git",
        tag = "1.11.3",
    )

    # Support for the ARDUINO_WATCHY_V10 DS3231 Real-Time Clock
    new_git_repository(
        name = "ds3232rtc",
        build_file = "//bazel:BUILD.ds3232rtc",
        remote = "https://github.com/JChristensen/DS3232RTC.git",
        tag = "2.0.0",
    )

    # Dependency of ds3232rtc
    new_git_repository(
        name = "time",
        build_file = "//bazel:BUILD.time",
        remote = "https://github.com/PaulStoffregen/Time.git",
        tag = "v1.6.1",
    )

    # Support for the ARDUINO_WATCHY_V15&V20 Pcf8563 Real-Time Clock
    new_git_repository(
        name = "rtc_pcf8563",
        build_file = "//;bazel:BUILD.rtc_pcf8563",
        remote = "https://github.com/elpaso/Rtc_Pcf8563.git",
        tag = "",
    )

# Thanks to https://github.com/simonhorlick/bazel_esp32
def arduinocore_avr_dependencies():
    # The cross compiler, tools and headers.
    new_git_repository(
        name = "arduinocore_avr",
        build_file = "@arduboy//bazel:BUILD.arduinocore_avr",
        remote = "https://github.com/arduino/ArduinoCore-avr.git",
        # tag = "1.8.5", # Un-comment to re-grab new tag
        commit = "b3243815e2ed8c72f9ac3669e69632a590b1d048",  # tag 1.8.5
        shallow_since = "1645003222 +0100",  # tag 1.8.5
    )
