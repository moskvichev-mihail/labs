@ECHO OFF

cd ..\..\src\BookLibrary.Web
dotnet ef database update || goto handle_error
exit /B 0

GOTO handle_error

:handle_error
EXIT /B %ERRORLEVEL%