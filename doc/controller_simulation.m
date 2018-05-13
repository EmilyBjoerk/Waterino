# Prevent octave from thinking this is a function file
1;

clear;

# Pot parameters
global capacity = 500; # ml
global dryout_time = 24*10; # h
global evaporation_rate= capacity/(4*dryout_time); # ml/h so that it dries out in the given time

# Controller parameters
global threshold = capacity/5; # ml
global tgt_period = 24*10; # 4 days
global last_watered = 0;
global default_water = 10; #ml
global Kp = 3.0;
global Ki = 5.0;
global Kd = 0;
global Si = 0;
global last_error = 0;

# Simulation parameters
global tick_rate = 1; # 1h
end_time = tgt_period *30;

function ans = pot_level(old_level, water_added)
  global tick_rate;
  global evaporation_rate;
  water_added = max(0, water_added);
  ans = water_added + old_level - evaporation_rate* tick_rate;
endfunction

function [water_added,error] = controller(now)
  global Si;
  global Kp;
  global Ki;
  global Kd;
  global last_watered;
  global tgt_period;
  global default_water;
  global last_error;
  global tick_rate;
  # Positive error means too little water
  error = 1 - (now - last_watered)/tgt_period; 
  last_watered = now;


  water_added = (1 + Kp * error + Ki*Si + Kd*(error - last_error)/tick_rate)*default_water;
  last_error = error;
  Si = Si + error;
endfunction



t = 0:tick_rate:end_time;
w = [threshold];
wa = [];
e = [];
error = 0;
for now = 0:tick_rate:end_time
  old_level = w(size(w)(2));
  new_level = max(0, pot_level(old_level, 0));
  water_added = 0;
  
  if (new_level < threshold)
    [water_added,error] = controller(now);
    new_level = max(0, pot_level(old_level, water_added));
  endif
  wa = [wa, water_added];
  w = [w, new_level];
  e = [e, error];
endfor

w=w(2:end);
t=t/tgt_period;


figure(1);
plot(t, w, "-;water level;", t, wa, "-;water added;")
figure(2)
plot(t, e, "-;error;")
