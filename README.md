# Building RocksDB Native Nuget Packages

This repository contains a few simple script files that fetch a specific (currently hardwired) RocksDB source release and build NuGet packages based on that. We are currently building for Windows only. The RocksDB project can be found at:
* [https://rocksdb.org/](https://rocksdb.org/)

NuGet packages are based on specific versions of the RocksDB source code found at:
* [https://github.com/facebook/rocksdb/releases](https://github.com/facebook/rocksdb/releases)

## On Windows 10
You are going to need either the Visual Studio Build Tools or a Visual Studio installation with CMake support, and the [NuGet CLI](https://docs.microsoft.com/en-us/nuget/install-nuget-client-tools#nugetexe-cli). Then you can run e.g. inside a `x64 Native Tools Command Prompt for VS 2017` the following commands for example:

```bat
SET WORKSPACE=C:\workspace\rocksdb-build
SET NUGET=C:\workspace\nuget\nuget.exe
CD %WORKSPACE%
rocksdb-native-windows-pack.bat %WORKSPACE% %NUGET%
```

If everything went well your resulting `rocksdb-native-windows-static.x.y.z.nupkg` will be placed at `C:\workspace\rocksdb-build`. This specific package is intended for static linking only, i.e. no `.dll` is placed in the resulting `nupkg`. See `rocksdb-native-windows-build.bat` called by `rocksdb-native-windows-pack.bat` for more details.

### Reference
* [https://github.com/facebook/rocksdb/wiki/Building-on-Windows](https://github.com/facebook/rocksdb/wiki/Building-on-Windows)

### Releases
* https://www.nuget.org/packages/rocksdb-native-windows-static

### Linking with CMake
Just a hint. In case you are building a native C++ CMake-based project on Windows you can directly link the NuGet package after a package restore: just provide the path to the `.targets` file of the NuGet package as if it were a simple lib to the `target_link_libraries` command of CMake after providing your CMake target to link to. You can find more details of this feature available since CMake version 3.8.0 at:
* [https://gitlab.kitware.com/cmake/cmake/issues/16340](https://gitlab.kitware.com/cmake/cmake/issues/16340)
