import 'package:pragma_design_system/src/foundations/foundations.dart'
    show DSSpacingFoundations, DSRadiusFoundations;
import 'package:pragma_design_system/src/utils/enums.dart';

import '../foundations/ds_sizes_foundations.dart';

double getDSElevation(DSSpacin elevation) {
  switch (elevation) {
    case DSSpacin.xxs:
      return DSSpacingFoundations.xxs;
    case DSSpacin.xs:
      return DSSpacingFoundations.xs;
    case DSSpacin.small:
      return DSSpacingFoundations.small;
    case DSSpacin.medium:
      return DSSpacingFoundations.medium;
    case DSSpacin.large:
      return DSSpacingFoundations.large;
    case DSSpacin.xl:
      return DSSpacingFoundations.xl;
    case DSSpacin.xxl:
      return DSSpacingFoundations.xxl;
    default:
      return DSSpacingFoundations.none;
  }
}

double getDSRadius(DSSizeRadius radius) {
  switch (radius) {
    case DSSizeRadius.xs:
      return DSRadiusFoundations.radiusXS;
    case DSSizeRadius.small:
      return DSRadiusFoundations.radiusSM;
    case DSSizeRadius.medium:
      return DSRadiusFoundations.radiusMD;
    case DSSizeRadius.large:
      return DSRadiusFoundations.radiusLG;
    case DSSizeRadius.xl:
      return DSRadiusFoundations.radiusXL;
    case DSSizeRadius.radiusCircular:
      return DSRadiusFoundations.radiusCircular;
    default:
      return DSRadiusFoundations.none;
  }
}

  double getDsSizeIconButton(DSSize size) {
    switch (size) {
      case DSSize.xs:
        return DSSizesFoundations.iconSizeXS * 1.2;
      case DSSize.small:
        return DSSizesFoundations.iconSizeSmall * 1.3;
      case DSSize.medium:
        return DSSizesFoundations.iconSizeMedium * 1.4;
      case DSSize.large:
        return DSSizesFoundations.iconSizeLarge * 1.8;
      case DSSize.xl:
        return DSSizesFoundations.iconSizeXL * 1.8;
    }
  }
