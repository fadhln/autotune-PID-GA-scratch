function err = fitness(x, plant, Ts, desired)

% Fungsi ini mendefinisikan sistem yang terkontrol dengan PID
% Parameter: x -> [Kp, Ki, Kd]
%            plant -> sistem Diskrit
%            Ts -> waktu sampling
%            desired -> keinginan spesifikasi

    c = pid(x(1), x(2), x(3), 0, Ts);
    
    system = feedback(series(c, plant), 1);
    sim = stepinfo(system);
    
    riseTimeError = sim.RiseTime - desired.RiseTime;
    overShootError = sim.Overshoot - desired.Overshoot;
    settlingTimeError = sim.SettlingTime - desired.SettlingTime;
    
    err = riseTimeError + overShootError + settlingTimeError;
end