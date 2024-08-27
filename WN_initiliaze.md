# Initialize


## Initialize 2D Grid ( pointInitialization.cpp [140] )

- compute maxStationHeight
- fill airTempGrid and cloudCoverGrid (2d) by interpolate from stations (using inverse distance squared weighting)
- check that cloudCoverGrid is completely filled
- interpolate all stations vertically to maxStationHeight
    - compute neutral ABL height [213]
    - AGL = maxStationHeight + Rough_h
    - getWindSpeed()
- fill uInitializationGrid and vInitializationGrid (2d) by interpolate from stations (using inverse distance squared weighting)

## Initialize 3D Grid ( initialize.cpp [94] )
for rows
  for cols
    get roughness for this x,y cell
    for layers
      getWindSpeed()

## getWindSpeed ( windProfile.cpp [58] )
- if uniform:

    return inputWindSpeed
- if logarithmic:

    return inputWindSpeed*((log((AGL-Rough_d)/Roughness))/(log((inputWindHeight + Rough_h - Rough_d)/Roughness)))
    
    $$inputWindSpeed * { {log {{AGL-Rough_d} \over {Roughness}}} \over {log{{inputWindHeight + Rough_h - Rough_d} \over {Roughness}}}}$$

- if power_law_askervein:

    return inputWindSpeed*std::pow((AGL/inputWindHeight),powerLawPower)

    $$ inputWindSpeed * {{AGL} \over {inputWindSpeed}}^{powerLawPower} $$

 - if monin_obukov_similarity:

```cpp
inwindheight = (inputWindHeight + Rough_h) - (Rough_d); //height of input wind (from z=0 of log profile)
//If the input wind is at a height where the log profile isn't defined (can happen on output interpolation),
//just linearly interpolate. Use three times the roughness height to avoid issues that can arise sampling
//too close to where the log profile goes to 0.
if(inwindheight < 3.0*Roughness){
    velocity = inputWindSpeed * (AGL/(inwindheight + Rough_d));
    return velocity;
}else{ //else, just do standard profile stuff
    if(AGL < (Rough_d + 7.0*Roughness))	//linearly interpolate, as in AERMOD, if below 7*z0
    {
        vel7z0 = monin_obukov(7.0*Roughness, inputWindSpeed, inwindheight, Roughness, ObukovLength);	//compute windspeeds at 7*z0 height
        velocity = vel7z0 * (AGL/(7.0*Roughness + Rough_d));
        return velocity;
    }else if(AGL < (Rough_d + ABL_height))	//if below ABL top, monin-obukov similarity (log profile)
    {
        velocity = monin_obukov((AGL - Rough_d), inputWindSpeed, inwindheight, Roughness, ObukovLength);
        return velocity;
    }else{	//else we're above the ABL...
        if(ABL_height<=0.0) //This can happen if input velocity is 0 which gives u_star=0 (typically if diurnal is off)
            velocity = 0.0;
        else
            velocity = monin_obukov(ABL_height, inputWindSpeed, inwindheight, Roughness, ObukovLength);
    return velocity;
    }
``` 



## Roughness

Roughness
Rough_h: Roughness height
Rough_d

set_uniRoughness: ninja.cpp [3910]

## Roughness base values

### Vegetation Grass
- Roughness: 0.01 m
- RoughH: 0.0 m
- RoughD: 0.0 m
- Albedo: 0.25
- Bowen: 1.0
- Cg: 0.15
- Anthropogenic: 0.0

### Vegetation Brush
- Roughness: 0.43 m
- RoughH: 2.3 m
- RoughD: 1.8 m
- Albedo: 0.25
- Bowen: 1.0
- Cg: 0.15
- Anthropogenic: 0.0


### Vegetation Trees
- Roughness: 1.0 m
- RoughH: 15.4 m
- RoughD: 12.0 m
- Albedo: 0.1
- Bowen: 1.0
- Cg: 0.15
- Anthropogenic: 0.0