import 'package:flutter_test/flutter_test.dart';
import 'package:parser/graphql_parser/gq_grammar.dart';
import 'package:petitparser/petitparser.dart';

final GraphQlGrammar g = GraphQlGrammar();

void main() {
  test("Schema element  test", () {
    var parser = g.build(start: () => g.schemaElement().end());
    var result = parser.parse('''
      
      mutation: Test2
    
    ''');
    expect(result.isSuccess, true);
    expect(result.value, "mutation-Test2");
  });

  test("Schema   test", () {
    var parser = g.build(start: () => g.schemaDefinition().end());
    var result = parser.parse('''
      schema {
      mutation: Test2
   #   query: test1
    }
    ''');
    expect(result.isSuccess, true);
  });
}
