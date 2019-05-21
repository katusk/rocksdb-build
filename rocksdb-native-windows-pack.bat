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
powershell -Command "Invoke-WebRequest https://github.com/facebook/rocksdb/archive/v6.0.2.zip -OutFile rocksdb-6.0.2.zip"
powershell -Command "Expand-Archive rocksdb-6.0.2.zip -DestinationPath ."
rocksdb-native-windows-build.bat %WORKSPACE% release
rocksdb-native-windows-build.bat %WORKSPACE% debug
%NUGET% pack rocksdb-native-windows-static.nuspec
CD %WORKSPACE%
