@echo off

CD /d %~dp0

SET SCRIPT_DIR=%CD%
SET PRUDOCT_DIR=product
SET BUILD_DIR=build

@REM SET VC_VERSION=Visual Studio 16 2019
@REM SET VC_VERSION=Visual Studio 17 2022
SET VC_VERSION=Visual Studio 15 2017

SET  BUILD_TYPE=Release
@REM SET BUILD_TYPE=Debug

SET ARCH_TYPE=win32
@REM SET ARCH_TYPE=x64

IF EXIST "%BUILD_DIR%" (
    RMDIR /s /q "%BUILD_DIR%"
)

IF EXIST "%PRUDOCT_DIR%" (
    RMDIR /s /q "%PRUDOCT_DIR%"
)

cmake -B "%BUILD_DIR%" -S . -G "%VC_VERSION%" -A %ARCH_TYPE%  -DCMAKE_BUILD_TYPE=%BUILD_TYPE%
IF %ERRORLEVEL% neq 0 (
    goto end
)

cmake --build "%BUILD_DIR%" --config %BUILD_TYPE%
IF %ERRORLEVEL% neq 0 (
    goto end
)

cmake --install "%BUILD_DIR%" --config %BUILD_TYPE% --prefix "%PRUDOCT_DIR%"
IF %ERRORLEVEL% neq 0 (
    goto end
)

:end
