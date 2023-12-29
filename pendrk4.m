function w = pendrk4(a, b, alpha, L, m, g, h)
%a is the initial time step
%b is the final time step
%alpha is the vector of initial conditions (i.e thetas (rad), omegas (rad/sec))
% L is the vector of rod lengths (constant, in meters)
% m is the vector of point masses (constant, in kilograms)
% g is the gravitational constant (constant, in meters/second^2)
% h is the delta per time step

t = (a:h:b)';
N = (b - a)/(h);
w = zeros(N+1, length(alpha));
w(1,:) = alpha;

for i = 1:N
    k1 = h * fpend(w(i,:), L, m, g);
    k2 = h * fpend(w(i,:) + k1/2, L, m, g);
    k3 = h * fpend(w(i,:) + k2/2, L, m, g);
    k4 = h * fpend(w(i,:) + k3, L, m, g);
    
    w(i+1, :) = w(i,:) + (1/6) .* (k1 + 2*k2 + 2*k3 + k4);
end


%th2 = w(:, 2);
%plot(t, th2, 'Linewidth', 2)
%hold on
