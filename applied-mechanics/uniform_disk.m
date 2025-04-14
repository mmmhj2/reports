clear all;

global rho = 8000;
global nu = 0.3;
global Ra = 0.25;
global omega = 1256.63706; # Radian per second
global sigma_a = 200e6;

function sigma = uniform_stress_equation_radical(r)
  global rho nu Ra omega sigma_a;
  sigma = (3 + nu) / 8 .* rho .* omega .* omega .* (Ra.*Ra - r.*r) + sigma_a;
  # sigma(2) = rho .* omega .* omega / 8 .* ((3+nu).*Ra.*Ra - (1+3*nu).*r.*r) + sigma_a;
endfunction

function sigma = uniform_stress_equation_tangent(r)
  global rho nu Ra omega sigma_a;
  sigma = rho .* omega .* omega / 8 .* ((3+nu).*Ra.*Ra - (1+3*nu).*r.*r) + sigma_a;
endfunction

R = linspace(0, Ra, 100);
# plot(R, uniform_stress_equation_radical(R), R, uniform_stress_equation_tangent(R))
hold on;
radical = uniform_stress_equation_radical(R);
tangent = uniform_stress_equation_tangent(R);

plot(uniform_stress_equation_radical(R), R);
plot(uniform_stress_equation_tangent(R), R);

# xline(800e6, 'r', 'Admissible stress');
line([800e6 800e6], ylim, "linestyle", "--", 'color', 'red', 'linewidth', 2);
xlim([0 800e6]);
legend('Radical Stress', 'Tangential Stress', 'Permissible Stress');
xlabel('Stress (Pa)');
ylabel('Radius (m)');
print -depsc2 'part-2-question-1.eps'

