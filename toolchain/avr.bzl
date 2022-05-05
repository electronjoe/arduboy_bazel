load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

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

tool_paths = [
    tool_path(
        name = "gcc",
        path = "/home/vscode/toolchain-avr/objdir/bin/avr-g++",
    ),
    tool_path(
        name = "ld",
        path = "/home/vscode/toolchain-avr/objdir/bin/avr-ld",
    ),
    tool_path(
        name = "ar",
        path = "/home/vscode/toolchain-avr/objdir/bin/avr-ar",
    ),
    tool_path(
        name = "cpp",
        path = "/home/vscode/toolchain-avr/objdir/bin/avr-g++",
    ),
    tool_path(
        name = "gcov",
        path = "/home/vscode/toolchain-avr/objdir/bin/avr-gcov",
    ),
    tool_path(
        name = "nm",
        path = "/home/vscode/toolchain-avr/objdir/bin/avr-nm",
    ),
    tool_path(
        name = "objdump",
        path = "/home/vscode/toolchain-avr/objdir/bin/avr-objdump",
    ),
    tool_path(
        name = "strip",
        path = "/home/vscode/toolchain-avr/objdir/bin/avr-strip",
    ),
]

def _avr_impl(ctx):
    features = [
        feature(
            name = "default_compiler_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.assemble,
                        ACTION_NAMES.preprocess_assemble,
                        ACTION_NAMES.linkstamp_compile,
                        ACTION_NAMES.c_compile,
                        ACTION_NAMES.cpp_compile,
                        ACTION_NAMES.cpp_header_parsing,
                        ACTION_NAMES.cpp_module_compile,
                        ACTION_NAMES.cpp_module_codegen,
                        ACTION_NAMES.lto_backend,
                        ACTION_NAMES.clif_match,
                    ],
                    flag_groups = ([
                        flag_group(
                            flags = BUILD_EXTRA_FLAGS + [
                                "-g",
                                "-Os",
                                "-w",
                                "-std=gnu++11",
                                "-fpermissive",
                                "-fno-exceptions",
                                "-ffunction-sections",
                                "-fdata-sections",
                                "-fno-threadsafe-statics",
                                "-Wno-error=narrowing",
                                "-flto",
                                "-w",
                                "-x",
                                "c++",
                                "-CC",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.cpp_link_executable,
                        ACTION_NAMES.cpp_link_dynamic_library,
                        ACTION_NAMES.cpp_link_nodeps_dynamic_library,
                    ],
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-w",
                                "-Os",
                                "-g",
                                "-flto",
                                "-fuse-linker-plugin",
                                "-Wl,--gc-sections",
                                "-mmcu=atmega32u4",
                                "-lm",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
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
        cxx_builtin_include_directories = [
            "/home/vscode/toolchain-avr/objdir/avr",
            "/home/vscode/toolchain-avr/objdir/lib/gcc/avr/7.3.0/",
        ],
    )

cc_toolchain_config = rule(
    attrs = {},
    provides = [CcToolchainConfigInfo],
    implementation = _avr_impl,
)
