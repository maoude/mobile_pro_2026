// =====================================================================
// Week 2 - Slide 16: Generics and Dart literals
// =====================================================================
// WHAT YOU LEARN
//   * [ ] is a list literal and { } is a map (or set) literal.
//   * Generics state the type of the contents:
//         <String>[ ... ]            a list of Strings
//         <String, String>{ ... }    a map with String keys and values
//   * Then Dart checks every item and refuses the wrong type.
//
// HOW TO RUN
//   dart run 12_generics_and_literals.dart
//
// EXPECTED OUTPUT
//   List: [Hulk, Captain America]
//   Map: {Captain America: I can do this all day!, Spider Man: Am I an Avenger?, Hulk: Smaaaaaash!}
// =====================================================================

void main() {
  // <String> before [ ] : every item must be a String.
  var avengerNames = <String>['Hulk', 'Captain America'];

  // <String, String> before { } : keys and values must both be Strings.
  var avengerQuotes = <String, String>{
    'Captain America': 'I can do this all day!',
    'Spider Man': 'Am I an Avenger?',
    'Hulk': 'Smaaaaaash!',
  };

  print('List: $avengerNames');
  print('Map: $avengerQuotes');

  // The types protect you. This line would NOT compile, because 5 is not
  // a String:
  // avengerNames.add(5);
}
