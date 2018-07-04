# Sudo.bat For Windows (UAC Method)

- Put this file in any folder that is in your %PATH%
- Can be used to open many types of URLs and files.
- Leverages "User Account Control" ( UAC )
- Cleans up after itself.

# Examples:

- To open admin command prompt:

  sudo.bat

- To open hosts file for editing:

  sudo.bat c:\windows\system32\drivers\etc\hosts

- To delete a file:

  sudo.bat del /Q "c:\some\folder\some-file.txt"

- To copy a file:

  sudo.bat copy /y "c:\from\folder\from-file.txt" "c:\to\folder\"

- Or
 
  sudo.bat copy /y "c:\from\folder\from-file.txt" "c:\to\folder\to-file.txt"

- To force window to stay open after command, give /k as first argument:

  sudo.bat /k dir

- Or

  sudo.bat /k C:\Utils\Git\bin\bash.exe

# Sudo.bat

```
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
:: - To copy a file:
::
::   sudo.bat copy /y "c:\from\folder\from-file.txt" "c:\to\folder\"
::
:: - To copy a file:
::
::   sudo.bat copy /y "c:\from\folder\from-file.txt" "c:\to\folder\to-file.txt"
::
:: - To force window to stay open after command, give /k as first argument:
::
::   sudo.bat /k dir
::
:: - To force window to stay open after command, give /k as first argument:
::
::   sudo.bat /k C:\Utils\Git\bin\bash.exe
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO OFF
SET    SETTING_KEEP_TEMP_FILES=
SET    SETTING_GET_TIME_STAMP_COMMAND=ECHO %RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%
unixdate.exe 1>NUL 2>NUL && SET SETTING_GET_TIME_STAMP_COMMAND=unixdate.exe +%%Y-%%m-%%d_%%H-%%M-%%S-%%N
SET    TIME_STAMP=
FOR /F "delims=" %%i in ('%SETTING_GET_TIME_STAMP_COMMAND%') do SET TIME_STAMP=%%i
IF NOT DEFINED TIME_STAMP SET TIME_STAMP=%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%
SET TEMPFILE1=%TEMP%\sudo.%TIME_STAMP%.bat
SET    ARGS=
SET    ARG=
SET    ARGTMP=
SET    SLASHARGS=
:GET_ARGS_LOOP
SET    ARG=%1
SET    ARGTMP=%~1
SHIFT
IF NOT DEFINED ARG GOTO :GET_ARGS_AFTER
IF NOT DEFINED ARGS  IF "%ARGTMP:~0,1%" == "/" SET SLASHARGS=%SLASHARGS% %ARGTMP%
IF NOT DEFINED ARGS  IF "%ARGTMP:~0,1%" == "/" GOTO :GET_ARGS_LOOP
SET    ARGS=%ARGS% %ARG%
GOTO :GET_ARGS_LOOP
:GET_ARGS_AFTER
IF     DEFINED ARGS  SET ARGS=%ARGS:~1%
IF     DEFINED ARGS  IF NOT DEFINED SLASHARGS ( ECHO START "Sudo Command Prompt" /D "%CD%" %ARGS% ^^^&^^^& exit ^^^|^^^| exit 1>"%TEMPFILE1%" )
IF     DEFINED ARGS  IF     DEFINED SLASHARGS ( ECHO START "Sudo Command Prompt" /D "%CD%" cmd.exe %SLASHARGS% %ARGS%>"%TEMPFILE1%" )
IF NOT DEFINED ARGS  ( ECHO START "Sudo Command Prompt" /D "%CD%" cmd.exe>"%TEMPFILE1%" )
ECHO IF "%%ERRORLEVEL%%" == "1" START "Sudo Command Prompt" /D "%CD%" cmd.exe /C %ARGS%>>"%TEMPFILE1%"
IF NOT DEFINED SETTING_KEEP_TEMP_FILES ( ECHO DEL /Q "%TEMPFILE1%">>"%TEMPFILE1%" )
ECHO EXIT>>"%TEMPFILE1%"
ECHO #### %%TEMPFILE1%% = "%TEMPFILE1%">&2
TYPE "%TEMPFILE1%">&2
ECHO powershell.exe -Command "Start-Process \"%TEMPFILE1%\" -Verb RunAs">&2
powershell.exe -Command "Start-Process \"%TEMPFILE1%\" -Verb RunAs" || ( ECHO powershell.exe not found?>&2 )
```
