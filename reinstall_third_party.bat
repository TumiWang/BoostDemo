@echo off
setlocal

CD /d %~dp0

SET SCRIPT_DIR=%CD%
SET PRUDOCT_DIR=product
SET BUILD_DIR=build

SET ROOT_DIR=%CD%
SET CURRENT_SYSTEM_NAME=Windows
SET CURRENT_SYSTEM_ARCH=x86_64

@REM SET VC_VERSION=Visual Studio 17 2022
@REM SET VC_VERSION=Visual Studio 16 2019
SET VC_VERSION=Visual Studio 15 2017

IF "%VC_VERSION%" == "Visual Studio 15 2017" (
    SET VC_VERSION_SHORT=VS2017
    SET VC_TOOLSET=msvc-14.1
)
    
IF "%VC_VERSION%" == "Visual Studio 16 2019" (
    SET VC_VERSION_SHORT=VS2019
    SET VC_TOOLSET=msvc-14.2
)

IF "%VC_VERSION%" == "Visual Studio 17 2022" (
    SET VC_VERSION_SHORT=VS2022
    SET VC_TOOLSET=msvc-14.3
)

IF "%VC_VERSION_SHORT%_x" == "_x" (
    goto end
)

SET TEMP_DIR=temp
SET PREFIX_DIR=prefix\%CURRENT_SYSTEM_NAME%-%VC_VERSION_SHORT%
SET THIRD_PARTY_DIR=third_party

IF EXIST "%TEMP_DIR%" (
    RMDIR /s /q "%TEMP_DIR%"
)
MKDIR "%TEMP_DIR%"

IF EXIST "%PREFIX_DIR%" (
    RMDIR /s /q "%PREFIX_DIR%"
)
MKDIR "%PREFIX_DIR%"

:: Install Boost
IF EXIST "%THIRD_PARTY_DIR%\boost-1.86.0-b2-nodocs.tar.gz" (
    :: release
    cd "%ROOT_DIR%\%TEMP_DIR%"
    tar -xzf "%ROOT_DIR%\%THIRD_PARTY_DIR%\boost-1.86.0-b2-nodocs.tar.gz"
    cd boost-1.86.0
    bootstrap.bat --with-libraries=all
    cd "%ROOT_DIR%\%TEMP_DIR%\boost-1.86.0"
    b2.exe --prefix="%ROOT_DIR%\%PREFIX_DIR%\release" variant=release toolset=%VC_TOOLSET% link=static runtime-link=static install
    cd "%ROOT_DIR%\%TEMP_DIR%"
    RMDIR /s /q boost-1.86.0

    :: debug
    cd "%ROOT_DIR%\%TEMP_DIR%"
    tar -xzf "%ROOT_DIR%\%THIRD_PARTY_DIR%\boost-1.86.0-b2-nodocs.tar.gz"
    cd boost-1.86.0
    bootstrap.bat --with-libraries=all
    cd "%ROOT_DIR%\%TEMP_DIR%\boost-1.86.0"
    b2.exe --prefix="%ROOT_DIR%\%PREFIX_DIR%\debug" variant=debug toolset=%VC_TOOLSET% link=static runtime-link=static install
    cd "%ROOT_DIR%\%TEMP_DIR%"
    RMDIR /s /q boost-1.86.0
)

cd "%ROOT_DIR%"
IF EXIST "%TEMP_DIR%" (
    RMDIR /s /q "%TEMP_DIR%"
)

:end
pause