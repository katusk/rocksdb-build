REM Parameters
REM ----------
REM Example command:
REM rocksdb-native-windows-pack.bat C:\workspace\rocksdb-build C:\workspace\nuget\nuget.exe
REM %1: WORKSPACE is the root directory of this RocksDB build project, e.g.: "C:\workspace\rocksdb-build".
REM %2: NUGET is the full path to a nuget executable, e.g.: "C:\workspace\nuget\nuget.exe".

REM Comments
REM --------
REM Run inside e.g. "x64 Native Tools Command Prompt for VS 2017"

REM Environment variables
REM ---------------------
SET WORKSPACE=%1
SET NUGET=%2

REM Build commands
REM --------------
CD %WORKSPACE%
RM %WORKSPACE%\rocksdb-6.0.2.zip
RMDIR /S /Q %WORKSPACE%\rocksdb-6.0.2
POWERSHELL -Command "Invoke-WebRequest https://github.com/facebook/rocksdb/archive/v6.0.2.zip -OutFile %WORKSPACE%\rocksdb-6.0.2.zip"
POWERSHELL -Command "Expand-Archive rocksdb-6.0.2.zip -DestinationPath %WORKSPACE%"
CALL %WORKSPACE%\rocksdb-native-windows-build.bat %WORKSPACE% release
CALL %WORKSPACE%\rocksdb-native-windows-build.bat %WORKSPACE% debug
CD %WORKSPACE%
%NUGET% pack %WORKSPACE%\rocksdb-native-windows-static.nuspec
CD %WORKSPACE%
