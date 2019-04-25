%% --------------------------------------------------------------------- %%
%                           ** TOBS class **                              %
%-------------------------------------------------------------------------%

classdef TOBS
    
    %% Properties
    properties
        
        % TOBS parameters
        epsilons
        flip_limits
        symmetry
        
        % Densities (for FEA analysis) and design variables (binary)
        rho_min
        densities
        design_variables
        
        % Objective and sensitivities
        objective
        objective_sensitivities
        
        % Constraints and sensitivities
        % [ constraint_1, constraint_2, ..., constraint_n ]
        constraints
        constraints_limits
        constraints_sensitivities
        
        % Optimization history
        % [ objective, constraint_1, constraint_2, ..., constraint_n ]
        history
        
    end
    
    %% Methods
    methods
        
        %% Constructor
        function tobs = TOBS()
            
            disp([' '])
            disp(['         Preparing TOBS.'])
            
            % Default symmetry condition
            tobs.symmetry = 0;
            
        end % end Constructor
        
        %% Function to solve optimization problem with ILP
            function tobs = SolveWithILP(tobs)
            
%             % Add CPLEX library.
%             addpath('/opt/ibm/ILOG/CPLEX_Studio1271/cplex/matlab/x86-64_linux');
%             addpath('/opt/ibm/ILOG/CPLEX_Studio1271/cplex/examples/src/');

            % Prepare ILP problem.
            clear options
            options.Symmetry = tobs.symmetry;
%             options.Optimizer = 'cplex';
            options.Optimizer = 'intlinprog';
            COptimize = ILP (tobs.epsilons', tobs.constraints_limits', tobs.constraints', tobs.design_variables, tobs.flip_limits, 'Minimize');
            tobs.design_variables = COptimize.Optimize (tobs.objective_sensitivities, tobs.constraints_sensitivities, options);
            
        end % end SolveWithILP
    
    end % end methods
end