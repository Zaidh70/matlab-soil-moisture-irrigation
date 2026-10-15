port = 'COM7';
board = 'ESP32-WROOM-DevKitC';

% Call the function to initialize
[MCesp32, m5unified, ZNpixl] = StartM5(port, board);
TimeStrt = 1;         % Starting time counter
x = [];               % Initialize X array for graph plot
maxDatPts = 300; %Variable for max data points store from sensor 
writeDigitalPin(MCesp32, "D26", 0) %Keeps the water pump on pin D26 off at start 

while true %loop will continue unless condition not satisfied
MoistureRd = readVoltage(MCesp32, "D36"); %Reads Moisture value of moisture sensor which is on pin D36 of M5
    x = [x, MoistureRd]; % Adds the Moisture sensor data to the array x which will be plotted 
     if length(x) > maxDatPts % If the lenght of array x is greater than the max data points value 
        x = x(end-maxDatPts+1:end); % It will keep refresh the data points to avoid buffer error
    end
    % Plot the data
    plot(x,'-o',LineWidth=1.5);% Plot array x with o marker and 1.5 line width 
    grid on;
    ylim([0 4])% Y axis is set to min 0 value to max 4 to adjust graph scale
    title('Moisture Sensor Data');% this gives title to the graph
    xlabel('Time (s)'); %Sets x axis label to time in seconds.
    ylabel('Soil Moisture Value');% It will set y axis lable to Soil Moisture Value
    
    % Updates the plot with new data 
    drawnow;

    % Everytime the loop repeats this will add 1 more to timestrt counter
    TimeStrt = TimeStrt + 1;
    
    if readDigitalPin(MCesp32,"D13") == 0 %Reads if the blue button is pressed i.e its value is 0 on pin D13
        disp('Emergency Stop') % display program emergency end message 
        writeDigitalPin(MCesp32,"D26", 0) % turns off the water pump on pin D26
        break %breaks the loop
    end
  if MoistureRd > 1.4 && MoistureRd <= 4 %Means if Moisture reading is between Voltage 1.6v to 4v
     writeDigitalPin(MCesp32, 'D26', 1)%Sets water pump value to 1 which starts the pump. 
     disp("Soil is really dry, watering till wet");%disp soil dry message 
     pause(0.8) % pause to avoid buffer overload 
     end
  if MoistureRd >= 1.3 && MoistureRd <= 1.4 %Means if Moisture reading is between Voltage 1.2v to 1.6v
      writeDigitalPin(MCesp32, 'D26', 1)%Sets water pump value to 1 which starts the pump
      disp('Soil is still little dry, watering till completely moist')%Disp water a little dry message 
      pause(0.8)% pause to avoid buffer overload 
      end
if MoistureRd < 1.3
    disp('Soil is moist no need for watering')
    writeDigitalPin(MCesp32, "D26", 0)
    pause(1)

end
end

  
     