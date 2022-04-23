load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

# Arduboy
BUILD_MCU = "atmega32u4"
BUILD_F_CPU = "16000000L"  # CPU Frequency
BUILD_ARDUINO = "10819L"
BUILD_USB_MANUFACTURER = "Arduboy"  # Device Query USB Info
BUILD_USB_PRODUCT = "Arduboy_FX"  # Device Query USB Info
BUILD_USB_VID = "0x2341"
BUILD_USB_PID = "0x8036"

BUILD_EXTRA_FLAGS = [
    # Arduboy
    "-mmcu=" + BUILD_MCU,
    "-DF_CPU=" + BUILD_F_CPU,
    "-DARDUINO=" + BUILD_ARDUINO,
    "-DARDUINO_AVR_LEONARDO",
    "-DARDUINO_ARCH_AVR",
    "-DUSB_VID=" + BUILD_USB_VID,
    "-DUSB_PID=" + BUILD_USB_PID,
    "-DUSB_MANUFACTURER=\"" + BUILD_USB_MANUFACTURER + "\"",
    "-DUSB_PRODUCT=\"" + BUILD_USB_PRODUCT + "\"",
]

RUNTIME_PLATFORM_PATH = "external/arduino_esp32"
COMPILER_SDK_PATH = RUNTIME_PLATFORM_PATH + "/tools/sdk"

INCLUDE_DIRS = [
    "include/config",
    "include/app_trace",
    "include/app_update",
    "include/asio",
    "include/bootloader_support",
    "include/bt",
    "include/coap",
    "include/console",
    "include/driver",
    "include/efuse",
    "include/esp-tls",
    "include/esp32",
    "include/esp_adc_cal",
    "include/esp_event",
    "include/esp_http_client",
    "include/esp_http_server",
    "include/esp_https_ota",
    "include/esp_https_server",
    "include/esp_ringbuf",
    "include/esp_websocket_client",
    "include/espcoredump",
    "include/ethernet",
    "include/expat",
    "include/fatfs",
    "include/freemodbus",
    "include/freertos",
    "include/heap",
    "include/idf_test",
    "include/jsmn",
    "include/json",
    "include/libsodium",
    "include/log",
    "include/lwip",
    "include/mbedtls",
    "include/mdns",
    "include/micro-ecc",
    "include/mqtt",
    "include/newlib",
    "include/nghttp",
    "include/nvs_flash",
    "include/openssl",
    "include/protobuf-c",
    "include/protocomm",
    "include/pthread",
    "include/sdmmc",
    "include/smartconfig_ack",
    "include/soc",
    "include/spi_flash",
    "include/spiffs",
    "include/tcp_transport",
    "include/tcpip_adapter",
    "include/ulp",
    "include/unity",
    "include/vfs",
    "include/wear_levelling",
    "include/wifi_provisioning",
    "include/wpa_supplicant",
    "include/xtensa-debug-module",
    "include/esp-face",
    "include/esp32-camera",
    "include/esp-face",
    "include/fb_gfx",
]

COMPILER_CPREPROCESSOR_FLAGS = ["-I" + COMPILER_SDK_PATH + "/" + p for p in INCLUDE_DIRS] + [
    "-I" + RUNTIME_PLATFORM_PATH + "/cores/esp32",
    "-I" + RUNTIME_PLATFORM_PATH + "/variants/esp32",
]

COMPILER_WARNING_FLAGS = ["-Wall"]

COMPILER_C_FLAGS = [
    "-std=gnu99",
    "-Os",
    "-g",
    "-flto",
    "-ffunction-sections",
    "-fdata-sections",
    "-fstrict-volatile-bitfields",
    "-nostdlib",
    "-Wpointer-arith",
] + COMPILER_WARNING_FLAGS + [
    "-Wno-maybe-uninitialized",
    "-Wno-unused-function",
    "-Wno-unused-but-set-variable",
    "-Wno-unused-variable",
    "-Wno-deprecated-declarations",
    "-Wno-unused-parameter",
    "-Wno-sign-compare",
    "-Wno-old-style-declaration",
    "-MMD",
    "-c",
]

# -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -flto -w -x
COMPILER_CPP_FLAGS = [
    "-std=gnu++11",
    "-Os",
    "-g",
    "-flto",
    "-Wpointer-arith",
    "-fexceptions",
    "-ffunction-sections",
    "-fdata-sections",
    "-fstrict-volatile-bitfields",
    "-nostdlib",
] + COMPILER_WARNING_FLAGS + [
    "-Wno-error=maybe-uninitialized",
    "-Wno-error=unused-function",
    "-Wno-error=unused-but-set-variable",
    "-Wno-error=unused-variable",
    "-Wno-error=deprecated-declarations",
    "-Wno-unused-parameter",
    "-Wno-unused-but-set-parameter",
    "-Wno-missing-field-initializers",
    "-Wno-sign-compare",
    "-fno-rtti",
    "-MMD",
    "-c",
]

COMPILER_C_ELF_FLAGS = [
    "-nostdlib",
    "-L" + COMPILER_SDK_PATH + "/lib",
    "-L" + COMPILER_SDK_PATH + "/ld",
    "-u",
    "ld_include_panic_highint_hdl",
    "-u",
    "call_user_start_cpu0",
    "-Wl,--gc-sections",
    "-Wl,-static",
    "-Wl,--undefined=uxTopUsedPriority",
    "-u",
    "__cxa_guard_dummy",
    "-u",
    "__cxx_fatal_exception",
]

COMPILER_C_ELF_LIBS = [
    "-lgcc",
    "-lc",
    "-lm",
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "/usr/bin/avr-gcc",
        ),
        tool_path(
            name = "ld",
            path = "/usr/bin/avr-ld",
        ),
        tool_path(
            name = "ar",
            path = "/usr/bin/avr-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/usr/bin/avr-g++",
        ),
        tool_path(
            name = "gcov",
            path = "/usr/bin/avr-gcov",
        ),
        tool_path(
            name = "nm",
            path = "/usr/bin/avr-nm",
        ),
        tool_path(
            name = "objdump",
            path = "/usr/bin/avr-objdump",
        ),
        tool_path(
            name = "strip",
            path = "/usr/bin/avr-strip",
        ),
    ]

    default_compile_flags_feature = feature(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-DCOMPILING_AS_CPP_NOT_C",
                        ] + COMPILER_CPREPROCESSOR_FLAGS + COMPILER_CPP_FLAGS + BUILD_EXTRA_FLAGS,
                    ),
                ],
            ),
        ],
    )

    default_c_compile_flags_feature = feature(
        name = "default_c_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.c_compile,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-DCOMPILING_AS_C_NOT_CPP",
                        ] + COMPILER_CPREPROCESSOR_FLAGS + COMPILER_C_FLAGS + BUILD_EXTRA_FLAGS,
                    ),
                ],
            ),
        ],
    )

    all_link_actions = [
        ACTION_NAMES.cpp_link_executable,
        ACTION_NAMES.cpp_link_dynamic_library,
        ACTION_NAMES.cpp_link_nodeps_dynamic_library,
    ]

    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = COMPILER_C_ELF_FLAGS + ["-Wl,--start-group"] + COMPILER_C_ELF_LIBS +
                                [
                                    "-Wl,--end-group",
                                    "-Wl,-EL",
                                ],
                    ),
                ],
            ),
        ],
    )

    features = [
        default_compile_flags_feature,
        default_c_compile_flags_feature,
        default_link_flags_feature,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        cxx_builtin_include_directories = [
            "/usr/lib/avr/x86_64-linux-gnu/include/",
            "/usr/lib/gcc/avr/5.4.0/include",
        ],
        features = features,
        toolchain_identifier = "avr-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "avr",
        target_libc = "unknown",
        compiler = "avr-g++",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
