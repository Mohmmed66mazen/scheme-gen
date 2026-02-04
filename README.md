# OpenAPI to Dart Models

This tool turns your API (OpenAPI JSON) into Dart code automatically. No more writing models by hand!

## 🚀 How to use
Run this command in your terminal:

```bash
dart run bin/scheme_gen.dart -i api.json -o models/api.dart
```

- `-i`: Your API JSON file.
- `-o`: Where to save the generated code.

## ✨ What it does
1. **Reads your API**: Looks at your `api.json`.
2. **Groups by Tag**: If your API has "User" and "Order" sections, it makes `api_User.dart` and `api_Order.dart`.
3. **Adds Helpers**: Every class gets `fromJson` and `toJson`.
4. **Handles Nulls**: Knows when a field can be empty or is required.

## 📁 Output Example
If you use `-o lib/generated/apis.dart`, you might get:
- `lib/generated/apis_User.dart`
- `lib/generated/apis_Product.dart`

## 🛠 Setup
```bash
dart pub get
```
