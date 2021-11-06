@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
REM ======================================================================
REM Setup
REM ======================================================================

REM Set the version of Eclipse CDT you are using.
REM Eclipse versions: 2020-03 (4.15), 2019-12 (4.14), 2019-09 (4.13), 2019-06 (4.12), 2019-03 (4.11), 2018-12 (4.10), 2018-09 (4.9), Photon (4.8), Oxygen (4.7), Neon (4.6), Mars (4.5)
set eclipseCdtVersion=4.15
REM Set the current directory as the 'original' directory.
set originalDir=%cd%
REM Log level - Possible values <ERROR|WARNING|NOTICE|STATUS|VERBOSE|DEBUG|TRACE>
set "logLevel=DEBUG"
REM Address model - Comma separated list with possible values <32|64>, e.g. "32,64"
set "addressModel=32,64"
REM Processor Architecture - Comma separated list with possible values <x86|ARM>, e.g. "x86,ARM"
set "targetProcessorArchitecture=x86"
REM Build types - Comma separated list with possible values <None|Debug|Release|RelWithDebInfo|MinSizeRel>, e.g. "Debug,Release,RelWithDebInfo"
set "buildTypes=Debug"
REM Set the build folder
set "buildFolder=../build/eclipse_win"

REM ----------------------------------------------------------------------
REM Generate arguments for CMAKE using the set values from the previous
REM section.
REM ----------------------------------------------------------------------
if defined logLevel (
	REM Generate the log level argument.
	set "cmakeLogLevel=--loglevel=%logLevel%"
)

REM ======================================================================
REM Create a project for Eclipse CDT
REM ======================================================================

REM Inform the user
echo ===========================================================================================
echo Building project(s) for Eclipse CDT version %eclipseCdtVersion%
echo ===========================================================================================

REM Go into the source folder.
cd ../../sources

REM Create Eclipse CDT projects for different address models, target processors and build types.
for %%a in ("%addressModel:,=" "%") do (
	set "iteratedAddressModel=%%~a"
	REM Set the correct toolchain file.
	set "cmakeToolchainFile=-DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/windows/mingw!iteratedAddressModel!.toolchain"
	
	for %%p in ("%targetProcessorArchitecture:,=" "%") do (
		set "iteratedTargetProcessorArchitecture=%%~p"	
		
		REM Create the target architecture and model identifier.
		if !iteratedTargetProcessorArchitecture! == x86 (
			if !iteratedAddressModel! == 32 (
				set "targetArchitectureAndModel=x86"
			) else (
				set "targetArchitectureAndModel=amd64"
			)
		) else (
			if !iteratedAddressModel! == 32 (
				set "targetArchitectureAndModel=arm"
			) else (
				set "targetArchitectureAndModel=arm64"
			)
		)
	
		for %%b in ("%buildTypes:,=" "%") do (
			set "iteratedBuildType=%%~b"
			echo Building '!iteratedBuildType!' project for a !iteratedAddressModel!bit '!iteratedTargetProcessorArchitecture!' processor.
			echo -------------------------------------------------------------------------------------------
			
			REM Generate the build type argument.
			set "cmakeBuildType=-DCMAKE_BUILD_TYPE=!iteratedBuildType!"
			REM Append subfolder.
			set "buildFolder=%buildFolder%_!iteratedBuildType!/!targetArchitectureAndModel!"
			
			cmake -B!buildFolder! -G"Eclipse CDT4 - MinGW Makefiles" -D_ECLIPSE_VERSION=%eclipseCdtVersion% !cmakeToolchainFile! %cmakeLogLevel% !cmakeBuildType!
			
			REM Inform the user
			echo -------------------------------------------------------------------------------------------
			echo Done building. Import the Eclipse project from the subfolder "!buildFolder!"!
			echo -------------------------------------------------------------------------------------------
		)
	)
)
REM Return to the original folder.
echo Returning to original directory.
cd "%originalDir%"

REM Wait 5 seconds
REM timeout 5
PAUSE
