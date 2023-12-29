function ydot = fpend(y, L, m, g)
%fpend is the system of functions
% y is the input from the previous timestep (variable) 
            %i.e. theta (rad) and omega (rad/sec)
% L is the vector of rod lengths (constant, in meters)
% m is the vector of point masses (constant, in kilograms)
% g is the gravitational constant (constant, in meters/second^2)

ydot = [y(3), ...
        y(4), ...
        (-g*(2*m(1) + m(2))*sin(y(1))  - m(2)*g*sin(y(1) - 2*y(2)) - 2*sin(y(1) - y(2))*m(2)*(y(4)^2*L(2) + y(3)^2*L(1)*cos(y(1) - y(2)))) ...
                    / (L(1)*(2*m(1) + m(2) - m(2)*cos(2*y(1) - 2*y(2)))), ...
        (2*sin(y(1) - y(2))*(y(3)^2 * L(1)*(m(1) + m(2)) + g*(m(1) + m(2))*cos(y(1)) + y(4)^2*L(2)*m(2)*cos(y(1) - y(2)))) ...
                    / (L(2)*(2*m(1) + m(2) - m(2)*cos(2*y(1) - 2*y(2))))];

end

