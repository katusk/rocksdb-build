REM Parameters
REM ----------
REM Example command:
REM rocksdb-native-windows-build.bat C:\workspace\rocksdb-build release
REM %1: WORKSPACE is the root directory of this RocksDB build project, e.g.: "C:\workspace\rocksdb-build".
REM %2: ROCKSDB_CONFIG_TYPE can be "release" or "debug" without quotes, e.g.: "release".

REM Comments
REM --------
REM The shipped Windows CMake build of RocksDB is for x64 only. It builds both the static and shared library versions of RocksDB by default.
REM Please inspect the CMake options in ROCKSDB_COMMON_CMAKE_PARAMS below for set build parameters. Those options are all defined in the root CMakeLists.txt file.
REM WARN. The PORTABLE option is left OFF (default) meaning with MSVC the "/arch:AVX2" flag is passed for the build (by default).

REM Environment variables
REM ---------------------
SET WORKSPACE=%1
SET ROCKSDB_NAME=rocksdb
SET ROCKSDB_VERSION=6.0.2
SET ROCKSDB_PLATFORM_NAME=x64
SET ROCKSDB_OS_NAME=windows
SET ROCKSDB_LINKING_TYPE=static_shared
SET ROCKSDB_CONFIG_TYPE=%2
SET ROCKSDB_CONFIG_NAME=%ROCKSDB_NAME%-%ROCKSDB_VERSION%-%ROCKSDB_PLATFORM_NAME%-%ROCKSDB_OS_NAME%-%ROCKSDB_LINKING_TYPE%-%ROCKSDB_CONFIG_TYPE%
SET ROCKSDB_BUILD_ROOT=%WORKSPACE%\%ROCKSDB_NAME%-%ROCKSDB_VERSION%\CMakeBuilds\build\%ROCKSDB_CONFIG_NAME%
SET ROCKSDB_INSTALL_ROOT=%WORKSPACE%\%ROCKSDB_NAME%-%ROCKSDB_VERSION%\CMakeBuilds\install\%ROCKSDB_CONFIG_NAME%
SET ROCKSDB_COMMON_CMAKE_PARAMS=-DWITH_MD_LIBRARY=ON -DROCKSDB_INSTALL_ON_WINDOWS=ON -DWITH_TESTS=OFF -DCMAKE_INSTALL_PREFIX:PATH=%ROCKSDB_INSTALL_ROOT%
SET ROCKSDB_COMMON_BUILD_PARAMS=/p:Configuration=%ROCKSDB_CONFIG_TYPE% /p:Platform=%ROCKSDB_PLATFORM_NAME% /p:VisualStudioVersion=15.0 /m

REM Build commands
REM --------------
CD %WORKSPACE%
MKDIR %ROCKSDB_BUILD_ROOT%
MKDIR %ROCKSDB_INSTALL_ROOT%
CD %ROCKSDB_BUILD_ROOT%
cmake -G "Visual Studio 15 2017 Win64" %ROCKSDB_COMMON_CMAKE_PARAMS% %WORKSPACE%\%ROCKSDB_NAME%-%ROCKSDB_VERSION%
msbuild rocksdb.sln %ROCKSDB_COMMON_BUILD_PARAMS%
msbuild INSTALL.vcxproj %ROCKSDB_COMMON_BUILD_PARAMS%
CD %WORKSPACE%
