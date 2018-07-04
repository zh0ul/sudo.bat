::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::                       Sudo For Windows (UAC Method)
::
:: - Put this file in any folder that is in your %PATH%
:: - Can be used to open many types of URLs and files.
:: - Leverages "User Account Control" ( UAC )
:: - Cleans up after itself.
::
:: - Examples:
::
:: - To open admin command prompt:
::
::   sudo.bat
::
:: - To open hosts file for editing:
::
::   sudo.bat c:\windows\system32\drivers\etc\hosts
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO OFF
SET  ARGS=
SET  ARG=
:GET_ARGS_LOOP
SET  ARG=%1
IF   NOT DEFINED ARG GOTO :GET_ARGS_AFTER
SET  ARGS=%ARGS% %ARG%
SHIFT
GOTO :GET_ARGS_LOOP
:GET_ARGS_AFTER
IF       DEFINED ARGS  SET ARGS=%ARGS:~1%
IF   NOT DEFINED ARGS  SET ARGS=cmd.exe
SET  TEMPFILE1=%TEMP%\sudo.%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%.bat
ECHO PUSHD %CD%>"%TEMPFILE1%"
ECHO START "Sudo Command Prompt" /D "%CD%" cmd.exe /c %ARGS%>>"%TEMPFILE1%"
ECHO DEL /Q "%TEMPFILE1%">>"%TEMPFILE1%"
ECHO #### ^%%TEMPFILE1^%% = %TEMPFILE1%
TYPE "%TEMPFILE1%"
powershell.exe -Command "Start-Process \"%TEMPFILE1%\" -Verb RunAs"
