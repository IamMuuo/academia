import 'package:academia/config/config.dart';
import 'package:academia/exports/barrel.dart';
import 'package:academia/utils/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:logger/logger.dart';

part 'in_app_update_state.dart';

class InAppUpdateCubit extends Cubit<InAppUpdateState> {
  InAppUpdateCubit() : super(InAppUpdateInitial());
  final Logger _logger = Logger();
  final ctx = AcademiaRouter.router.routerDelegate.navigatorKey.currentContext;

  void checkForUpdate() async {
    final flavor = GetIt.instance.get<FlavorConfig>();

    if (!flavor.isProduction) {
      _logger.i("Running on ${flavor.flavorName} ignoring check for update");
      return;
    }

    _logger.i("Checking for app update");
    emit(InAppUpdateLoading());

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        _logger.i({
          "update": "update found",
          "package name": updateInfo.packageName,
          "package outdated in days": updateInfo.clientVersionStalenessDays,
        });
        emit(InAppUpdateAvailable(updateInfo: updateInfo));
        if ((updateInfo.clientVersionStalenessDays ?? 0) >= 1) {
          await InAppUpdate.performImmediateUpdate();
        } else {
          final res = await InAppUpdate.startFlexibleUpdate();
          if (res == AppUpdateResult.success) {
            await InAppUpdate.completeFlexibleUpdate();
          }
        }
      } else {
        _logger.i("No updates available at the moment");
        emit(InAppUpdateNoUpdate());
      }
    } catch (e) {
      ScaffoldMessenger.of(ctx!).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(minutes: 2),
      ));

      _logger.e(e);
      emit(InAppUpdateError(errorMessage: e.toString()));
    }
  }

  Future<AppUpdateResult?> performUpdate() async {
    try {
      emit(InAppUpdateInProgress());
      _logger.i("Performing immediate update");
      final res = await InAppUpdate.performImmediateUpdate();
      emit(InAppUpdateCompleted());
      return res;
    } catch (e) {
      _logger.e(e.toString());
      emit(InAppUpdateError(errorMessage: e.toString()));
    }
    return null;
  }
}
