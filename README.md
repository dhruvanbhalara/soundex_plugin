
# Soundex Flutter Plugin

This plugin provides a simple and efficient way to encode strings based on their pronunciation, facilitating features like search and data matching in Flutter applications.

## Features

- **Soundex Encoding**: Convert any string into its Soundex code.
- **Search Functionality**: Example app demonstrating how to use Soundex encoding to filter a list of names based on phonetic similarity.

## Getting Started

To use this plugin in your Flutter app, follow these steps:

### Installation

Add `soundex_flutter` to your `pubspec.yaml` file:

```yaml
dependencies:
  soundex_flutter: ^1.0.0
```

Run `flutter pub get` to install the new dependency.

### Usage

Import `soundex_flutter` in your Dart code:

```dart
import 'package:soundex_flutter/soundex_flutter.dart';
```

#### Encoding a String

To encode a string using the Soundex algorithm:

```dart
String name = "Robert";
String encoded = SoundexPlugin.encode(name);
print("Encoded Soundex: $encoded"); // Output: R163
```

#### Implementing a Search Filter

You can use the Soundex encoding to filter names phonetically in a search implementation:

```dart
List<String> names = ['Robert', 'Rupert', 'Rubin'];
String searchQuery = "Rupert";
String encodedSearch = SoundexPlugin.encode(searchQuery);

List<String> filteredNames = names.where((name) {
  return SoundexPlugin.encode(name).startsWith(encodedSearch);
}).toList();

print(filteredNames); // Output: ['Robert', 'Rupert']
```

## Example App

The plugin includes an example Flutter application demonstrating how to use the Soundex encoding in a search feature. To run the example app:

1. Clone the repo.
2. Navigate to the `example` directory.
3. Run `flutter run` in the terminal.

## Contributing

Contributions to `soundex_flutter` are welcome. Please consider submitting a pull request if you have ideas on how to improve the library or extend its functionality.

## License

This plugin is provided under the MIT License. See the LICENSE file in the root directory for the full license text.

## Support

If you have any issues or feature requests, please file an issue on the plugin's GitHub repository. Your feedback is appreciated!


