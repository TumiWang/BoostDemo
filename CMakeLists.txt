cmake_minimum_required(VERSION 3.16)

project(test)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 11)

if (CMAKE_BUILD_TYPE STREQUAL Debug)
    set(BUILD_TYPE_INNER debug)
else()
    set(BUILD_TYPE_INNER release)
endif()

set(CMAKE_PREFIX_PATH 
    "${CMAKE_CURRENT_SOURCE_DIR}/prefix/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${BUILD_TYPE_INNER}"
)

# find_package(OpenSSL REQUIRED)
find_package(Boost 1.86.0 REQUIRED COMPONENTS chrono system thread)

add_subdirectory(source)
