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
:: - To delete a file:
::
::   sudo.bat del /Q "c:\some\folder\some-file.txt"
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO OFF
SET  TEMPFILE1=%TEMP%\sudo.%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%.bat
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
IF       DEFINED ARGS  ECHO START "Sudo Command Prompt" /D "%CD%" %ARGS% ^^^&^^^& exit ^^^|^^^| exit>"%TEMPFILE1%"
IF   NOT DEFINED ARGS  ECHO START "Sudo Command Prompt" /D "%CD%" cmd.exe>"%TEMPFILE1%"
ECHO IF "%%ERRORLEVEL%%" == "1" START "Sudo Command Prompt" /D "%CD%" cmd.exe /C %ARGS%>>"%TEMPFILE1%"
ECHO EXIT>>"%TEMPFILE1%"
ECHO DEL /Q "%TEMPFILE1%">>"%TEMPFILE1%"
ECHO #### %%TEMPFILE1%% = %TEMPFILE1%
TYPE "%TEMPFILE1%"
powershell.exe -Command "Start-Process \"%TEMPFILE1%\" -Verb RunAs"
