#! cmd //c
rem This batch file will start from either cmd.exe or MSYS bash/sh shell.
rem Windows OS doesn't understand what #! means so a helper file named #!.exe
rem exists in the bin directory with this script.  The program actually just
rem exits with 0 status.
@echo off

if "x%1" EQU "x" goto _USAGE
if /I "%1" EQU "ON" goto _ON
if /I "%1" EQU "OFF" goto _OFF
goto _USAGE

:_ON
@echo on
rem install the release candidate options
mingw-get install mingw32-wsl_rc
rem install the test meta package
mingw-get install mingw32-wsl_rc-test-on
rem remove the meta package from mingw-get database
mingw-get remove mingw32-wsl_rc-test-on
rem upgrade to the release candidate of the runtime and w32api packages.
mingw-get upgrade mingw32-mingwrt mingw32-w32api
@echo off
goto _END
:_OFF
@echo on
rem make sure that the doc and lic files are removed
mingw-get remove mingw32-mingwrt-doc mingw32-mingwrt-lic
mingw-get remove mingw32-w32api-doc mingw32-w32api-lic
rem install the meta package to revert to production mode
mingw-get install mingw32-wsl_rc-test-off
rem remove the meta pacakge from the mingw-get database
mingw-get remove mingw32-wsl_rc-test-off
rem remove the release candidate options
mingw-get remove mingw32-wsl_rc
@echo off
goto _END
:_USAGE
echo "test-wsl-rc.bat [on|off]"
goto _END
:_END
@echo on
