# Building RocksDB Native Nuget Packages

This repository contains a few simple script files that fetch a specific (currently hardwired) RocksDB source release and build NuGet packages based on that. We are currently building for Windows only. The RocksDB project can be found at:
* [https://rocksdb.org/](https://rocksdb.org/)

## On Windows 10
You are going to need either the Visual Studio Build Tools or a Visual Studio installation with CMake support, and the NuGet CLI. Then you can run e.g. inside a x64 Native Tools Command Prompt for VS 2017 the following commands for example:

```bat
SET WORKSPACE=C:\workspace\rocksdb-build
SET NUGET=C:\workspace\nuget\nuget.exe
CD %WORKSPACE%
rocksdb-native-windows-pack.bat %WORKSPACE% %NUGET%
```

If everything went well your resulting `rocksdb-native-windows-static.x.y.z.nupkg` will be placed at `C:\workspace\rocksdb-build`. This specific package is intended for static linking only, i.e. no dll is placed in the resulting `nupkg`. See `rocksdb-native-windows-build.bat` called by `rocksdb-native-windows-pack.bat` for more details.
