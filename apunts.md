# Apunts Flutter

A continuació es troben alguns apunts sobre el desenvolupament amb Flutter. Igual que vosaltres, encara no entinc gaire
idea, aixi que pot ser que el que posi no sigui cert o ho sigui parcialment.

## Recomanacions

- Abans de fer qualsevol cosa, documenteu-vos
- Fer el [tutorial de la primera app de flutter](https://docs.flutter.dev/get-started/codelab), és ràpid i ens permet
  veure com funciona el framework.

## Basics

- `main` és la funció principal de l'aplicació. Aquesta funció s'executa quan s'inicia l'aplicació.
- `runApp` és un mètode que inicia l'aplicació.
- `print` és una funció que mostra un missatge a la consola.
- `setState` és un mètode que actualitza l'estat d'un `StatefulWidget`.
- `Future` és un objecte que conté informació sobre una tasca que es pot executar en segon pla.
- `async` és una paraula clau que indica que una funció s'executa en un altre thread.
- `await` és una paraula clau que indica que una funció s'executa en un altre thread i espera a que acabi per continuar.

## Widgets

Un widget és una classe que hereta de `StatelessWidget` o `StatefulWidget`. Els widgets són els elements que es mostren
a la pantalla. Els widgets es poden empaquetar en altres widgets, i així es poden crear aplicacions complexes.

- `StatelessWidget` és un widget que no té estat. El seu contingut no canvia. Exemple: `Text`.
- `StatefulWidget` és un widget que té estat. El seu contingut pot canviar. Exemple: `Checkbox`.
- `State` és la classe que conté l'estat d'un `StatefulWidget`. Els widgets `StatelessWidget` no tenen estat, per tant
  no tenen classe `State`.
- `BuildContext` és un objecte que conté informació sobre el context en el que es troba un widget. Per exemple,
  el `BuildContext` d'un `Text` conté informació sobre el `Text` i el `BuildContext` del seu pare.

## Material

- `MaterialApp` és un widget que conté la informació de l'aplicació. Per exemple, el nom de l'aplicació, el tema, etc.
- `Scaffold` és un widget que conté la informació de la pantalla. Per exemple, el títol de la pantalla, el botó de
  tornar enrere, etc.
- `AppBar` és un widget que conté la informació de la barra superior de la pantalla. Per exemple, el títol de la
  pantalla, el botó de tornar enrere, etc.
- `Text` és un widget que mostra text a la pantalla.
- `Center` és un widget que centra el seu fill.
- `Column` és un widget que mostra els fills en columnes.
- `Row` és un widget que mostra els fills en files.
- `Expanded` és un widget que expandeix el seu fill per omplir tot l'espai disponible.
- `Container` és un widget que conté un altre widget.
- `Padding` és un widget que afegeix un espai entre el seu fill i el seu pare.
- `RaisedButton` és un widget que mostra un botó amb un fons.
- `FlatButton` és un widget que mostra un botó sense fons.
- `IconButton` és un widget que mostra un botó amb una icona.
- `Icon` és un widget que mostra una icona.
- `Image` és un widget que mostra una imatge.
- `TextField` és un widget que mostra un camp de text.

## Estils

Els estils són objectes que contenen informació sobre com es mostra un widget. Per exemple, el color de fons
d'un `Container`, el color del text d'un `Text`, etc.

- `ThemeData` és un estil que conté informació sobre el tema de l'aplicació. Per exemple, el color de fons de la
  pantalla, el color del text, etc. Aquest estil global el podem trobar a theme/style.dart.
- Podem crear nous estils concrets fent nous fitxers dins de la carpeta theme

## Rutes

Les rutes són objectes que contenen informació sobre una pantalla. Per exemple, el nom de la pantalla, el widget que la
conté, etc.

- `MaterialPageRoute` és una ruta que conté informació sobre una pantalla. Per exemple, el nom de la pantalla, el widget
  que la conté, etc.
- `Navigator` és un widget que conté les rutes de l'aplicació. Per exemple, la ruta actual, la ruta anterior, etc.
- `Navigator.push` és un mètode que afegeix una nova ruta a la pila de rutes.
- `Navigator.pop` és un mètode que treu la ruta actual de la pila de rutes.

## Serveis

Per a comunicar-nos amb el servidor, utilitzarem la llibreria `http` de Dart. Per a utilitzar-la, cal importar-la a
l'inici del fitxer:

```dart
import 'package:http/http.dart' as http;
```

- Per a fer una petició GET, utilitzarem la funció `get` de la llibreria `http`:

```dart
http.get(url);
```

- Per a fer una petició POST, utilitzarem la funció `post` de la llibreria `http`:

```dart
http.post(url, body: body);
```

- Per a fer una petició PUT, utilitzarem la funció `put` de la llibreria `http`:

```dart
http.put(url, body: body);
```

- Per a fer una petició DELETE, utilitzarem la funció `delete` de la llibreria `http`:

```dart
http.delete(url);
```

- Per a obtenir la resposta de la petició, utilitzarem la funció `then` de la resposta:

```dart
http.get(url).
then
((response) {
int statusCode = response.statusCode;
String body = response.body;

//Per a obtenir la resposta en format JSON, utilitzarem la funció `jsonDecode` de la llibreria `convert`:
Map<String, dynamic> json = jsonDecode(body);
});
```

## Internacionalització

S'ha canviat la [llibreria d'internacionalització](https://pub.dev/packages/easy_localization) degut a que la nativa de
flutter es una merda.
\nA continuació es detallen els canvis a realitzar per a que funcioni correctament.

### Afegir nova traducció (frase)

Per afegir una nova paraula o frase, cal afegir-la als fitxers de la carpeta `langs`. Per exemple, per afegir la
paraula "Hola", cal afegir la següent linia al fitxer `langs/es_ES.json`:

```json
  "hello": "Hola"
```

i caldria fer el mateix en els altres dos fitxers.
> Recordeu que cal fer les keys en anglès.

### Afegir nova traducció amb paràmetres

Per afegir una nova paraula o frase amb paràmetres, cal afegir-la als fitxers de la carpeta `langs`. Per exemple, per
afegir la
paraula "Hola, {name}", cal afegir la següent linia al fitxer `langs/es_ES.json`:

```json
  "hello": "Hola, {name}"
```

i caldria fer el mateix en els altres dos fitxers.

També podem fer que la paraula o frase tingui un valor o altre depenent d'un paràmetre. Per exemple:

```json
  "gender":{
"male": "Hi man ;) {}",
"female": "Hello girl :) {}",
"other": "Hello {}"
}
```

> També es poden fer coses més complexes (com pluralització, utilitzar unitats numèriques, reaprofitar altres
> traduccions...), però per això millor llegir
> la [documentació de la llibreria](https://pub.dev/packages/easy_localization).

### Traduir un widget

- Finalement, per a utilitzar la paraula, cal importar la
  llibreria `import 'package:easy_localization/easy_localization.dart';` i posteriorment traduir allò que volem:

```dart
import 'package:easy_localization/easy_localization.dart';

Text
('title').tr() //Text widget
print('title'.tr()); //String
var title = tr('title') //Static function
```

i si passem paràmetres, el podem especificar de la següent manera:

```dart
// args
Text('msg').tr(args: ['Easy localization', 'Dart']),
// namedArgs
Text('msg_named').tr(namedArgs: {'lang': 'Dart'}),
// args and namedArgs
Text('msg_mixed').tr(args: ['Easy localization'],namedArgs: {'lang': 'Dart'}),
// gender
Text('gender').tr(gender: _gender? "female":"male"),
```