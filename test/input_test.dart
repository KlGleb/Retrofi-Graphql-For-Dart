import 'package:test/test.dart';
import 'package:retrofit_graphql/graphql_parser/gq_grammar.dart';
import 'package:petitparser/petitparser.dart';

void main() {
  test("Input  test", () {
    final GQGrammar g = GQGrammar();

    var parser = g.buildFrom(g.inputDefinition().end());
    var result = parser.parse('''
      input Test {
        "Sample documentation"
        test: boolean! = true
        """
        Block Documentation
        """
        test2: Int
      }
    ''');
    expect(result.isSuccess, true);

    // print((result.value as GraphqlTypeDefinition).toDart());

    result = parser.parse('''
      input Test2 @skip(if: true){
        test: boolean! = true @test(if: true) @test(if: true)
        object: User! = {
          firstName: "Oualitsen"
          lastName: "Ramdane"
        }
      }
    ''');
    expect(result.isSuccess, true);
  });

  test("Field test with init", () {
    final GQGrammar g = GQGrammar();

    var parser = g.buildFrom(
        g.field(canBeInitialized: true, acceptsArguments: false).end());
    var result = parser.parse('''
      fieldName: String! = "Azul fellawen" @skip(if: true)
    ''');
    expect(result.isSuccess, true);
    expect(result.value.type.nullable, false);
  });

  test("Field test without init", () {
    final GQGrammar g = GQGrammar();

    var parser = g.buildFrom(
        g.field(canBeInitialized: false, acceptsArguments: false).end());
    var result = parser.parse('''
      fieldName: String! = "Azul fellawen" @skip(if: true)
    ''');

    result = parser.parse('''
      fieldName: String!  @skip(if: true)
    ''');
    expect(result.isSuccess, true);
  });
}
