close all;
clear all;

global rho = 8000;
global nu = 0.3;
global Ra = 0.25;
global omega = 1256.63706; # Radian per second
global sigma_a = 200e6;
global K = (500 - 200) / Ra;
global alpha = 18e-6;
global E = 160e9;

function sigma = thermal_stress_radical(r)
  global rho nu Ra omega sigma_a K alpha E;
  sigma = alpha * K * E / 3 * (Ra - r);
endfunction

function sigma = thermal_stress_tangent(r)
  global rho nu Ra omega sigma_a K alpha E;
  sigma = alpha * K * E / 3 * (Ra - 2*r);
endfunction

function sigma = uniform_stress_equation_radical(r)
  global rho nu Ra omega sigma_a;
  sigma = (3 + nu) / 8 .* rho .* omega .* omega .* (Ra.*Ra - r.*r) + sigma_a;
endfunction

function sigma = uniform_stress_equation_tangent(r)
  global rho nu Ra omega sigma_a;
  sigma = rho .* omega .* omega / 8 .* ((3+nu).*Ra.*Ra - (1+3*nu).*r.*r) + sigma_a;
endfunction

R = linspace(0, Ra, 100);

hold on;
plot(thermal_stress_radical(R) + uniform_stress_equation_radical(R), R);
plot(thermal_stress_tangent(R) + uniform_stress_equation_tangent(R), R);
line([800e6 800e6], ylim, "linestyle", "--", 'color', 'red', 'linewidth', 2);
# xlim([0 800e6]);
legend('Radical Stress', 'Tangential Stress', 'Permissible Stress');
xlabel('Stress (Pa)');
ylabel('Radius (m)');
print -depsc2 'part-2-question-4.eps'

