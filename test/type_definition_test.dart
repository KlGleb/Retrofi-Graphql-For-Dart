import 'package:flutter_test/flutter_test.dart';
import 'package:parser/graphql_parser/gq_grammar.dart';
import 'package:petitparser/petitparser.dart';

void main() {
  test("Type test", () {
    final GraphQlGrammar g = GraphQlGrammar();

    var parser = g.buildFrom(g.typeDefinition().end());
    var result = parser.parse('''
      type Test2 implements Test {
        name: String!
        test: Boolean
        next: Test2
      }
    ''');
    expect(result.isSuccess, true);

    result = parser.parse('''
      type Test3  {
        name: String!
        test: Boolean
        next: Test3
      }
    ''');
    expect(result.isSuccess, true);

    result = parser.parse('''
      type Test4 @test(if: true) {
        name: String!
        test(test: Int!): [Boolean!]!
        next: [Test4!]
      }
    ''');
    expect(result.isSuccess, true);
  });

  test("Type test with arguments", () {
    final GraphQlGrammar g = GraphQlGrammar();

    var parser = g.buildFrom(g.typeDefinition().end());
    var result = parser.parse('''
      type Test2 implements Test {
        name(test: String!): String!
        test: Boolean
        next: Test2
      }
    ''');
    expect(result.isSuccess, true);
  });
}
