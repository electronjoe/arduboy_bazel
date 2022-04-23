load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

def watch_dependencies():
    # Driver for the Watchy E-Ink Display
    new_git_repository(
        name = "GxEPD2",
        build_file = "//bazel:GxEPD2.BUILD",
        remote = "https://github.com/ZinggJM/GxEPD2.git",
        tag = "1.4.5",
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
def bazel_esp32_dependencies():
    # The cross compiler, tools and headers.
    http_archive(
        name = "xtensa_esp32_elf_linux64",
        build_file = "@watch//bazel:BUILD.xtensa_esp32_elf_linux64",
        sha256 = "96f5f6e7611a0ed1dc47048c54c3113fc5cebffbf0ba90d8bfcd497afc7ef9f3",
        strip_prefix = "xtensa-esp32-elf",
        urls = ["https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-97-gc752ad5-5.2.0.tar.gz"],
    )

    # The Arduino base libraries.
    http_archive(
        name = "arduino_esp32",
        build_file = "@watch//bazel:BUILD.arduino_esp32",
        strip_prefix = "esp32-1.0.6",
        sha256 = "982da9aaa181b6cb9c692dd4c9622b022ecc0d1e3aa0c5b70428ccc3c1b4556b",
        urls = ["https://github.com/espressif/arduino-esp32/releases/download/1.0.6/esp32-1.0.6.zip"],
    )
