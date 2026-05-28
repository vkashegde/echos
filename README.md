# echos

Premium offline local music player for Android and iOS.

## Features

- Local library scan (songs, albums, artists, genres, folders)
- Background playback with notification and lock screen controls
- Playlists with reorder, create, rename, delete
- Liked songs with instant persistence (Isar)
- Recently played and most played tracking
- Debounced search with categorized results
- Dynamic album-art theming (palette_generator)
- Spotify-inspired dark UI with glass mini player and cinematic now playing

## Stack

- Flutter · flutter_bloc (Cubit) · go_router
- just_audio · audio_service · audio_session
- on_audio_query · Isar · palette_generator · flutter_animate

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Grant audio/storage permissions on first launch so the library can scan device audio.

## Architecture

Feature-first clean architecture under `lib/`:

- `core/` — theme, services, widgets, utils
- `features/` — player, library, playlists, search, favorites, settings
- `routes/` — go_router configuration
