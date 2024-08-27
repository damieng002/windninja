WindNinja
=========

## Update from original repo
- Variables added in cmd args to be able to use a altitude
``` plaintext
  --use_upper_wind arg (=0)             initialize the upper level winds with
                                        other values than the lower level winds
                                        (true, false)
  --upper_wind_limit arg                limit above which upper level winds are
                                        used (ASL)
  --upper_wind_height arg               height at which upper winds are given
                                        (ASL)
  --upper_wind_speed arg                speed of upper wind km/h
  --upper_wind_direction arg            direction of upper wind
  --upper_wind_units arg                units of input upper wind speed (mps,
                                        mph, kph, kts)
  --upper_wind_zero_middle_layer arg    add a layer with zero wind between low
                                        and high altitude winds
```
- Save to disk a VTK with initilized winds
- Docker build is split in two images see [Docker](Docker.md)
- Add md file with key points to add new variables see [Add_variables](Add_variables.md)
- Add md file with information on wind initilization see [WN_initiliaze](WN_initiliaze.md)


Original Readme from forked repo
================================
WindNinja is a diagnostic wind model developed for use in wildland fire modeling.

Web:
http://firelab.org/project/windninja

Source & wiki:
https://github.com/firelab/windninja

FAQ:
https://github.com/firelab/windninja/wiki/Frequently-Asked-Questions

IRC:
irc://irc.freenode.net/#windninja

[Building on Linux](https://github.com/firelab/windninja/wiki/Building-WindNinja-on-Linux)

[Building on Windows](https://github.com/firelab/windninja/wiki/Building-WindNinja-on-Windows-using-the-MSVC-compiler-and-gisinternals.com-dependencies)

Directories:
 * autotest    -> testing suite
 * cmake       -> cmake support scripts
 * data        -> testing data
 * doc         -> documentation
 * images      -> splash image and icons for gui
 * src         -> source files

Dependencies (versions are versions we build against for the Windows installer):
 * Boost 1.46:
    * boost_date_time
    * boost_program_options
    * boost_test
 * NetCDF 4.1.1
 * GDAL 2.2.2
    * NetCDF support
    * PROJ.4 support
    * GEOS support
    * CURL support
 * Qt 4.8.5
    * QtGui
    * QtCore
    * QtNetwork/Phonon
    * QtWebKit
 * [OpenFOAM 2.2.x](https://github.com/OpenFOAM/OpenFOAM-2.2.x)

See INSTALL for more information (coming soon)

See CREDITS for authors

See NEWS for release information

=========
<img src="images/bsb.jpg" alt="Example output"  />

