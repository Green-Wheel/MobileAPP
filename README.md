# GreenWheel MobileApp

Projecte per a l'assignatura PES de la Facultat d'Informàtica de Barcelona (FIB) de la Universitat Politècnica de
Catalunya (UPC).
<br/>**Quatrimestre:** Tardor curs 2022/2023.
<br/>**Temàtica:** MOBILITAT SOSTENIBLE: fomentar l'ús de vehicles elèctrics (punts de recàrrega,...) i bicing.

## Introducció

El nostre projecte consisteix en el desenvolupament d’una aplicació mòbil la qual està principalment enfocada per tota
aquella gent que disposi d’un cotxe elèctric i/o vulgui disposar de bicicletes durant uns dies.
<br>L’aplicació constarà d’un mapa en el qual es podran veure els punts de càrrega elèctrics de tot Catalunya i tots
aquells punts on hi hagi bicis disponibles per a ser llogades. La nostra principal innovació és que un usuari podrà
posar a disposició d’altres usuaris tant punts de càrrega com bicicletes, d’aquesta manera li proporcionen una utilitat
als seus carregadors i bicicletes quan els propis usuaris no en facin ús.

### Membres del grup

| Nom                  | GitHub username | Taiga username | Responsabilitat |
|----------------------|-----------------|----------------|-----------------|
| **Isslam Benali**    | Isslam1         | IsslamBenali   | Service         |
| **Arnau Giménez**    | arnau147        | arnau147       | Sprint 1        |
| **Cristina Migó**    | crismigo        | crismigo       | Sprint 2        |
| **Miguel Gutiérrez** | MikierXXV       | mikierxxv      | Demo tècnica    |
| **Daniel Oliveras**  | daniou          | daniou         | Inception       |
| **Andreu Orensanz**  | andyfratello    | andreuorensanz | Inception       |
| **Àlex Ollé**        | aolle99         | aolle99        | Sprint 3        |

### Professor responsable

Jordi Piguillem Poch ( [jpiguillem@essi.upc.edu](mailto:jpiguillem@essi.upc.edu) )

### Enllaços

- [Enllaç al entorn de PRE (NO DISPONIBLE)]()
- [Enllaç al entorn de PRODUCCIÓ (NO DISPONIBLE)]()
- [Enllaç al projecte Taiga](https://tree.taiga.io/project/arnau147-pes-green-whee/)
- [Repositori GitHub](https://github.com/orgs/Green-Wheel/repositories)



## Requeriments per a poder començar a treballar
<details>
<summary>Explicació detallada</summary>

### Introducció

A continuació trobareu un tutorial guiat per tal d'instalar-vos el projecte en local i poder començar a treballar-hi.
Aquest tutorial està pensat per a que sigui seguit en ordre, però si voleu podeu saltar-vos algun pas si ja teniu
instal·lat alguna de les eines que es demanen.
<br>Serà una guia d'instalació de com ho he fet jo, però si voleu podeu seguir
la [oficial](https://docs.flutter.dev/get-started/install).
<br>El tutorial està pensat per a windows. En qualsevol altre sistema operatiu, serà semblant, però no puc assegurar que
funcioni.
> PD: Si teniu mac, ho sento per vosaltres

### Instal·lació de Flutter

1. Descarregar el zip
   de [Flutter](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.3.3-stable.zip)
   i descomprimir-lo a la carpeta que vulgueu (Recomano que tot el que instal·leu ho feu en un disc que tingueu molt
   espai). Cal que la carpeta no tingui permisos elevats (Program files) ni que el path tingui espais o caracters
   especials.
2. Afegir la ruta de la carpeta bin a les variables d'entorn.
    1. Buscar "editar variables d'entorn" i obrir el programa.
    2. A la pestanya "Avançat" seleccionar "Variables d'entorn".
    3. A la pestanya "Variables del sistema" seleccionar "Path" i editar-la.
    4. Afegir una nova variable amb la ruta de la carpeta bin de flutter(es troba en la carpeta resultant de
       descomprimir).
3. Comprovar que s'ha instal·lat correctament executant el següent comandament a la terminal:

```bash
flutter doctor
```

4. Si tot ha anat bé, hauríeu de veure això (pot ser que us surtin opcions malament, però més endavant les arreglarem):

```bash
Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel stable, 3.3.3, on Microsoft Windows [versión 10.0.19043.1348], locale es-ES)
[√] Android toolchain - develop for Android devices (Android SDK version 31.0.0)
[√] Chrome - develop for the web
[√] Android Studio (version 2020.3)
[√] VS Code (version 1.62.3)
[√] Connected device (2 available)
```

### Instal·lar-se Android Studio

1. Descarregar Android Studio des de [aquí](https://developer.android.com/studio).
2. Instal·lar Android Studio (Recomano que ho intaleu en un disc que tingueu molt espai).
3. Obrir Android Studio i anar seguint les pantalles que van sortint.
   Quan us aparegui una que es diu SDK components setup, seleccionar l'ultima versió de la api que hi hagi (33 ara
   mateix), així com android virtual device si no està instalat. també android sdk. (vigileu el path)
4. Quan acabi, pulseu els tres puntets que hi ha a la dreta d'open i seleccionar "SDK Manager".
   ![img.png](https://i.imgur.com/VPwRc5Q.png)
5. A la pestanya "SDK Tools" seleccionar "Android SDK Build-Tools,Android SDK Platform-Tools, Android SDK command line tools i Android SDK Tools" i
   seleccionar la última versió.
6. A la pestanya "SDK Platforms" seleccionar descarregar el següent.
   ![img.png](https://i.imgur.com/qaVDKYD.png)
7. Quan acabi, pulseu els tres puntets que hi ha a la dreta d'open i seleccionar "AVD Manager".
8. Crear un nou dispositiu virtual amb el següent:
   ![img.png](https://i.imgur.com/30DaGJ3.png)
9. Li doneu a next i seleccioneu android api level 33.
10. Finalitzeu i ja tindreu un mòbil virtual per a poder executar l'aplicació.

### Instal·lar-se Intellij IDEA

Podeu utilitzar tant Android Studio com intellij, però a mi m'agrada més intellij ja que està més actualitzat i permet
fer més coses que android studio. Si voleu utilitzar android studio, podeu saltar-vos els punts 1 i 2.

1. Descarregar Intellij IDEA des de [aquí](https://www.jetbrains.com/es-es/idea/download/#section=windows).
2. Instal·lar Intellij IDEA.
3. Instal·lar el plugin de flutter a intellij.
    1. Obrir intellij i anar a "File" -> "Settings" -> "Plugins".
    2. Buscar "flutter" i instal·lar el plugin.
    3. També recomano instal·lar el plugin de dart, flutter intl i flutter pub version checker.
    4. Reiniciar intellij.
4. Anar a "File" -> "Settings" -> "Languages & Frameworks" -> "Flutter".
5.
    1. Anar a "File" -> "Settings" -> "Languages & Frameworks" -> "Flutter" i seleccionar "Enable Dart support for the
       project".
5. Seleccionar la ruta de la carpeta bin de flutter (El zip que heu descomprimit abans).

### Acabar configuració de flutter

1. Obrir una terminal i executar el següent comandament:

```bash
flutter doctor --android-licenses
```

2. Acceptar totes les llicències.
3. Obrir una terminal i executar el següent comandament:

```bash
flutter doctor
```

4. Si tot ha anat bé, hauria de sortir-vos tot en correcte menys lo de visual studio (que no cal que tingueu instal·lat)
   .

### Obtenir el projecte

1. Obrir intellij o android studio i seleccionar Get from VCS.
2. Copiar el [link](https://github.com/Green-Wheel/MobileAPP) del projecte i enganxar-lo a la casella de text o anar a
   la pestanya GitHub i seleccionar el projecte GreenWheel/MobileApp.
3. Quan se us hagi clonat, haurieu de tindre tot el projecte.

### Afegir la api key de google maps

1. Anar a [Google Cloud Platform](https://console.cloud.google.com/) i crear un projecte.
2. Anar a "APIs & Services" -> "Credentials" i crear una nova clau de API.
3. Anar a "APIs & Services" -> "Library" i buscar "Maps SDK for Android" i activar-la.
4. Copiar la clau que heu creat i crear un fitxer anomenat .env al root del projecte.
5. Afegir la següent línia al fitxer .env:

```bash
GOOGLE_MAPS_API_KEY=LA_CLAU_QUE_HEU_CREAT
```

### Instalar dependencies

1. Anar al fitxer pubspec.yaml.
2. A dalt a la barra de menús, seleccionar "Pub get" i esperar que es descarreguin les dependencies.

### Executar l'aplicació

1. Seleccionar a dalt a la dreta el dispositiu virtual que heu creat.
2. Si no teniu el dispositiu virtual creat, seleccionar "Create New Virtual Device" i crear-lo.
3. Si no teniu cap configuració posada, aneu a edit configurations i afegiu una configuració de tipus "Flutter".
2. Donar al play i esperar que s'instal·li l'aplicació.
3. Us hauria d'apareixer el movil virtual amb l'aplicació instal·lada.
4. Si no us surt, busqueu la pestanya a la barra lateral dreta anomenada Android Emulator.
5. Si tot ha anat bé, hauríeu de veure això:

![img.png](https://i.imgur.com/MzIYxjK.png)

### Executar tests

1. Per executar els tests, aneu a la pestanya "Run" i seleccioneu "Run All Tests".
2. Si no ho tenieu configurat, aneu a "Run" -> "Edit Configurations" i afegiu una configuració de tipus "Flutter Test".
   Allà seleccioneu que siguin de tipus directori i seleccioneu la carpeta test.

### En cas de que no us funcioni l'execució, feu això:

A alguns de vosaltres no us està funcionant l'execució de l¡aplicació o la virtualització del dispositiu android.
Crec que es bugueja una mica amb git, però no ho sé molt bé. Per això, si no us funciona, podeu fer això:

1. Crear un nou projecte de flutter, anant a File-> New -> project.
2. Seleccionar flutter amb el sdk (la carpeta de flutter principal) i next.
3. Posar el nom que vulgueu al projecte, on volgueu i amb la descripcio que vulgueu. Android Language = Kotlin i marqueu
   nomes android. Li doneu a create.
   ![Image](https://i.imgur.com/BKAsT2E.png)

4. Copieu els seguents fitxers/directoris a la carpeta del projecte que heu creat (del projecte github que teniu):
    - .git
    - android
    - assets
    - lib
    - test
    - .env
    - .gitignore
    - .metadata
    - analysis_options.yaml
    - apunts.md
    - LICENSE
    - pubspec.lock
    - pubspec.yaml
    - README.md

### Activar localització a l'emulador

Per tal que les funcionalitats i tots els botons del mapa funcionin, cal activar la localització a l'emulador. Per fer-ho, cal
anar a "Settings" -> "Location" i anar a "App access to location", seleccionar l'aplicació de "greenwheel" (amb el logo de Flutter)
i activar l'opció "Allow all the time". Depsprés reinicieu l'emulador i ja hauria de funcionar.
La localització de l'emulador no serà el lloc de l'ordinador que esteu fent servir si no predeterminadament és la seu central de Google. No us preocupeu, és normal. Quan es provi amb un mòbil de veritat la localització serà la real

![Image](https://i.imgur.com/9HK1Amx.png)


### Ja està! Ara us recomano que aneu al fitxer apunts.md i llegiu els apunts que hi ha per a començar a fer el projecte.

</details>

## Enllaços d'interès

### Documentació i formació

#### Documentació escrita

- [Documentació de flutter](https://flutter.dev/docs)
- [Tutorial de com crear la primera aplicació](https://docs.flutter.dev/get-started/codelab)
- [Petits tutorials de funcionalitats](https://docs.flutter.dev/cookbook)
- [Codis d'exemple de funcionalitats](https://flutter.github.io/samples/#/)
- [Documentació de la api de google maps](https://pub.dev/packages/google_maps_flutter)
- [Llibreria de serveis de google maps](https://pub.dev/packages/google_maps_webservice)
- [Explicacions i exemples de widgets a flutter by javaTpoint](https://www.javatpoint.com/flutter)
- [Documentació components de material design](https://material.io/components?platform=flutter)

#### Videos

- [Mini curs de YT de creació d'una copia de Uber amb flutter](https://www.youtube.com/playlist?list=PLy9JCsy2u97l8vY42NaXwsA_Y_LJXJyp6)
- [Curso YT des de 0 de flutter en Español 1](https://www.youtube.com/playlist?list=PLl_hIu4u7P677H9f6zPOHiOz2izkvQq2E)
- [Curso YT des de 0 de flutter en Español 2](https://www.youtube.com/playlist?list=PLgD-VLjdOvqj4qcsYTREjiLcVMK9vzbfj)
- [Video de 2h que explica una mica de tot](https://www.youtube.com/watch?v=CD1Y2DmL5JM&ab_channel=FlutterMapp)

### Llibreries i exemples de codi concrets

#### Mapes

- [Tutorial oficial d'afegeir un mapa a l'aplicació](https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#0)
- [Using Google Maps to add maps in flutter applications](https://blog.logrocket.com/google-maps-flutter/)
- [Com obrir aplicació google maps amb coordenades](https://stackoverflow.com/questions/47046637/open-google-maps-app-if-available-with-flutter)
- [Com fer un mapa amb rutes](https://medium.com/flutter-community/flutter-google-maps-with-directions-api-2d1a60b1a5a0)
- [Dibuixar ruta en mapa](https://medium.com/@rohanarafat86/drawing-route-direction-in-flutter-using-openrouteservice-api-and-google-maps-in-flutter-4431a2989dd5)
- [Geolocation](https://blog.logrocket.com/geolocation-geocoding-flutter/)

#### Chat

- [Llibreria per a fer un chat facilment (visualment)](https://pub.dev/packages/flutter_chat_ui)
- [Exemple real time chat amb django i flutter](https://github.com/udaykhalsa/flutter-django-chat-app)
- [Chat utilitzant flutter](https://medium.com/nerd-for-tech/flutter-a-chat-app-in-flutter-using-a-socket-io-service-88be02a388d6)

#### Notificacions push

- [Llibreria Notificacions push locals](https://pub.dev/packages/flutter_local_notifications)

#### Altres

- [App bar flotat al estil google maps](https://pub.dev/packages/floating_search_bar)

Si trobeu algun enllaç més, no dubteu en posar-lo.

