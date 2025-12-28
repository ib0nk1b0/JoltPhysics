project "Jolt"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "off"
   
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
   
    -- Jolt root directory
    JOLT_DIR = "%{wks.location}/OpenEngine/vendor/Jolt"

    files
    {
        JOLT_DIR .. "/Jolt/**.h",
        JOLT_DIR .. "/Jolt/**.cpp",

        -- Optional: exclude samples/tests if you have the full repo
        JOLT_DIR .. "/Jolt/**Tests.cpp",
        JOLT_DIR .. "/Jolt/**Samples/**",
    }

    includedirs
    {
        JOLT_DIR,
        JOLT_DIR .. "/Jolt",
    }
   
    defines {
        "JPH_FLOATING_POINT_CONTROL",
        "JPH_PROFILE_ENABLED",          -- optional
        -- "JPH_DEBUG_RENDERER",        -- only if you need it
        -- "JPH_ENABLE_ASSERTS",        -- recommended in Debug
    }
   
    filter "configurations:Debug"
        defines { "JPH_DEBUG_RENDERER", "JPH_ENABLE_ASSERTS" }
        symbols "On"
        optimize "Off"

    filter "configurations:Release or Dist"
        optimize "Speed"
        flags { "LinkTimeOptimization" }
        defines { "NDEBUG" }

    filter "system:windows"
        defines { "WIN32", "_WIN32" }
        disablewarnings { "4100", "4189", "4324" } -- common Jolt warnings

    filter {}