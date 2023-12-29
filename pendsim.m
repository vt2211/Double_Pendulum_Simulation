function pendsim(a, b, y, L, m, g, h)
%a is the initial time step
%b is the final time step
%alpha is the vector of initial conditions (i.e thetas (rad), omegas (rad/sec))
% L is the vector of rod lengths (constant, in meters)
% m is the vector of point masses (constant, in kilograms)
% g is the gravitational constant (constant, in meters/second^2)
% h is the delta per time step


%in case input y only consists of initial thetas
alpha = zeros(1, 4);
for i=1:length(y)
    if length(y) > length(alpha)
        return
    end
    alpha(i) = y(i);
end

%solving the system of differential equation
w = pendrk4(a, b, alpha, L, m, g, h);

%extracting the angles at time steps
th1 = w(:, 1);
th2 = w(:, 2);

%converting angles to cartesian coordinates
%L_rel = L(2)/L(1);
L_sum = sum(L);

x1 = L(1)*sin(th1);
y1 = -L(1)*cos(th1);

x2 = x1 + L(2)*sin(th2);
y2 = y1 - L(2)*cos(th2);

%Plotting the data
nth1 = numel(w(:, 1));
nth2 = numel(w(:, 1));
if all([nth1,nth2] > 1)
    if nth1 ~= nth2, error('Vector inputs must be equal lengths'); end
    for i = 1:nth1
        hold off
        %cla, axis equal, axis([-2.1,2.1,-2.1, 0.5]), grid on
        cla, grid on, 
        axis([-1.5*L_sum,1.5*L_sum,-1.5*L_sum, 0.5*L_sum])
        xlabel("horizontal position (m)"), ylabel("vertical position (m)")
        title("Simulation of the Double Pendulum")
        line([-.3*L_sum,.3*L_sum], [0,0], 'linewidth',5, 'color','b')
        line([0,x1(i),x2(i)], [0,y1(i),y2(i)], 'linewidth',3, 'color','k')
        line([x1(i),x2(i)], [y1(i),y2(i)], 'linestyle','none','marker','.', ...
        'markersize',32, 'color','r')
        pause(h)
    end
    return
end
