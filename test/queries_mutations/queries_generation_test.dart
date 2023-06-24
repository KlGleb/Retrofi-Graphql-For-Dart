import 'dart:io';

import 'package:test/test.dart';
import 'package:retrofit_graphql/graphql_parser/gq_grammar.dart';
import 'package:petitparser/petitparser.dart';

void main() async {
  test("Input transformation", () {
    final GQGrammar g = GQGrammar();

    var parser = g.buildFrom(g.fullGrammar().end());

    final text =
        File("test/queries_mutations/schema.graphql").readAsStringSync();
    var parsed = parser.parse(text);
    expect(parsed.isSuccess, true);
    expect(g.inputs.length, greaterThanOrEqualTo(1));
  });
}
