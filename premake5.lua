local current_dir = os.getcwd()

-- Define the project
project "glfw"
    kind "StaticLib"
    language "C"
    staticruntime "On"

	targetdir("./bin/" .. outputDir .. "/%{prj.name}")
	objdir("./bin-int/" .. outputDir .. "/%{prj.name}")

    -- Add the source files for GLFW
    files {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/glfw_config.h",
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/vulkan.c",
        "src/window.c",
        "src/platform.c",
        "src/posix_module.c",
        "src/null_init.c",
        "src/null_window.c",
        "src/null_monitor.c",
        "src/null_joystick.c",
        "src/posix_poll.c"
    }

    -- Exclude the example files if not needed
    filter "files:**/example.c"
        flags { "ExcludeFromBuild" }

    -- Windows-specific settings
    filter "system:windows"
        systemversion "latest"

        files {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_monitor.c",
            "src/win32_module.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wgl_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c"
        }

        defines {
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS"
        }

    -- Linux-specific settings
    filter "system:linux"
        pic "On"

        files {
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/xkb_unicode.c",
            "src/posix_time.c",
            "src/posix_thread.c",
            "src/glx_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c",
            "src/linux_joystick.c"
        }

        defines {
            "_GLFW_X11"
        }

    -- macOS-specific settings
    filter "system:macosx"
        pic "On"

        files {
            "src/cocoa_init.m",
            "src/cocoa_joystick.m",
            "src/cocoa_monitor.m",
            "src/cocoa_window.m",
            "src/cocoa_time.c",
            "src/posix_thread.c",
            "src/nsgl_context.m",
            "src/egl_context.c",
            "src/osmesa_context.c",
            "src/posix_time.c",
            "src/iokit_joystick.m"
        }

        defines {
            "_GLFW_COCOA"
        }

    filter "configurations:debug"
        symbols "On"
		optimize "Debug"

	filter "configurations:pre"
        symbols "Off"
		optimize "On"

	filter "configurations:release"
        symbols "Off"
		optimize "Speed"
