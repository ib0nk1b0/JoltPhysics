project "Jolt"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "off" -- should this be on?

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- Jolt root directory
    JOLT_DIR = "%{wks.location}/OpenEngine/vendor/Jolt"

    files
    {
        JOLT_DIR .. "/Jolt/**.h",
        JOLT_DIR .. "/Jolt/**.cpp",
    }

    includedirs
    {
        JOLT_DIR,
        JOLT_DIR .. "/Jolt",
    }

    defines
    {
        "JPH_ENABLE_ASSERTS",
        "JPH_STATIC_LIBRARY",
        "JPH_FLOATING_POINT_PRECISION=32",
        "JPH_USE_SSE4_1",
    }

    filter "system:windows"
        systemversion "latest"
        defines
        {
            "JPH_PLATFORM_WINDOWS",
            "JPH_COMPILER_MSVC",
            "_CRT_SECURE_NO_WARNINGS"
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"
        defines
        {
            "JPH_DEBUG",
            "JPH_ENABLE_ASSERTS"
        }

    filter "configurations:Release"
        runtime "Release"
        optimize "Speed"
        defines
        {
            "JPH_RELEASE",
            "NDEBUG"
        }

    filter {}
