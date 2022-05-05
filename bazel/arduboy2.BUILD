load("@rules_cc//cc:defs.bzl", "cc_library")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "arduboy2",
    srcs = glob([
        "src/*.cpp",
    ]),
    hdrs = glob([
        "src/*.h",
    ]),
    includes = ["src/"],
    deps = [
        "@arduinocore_avr//:cores_arduino",
        "@arduinocore_avr//:eeprom",
    ],
)
