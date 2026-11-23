# News App

A Flutter news reader built on the [NewsAPI](https://newsapi.org). Read top headlines by news channel, browse news by category and open full article details.

## Features

- Splash screen
- Top headlines with a news channel filter (BBC News, and other sources)
- Category screen (general, business, sports, technology and more)
- Article details with image, source, date and description
- Cached network images and loading spinners
- MVVM structure: repository → view model → view

## Tech stack

Flutter · Dart · http · cached_network_image · intl · flutter_spinkit · Google Fonts

## Project structure

```
lib/
  repository/   NewsAPI calls
  view_model/   news view model
  models/       headline and category response models
  view/         splash, home, categories and details screens
```

## Getting started

1. Get a free API key from [newsapi.org](https://newsapi.org).
2. Put your key in `lib/repository/news_repository.dart`.
3. Run:

```bash
flutter pub get
flutter run
```

## License

Released under the [MIT License](LICENSE).
