function [vals, exact, err, hs, slope] = error_analysis(a, b, alpha, L, m, g)
%a is the initial time step
%b is the final time step
%alpha is the vector of initial conditions (i.e thetas (rad), omegas (rad/sec))
% L is the vector of rod lengths (constant, in meters)
% m is the vector of point masses (constant, in kilograms)
% g is the gravitational constant (constant, in meters/second^2)

w_e = pendrk4(a, b, alpha, L, m, g, 0.001);
exact = w_e(length(w_e),2);

vals = zeros(1, 4);
hs = zeros(1, 4);
for k = 1:4
    w_k = pendrk4(a, b, alpha, L, m, g, 0.05/(2^(k-1)));
    vals(k) = w_k(length(w_k),2);
    hs(k) = 0.05/(2^(k-1));
end

err = vals - exact;

figure(1)
hold off
loglog(hs, vals, 'ob', 'LineWidth', 4)
xlabel('h'); ylabel('errors')
title('loglog scale')
grid on

figure(2)
hold on
plot(log(hs), log(err), 'ob', 'LineWidth', 5)
xlabel('log(h)')
ylabel('log(errors)')
title('linear scale')
plot(log(hs), log(err), '--m', 'LineWidth', 3)
xlabel('log(h)')
ylabel('log(errors)')
title('linear scale')

logerrors = log(err);
loghs = log(hs);
slope = (logerrors(4) - logerrors(1))/(loghs(4) - loghs(1));




