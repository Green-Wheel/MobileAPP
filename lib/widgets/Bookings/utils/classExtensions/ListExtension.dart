
import '../backendOperations.dart';

extension ListExtension on List{
  List cloneBackendOperations(){
    //TODO: CHECKEAR QUE LA LISTA SEA DE TIPO BACKENDOPERATIONS
    List<BackendOperation> clone = [];
    for (var elem in this){
      clone.add(elem.clone());
    }
    return clone;
  }
}