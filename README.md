# movie_app

see last movie and detail about you favori movie

## Getting Started

<img src="https://github.com/liodali/MovieApp/blob/main/movies.gif?raw=true" alt="Bike catalog app"><br>

## Preparation for build 
* if you want to regenerate apk or rebuild the project
 follow those steps
  
### Steps)
> add this lines in build.gradle inside app folder of android side, for environment config
```groovy
project.ext.envConfigFiles = [
        developdebug: ".env",
        developrelease: ".env",
        stagingdebug: ".env",
        stagingrelease: ".env",
        productiondebug: ".env",
        productionrelease: ".env",
]
apply from: project(':flutter_config').projectDir.getPath() + "/dotenv.gradle"

```
> the project contain generated file using build_runner, if you want to generate them
```shell
flutter pub run build_runner build
```

## Build
* I used Flutter 2.2.3
1) Android
> flutter build apk --release
2) iOS
> flutter build ios --no-codesign


##### In this project, we implement the  clean architecture
* we have 3 layer:

    * <srong>App module </string>  : This module contains all  the code related to the UI/Presentation layer such as widget,route,localization,DI  and contain viewModel
    * <srong>Core</string> : holds all concrete implementations of our repositories,UseCases and other data sources like  network,local Storage
    * <srong>Domain module </string>  : contain all interfaces of repositories  and  classes



> I used getIt as dependency injection for this project

> I used dio for http calls

> I used FlutterHook and Provider for reactive UI