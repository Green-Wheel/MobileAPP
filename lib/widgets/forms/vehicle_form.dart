import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backendServices/vehicles.dart';
import 'package:greenwheel/widgets/forms/brand_info.dart';
import 'package:greenwheel/widgets/forms/model_info.dart';
import 'package:greenwheel/widgets/forms/year_model_info.dart';
import 'package:greenwheel/widgets/forms/vehicle_basic_info.dart';

class VehicleForm extends StatefulWidget {
  final data;
  final int? id;

  const VehicleForm({Key? key, this.data, this.id}) : super(key: key);

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  //variables
  int _page = 0;
  late final Map<String, dynamic> _data;
  int _brandId = 1;
  int _modelId = 1;

  //functions
  void nextPage() {
    setState(() {
      ++_page;
    });
  }

  void previousPage() {
    setState(() {
      --_page;
    });
  }

  //widget functions
  @override
  void initState() {
    super.initState();
    _data = widget.data ??
        {
          'alias': '',
          'car_license': '',
          'charge_capacity': '',
          'model': 1,
        };
  }

  void getBasicInfo(basicInfo) {
    setState(() => {
      _data['alias'] = basicInfo['alias'],
      _data['car_license'] = basicInfo['car_license'],
      _data['charge_capacity'] = basicInfo['charge_capacity'],
    });
  }

  void getBrandId(int brandId) {
    setState(() => {
      _brandId = brandId,
    });
  }

  void getModelId(int modelId) {
    setState(() => {
      _modelId = modelId,
    });
  }

  Future<void> getYearModel(int model) async {
    print('model $model');
    setState(() => {
      _data['model'] = model,
    });
    print('Dades a fer post $_data');
    if (widget.data != null) {
      setState(() => {
        _data['id'] = widget.id,
      });
      print('data to put $_data');

      bool bUpdateVehicle = await VehicleService.putVehicle(_data);
      if (!bUpdateVehicle) {
        showDialog(
            context: context,
            builder: (context) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop(true);
              });
              return const AlertDialog(
                title: Text('Vehicle Updated Successfully'),
              );
            }
        );
      }
    } else {
      bool bCreateVehicle = await VehicleService.postVehicle(_data);
      if (!bCreateVehicle) {
        showDialog(
            context: context,
            builder: (context) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop(true);
              });
              return const AlertDialog(
                title: Text('Vehicle Created Successfully'),
              );
            }
        );
      }
    }
    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    switch (_page) {
      case 0:
        {
          return VehicleBasicInfo(
            data: {
              'alias': _data['alias'],
              'car_license': _data['car_license'],
              'charge_capacity': _data['charge_capacity']
            },
            callback: getBasicInfo,
            nextPage: nextPage,
          );
        }
      case 1:
        {
          return BrandInfo(brandId: _brandId, callback: getBrandId,
              nextPage: nextPage, prevPage: previousPage);
        }
      case 2:
        {
          return ModelInfo(
              brandId: _brandId,
              modelId: _modelId,
              callback: getModelId,
              nextPage: nextPage,
              prevPage: previousPage);
        }
      case 3:
        {
          return YearModelInfo(
              data: {
                'model': _data['model']
              },
              brandId: _brandId,
              modelId: _modelId,
              callback: getYearModel,
              prevPage: previousPage);
        }
      default:
        {
          return const Center(
              child: Scaffold(
                body: SingleChildScrollView(child: Text("PAGE NOT EXISTENT")),
              ));
        }
    }
  }
}
