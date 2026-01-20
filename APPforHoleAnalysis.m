function holeAreaAnalysisUI()
    fig = uifigure('Name', 'Pore Analysis and Capacitor Calculation System', 'Position', [100 100 800 700]);
    tabgroup = uitabgroup(fig, 'Position', [20 20 760 660]);
    tab1 = uitab(tabgroup, 'Title', 'Image Recognition and Analysis');
    uilabel(tab1, 'Position', [50 600 400 30], ...
        'Text', 'SEM Image Pore Area Analysis', 'FontSize', 16, 'FontWeight', 'bold');
    loadButton = uibutton(tab1, 'push', ...
        'Position', [50 550 150 30], ...
        'Text', 'Select Image File', ...
        'ButtonPushedFcn', @(btn,event) analyzeHoleArea());
    resultLabel = uilabel(tab1, 'Position', [50 450 500 80], ...
        'Text', 'Please select an image file to start the analysis', ...
        'FontSize', 12, 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.95 0.95 0.95], ...
        'WordWrap', 'on');
    tab2 = uitab(tabgroup, 'Title', 'Parameter Calculation');
    uilabel(tab2, 'Position', [50 600 400 30], ...
        'Text', 'Capacitor Hole Parameter Calculation', 'FontSize', 16, 'FontWeight', 'bold');
    uilabel(tab2, 'Position', [50 550 150 22], 'Text', 'Proportion of hole area (%):', 'FontSize', 10);
    holeRatioEdit = uieditfield(tab2, 'numeric', 'Position', [200 550 100 22], 'Value', 41.04);
    uilabel(tab2, 'Position', [50 520 150 22], 'Text', 'Rated Static Capacity C (μF):', 'FontSize', 10);
    C_edit = uieditfield(tab2, 'numeric', 'Position', [200 520 100 22], 'Value', 3300);
    uilabel(tab2, 'Position', [50 490 150 22], 'Text', 'Anode foil width b_ano (m):', 'FontSize', 10);
    b_ano_edit = uieditfield(tab2, 'numeric', 'Position', [200 490 100 22], 'Value', 0.032);
    uilabel(tab2, 'Position', [50 460 150 22], 'Text', 'Anode foil length l_ano (m):', 'FontSize', 10);
    l_ano_edit = uieditfield(tab2, 'numeric', 'Position', [200 460 100 22], 'Value', 0.75);
    uilabel(tab2, 'Position', [50 430 150 22], 'Text', 'Hole depth h_p (μm):', 'FontSize', 10);
    h_edit = uieditfield(tab2, 'numeric', 'Position', [200 430 100 22], 'Value', 40);
    uilabel(tab2, 'Position', [50 400 150 22], 'Text', 'Growth Factor a (nm/V):', 'FontSize', 10);
    a_edit = uieditfield(tab2, 'numeric', 'Position', [200 400 100 22], 'Value', 1.2);
    uilabel(tab2, 'Position', [50 370 150 22], 'Text', 'Rated Voltage U (V):', 'FontSize', 10);
    U_edit = uieditfield(tab2, 'numeric', 'Position', [200 370 100 22], 'Value', 63);
    uilabel(tab2, 'Position', [50 340 150 22], 'Text', 'Dielectric constant ε_r:', 'FontSize', 10);
    epsilon_edit = uieditfield(tab2, 'numeric', 'Position', [200 340 100 22], 'Value', 10);
    calcButton = uibutton(tab2, 'push', ...
        'Position', [50 300 150 30], ...
        'Text', 'Calculate hole parameters', ...
        'ButtonPushedFcn', @(btn,event) calculateHoleParams());
    paramResultLabel = uilabel(tab2, 'Position', [50 100 500 200], ...
        'Text', 'The calculation results of the hole parameters will be displayed here.', ...
        'FontSize', 10, 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.9 0.95 0.9], ...
        'WordWrap', 'on');
    function analyzeHoleArea()
        try
            [filename, pathname] = uigetfile({'*.jpg;*.png;*.tif;*.bmp', 'Image file'}, 'Select SEM image');
            if isequal(filename, 0)
                resultLabel.Text = 'No file selected!';
                return;
            end

            originalImage = imread(fullfile(pathname, filename));

            if size(originalImage, 3) == 3
                grayImage = im2gray(originalImage);
            else
                grayImage = originalImage;
            end

            enhancedImage = imadjust(grayImage);
            filteredImage = medfilt2(enhancedImage, [3 3]);

            initialThreshold = graythresh(filteredImage);
            binaryImage = imbinarize(filteredImage, initialThreshold);

            totalPixels = numel(binaryImage);
            holePixels = sum(binaryImage(:));
            holeAreaRatio = ((totalPixels-holePixels) / totalPixels) * 100;

            resultText = sprintf('Proportion of hole area: %.4f%%', holeAreaRatio);
            resultLabel.Text = resultText;

            showAnalysisImages(originalImage, grayImage, filteredImage, binaryImage, holeAreaRatio);
            
            fprintf('Proportion of hole area: %.4f%%\n', holeAreaRatio);
            
        catch ME
            resultLabel.Text = sprintf('Analysis Error: %s', ME.message);
        end
    end


    function calculateHoleParams()
        try

            hole_ratio = holeRatioEdit.Value / 100;   
            C = C_edit.Value * 1e-6;                  
            A_total = 2*b_ano_edit.Value * l_ano_edit.Value;           
            h_p = h_edit.Value * 1e-6;              
            t_ox = a_edit.Value * 1e-9 * U_edit.Value;           
            epsilon_r = epsilon_edit.Value;          
            epsilon_0 = 8.854e-12;                 
            

            C_unit = (epsilon_0 * epsilon_r) / t_ox;  
            A_pore_total = hole_ratio * A_total;
            A_non_pore = A_total - A_pore_total;
            target_C = C;
            
            func = @(d) calculateCapacitance(d, A_pore_total, h_p, A_non_pore, C_unit) - target_C;

            options = optimset('Display', 'off');
            d_initial = 1e-6; 
            try
                d_solution = fzero(func, d_initial, options);
            catch
               
                d_range = linspace(0.1e-6, 10e-6, 1000);
                C_values = arrayfun(@(d) calculateCapacitance(d, A_pore_total, h_p, A_non_pore, C_unit), d_range);
                [~, idx] = min(abs(C_values - target_C));
                d_solution = d_range(idx);
            end

            A_pore_single = pi * d_solution^2 / 4;                    
            N = A_pore_total / A_pore_single;                         
            n_single_side = N / 2;                                  
            A_single_side = A_total / 2;                              
            a_square = sqrt(A_single_side / n_single_side);           

            resultText = {
                sprintf('=== Hole Parameter Calculation Results ===')
                sprintf('Hole diameter: %.3f μm', d_solution * 1e6)
                sprintf('Average pore spacing: %.3f μm', a_square * 1e6)
            };
            
            paramResultLabel.Text = strjoin(resultText, newline);

            fprintf('\n=== Hole Parameter Calculation Results ===\n');
            for i = 1:length(resultText)
                fprintf('%s\n', resultText{i});
            end
            
        catch ME
            paramResultLabel.Text = sprintf('Calculation error: %s', ME.message);
        end
    end

    function C_calc = calculateCapacitance(d, A_pore_total, h_p, A_non_pore, C_unit)
        A_pore_single = pi * d^2 / 4;
        N = A_pore_total / A_pore_single;
        A_effective = N * (pi * d * h_p + A_pore_single) + A_non_pore;
        C_calc = A_effective * C_unit;
    end


    function showAnalysisImages(originalImage, grayImage, filteredImage, binaryImage, holeAreaRatio)

        fig2 = figure('Name', 'Analysis Results of Hole Area Ratio', 'Position', [100, 100, 1200, 600]);
        

        subplot(2, 3, 1);
        imshow(originalImage);

        subplot(2, 3, 2);
        imshow(filteredImage);

        subplot(2, 3, 3);
        imshow(binaryImage);

        subplot(2, 3, 4);
        imshow(originalImage);
        hold on;

        boundaryMask = bwperim(binaryImage);
        [boundaryY, boundaryX] = find(boundaryMask);
        plot(boundaryX, boundaryY, 'r.', 'MarkerSize', 0.001);

        subplot(2, 3, 5);
        imshow(label2rgb(bwlabel(binaryImage)));
        title('False color display of hole area');

        subplot(2, 3, 6);
        axis off;
        
        results = {
            sprintf('=== Analysis Results ===')
            sprintf('Proportion of hole area: %.4f%%', holeAreaRatio)
        };
        
        text(0.05, 0.5, results, 'FontSize', 14, 'VerticalAlignment', 'middle', ...
            'FontName', 'Consolas', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    end
end