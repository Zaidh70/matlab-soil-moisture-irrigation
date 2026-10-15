function [MCesp32, m5unified, ZNpixl] = StartM5(port, board)

   MCesp32 = arduino(port, board);
   m5unified = addon(MCesp32, 'M5stack/M5Unified');
   ZNpixl = addon(MCesp32, 'Adafruit/NeoPixel', 'D25', 10, 'NeoPixelType', 'GRB');
   disp('ESP32 and addons initialized successfully!');
end 
