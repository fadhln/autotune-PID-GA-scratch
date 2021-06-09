function [plant_d, desired, Ts] = defineSys()
    A = [0 1 0; 0 0 1; -18 -19 -12];
    B = [0; 0; 1];
    C = [30 0 0];
    D = [];
    plant = ss(A, B, C, D);
    
    Ts = 0.05;
    plant_d = c2d(plant, Ts, 'ZOH');
    
    desired = struct('RiseTime', 0.19, ...
                     'SettlingTime', 1.9, ...
                     'Overshoot', 10.5);
end