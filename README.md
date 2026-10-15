# MATLAB Soil Moisture Monitoring and Automatic Watering

A university engineering project that uses MATLAB to read soil-moisture sensor voltage from an ESP32, plot readings in real time, and control a water pump based on configurable voltage thresholds.

**Demonstration video:** [Watch the project in action](https://www.youtube.com/shorts/3doMDUiDFv0)

## Features

- Reads soil-moisture sensor voltage from ESP32 pin `D36`.
- Displays a continuously updating plot with a rolling history of up to 300 samples.
- Controls a water pump connected through the project's hardware interface on pin `D26`.
- Uses voltage thresholds to decide whether watering should be activated.
- Checks pin `D13` for an active-low emergency-stop input; when LOW is detected, the program turns the pump output off and exits the loop.
- Initializes the ESP32 connection and M5Unified and NeoPixel add-ons in a separate helper function.

## Hardware and software

- MATLAB
- MATLAB Support Package for Arduino Hardware
- ESP32-WROOM-DevKitC (as specified in the original code)
- Soil-moisture sensor connected to the configured analog input
- Water-pump hardware/driver connected to the configured output
- Emergency-stop button/input
- M5Unified and NeoPixel add-ons (initialized by `StartM5.m`)

> The original code specifies serial port `COM7`. Change this to the correct port on your computer before running. The board and pin assignments must match your actual wiring.

## Repository structure

```text
.
├── README.md
├── src/
│   ├── MinorProj1.m
│   └── StartM5.m
└── .gitignore
```

## Running the project

1. Install MATLAB and the MATLAB Support Package for Arduino Hardware.
2. Install the add-ons referenced in `src/StartM5.m`, if they are required by your hardware setup.
3. Connect the ESP32 and sensor/pump interface using the original project's wiring.
4. Open `src/MinorProj1.m` in MATLAB.
5. Confirm the serial port, board identifier, pin assignments, and voltage thresholds match your setup.
6. Run the script and observe the live moisture-voltage plot and pump-control messages.

**Safety:** Do not connect a pump directly to a microcontroller GPIO unless the pump's electrical requirements and a suitable driver circuit explicitly permit it. Keep water away from exposed electronics. Test pump control safely and supervise the system.

## Control logic in the recovered source

The current source uses these conditions:

- `MoistureRd > 1.4 && MoistureRd <= 4`: turn the pump output on.
- `MoistureRd >= 1.3 && MoistureRd <= 1.4`: turn the pump output on.
- `MoistureRd < 1.3`: turn the pump output off.

These are voltage thresholds from the original implementation, not universal soil-moisture percentages. Calibrate them for the sensor, soil, supply and circuit before reuse.

## Notes and future improvements

- The original comments describe one threshold range differently from the executable condition. Verify the intended thresholds before changing or reusing the control logic.
- The plot labels its horizontal axis as time, but the current implementation plots sample positions rather than measured elapsed seconds.
- Add a maximum pump-on duration and cooldown interval to reduce the risk of overwatering or a pump running continuously.
- Add sensor-disconnection detection, configuration outside the source code, and automated tests for the threshold logic.
- Replace the fixed serial port with a user-configurable setting.

## Project background

This repository documents a previously completed university engineering project. The included MATLAB files are the source files recovered by the author. The linked video demonstrates the project running in practice.

## License

No open-source license has been selected. Unless a license is added, others should not assume they have permission to reuse, modify, or redistribute this code. Confirm that any university/course restrictions permit public release before publishing.
