import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';

/// CLI for generating Dart models and services from OpenAPI JSON.
/// Usage:
///  dart run bin/main.dart --input api.json --output models/api
void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('input', abbr: 'i', help: 'Path to OpenAPI JSON file')
    ..addOption('output', abbr: 'o', help: 'Base name for output Dart files')
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Show usage information',
    );

  final argResults = parser.parse(arguments);

  if (argResults['help']) {
    print('OpenAPI Dart Scheme Generator - Version 1.0.1');
    print('Usage: dart run bin/scheme_gen.dart [options]');
    print(parser.usage);
    exit(0);
  }

  final inputPath = argResults['input'] as String?;
  final outputPath = argResults['output'] as String?;

  if (inputPath == null || outputPath == null) {
    print('Error: Missing required options --input and --output');
    print(parser.usage);
    exit(1);
  }

  final inputFile = File(inputPath);
  if (!inputFile.existsSync()) {
    print('Error: Input file does not exist: $inputPath');
    exit(1);
  }

  try {
    final jsonString = inputFile.readAsStringSync();
    final openApi = jsonDecode(jsonString) as Map<String, dynamic>;

    final generator = OpenApiGenerator(openApi, outputPath);
    generator.generate();
  } catch (e, stack) {
    print('Error during generation: $e');
    print(stack);
    exit(1);
  }
}

class OpenApiGenerator {
  final Map<String, dynamic> openApi;
  final String baseOutputPath;
  late final Map<String, dynamic> allSchemas;
  late final Map<String, dynamic> paths;

  OpenApiGenerator(this.openApi, this.baseOutputPath) {
    allSchemas =
        openApi['components']?['schemas'] as Map<String, dynamic>? ?? {};
    paths = openApi['paths'] as Map<String, dynamic>? ?? {};
  }

  void generate() {
    final tagToSchemas = _collectSchemasByTag();

    for (final tag in tagToSchemas.keys) {
      final schemaNames = tagToSchemas[tag]!;
      final tagSchemas = <String, dynamic>{};
      for (final name in schemaNames) {
        if (allSchemas.containsKey(name)) {
          tagSchemas[name] = allSchemas[name];
        }
      }

      final buffer = StringBuffer();
      buffer.writeln('// Generated code from OpenAPI spec');
      buffer.writeln('import \'dart:convert\';');
      buffer.writeln();

      // Generate Models
      for (final entry in tagSchemas.entries) {
        _generateModelClass(
          buffer,
          entry.key,
          entry.value as Map<String, dynamic>,
        );
      }

      final outputFileName =
          '${baseOutputPath.replaceAll('.dart', '')}_$tag.dart';
      final file = File(outputFileName);
      final directory = file.parent;
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      file.writeAsStringSync(buffer.toString());
      print('DONE: Generated $outputFileName');
    }
  }

  Map<String, Set<String>> _collectSchemasByTag() {
    final tagToSchemas = <String, Set<String>>{};

    void processSchema(dynamic schema, String tag) {
      if (schema is Map<String, dynamic>) {
        final refs = _findRefsInSchema(schema);
        for (final ref in refs) {
          tagToSchemas.putIfAbsent(tag, () => {}).add(ref);
        }
      }
    }

    for (final pathEntry in paths.entries) {
      final pathMethods = pathEntry.value as Map<String, dynamic>;
      for (final methodEntry in pathMethods.entries) {
        final methodData = methodEntry.value as Map<String, dynamic>;
        final tags = methodData['tags'] as List<dynamic>? ?? ['Default'];
        for (final tag in tags) {
          final tagStr = tag as String;

          // Request Body
          final requestBody =
              methodData['requestBody']?['content']?['application/json']?['schema'];
          if (requestBody != null) processSchema(requestBody, tagStr);

          // Responses
          final responses =
              methodData['responses'] as Map<String, dynamic>? ?? {};
          for (final response in responses.values) {
            final schema = response['content']?['application/json']?['schema'];
            if (schema != null) processSchema(schema, tagStr);
          }
        }
      }
    }

    // Recursively collect all dependent schemas for each tag
    for (final tag in tagToSchemas.keys) {
      final schemas = tagToSchemas[tag]!;
      final queue = schemas.toList();
      var i = 0;
      while (i < queue.length) {
        final currentSchemaName = queue[i++];
        final schema = allSchemas[currentSchemaName];
        if (schema is Map<String, dynamic>) {
          final deps = _findRefsInSchema(schema);
          for (final dep in deps) {
            if (schemas.add(dep)) {
              queue.add(dep);
            }
          }
        }
      }
    }

    return tagToSchemas;
  }

  Set<String> _findRefsInSchema(Map<String, dynamic> schema) {
    final refs = <String>{};
    void walk(dynamic node) {
      if (node is Map<String, dynamic>) {
        if (node.containsKey('\$ref')) {
          final ref = node['\$ref'] as String;
          if (ref.startsWith('#/components/schemas/')) {
            refs.add(ref.split('/').last);
          }
        }
        // Check properties, items, oneOf, anyOf, allOf
        node.forEach((key, value) {
          if (key != '\$ref') {
            walk(value);
          }
        });
      } else if (node is List) {
        for (final item in node) {
          walk(item);
        }
      }
    }
    walk(schema);
    return refs;
  }

  void _generateModelClass(
    StringBuffer buffer,
    String className,
    Map<String, dynamic> schema,
  ) {
    if (schema['type'] != 'object') return;

    final properties = schema['properties'] as Map<String, dynamic>? ?? {};
   

    final Map<String, bool> isNullableMap = {};
    for (final propName in properties.keys) {
      final propSchema = properties[propName] as Map<String, dynamic>;
      final propType = propSchema['type'];
      bool canBeNull = false;
      if (propType is List) {
        canBeNull = propType.contains('null');
      } else if (propSchema['nullable'] == true) {
        canBeNull = true;
      }
      isNullableMap[propName] =  canBeNull;
    }

    buffer.writeln('class $className {');

    // Fields
    for (final propName in properties.keys) {
      final propSchema = properties[propName] as Map<String, dynamic>;
      final type = _getDartType(propSchema);
      final nullable = isNullableMap[propName]! ? '?' : '';
      buffer.writeln('  final $type$nullable $propName;');
    }
    buffer.writeln();

    // Constructor
    buffer.writeln('  $className({');
    for (final propName in properties.keys) {
      buffer.writeln('    ${isNullableMap[propName]! ? '' : 'required'} this.$propName,');
    }
    buffer.writeln('  });');
    buffer.writeln();

    // FromJson
    buffer.writeln(
      '  factory $className.fromJson(Map<String, dynamic> json) => $className(',
    );
    for (final propName in properties.keys) {
      final propSchema = properties[propName] as Map<String, dynamic>;
      final isNullable = isNullableMap[propName]!;
      final fromJsonExpr = _getFromJsonExpression(
        propSchema,
        'json[\'$propName\']',
        isNullable,
        propName,
      );
      buffer.writeln('    $propName: $fromJsonExpr,');
    }
    buffer.writeln('  );');
    buffer.writeln();

    // ToJson
    buffer.writeln('  Map<String, dynamic> toJson() => {');
    for (final propName in properties.keys) {
      buffer.writeln('    \'$propName\': $propName,');
    }
    buffer.writeln('  };');

    buffer.writeln('}');
    buffer.writeln();
  }

  String _getDartType(Map<String, dynamic> schema) {
    final ref = schema['\$ref'] as String?;
    if (ref != null) {
      final name = ref.split('/').last;
      final refSchema = allSchemas[name];
      if (refSchema != null && refSchema['type'] == 'object') return name;
      return refSchema != null ? _getDartType(refSchema) : 'dynamic';
    }

    final type = schema['type'];
    if (type is List) {
      return _getTypeFromList(type, schema);
    } else {
      return _mapTypeToDart(type as String?, schema);
    }
  }

  String _getTypeFromList(List<dynamic> types, Map<String, dynamic> schema) {
    final format = schema['format'] as String?;
    if (format != null) {
      switch (format) {
        case 'int32':
          return 'int';
        case 'date-time':
          return 'DateTime';
        case 'uuid':
          return 'String';
      }
    }
    final nonNullType = types.firstWhere(
      (t) => t != 'null',
      orElse: () => 'dynamic',
    );
    return _mapTypeToDart(nonNullType as String?, schema);
  }

  String _mapTypeToDart(String? type, Map<String, dynamic> schema) {
    switch (type) {
      case 'string':
        return 'String';
      case 'integer':
        return 'int';
      case 'number':
        return 'double';
      case 'boolean':
        return 'bool';
      case 'array':
        final itemType = _getDartType(schema['items'] as Map<String, dynamic>);
        return 'List<$itemType>';
      default:
        return 'dynamic';
    }
  }

  String _getFromJsonExpression(
    Map<String, dynamic> schema,
    String access,
    bool isNullable,
    String propName,
  ) {
    final ref = schema['\$ref'] as String?;
    if (ref != null) {
      final name = ref.split('/').last;
      final refSchema = allSchemas[name];
      if (refSchema != null && refSchema['type'] == 'object') {
        final expr = '$name.fromJson($access)';
        return isNullable ? '$access != null ? $expr : null' : expr;
      }
    }

    if (schema['type'] == 'array') {
      final items = schema['items'] as Map<String, dynamic>;
      final itemRef = items['\$ref'] as String?;
      final String itemType = _getDartType(items);

      if (itemRef != null) {
        final itemName = itemRef.split('/').last;
        final itemSchema = allSchemas[itemName];
        if (itemSchema != null && itemSchema['type'] == 'object') {
          final mapExpr =
              '($access as List).map((e) => $itemName.fromJson(e)).toList()';
          return isNullable ? '$access != null ? $mapExpr : null' : mapExpr;
        }
      }

      // Handle List<String>, List<int>, etc.
      if (itemType != 'dynamic') {
        final castExpr = '($access as List).cast<$itemType>()';
        return isNullable ? '$access != null ? $castExpr : null' : castExpr;
      }

      final listExpr = 'List.from($access)';
      return isNullable ? '$access != null ? $listExpr : null' : listExpr;
    }

    return access;
  }
}
