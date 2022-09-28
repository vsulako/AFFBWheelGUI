# AFFBWheelGUI

[Описание на русском](./README_RU.md)

Program (hereinafter GUI*) for changing controller settings [AFFBWheel](https://github.com/vsulako/AFFBWheel).

## `Inputs` tab

Basic settings for the steering wheel, axles and buttons.

![](/images/affbwheelgui_inputs.png)

- **Axis #0, #1, #2, ....** - Displays the current state of the steering, throttle, brake, etc. axes.
- **Range (selector)** - sets the angle of rotation of the steering wheel from lock to lock, you can also enter any value.
- **Center (button)** - remembers the current position of the steering wheel as central, only until the device is turned on again, it is also set automatically when turned on.
- **Min/Max (input)** - sets the minimum and maximum value for the axis input.
- **Center (input)** - sets the center position of the axis, active only if the **Has center** flag is set.
- **Deadzone (input)** - Sets the center deadzone for the analog axis. If the axis is set to the center position (**Has center**), you can add a dead zone to the center. Example: The axis center is set to 530 and the dead zone is set to 10. The axis will now report a value of 0 when the reading is between 520 and 540. This only applies to the center. Deadzone does not work if axis center is disabled. To set dead zones at the edges, set the minimum/maximum slightly smaller than the actual borders.
- **Set Min (button)** - sets the minimum value of the axis. You need to set the axis to the minimum position and press the button.
- **Set Max (button)** - sets the maximum value of the axis. You need to set the axis to the maximum position and press the button.
- **Set Center (button)** - sets the center value of the axis. You need to set the axis in the center position and press the button.
- **Autolimit (switch)** - enables automatic minimum/maximum setting for the analog axis. If this is enabled, any time the existing limits are exceeded, the current value becomes the new limit. (In other words: turn it on, press the pedal all the way and back, turn it off - you're done, the boundaries are defined). Center position and dead zone will be disabled.
- **Has center (switch)** - sets whether the axis can have a center position.
- **Has center (switch)** - sets whether the axis can have a center position.
- **Output disabled (switch)** - disables input from the axis. For example, if the axis is not used, to remove noise (fluctuating values ​​when the axis is disabled).
- **Trim (selector)** - sets the rounding value for the analog axis. Bit-by-bit reduces the resolution of the raw (raw) axis readings to combat unwanted noise. For example, if you set the value to 3, the reading will change in increments of 8 (2 to the power of 3). If there is noise on the axis, you can try to increase this value (however, it is still better to find the cause of the noise and not hide it in this way).
  
- **Buttons** - buttons are displayed and configured here, you can test the operation of the buttons.
- **Center button (selector)** - you can select a button, pressing which will reset and remember the current position of the steering wheel (similar to the action **Center (button)**).
- **Debounce (input)** - sets the delay for the buttons to fire. If this value is greater than 0, the buttons will register changes only after a delay (1 cycle - about 1ms)
If the buttons have a problem with bouncing, try increasing this value.

## `Force Feedback` tab

Allows you to change the gains for each of the DirectX feedback effects.

![](/images/affbwheelgui_forcefeedback.png)

#### All:

Sets, increases or decreases, the strength of all effects below except **Endstop**.

#### Constant:

Constant force acting in one direction.

*Example:* The game typically uses constant force to simulate g-forces. This creates resistance when cornering at speed.

#### Ramp:

A force that is constantly increasing or decreasing. The growing force may continue in one direction, or may start as a strong push in one direction, weaken, stop, and then strengthen in the opposite direction.

*Example:* Car weight drag and chassis weight transfer in a turn.

#### Square, Sine, Triangle, Sawtooth Up/Down:

The force varies periodically with time (square/triangular/sawtooth/sine wave), can be applied to generate vibration.

*Example:* Some games may generate vibrations when the vehicle is damaged.

####Spring:

This is a force that increases depending on how far you are from a certain position on the wheel. The force depends on the position of the steering wheel.

*Example:* simulation of the force that returns the steering wheel to the center position.

#### Damper:

The force depends on the angular velocity, it is used to simulate the resistance of the steering wheel to rotation (loading).

*Example:* creating resistance on the handlebar when the flank is stationary and reducing this effect at speed.

#### Inertial:

The force depends on the angular acceleration, imitation of the resistance to change in rotational speed (inertia) is applied.

#### Friction:

Creates a constant force that resists rotation (similar to **Damper**, but slightly different) Should also simulate loading.

*Example:* the friction of the wheels of a car on the road surface.

#### Endstop:

This is the power of the rudder's final stop. That is, when the steering wheel reaches the extreme position, the feedback motor is turned on and does not allow the steering wheel to scroll further.

*Example:* if the steering angle is set to 900°, then if you turn the steering wheel from the center by 450° to the side, further steering will be limited.

*In practice, games often use only the Constant effect, sometimes also Spring and Damper. The rest can hardly be found.*

*It is better not to touch these settings, but adjust the OS strength in the game, if possible.*

#### Max velocity for Damper effect:

The maximum speed value for the damper effect.
As this parameter is increased, the damper effect becomes weaker, and vice versa.

#### Max velocity for Friction effect:

The maximum speed value for the friction effect.
Only affects how the effect works for low speed values.

#### Max acceleration for Inertial effect:

The maximum acceleration value for the inertia effect.
As this parameter increases, the effect of inertia weakens, and vice versa.

#### Min force:

Minimum value for feedback force.

*Tip:* If you want to get rid of the void on the steering wheel in the center, you can try increasing **Min force** to 5-10%.

#### Max force:

The maximum possible value for the feedback force.

#### Cut force:

Feedback force trim level.
If the resulting value is greater than the **Cut force** value, the force value will be cut at the **Cut force** level.

#### FFB PWM bit depth/frequency:

The default value is 9, the frequency is 15.625kHz. It should not be changed.
Values ​​greater than 9 lead to a decrease in frequency and the appearance of a nasty squeak.
Smaller values ​​only lose resolution.
The setting is left just in case.

#### Endstop offset:

The level at which the rudder return force will start when out of bounds.
Increasing the value increases the hardness of the effect.

*Note:* The range of values ​​is from 0 to 16383.

#### Endstop width:

the width of the section over which the return force increases linearly to a maximum. As the value increases, the effect becomes softer.

*Note:* The value range is from 0 to 16383. If you don't like how the rudder stop effect behaves in the end position, try increasing or decreasing this value. If you have a powerful motor and there will probably be a vibration effect when you hit the limit, then try reducing the **Endstop width**.

## Save and reset settings

At the bottom of the window are buttons for saving and resetting to default settings.

![](/images/affbwheelgui_bottom.png)

- **Reset settings to defaults** - resets settings to default. <br>
  *If you've updated the firmware or GUI and you're having some problems, try resetting with this button first*.
- **Load settings from EEPROM** - loading settings from the non-volatile memory of the controller. <br>
  *Normally, all settings are loaded automatically when you start the setup program and you do not need to press this button*.
- **Save settings to EEPROM** - saves settings to the non-volatile memory of the controller, allows you to save settings when the controller is turned off. <br>
  *Don't forget to save the settings after changing and before powering off the controller*.

## Download

**[Latest compiled version (Windows x86)](https://github.com/vsulako/AFFBWheelGUI/releases/latest)** <br>
**[Past Versions](https://github.com/vsulako/AFFBWheelGUI/releases)**

## Requirements for compiling

- Delphi
- [JEDI Visual Component Library](https://github.com/project-jedi/jvcl)

## Known Issues and Solutions

- In case of "Device cannot be opened" error in Windows 10, please try to install update [KB4482887](https://catalog.update.microsoft.com/Search.aspx?q=KB4482887):
<https://support.microsoft.com/en-us/topic/march-1-2019-kb4482887-os-build-17763-348-f7a9f207-0627-1fb9-cca7-29bb7b26027f>
