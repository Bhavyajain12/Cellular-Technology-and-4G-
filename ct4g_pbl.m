dataSize = 50:50:500;
timeTaken = 5:5:50;
distance = 5:5:50;
speedOfLight = 299792:1:299802;
queueLength = 55;
threshold = 10:10:100;
Bandwidth = zeros(1, 10);
propagationDelay = zeros(1, 10);
answer = zeros(1, 10);
queueType = cell(1, 10);
throughput = zeros(1, 10);
latency = zeros(1, 10);
jitter = zeros(1, 10);

% Calculate Bandwidth
for x = 1:10
    Bandwidth(x) = (dataSize(x) * 8) / (timeTaken(x) * 1000); 
end 

disp('Bandwidth (kbps): ');
disp(Bandwidth);

% Calculate Propagation Delay
for y = 1:10
    propagationDelay(y) = (distance(y) * 1000) ./ (speedOfLight(y) - (y-1) + 1);  
end

disp('Propagation Delay (ms): ');
disp(propagationDelay);

% Determine Queue Type
for x = 1:10
    if queueLength > threshold(x)
        queueType{x} = "Congested";
        answer(x) = 1;
    else
        queueType{x} = "Not Congested";
        answer(x) = 0;
    end
end

disp('Queue Type: ');
disp(queueType);

% Calculate Latency
for i = 1:10
    latency(i) = (dataSize(i) * 8) ./ (Bandwidth(i) * 1000);
end

disp("Latency (ms):");
disp(latency);

% Calculate Throughput
for i = 1:10
    throughput(i) = dataSize(i) ./ timeTaken(i);
end

disp("Throughput");
disp(throughput);

% Calculate Jitter
for i = 1:10
    jitter(i) = latency(i) ./ throughput(i);
end

disp("Jitter (bits/ms)");
disp(jitter);

% Plotting
figure;
plot(dataSize, Bandwidth, 'b-o');
xlabel('Data Size');
ylabel('Bandwidth (kbps)');
title('Bandwidth vs. Data Size');

figure;
plot(distance, propagationDelay, 'r-*');
xlabel('Distance');
ylabel('Propagation Delay (ms)');
title('Propagation Delay vs. Distance');

figure;
bar(answer);
set(gca, 'XTickLabel', threshold);
xlabel('Threshold');
ylabel('Congestion (1: Congested, 0: Not Congested)');
title('Congestion Status');

figure;
plot(dataSize, latency, 'g-s');
xlabel('Data Size');
ylabel('Latency (ms)');
title('Latency vs. Data Size');

figure;
plot(timeTaken, throughput, 'm-d');
xlabel('Time Taken');
ylabel('Throughput');
title('Throughput vs. Time Taken');

figure;
plot(jitter, 'k-x');
xlabel('Data Size/Time Taken Index');
ylabel('Jitter (bits/ms)');
title('Jitter vs. Data Size/Time Taken Index');