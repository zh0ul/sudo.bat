# Sudo.bat For Windows (UAC Method)

- Put this file in any folder that is in your %PATH%
- Can be used to open many types of URLs and files.

# Examples:

# To open hosts file for editing:

   sudo c:\windows\system32\drivers\etc\hosts

# To open command prompt:

   sudo cmd

# Sudo.bat

```
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::                       Sudo For Windows (UAC Method)
::
:: - Put this file in any folder that is in your %PATH%
:: - Can be used to open many types of URLs and files.
:: - Examples:
::
::   To open hosts file for editing:
::
::     sudo c:\windows\system32\drivers\etc\hosts
::
::   To open command prompt:
::
::     sudo cmd
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO OFF
SET  ARGS=
SET  ARG=
:GET_ARGS_LOOP
SET  ARG=%~1
IF   NOT DEFINED ARG GOTO :GET_ARGS_AFTER
SET  ARGS=%ARGS% "%ARG%"
SHIFT
GOTO :GET_ARGS_LOOP
:GET_ARGS_AFTER
IF   NOT DEFINED ARGS  SET ARGS=cmd.exe
SET  TEMPFILE=%TEMP%\sudo.%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%.bat
ECHO ^%%TEMPFILE^%% = %TEMPFILE%
ECHO PUSHD %CD%>"%TEMPFILE%"
ECHO START "Sudo Command Prompt" /D "%CD%"  %ARGS%>>"%TEMPFILE%"
ECHO DEL /Q "%TEMPFILE%">>"%TEMPFILE%"
TYPE "%TEMPFILE%"
powershell.exe -Command "Start-Process %TEMPFILE% -Verb RunAs"
```
