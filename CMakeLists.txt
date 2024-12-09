cmake_minimum_required(VERSION 3.16)

project(test)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 11)

if (CMAKE_BUILD_TYPE STREQUAL Debug)
    set(BUILD_TYPE_INNER debug)
else()
    set(BUILD_TYPE_INNER release)
endif()

if (MSVC)
    if (CMAKE_GENERATOR STREQUAL "Visual Studio 15 2017")
        set(VC_VERSION_INNER VS2017)
    elseif (CMAKE_GENERATOR STREQUAL "Visual Studio 16 2019")
        set(VC_VERSION_INNER VS2019)
    elseif (CMAKE_GENERATOR STREQUAL "Visual Studio 17 2022")
        set(VC_VERSION_INNER VS2022)
    else ()
        message(FATAL_ERROR "不支持 ${CMAKE_GENERATOR}")
    endif ()
    # 这个路径要和reinstall_third_party.bat脚本里指定的对应
    set(CMAKE_PREFIX_PATH 
        "${CMAKE_CURRENT_SOURCE_DIR}/prefix/${CMAKE_SYSTEM_NAME}-${VC_VERSION_INNER}/${BUILD_TYPE_INNER}/lib/cmake"
    )

    # 使用宏 _WIN32_WINNT 指定Windows版本
    # 例如 add_compile_definitions(_WIN32_WINNT=0x0601) 代表Windows 7
    add_compile_definitions(_WIN32_WINNT=0x0601)

    # 使用静态运行库
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    set(Boost_USE_STATIC_RUNTIME ON)
else ()
    # 这个路径要和reinstall_third_party.sh脚本里指定的对应
    set(CMAKE_PREFIX_PATH 
        "${CMAKE_CURRENT_SOURCE_DIR}/prefix/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${BUILD_TYPE_INNER}"
    )
endif ()

# 这个是默认值
# set(Boost_USE_STATIC_LIBS ON)

# find_package(OpenSSL REQUIRED)
find_package(Boost 1.86.0 REQUIRED COMPONENTS chrono system thread)

add_subdirectory(source)
