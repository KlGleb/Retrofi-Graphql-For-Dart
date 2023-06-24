import 'dart:io';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:logger/logger.dart';
import 'package:retrofit_graphql/graphql_parser/gq_grammar.dart';

class RetrofitGraphqlGeneratorBuilder implements Builder {
  final BuilderOptions options;
  final logger = Logger();

  /// Glob of all input files with ".graphqls" extension
  static final inputFiles = Glob('lib/**/*.graphql');
  static final inputFiles2 = Glob('lib/**/*.graphqls');
  RetrofitGraphqlGeneratorBuilder(this.options);
  static const outputDir = 'lib/generated';

  @override
  Map<String, List<String>> get buildExtensions => {
        '.graphql': ['.gq.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    var map = {
      "ID": "String",
      "String": "String",
      "Float": "double",
      "Int": "int",
      "Boolean": "bool",
      "Null": "null"
    };
    options.config.entries
        .where((element) => element.value is String)
        .forEach((e) {
      map[e.key] = e.value as String;
    });

    var g = GQGrammar(typeMap: map);

    var parser = g.buildFrom(g.start());

    var schema = await readSchema(buildStep);
    parser.parse(schema);

    final inputs = g.generateInputs(g);
    final enums = g.generateEnums(g);
    final types = g.generateTypes(g);
    final client = g.generateClient(g);

    var dir = Directory(outputDir);
    var exists = await dir.exists();
    if (!exists) {
      await dir.create(recursive: true);
    }

    await File('$outputDir/$inputsFileName.dart').writeAsString(inputs);
    await File('$outputDir/$enumsFileName.dart').writeAsString(enums);
    await File('$outputDir/$typesFileName.dart').writeAsString(types);
    await File('$outputDir/$clientFileName.dart').writeAsString(client);
  }

  Future<String> readSchema(BuildStep buildStep) async {
    final inputAssets = await buildStep.findAssets(inputFiles).toList();
    final inputAssets2 = await buildStep.findAssets(inputFiles2).toList();
    inputAssets.addAll(inputAssets2);

    final contents = await Future.wait(
        inputAssets.map((asset) => buildStep.readAsString(asset)));
    final schema = contents.join("\n");
    return schema;
  }
}
