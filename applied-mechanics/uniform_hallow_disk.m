clear all;
close all;

global rho = 8000;
global nu = 0.3;
global Ra = 0.25;
global omega = 1256.63706; # Radian per second
global sigma_a = 200e6;

function sigma = uniform_stress_equation_radical(r, R0)
  global rho nu Ra omega sigma_a;
  sigma = (3 + nu)/8 .* rho .* (omega.^2) .* ...
    ((Ra.^2) + (R0.^2) - (Ra.^2).*(R0.^2)./(r.^2) - (r.^2)) +...
    sigma_a .* (Ra.^2 .* (r.^2 - R0.^2)) ./ (r.^2 .* (Ra.^2 - R0.^2));
endfunction

function sigma = uniform_stress_equation_tangent(r, R0)
  global rho nu Ra omega sigma_a;
  sigma = (3 + nu)/8 .* rho .* (omega.^2) .* ...
    ((Ra.^2) + (R0.^2) + (Ra.^2).*(R0.^2)./(r.^2) - (1+3*nu)/(3+nu).*(r.^2)) +...
    sigma_a .* (Ra.^2 .* (r.^2 + R0.^2)) ./ (r.^2 .* (Ra.^2 - R0.^2));
endfunction


R = linspace(0.005, Ra, 100);
radical = uniform_stress_equation_radical(R, 0.005);
tangent = uniform_stress_equation_tangent(R, 0.005);
hold on;
plot(radical, R, 'r-');
plot(tangent, R, 'r--');
text(3e8, 0.005, 'r = 0.005')

R = linspace(0.01, Ra, 100);
radical = uniform_stress_equation_radical(R, 0.01);
tangent = uniform_stress_equation_tangent(R, 0.01);
plot(radical, R, 'm-');
plot(tangent, R, 'm--');
text(2e8, 0.018, 'r = 0.01')

R = linspace(0.02, Ra, 100);
radical = uniform_stress_equation_radical(R, 0.02);
tangent = uniform_stress_equation_tangent(R, 0.02);
plot(radical, R, 'b-');
plot(tangent, R, 'b--');
text(1.5e8, 0.03, 'r = 0.02')

R = linspace(0.05, Ra, 100);
radical = uniform_stress_equation_radical(R, 0.05);
tangent = uniform_stress_equation_tangent(R, 0.05);
plot(radical, R, 'g-');
plot(tangent, R, 'g--');
text(1e8, 0.07, 'r = 0.05')

line([800e6 800e6], ylim, "linestyle", "--", 'color', 'red', 'linewidth', 2);
xlim([0 1100e6]);
xlabel('Stress (Pa)');
ylabel('Radius (m)');
print -depsc2 'part-2-question-2.eps'

