# flame_cache_issue

A minimal project to reproduce a bug with audio cache in flame games using sound effects

## The Problem

I have a game using FlameEngine deployed on my web server and found that far too many mp3 files were fetched. Further testing revealed that Safari fetches the mp3 file from the server each time a sound effect is played. Chrome does not show this behavior. 

More testing revealed that after a refresh of the web page in the browser, no more mp3 files are fetched. It seems that after the refresh, they are read from the cache.
When I clear the cache in Safari, the problem occurs again.

So with a fresh load, the user may be wasting a lot of traffic depending on how many sound effects are played.

I made this minimal project that can be cloned and run to reproduce this behavior.

Each tap on the square plays the sound file pha.mp3

## How to reproduce
``` 
git clone https://github.com/schilken/flame_cache_issue
cd flame_cache_issue
flutter pub get
flutter build web
cd build/web
python -m http.server 8000
```

## Running in Chrome

The file pha.mp3 is read only once.

``` 
➜  web python -m http.server 8000
Serving HTTP on :: port 8000 (http://[::]:8000/) ...
::1 - - [27/Jan/2023 13:54:46] "GET / HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /flutter.js HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /manifest.json HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /flutter_service_worker.js?v=931905632 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /icons/Icon-192.png HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /main.dart.js HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /index.html HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /assets/AssetManifest.json HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /favicon.png HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:46] "GET /assets/FontManifest.json HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:47] "GET /assets/fonts/MaterialIcons-Regular.otf HTTP/1.1" 200 -
::1 - - [27/Jan/2023 13:54:47] "GET /assets/assets/audio/pha.mp3 HTTP/1.1" 200 -
```

## Running in Safari

On the first load, the file pha.mp3 is read for each tap.
After a refresh in the browser (GET / and GET /flutter_service_worker.js) no more mp3 are fetched.

``` 
 web python -m http.server 8008
Serving HTTP on :: port 8008 (http://[::]:8008/) ...
::1 - - [27/Jan/2023 14:55:33] "GET / HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /manifest.json HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /flutter.js HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /flutter_service_worker.js?v=3068556246 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /favicon.png HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /index.html HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /main.dart.js HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /assets/FontManifest.json HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /assets/AssetManifest.json HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /assets/fonts/MaterialIcons-Regular.otf HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:34] "GET /assets/assets/audio/pha.mp3 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:56] "GET /assets/assets/audio/pha.mp3 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:57] "GET /assets/assets/audio/pha.mp3 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:58] "GET /assets/assets/audio/pha.mp3 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:59] "GET /assets/assets/audio/pha.mp3 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:55:59] "GET /assets/assets/audio/pha.mp3 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:56:19] "GET / HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:56:20] "GET /flutter_service_worker.js?v=3068556246 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:56:20] "GET /assets/assets/audio/pha.mp3 HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:59:14] "GET / HTTP/1.1" 200 -
::1 - - [27/Jan/2023 14:59:15] "GET /flutter_service_worker.js?v=3068556246 HTTP/1.1" 200 -
```
