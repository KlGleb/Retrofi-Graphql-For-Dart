import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:parser/graphql_parser/gq_grammar.dart';
import 'package:petitparser/petitparser.dart';

final GraphQlGrammar g = GraphQlGrammar();

void main() async {
  group("bms grammar", () {
    test("bms geammar fragment dependecy", () {
      final text = File("test/schema.graphql").readAsStringSync();

      final GraphQlGrammar g = GraphQlGrammar();
      var parser = g.buildFrom(g.fullGrammar().end());
      var parsed = parser.parse(text);

      expect(parsed.isSuccess, true);
      var frag = g.fragments["userFrag"]!;
      expect(frag.dependecies.map((e) => e.fragmentName), contains("beFrag"));
      print("frag = ${frag.toString()}");
    });
  });
  group("Fragment tests", () {
    test("Fragments test", () async {
      final text = File("test/fragment/fragments.graphql").readAsStringSync();
      final GraphQlGrammar g = GraphQlGrammar();
      var parser = g.buildFrom(g.fullGrammar().end());

      var parsed = parser.parse(text);

      expect(parsed.isSuccess, true);
      expect(g.fragments.length, greaterThanOrEqualTo(4));
      g.fragments.forEach((key, value) {
        print(value);
      });
    });

    test("Fragemnt Dependecies Test", () {
      final GraphQlGrammar g = GraphQlGrammar();
      var parser = g.buildFrom(g.fullGrammar().end());

      var parsed = parser.parse(
          File("test/fragment/fragment_dependecy.graphql").readAsStringSync());
      expect(parsed.isSuccess, true);

      final frag = g.fragments["AddressFragment"]!;
      expect(frag.dependecies.map((e) => e.fragmentName),
          containsAll(["StateFragment"]));
      expect(g.fragments.length, greaterThanOrEqualTo(2));
    });
  });
}
