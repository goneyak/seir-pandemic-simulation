function seir_all_scenarios()
    % === Common Parameters ===
    sigma_base = 1/5;
    gamma_base = 1/7;
    N = 10000;
    tspan = [0 360];

    % === Scenario Definitions ===
    scenarios = {
        'Baseline',              0.5, sigma_base, gamma_base, 1.0, 1
        'Reduced beta 0.25',     0.25, sigma_base, gamma_base, 1.0, 1
        'Reduced beta 0.1',      0.1,  sigma_base, gamma_base, 1.0, 1
        'Increased gamma 1/5',   0.5, sigma_base, 1/5,         1.0, 1
        'Increased gamma 1/3',   0.5, sigma_base, 1/3,         1.0, 1
        'Short sigma 1/3',       0.5, 1/3,        gamma_base,  1.0, 1
        'Long sigma 1/7',        0.5, 1/7,        gamma_base,  1.0, 1
        '30 percent Vaccinated', 0.5, sigma_base, gamma_base,  0.7, 1
        '60 percent Vaccinated', 0.5, sigma_base, gamma_base,  0.4, 1
        'I0 10',                 0.5, sigma_base, gamma_base,  1.0, 10
        'I0 100',                0.5, sigma_base, gamma_base,  1.0, 100
    };

    output_dir = 'SEIR_Output';
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end

    % === Run Simulation for Each Scenario ===
    for i = 1:size(scenarios,1)
        % Load scenario parameters
        scenario_name = scenarios{i,1};
        beta          = scenarios{i,2};
        sigma         = scenarios{i,3};
        gamma         = scenarios{i,4};
        s0_ratio      = scenarios{i,5};
        I0            = scenarios{i,6};

        % Set initial conditions
        E0 = 0; R0 = 0;
        S0 = s0_ratio * N - I0;

        % Skip if initial susceptible population is negative
        if S0 < 0
            warning('Scenario %s skipped due to negative S0.', scenario_name);
            continue;
        end

        y0 = [S0; E0; I0; R0];

        % Solve ODE
        [t, y] = ode45(@(t, y) seir_ode(t, y, beta, sigma, gamma, N), tspan, y0);

        % Plot results
        figure('Visible','off');
        plot(t, y, 'LineWidth', 2);
        legend('Susceptible', 'Exposed', 'Infectious', 'Recovered');
        title(['SEIR: ', scenario_name], 'Interpreter', 'none');
        xlabel('Time (days)');
        ylabel('Population');
        grid on;

        safe_name = regexprep(scenario_name, '[^\w\s-]', '');
        safe_name = strrep(safe_name, ' ', '_');

        % Save plot
        saveas(gcf, fullfile(output_dir, ['SEIR_', safe_name, '.png']));
        close(gcf);
    end
end

% === SEIR ODE System ===
function dydt = seir_ode(~, y, beta, sigma, gamma, N)
    S = y(1); E = y(2); I = y(3); R = y(4);
    dS = -beta * S * I / N;
    dE = beta * S * I / N - sigma * E;
    dI = sigma * E - gamma * I;
    dR = gamma * I;
    dydt = [dS; dE; dI; dR];
end
