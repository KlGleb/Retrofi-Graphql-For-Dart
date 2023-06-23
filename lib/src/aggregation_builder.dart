import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:parser/graphql_parser/gq_grammar.dart';
import 'package:petitparser/petitparser.dart';

class AggregatingBuilder implements Builder {
  final BuilderOptions options;

  /// Glob of all input files with ".graphqls" extension
  static final inputFiles = Glob('lib/**/*.graphql');

  AggregatingBuilder(this.options);

  @override
  Map<String, List<String>> get buildExtensions {
    // '$lib$' is a synthetic input that is used to
    // force the builder to build only once.
    return const {
      '\$lib\$': ['all_files.merged.graphql']
    };
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    String path = options.config["path"] ?? "./lib/generated";

    final files = <String>[];
    await for (final input in buildStep.findAssets(inputFiles)) {
      var contents = await buildStep.readAsString(input);
      files.add(contents);
    }
    String fileContent = files.join('\n');

    final GraphQlGrammar g = GraphQlGrammar();
    var parser = g.buildFrom(g.fullGrammar().end());
    parser.parse(fileContent);
    g.saveToFiles(g, path);

    final outputFile =
        AssetId(buildStep.inputId.package, 'lib/all_files.merged.graphql');
    return buildStep.writeAsString(outputFile, fileContent);
  }
}