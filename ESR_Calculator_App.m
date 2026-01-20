function ESR_Calculator_App
    fig = uifigure('Name', 'Aluminum Electrolytic Capacitor ESR Calculator (with Contribution Analysis)', ...
                  'Position', [100, 100, 1400, 850]);
    gl_main = uigridlayout(fig, [1, 2]);
    gl_main.RowHeight = {'1x'};
    gl_main.ColumnWidth = {'0.6x', '1x'};
    gl_main.Padding = [10, 10, 10, 10];
    gl_main.RowSpacing = 10;
    gl_main.ColumnSpacing = 10;
    input_panel = uipanel(gl_main);
    input_panel.Layout.Row = 1;
    input_panel.Layout.Column = 1;
    input_panel.Title = 'Parameter Input';
    input_panel.Scrollable = 'on';
    gl_right = uigridlayout(gl_main, [4, 1]);
    gl_right.RowHeight = {'0.25x', '0.25x', '0.25x', '0.25x'};
    gl_right.ColumnWidth = {'1x'};
    gl_right.Layout.Row = 1;
    gl_right.Layout.Column = 2;
    gl_right.RowSpacing = 10;
    result_panel = uipanel(gl_right);
    result_panel.Layout.Row = 1;
    result_panel.Layout.Column = 1;
    result_panel.Title = 'ESR Calculation Result';
    contrib_panel = uipanel(gl_right);
    contrib_panel.Layout.Row = 2;
    contrib_panel.Layout.Column = 1;
    contrib_panel.Title = 'ESR Contribution Analysis';
    freq_panel = uipanel(gl_right);
    freq_panel.Layout.Row = 3;
    freq_panel.Layout.Column = 1;
    freq_panel.Title = 'Frequency Characteristic Curve';
    temp_panel = uipanel(gl_right);
    temp_panel.Layout.Row = 4;
    temp_panel.Layout.Column = 1;
    temp_panel.Title = 'Temperature Characteristic Curve';
    build_parameter_input_simple(input_panel, result_panel, contrib_panel, freq_panel, temp_panel);
end

function build_parameter_input_simple(input_panel, result_panel, contrib_panel, freq_panel, temp_panel)
    tabgroup = uitabgroup(input_panel);
    tabgroup.Position = [10, 50, 450, 650];
    tab_structural = uitab(tabgroup, 'Title', 'Structural Parameters');
    tab_material = uitab(tabgroup, 'Title', 'Material Parameters');
    tab_working = uitab(tabgroup, 'Title', 'Working Conditions');
    button_panel = uipanel(input_panel);
    button_panel.Position = [10, 10, 450, 35];
    ui_components = struct();
    gl_structural = uigridlayout(tab_structural, [16, 2]);
    gl_structural.RowHeight = repmat(30, 1, 16);
    gl_structural.ColumnWidth = {'1x', '1.5x'};
    gl_structural.Padding = [10, 10, 10, 10];
    gl_structural.RowSpacing = 8;
    gl_structural.ColumnSpacing = 10;
    current_row = 1;
    ui_components.label_L = uilabel(gl_structural);
    ui_components.label_L.Text = 'Anode Foil Length (m):';
    ui_components.label_L.Layout.Row = current_row;
    ui_components.label_L.Layout.Column = 1;
    ui_components.L_edit = uieditfield(gl_structural, 'numeric');
    ui_components.L_edit.Value = 0.75;
    ui_components.L_edit.Layout.Row = current_row;
    ui_components.L_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_W = uilabel(gl_structural);
    ui_components.label_W.Text = 'Anode Foil Width (m):';
    ui_components.label_W.Layout.Row = current_row;
    ui_components.label_W.Layout.Column = 1;
    ui_components.W_edit = uieditfield(gl_structural, 'numeric');
    ui_components.W_edit.Value = 0.032;
    ui_components.W_edit.Layout.Row = current_row;
    ui_components.W_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_t_core = uilabel(gl_structural);
    ui_components.label_t_core.Text = 'Anode Aluminum Core Thickness (μm):';
    ui_components.label_t_core.Layout.Row = current_row;
    ui_components.label_t_core.Layout.Column = 1;
    ui_components.t_core_edit = uieditfield(gl_structural, 'numeric');
    ui_components.t_core_edit.Value = 33;
    ui_components.t_core_edit.Layout.Row = current_row;
    ui_components.t_core_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_t_cathode = uilabel(gl_structural);
    ui_components.label_t_cathode.Text = 'Cathode Foil Thickness (μm):';
    ui_components.label_t_cathode.Layout.Row = current_row;
    ui_components.label_t_cathode.Layout.Column = 1;
    ui_components.t_cathode_edit = uieditfield(gl_structural, 'numeric');
    ui_components.t_cathode_edit.Value = 44;
    ui_components.t_cathode_edit.Layout.Row = current_row;
    ui_components.t_cathode_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_t_porous = uilabel(gl_structural);
    ui_components.label_t_porous.Text = 'Anode Porous Layer Thickness (μm):';
    ui_components.label_t_porous.Layout.Row = current_row;
    ui_components.label_t_porous.Layout.Column = 1;
    ui_components.t_porous_edit = uieditfield(gl_structural, 'numeric');
    ui_components.t_porous_edit.Value = 40;
    ui_components.t_porous_edit.Layout.Row = current_row;
    ui_components.t_porous_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_d_p = uilabel(gl_structural);
    ui_components.label_d_p.Text = 'Electrolyte Paper Thickness (μm):';
    ui_components.label_d_p.Layout.Row = current_row;
    ui_components.label_d_p.Layout.Column = 1;
    ui_components.d_p_edit = uieditfield(gl_structural, 'numeric');
    ui_components.d_p_edit.Value = 58;
    ui_components.d_p_edit.Layout.Row = current_row;
    ui_components.d_p_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_d_oxide = uilabel(gl_structural);
    ui_components.label_d_oxide.Text = 'Oxide Film Thickness (nm):';
    ui_components.label_d_oxide.Layout.Row = current_row;
    ui_components.label_d_oxide.Layout.Column = 1;
    ui_components.d_oxide_edit = uieditfield(gl_structural, 'numeric');
    ui_components.d_oxide_edit.Value = 75;
    ui_components.d_oxide_edit.Layout.Row = current_row;
    ui_components.d_oxide_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_hole_diam = uilabel(gl_structural);
    ui_components.label_hole_diam.Text = 'Hole Diameter (μm):';
    ui_components.label_hole_diam.Layout.Row = current_row;
    ui_components.label_hole_diam.Layout.Column = 1;
    ui_components.hole_diam_edit = uieditfield(gl_structural, 'numeric');
    ui_components.hole_diam_edit.Value = 1.1;
    ui_components.hole_diam_edit.Layout.Row = current_row;
    ui_components.hole_diam_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_hole_spacing = uilabel(gl_structural);
    ui_components.label_hole_spacing.Text = 'Hole Spacing (μm):';
    ui_components.label_hole_spacing.Layout.Row = current_row;
    ui_components.label_hole_spacing.Layout.Column = 1;
    ui_components.hole_spacing_edit = uieditfield(gl_structural, 'numeric');
    ui_components.hole_spacing_edit.Value = 1.5;
    ui_components.hole_spacing_edit.Layout.Row = current_row;
    ui_components.hole_spacing_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_L_left = uilabel(gl_structural);
    ui_components.label_L_left.Text = 'Anode Lead Length (m):';
    ui_components.label_L_left.Layout.Row = current_row;
    ui_components.label_L_left.Layout.Column = 1;
    ui_components.L_left_edit = uieditfield(gl_structural, 'numeric');
    ui_components.L_left_edit.Value = 0.622;
    ui_components.L_left_edit.Layout.Row = current_row;
    ui_components.L_left_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_Ls = uilabel(gl_structural);
    ui_components.label_Ls.Text = 'Series Inductance (nH):';
    ui_components.label_Ls.Layout.Row = current_row;
    ui_components.label_Ls.Layout.Column = 1;
    ui_components.L_s_edit = uieditfield(gl_structural, 'numeric');
    ui_components.L_s_edit.Value = 60;
    ui_components.L_s_edit.Layout.Row = current_row;
    ui_components.L_s_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_Rc = uilabel(gl_structural);
    ui_components.label_Rc.Text = 'Contact Resistance (mΩ):';
    ui_components.label_Rc.Layout.Row = current_row;
    ui_components.label_Rc.Layout.Column = 1;
    ui_components.R_contact_edit = uieditfield(gl_structural, 'numeric');
    ui_components.R_contact_edit.Value = 0;
    ui_components.R_contact_edit.Layout.Row = current_row;
    ui_components.R_contact_edit.Layout.Column = 2;
    current_row = current_row + 1;
    empty_label1 = uilabel(gl_structural);
    empty_label1.Text = '';
    empty_label1.Layout.Row = current_row;
    empty_label1.Layout.Column = 1;
    current_row = current_row + 1;
    gl_material = uigridlayout(tab_material, [18, 2]);
    gl_material.RowHeight = repmat(30, 1, 18);
    gl_material.ColumnWidth = {'1x', '1.5x'};
    gl_material.Padding = [10, 10, 10, 10];
    gl_material.RowSpacing = 8;
    gl_material.ColumnSpacing = 10;
    current_row = 1;
    oxide_title = uilabel(gl_material);
    oxide_title.Text = 'Oxide Film Parameters';
    oxide_title.FontWeight = 'bold';
    oxide_title.FontSize = 11;
    oxide_title.HorizontalAlignment = 'center';
    oxide_title.BackgroundColor = [0.9, 0.9, 0.9];
    oxide_title.Layout.Row = current_row;
    oxide_title.Layout.Column = [1, 2];
    current_row = current_row + 1;
    ui_components.label_epsilon_r = uilabel(gl_material);
    ui_components.label_epsilon_r.Text = 'Relative Permittivity:';
    ui_components.label_epsilon_r.Layout.Row = current_row;
    ui_components.label_epsilon_r.Layout.Column = 1;
    ui_components.epsilon_r_edit = uieditfield(gl_material, 'numeric');
    ui_components.epsilon_r_edit.Value = 10;
    ui_components.epsilon_r_edit.Layout.Row = current_row;
    ui_components.epsilon_r_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_tan_delta = uilabel(gl_material);
    ui_components.label_tan_delta.Text = 'Loss Tangent:';
    ui_components.label_tan_delta.Layout.Row = current_row;
    ui_components.label_tan_delta.Layout.Column = 1;
    ui_components.tan_delta_edit = uieditfield(gl_material, 'numeric');
    ui_components.tan_delta_edit.Value = 0.01731;
    ui_components.tan_delta_edit.Layout.Row = current_row;
    ui_components.tan_delta_edit.Layout.Column = 2;
    current_row = current_row + 1;
    al_title = uilabel(gl_material);
    al_title.Text = 'Aluminum Material Parameters';
    al_title.FontWeight = 'bold';
    al_title.FontSize = 11;
    al_title.HorizontalAlignment = 'center';
    al_title.BackgroundColor = [0.9, 0.9, 0.9];
    al_title.Layout.Row = current_row;
    al_title.Layout.Column = [1, 2];
    current_row = current_row + 1;
    ui_components.label_alpha_Al = uilabel(gl_material);
    ui_components.label_alpha_Al.Text = 'Resistivity Temperature Coefficient:';
    ui_components.label_alpha_Al.Layout.Row = current_row;
    ui_components.label_alpha_Al.Layout.Column = 1;
    ui_components.alpha_Al_edit = uieditfield(gl_material, 'numeric');
    ui_components.alpha_Al_edit.Value = 0.00403;
    ui_components.alpha_Al_edit.Layout.Row = current_row;
    ui_components.alpha_Al_edit.Layout.Column = 2;
    current_row = current_row + 1;
    electrolyte_title = uilabel(gl_material);
    electrolyte_title.Text = 'Electrolyte Conductivity Parameters';
    electrolyte_title.FontWeight = 'bold';
    electrolyte_title.FontSize = 11;
    electrolyte_title.HorizontalAlignment = 'center';
    electrolyte_title.BackgroundColor = [0.9, 0.9, 0.9];
    electrolyte_title.Layout.Row = current_row;
    electrolyte_title.Layout.Column = [1, 2];
    current_row = current_row + 1;
    ui_components.label_elec_A = uilabel(gl_material);
    ui_components.label_elec_A.Text = 'Coefficient A:';
    ui_components.label_elec_A.Layout.Row = current_row;
    ui_components.label_elec_A.Layout.Column = 1;
    ui_components.elec_A_edit = uieditfield(gl_material, 'numeric');
    ui_components.elec_A_edit.Value = 1.80;
    ui_components.elec_A_edit.Layout.Row = current_row;
    ui_components.elec_A_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_elec_B = uilabel(gl_material);
    ui_components.label_elec_B.Text = 'Coefficient B:';
    ui_components.label_elec_B.Layout.Row = current_row;
    ui_components.label_elec_B.Layout.Column = 1;
    ui_components.elec_B_edit = uieditfield(gl_material, 'numeric');
    ui_components.elec_B_edit.Value = 42.34;
    ui_components.elec_B_edit.Layout.Row = current_row;
    ui_components.elec_B_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_elec_C = uilabel(gl_material);
    ui_components.label_elec_C.Text = 'Coefficient C:';
    ui_components.label_elec_C.Layout.Row = current_row;
    ui_components.label_elec_C.Layout.Column = 1;
    ui_components.elec_C_edit = uieditfield(gl_material, 'numeric');
    ui_components.elec_C_edit.Value = 0.33;
    ui_components.elec_C_edit.Layout.Row = current_row;
    ui_components.elec_C_edit.Layout.Column = 2;
    current_row = current_row + 1;
    paper_title = uilabel(gl_material);
    paper_title.Text = 'Electrolyte Paper Measurement Parameters';
    paper_title.FontWeight = 'bold';
    paper_title.FontSize = 11;
    paper_title.HorizontalAlignment = 'center';
    paper_title.BackgroundColor = [0.9, 0.9, 0.9];
    paper_title.Layout.Row = current_row;
    paper_title.Layout.Column = [1, 2];
    current_row = current_row + 1;
    ui_components.label_paper_A = uilabel(gl_material);
    ui_components.label_paper_A.Text = 'Test Electrode Diameter (m):';
    ui_components.label_paper_A.Layout.Row = current_row;
    ui_components.label_paper_A.Layout.Column = 1;
    ui_components.paper_A_edit = uieditfield(gl_material, 'numeric');
    ui_components.paper_A_edit.Value = 0.038;
    ui_components.paper_A_edit.Layout.Row = current_row;
    ui_components.paper_A_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_paper_B = uilabel(gl_material);
    ui_components.label_paper_B.Text = 'Electrolyte Paper Thickness (μm):';
    ui_components.label_paper_B.Layout.Row = current_row;
    ui_components.label_paper_B.Layout.Column = 1;
    ui_components.paper_B_edit = uieditfield(gl_material, 'numeric');
    ui_components.paper_B_edit.Value = 58;
    ui_components.paper_B_edit.Layout.Row = current_row;
    ui_components.paper_B_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_paper_C = uilabel(gl_material);
    ui_components.label_paper_C.Text = 'High Frequency Rs (mΩ):';
    ui_components.label_paper_C.Layout.Row = current_row;
    ui_components.label_paper_C.Layout.Column = 1;
    ui_components.paper_C_edit = uieditfield(gl_material, 'numeric');
    ui_components.paper_C_edit.Value = 203;
    ui_components.paper_C_edit.Layout.Row = current_row;
    ui_components.paper_C_edit.Layout.Column = 2;
    current_row = current_row + 1;
    cpe_title = uilabel(gl_material);
    cpe_title.Text = 'CPE Parameters';
    cpe_title.FontWeight = 'bold';
    cpe_title.FontSize = 11;
    cpe_title.HorizontalAlignment = 'center';
    cpe_title.BackgroundColor = [0.9, 0.9, 0.9];
    cpe_title.Layout.Row = current_row;
    cpe_title.Layout.Column = [1, 2];
    current_row = current_row + 1;
    ui_components.label_CPE_Q = uilabel(gl_material);
    ui_components.label_CPE_Q.Text = 'CPE Parameter Q:';
    ui_components.label_CPE_Q.Layout.Row = current_row;
    ui_components.label_CPE_Q.Layout.Column = 1;
    ui_components.CPE_Q_edit = uieditfield(gl_material, 'numeric');
    ui_components.CPE_Q_edit.Value = 6.2342e-5;
    ui_components.CPE_Q_edit.Layout.Row = current_row;
    ui_components.CPE_Q_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_CPE_n = uilabel(gl_material);
    ui_components.label_CPE_n.Text = 'CPE Parameter n:';
    ui_components.label_CPE_n.Layout.Row = current_row;
    ui_components.label_CPE_n.Layout.Column = 1;
    ui_components.CPE_n_edit = uieditfield(gl_material, 'numeric');
    ui_components.CPE_n_edit.Value = 0.91655;
    ui_components.CPE_n_edit.Layout.Row = current_row;
    ui_components.CPE_n_edit.Layout.Column = 2;
    gl_working = uigridlayout(tab_working, [8, 2]);
    gl_working.RowHeight = repmat(30, 1, 8);
    gl_working.ColumnWidth = {'1x', '1.5x'};
    gl_working.Padding = [10, 10, 10, 10];
    gl_working.RowSpacing = 8;
    gl_working.ColumnSpacing = 10;
    current_row = 1;
    ui_components.label_temp = uilabel(gl_working);
    ui_components.label_temp.Text = 'Target Temperature (°C):';
    ui_components.label_temp.Layout.Row = current_row;
    ui_components.label_temp.Layout.Column = 1;
    ui_components.target_temp_edit = uieditfield(gl_working, 'numeric');
    ui_components.target_temp_edit.Value = 25;
    ui_components.target_temp_edit.Layout.Row = current_row;
    ui_components.target_temp_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_freq = uilabel(gl_working);
    ui_components.label_freq.Text = 'Target Frequency (Hz):';
    ui_components.label_freq.Layout.Row = current_row;
    ui_components.label_freq.Layout.Column = 1;
    ui_components.target_freq_edit = uieditfield(gl_working, 'numeric');
    ui_components.target_freq_edit.Value = 1000;
    ui_components.target_freq_edit.Layout.Row = current_row;
    ui_components.target_freq_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_freq_range = uilabel(gl_working);
    ui_components.label_freq_range.Text = 'Frequency Sweep Range:';
    ui_components.label_freq_range.Layout.Row = current_row;
    ui_components.label_freq_range.Layout.Column = 1;
    ui_components.freq_range_edit = uieditfield(gl_working, 'text');
    ui_components.freq_range_edit.Value = 'logspace(1,5,50)';
    ui_components.freq_range_edit.Tooltip = 'Example: 100:100:10000 or logspace(1,5,50)';
    ui_components.freq_range_edit.Layout.Row = current_row;
    ui_components.freq_range_edit.Layout.Column = 2;
    current_row = current_row + 1;
    ui_components.label_temp_range = uilabel(gl_working);
    ui_components.label_temp_range.Text = 'Temperature Sweep Range:';
    ui_components.label_temp_range.Layout.Row = current_row;
    ui_components.label_temp_range.Layout.Column = 1;
    ui_components.temp_range_edit = uieditfield(gl_working, 'text');
    ui_components.temp_range_edit.Value = '20:5:125';
    ui_components.temp_range_edit.Tooltip = 'Example: -40:10:125 or [25, 45, 65, 85]';
    ui_components.temp_range_edit.Layout.Row = current_row;
    ui_components.temp_range_edit.Layout.Column = 2;
    current_row = current_row + 1;
    empty_label2 = uilabel(gl_working);
    empty_label2.Text = '';
    empty_label2.Layout.Row = current_row;
    empty_label2.Layout.Column = 1;
    current_row = current_row + 1;
    gl_buttons = uigridlayout(button_panel, [1, 2]);
    gl_buttons.RowHeight = {'1x'};
    gl_buttons.ColumnWidth = {'1x', '1x'};
    gl_buttons.Padding = [5, 5, 5, 5];
    gl_buttons.RowSpacing = 5;
    gl_buttons.ColumnSpacing = 10;
    ui_components.calc_btn = uibutton(gl_buttons, 'push');
    ui_components.calc_btn.Text = 'Calculate ESR and Contribution';
    ui_components.calc_btn.BackgroundColor = [0.2, 0.6, 1.0];
    ui_components.calc_btn.FontColor = [1, 1, 1];
    ui_components.calc_btn.FontWeight = 'bold';
    ui_components.calc_btn.FontSize = 12;
    ui_components.calc_btn.Layout.Row = 1;
    ui_components.calc_btn.Layout.Column = 1;
    ui_components.export_btn = uibutton(gl_buttons, 'push');
    ui_components.export_btn.Text = 'Export Excel Data';
    ui_components.export_btn.BackgroundColor = [0.1, 0.7, 0.3];
    ui_components.export_btn.FontColor = [1, 1, 1];
    ui_components.export_btn.FontWeight = 'bold';
    ui_components.export_btn.FontSize = 12;
    ui_components.export_btn.Layout.Row = 1;
    ui_components.export_btn.Layout.Column = 2;
    ui_components.result_text = uitextarea(result_panel);
    ui_components.result_text.Position = [10, 10, 550, 150];
    ui_components.result_text.Editable = 'off';
    ui_components.result_text.FontName = 'Consolas';
    ui_components.result_text.FontSize = 10;
    ui_components.contrib_text = uitextarea(contrib_panel);
    ui_components.contrib_text.Position = [10, 10, 550, 150];
    ui_components.contrib_text.Editable = 'off';
    ui_components.contrib_text.FontName = 'Consolas';
    ui_components.contrib_text.FontSize = 9;
    ui_components.freq_ax = uiaxes(freq_panel);
    ui_components.freq_ax.Position = [10, 10, 550, 150];
    title(ui_components.freq_ax, 'ESR Frequency Characteristic');
    xlabel(ui_components.freq_ax, 'Frequency (Hz)');
    ylabel(ui_components.freq_ax, 'ESR (mΩ)');
    grid(ui_components.freq_ax, 'on');
    set(ui_components.freq_ax, 'XScale', 'log');
    ui_components.temp_ax = uiaxes(temp_panel);
    ui_components.temp_ax.Position = [10, 10, 550, 150];
    title(ui_components.temp_ax, 'ESR Temperature Characteristic');
    xlabel(ui_components.temp_ax, 'Temperature (°C)');
    ylabel(ui_components.temp_ax, 'ESR (mΩ)');
    grid(ui_components.temp_ax, 'on');
    ui_components.calc_btn.ButtonPushedFcn = @(btn,event) calculate_ESR_callback(ui_components);
    ui_components.export_btn.ButtonPushedFcn = @(btn,event) export_origin_data_callback(ui_components);
    setappdata(input_panel, 'ui_components', ui_components);
end

function calculate_ESR_callback(ui_components)
    try
        input_params = get_all_input_parameters(ui_components);
        target_temp = ui_components.target_temp_edit.Value;
        target_freq = ui_components.target_freq_edit.Value;
        freq_range = eval(ui_components.freq_range_edit.Value);
        temp_range = eval(ui_components.temp_range_edit.Value);
        ui_components.result_text.Value = 'Calculating, please wait...';
        drawnow;
        input_params.temperature = target_temp;
        input_params.frequency = target_freq;
        [ESR_target, contributions] = calculate_ESR_with_contributions(input_params);
        ESR_freq = zeros(size(freq_range));
        for i = 1:length(freq_range)
            temp_params = input_params;
            temp_params.frequency = freq_range(i);
            ESR_freq(i) = calculate_ESR_direct(temp_params);
        end
        ESR_temp = zeros(size(temp_range));
        for i = 1:length(temp_range)
            temp_params = input_params;
            temp_params.temperature = temp_range(i);
            temp_params.frequency = target_freq;
            ESR_temp(i) = calculate_ESR_direct(temp_params);
        end
        last_calc = struct();
        last_calc.input_params = input_params;
        last_calc.ESR_target = ESR_target;
        last_calc.contributions = contributions;
        last_calc.freq_range = freq_range;
        last_calc.temp_range = temp_range;
        last_calc.ESR_freq = ESR_freq;
        last_calc.ESR_temp = ESR_temp;
        last_calc.target_temp = target_temp;
        last_calc.target_freq = target_freq;
        ui_components.last_calculation = last_calc;
        input_panel = ui_components.L_edit.Parent.Parent.Parent;
        setappdata(input_panel, 'ui_components', ui_components);
        result_str = sprintf('Target Working Point: %d°C, %d Hz\n', target_temp, target_freq);
        result_str = [result_str sprintf('Total ESR = %.3f mΩ\n\n', ESR_target)];
        result_str = [result_str sprintf('Frequency Sweep Range:\n')];
        result_str = [result_str sprintf('%.0fHz - %.0fHz\n\n', freq_range(1), freq_range(end))];
        result_str = [result_str sprintf('Temperature Sweep Range:\n')];
        result_str = [result_str sprintf('%d°C - %d°C', temp_range(1), temp_range(end))];
        ui_components.result_text.Value = result_str;
        contrib_str = sprintf('=== ESR Contribution Analysis (Elimination Method) ===\n\n');
        contrib_str = [contrib_str sprintf('Al Foil:        %6.3f mΩ (%5.1f%%)\n', contributions.R_Al, contributions.ratio_Al)];
        contrib_str = [contrib_str sprintf('Contact:        %6.3f mΩ (%5.1f%%)\n', contributions.R_contact, contributions.ratio_contact)];
        contrib_str = [contrib_str sprintf('Electrolyte:    %6.3f mΩ (%5.1f%%)\n', contributions.R_electrolyte, contributions.ratio_electrolyte)];
        contrib_str = [contrib_str sprintf('Paper:          %6.3f mΩ (%5.1f%%)\n', contributions.R_paper, contributions.ratio_paper)];
        contrib_str = [contrib_str sprintf('Oxide Loss:     %6.3f mΩ (%5.1f%%)\n', contributions.R_oxide, contributions.ratio_oxide)];
        contrib_str = [contrib_str sprintf('Non-Perf Al Core:%6.3f mΩ (%5.1f%%)\n', contributions.R_Al_non_perf, contributions.ratio_Al_non_perf)];
        total_percentage = contributions.ratio_Al + contributions.ratio_contact + contributions.ratio_electrolyte + ...
                  contributions.ratio_paper + contributions.ratio_oxide + contributions.ratio_Al_non_perf;
        contrib_str = [contrib_str sprintf('\nTotal Percentage: %5.1f%%', total_percentage)];
        contrib_str = [contrib_str sprintf('\nTotal ESR:       %6.3f mΩ', ESR_target)];
        contrib_str = [contrib_str sprintf('\n\nNote: Percentage based on elimination method')];
        ui_components.contrib_text.Value = contrib_str;
        update_plots(ui_components, freq_range, ESR_freq, temp_range, ESR_temp, target_freq, target_temp, ESR_target);
        fprintf('Calculation completed! You can click export to generate data file.\n');
    catch ME
        errordlg(sprintf('Calculation Error: %s', ME.message), 'Calculation Error');
        ui_components.result_text.Value = sprintf('Calculation Error:\n%s', ME.message);
        ui_components.contrib_text.Value = 'Contribution Analysis Failed';
    end
end

function input_params = get_all_input_parameters(ui_components)
    input_params.L = ui_components.L_edit.Value;
    input_params.W = ui_components.W_edit.Value;
    input_params.t_core = ui_components.t_core_edit.Value * 1e-6;
    input_params.t_porous = ui_components.t_porous_edit.Value * 1e-6;
    input_params.d_p = ui_components.d_p_edit.Value * 1e-6;
    input_params.d_oxide = ui_components.d_oxide_edit.Value * 1e-9;
    input_params.hole_diameter = ui_components.hole_diam_edit.Value * 1e-6;
    input_params.hole_spacing = ui_components.hole_spacing_edit.Value * 1e-6;
    input_params.L_left = ui_components.L_left_edit.Value;
    input_params.L_s = ui_components.L_s_edit.Value * 1e-9;
    input_params.R_contact = ui_components.R_contact_edit.Value * 1e-3;
    input_params.t_cathode = ui_components.t_cathode_edit.Value * 1e-6;
    input_params.epsilon_r_oxide = ui_components.epsilon_r_edit.Value;
    input_params.tan_delta_oxide = ui_components.tan_delta_edit.Value;
    input_params.alpha_Al = ui_components.alpha_Al_edit.Value;
    input_params.elec_A = ui_components.elec_A_edit.Value;
    input_params.elec_B = ui_components.elec_B_edit.Value;
    input_params.elec_C = ui_components.elec_C_edit.Value;
    input_params.paper_A = ui_components.paper_A_edit.Value ;
    input_params.paper_B = ui_components.paper_B_edit.Value * 1e-6;
    input_params.paper_C = ui_components.paper_C_edit.Value * 1e-3;
    input_params.CPE_Q = ui_components.CPE_Q_edit.Value;
    input_params.CPE_n = ui_components.CPE_n_edit.Value;
end

function [total_ESR, contributions] = calculate_ESR_with_contributions(params)
    base_ESR = calculate_ESR_direct(params);
    contrib = struct();
    params_temp = params;
    params_temp.rho_Al_factor = 1e-6;
    ESR_no_Al = calculate_ESR_direct(params_temp);
    contrib.R_Al = max(0, base_ESR - ESR_no_Al);
    params_temp = params;
    params_temp.R_contact_factor = 1e-6;
    ESR_no_contact = calculate_ESR_direct(params_temp);
    contrib.R_contact = max(0, base_ESR - ESR_no_contact);
    params_temp = params;
    params_temp.rho_e_factor = 1e-6;
    ESR_no_electrolyte = calculate_ESR_direct(params_temp);
    contrib.R_electrolyte = max(0, base_ESR - ESR_no_electrolyte);
    params_temp = params;
    params_temp.rho_paper_factor = 1e-6;
    ESR_no_paper = calculate_ESR_direct(params_temp);
    contrib.R_paper = max(0, base_ESR - ESR_no_paper);
    params_temp = params;
    params_temp.tan_delta_factor = 1e-6;
    ESR_no_oxide = calculate_ESR_direct(params_temp);
    contrib.R_oxide = max(0, base_ESR - ESR_no_oxide);
    params_temp = params;
    params_temp.non_perf_factor = 1e-6;
    ESR_no_non_perf = calculate_ESR_direct(params_temp);
    contrib.R_Al_non_perf = max(0, base_ESR - ESR_no_non_perf);
    total_ESR = base_ESR;
    if total_ESR > 0
        contrib.ratio_Al = (contrib.R_Al / total_ESR) * 100;
        contrib.ratio_contact = (contrib.R_contact / total_ESR) * 100;
        contrib.ratio_electrolyte = (contrib.R_electrolyte / total_ESR) * 100;
        contrib.ratio_paper = (contrib.R_paper / total_ESR) * 100;
        contrib.ratio_oxide = (contrib.R_oxide / total_ESR) * 100;
        contrib.ratio_Al_non_perf = (contrib.R_Al_non_perf / total_ESR) * 100;
        total_ratio = contrib.ratio_Al + contrib.ratio_contact + contrib.ratio_electrolyte + ...
                     contrib.ratio_paper + contrib.ratio_oxide + contrib.ratio_Al_non_perf;
        if abs(total_ratio - 100) > 0.1
            scale_factor = 100 / total_ratio;
            contrib.ratio_Al = contrib.ratio_Al * scale_factor;
            contrib.ratio_contact = contrib.ratio_contact * scale_factor;
            contrib.ratio_electrolyte = contrib.ratio_electrolyte * scale_factor;
            contrib.ratio_paper = contrib.ratio_paper * scale_factor;
            contrib.ratio_oxide = contrib.ratio_oxide * scale_factor;
            contrib.ratio_Al_non_perf = contrib.ratio_Al_non_perf * scale_factor;
        end
    else
        contrib.ratio_Al = 0;
        contrib.ratio_contact = 0;
        contrib.ratio_electrolyte = 0;
        contrib.ratio_paper = 0;
        contrib.ratio_oxide = 0;
        contrib.ratio_Al_non_perf = 0;
    end
    contributions = contrib;
end

function ESR = calculate_ESR_direct(input_params)
    T = input_params.temperature;
    f = input_params.frequency;
    rho_Al_factor = get_param_factor(input_params, 'rho_Al_factor', 1);
    R_contact_factor = get_param_factor(input_params, 'R_contact_factor', 1);
    rho_e_factor = get_param_factor(input_params, 'rho_e_factor', 1);
    rho_paper_factor = get_param_factor(input_params, 'rho_paper_factor', 1);
    tan_delta_factor = get_param_factor(input_params, 'tan_delta_factor', 1);
    non_perf_factor = get_param_factor(input_params, 'non_perf_factor', 1);
    modified_params = input_params;
    modified_params.R_contact = input_params.R_contact * R_contact_factor;
    ESR = calculate_ESR_physical(f, T, modified_params, rho_Al_factor, rho_e_factor, rho_paper_factor, tan_delta_factor, non_perf_factor);
end

function value = get_param_factor(params, field, default)
    if isfield(params, field)
        value = params.(field);
    else
        value = default;
    end
end

function ESR_pred = calculate_ESR_physical(f, T, params, rho_Al_factor, rho_e_factor, rho_paper_factor, tan_delta_factor, non_perf_factor)
    rho_composite = (params.paper_C * 3.1415926535*(params.paper_A/2)^2/params.paper_B)/(params.elec_A * exp(-20/params.elec_B) + params.elec_C) * ...
                   (params.elec_A * exp(-T/params.elec_B) + params.elec_C) * rho_paper_factor;
    Q_physical = params.CPE_Q;
    n_physical = params.CPE_n;
    Z_l_prime = calculate_longitudinal_impedance_per_unit_with_factor(f, T, params, rho_Al_factor);
    Y_t_prime = calculate_transverse_admittance_physical_with_factors(f, T, params, rho_composite, Q_physical, n_physical, rho_e_factor, tan_delta_factor, non_perf_factor);
    gamma = sqrt(Z_l_prime .* Y_t_prime);
    Z0 = sqrt(Z_l_prime ./ Y_t_prime);
    Z_line = 1/(1/(Z0 .* coth(gamma .* params.L_left)) + 1/(Z0 .* coth(gamma .* (params.L-params.L_left))));
    Z_total_physical = Z_line + params.R_contact;
    ESR_pred = real(Z_total_physical) * 1000;
end

function Z_l_prime = calculate_longitudinal_impedance_per_unit_with_factor(f, T, params, rho_Al_factor)
    rho_Al = 2.82e-8 * (1 + params.alpha_Al * (T - 20)) * rho_Al_factor;
    t_cat = params.t_cathode;
    R_Al_prime = rho_Al / (params.t_core * params.W) + rho_Al / (t_cat * params.W);
    L_s_prime = params.L_s / params.L;
    omega = 2 * pi * f;
    Z_l_prime = R_Al_prime + 1j * omega * L_s_prime;
end

function Y_t_prime = calculate_transverse_admittance_physical_with_factors(f, T, params, rho_composite, Q, n, rho_e_factor, tan_delta_factor, non_perf_factor)
    omega = 2 * pi * f;
    perforated_ratio = pi * (params.hole_diameter/2)^2 / params.hole_spacing^2;
    non_perforated_ratio = 1 - perforated_ratio * non_perf_factor;
    Y_perforated_per_area = calculate_perforated_admittance_with_factors(f, T, params, rho_composite, Q, n, rho_e_factor, tan_delta_factor);
    Y_non_perforated_per_area = calculate_non_perforated_admittance_with_factors(f, T, params, rho_composite, Q, n, tan_delta_factor);
    Y_perforated = Y_perforated_per_area * params.W * perforated_ratio * 2;
    Y_non_perforated = Y_non_perforated_per_area * params.W * non_perforated_ratio * 2;
    Y_t_prime = Y_perforated + Y_non_perforated;
end

function Y_perforated_per_area = calculate_perforated_admittance_with_factors(f, T, params, rho_composite, Q, n, rho_e_factor, tan_delta_factor)
    Z_hole_single = calculate_hole_single_impedance_with_factors(f, T, params, rho_composite, Q, n, rho_e_factor, tan_delta_factor);
    hole_area = pi * (params.hole_diameter/2)^2;
    Y_hole_single = 1 / Z_hole_single;
    Y_perforated_per_area = Y_hole_single / hole_area;
end

function Z_hole = calculate_hole_single_impedance_with_factors(f, T, params, rho_composite, Q, n, rho_e_factor, tan_delta_factor)
    Z_oxide_hole = calculate_oxide_impedance_single_with_factor(f, params, tan_delta_factor);
    Z_electrolyte_hole = calculate_electrolyte_hole_impedance_with_factor(f, T, params, rho_e_factor);
    Z_paper_composite = calculate_paper_composite_impedance(f, params, rho_composite, Q, n);
    Z_hole = Z_oxide_hole + Z_electrolyte_hole + Z_paper_composite;
end

function Z_oxide = calculate_oxide_impedance_single_with_factor(f, params, tan_delta_factor)
    epsilon_r_oxide = params.epsilon_r_oxide;
    tan_delta_oxide = params.tan_delta_oxide * tan_delta_factor;
    epsilon_0 = 8.854e-12;
    omega = 2 * pi * f;
    A_hole = pi * (params.hole_diameter/2)^2;
    additional_area = pi * params.hole_diameter * params.t_porous;
    C_oxide_single1 = (epsilon_0 * epsilon_r_oxide * A_hole) / params.d_oxide;
    Z_oxide1 = 1./(1j * omega * C_oxide_single1) + tan_delta_oxide/(omega * C_oxide_single1);
    C_oxide_single2 = (epsilon_0 * epsilon_r_oxide * additional_area) / params.d_oxide;
    Z_oxide2 = 1./(1j * omega * C_oxide_single2) + tan_delta_oxide/(omega * C_oxide_single2);
    Z_oxide = 1/(1/Z_oxide1 + 1/Z_oxide2);
end

function Z_electrolyte = calculate_electrolyte_hole_impedance_with_factor(f, T, params, rho_e_factor)
    rho_e = calculate_electrolyte_resistivity(f, T, params) * rho_e_factor;
    A_cross = pi * (params.hole_diameter/2)^2;
    R_electrolyte = rho_e * params.t_porous / A_cross;
    Z_electrolyte = R_electrolyte;
end

function Y_non_perforated_per_area = calculate_non_perforated_admittance_with_factors(f, T, params, rho_composite, Q, n, tan_delta_factor)
    Z_non_perf_single = calculate_non_perforated_single_impedance_with_factors(f, T, params, rho_composite, Q, n, tan_delta_factor);
    d_s = params.hole_spacing;
    unit_cell_area = d_s^2 - pi*(params.hole_diameter/2)^2;
    Y_non_perf_single = 1 / Z_non_perf_single;
    Y_non_perforated_per_area = Y_non_perf_single / unit_cell_area;
end

function Z_non_perf_single = calculate_non_perforated_single_impedance_with_factors(f, T, params, rho_composite, Q, n, tan_delta_factor)
    d_s = params.hole_spacing;
    A_unit = d_s^2 - pi*(params.hole_diameter/2)^2;
    epsilon_r_oxide = params.epsilon_r_oxide;
    tan_delta_oxide = params.tan_delta_oxide * tan_delta_factor;
    epsilon_0 = 8.854e-12;
    omega = 2 * pi * f;
    C_oxide_non_perf = (epsilon_0 * epsilon_r_oxide * A_unit) / params.d_oxide;
    Z_oxide_non_perf = 1./(1j * omega * C_oxide_non_perf) + tan_delta_oxide/(omega * C_oxide_non_perf);
    R_composite_non_perf = rho_composite * params.d_p / A_unit;
    Z_CPE = 1 / (Q * (1j * omega)^n) / (pi * (params.paper_A/2)^2) * A_unit;
    Z_paper_composite_non_perf = R_composite_non_perf;
    rho_Al = 2.82e-8 * (1 + params.alpha_Al * (T - 20));
    R_Al_non_perf = rho_Al * params.t_porous / A_unit;
    Z_non_perf_single = Z_oxide_non_perf + Z_paper_composite_non_perf + R_Al_non_perf;
end

function rho_e = calculate_electrolyte_resistivity(f, T, params)
    rho_e = (params.elec_A * exp(-T/params.elec_B) + params.elec_C);
end

function Z_paper_composite = calculate_paper_composite_impedance(f, params, rho_composite, Q, n)
    omega = 2 * pi * f;
    A_hole = pi * (params.hole_diameter/2)^2;
    R_composite = rho_composite * params.d_p / A_hole;
    Z_CPE = 1 / (Q * (1j * omega)^n) * pi * (params.paper_A/2)^2 / A_hole;
    Z_paper_composite = R_composite;
end

function update_plots(ui_components, freq_range, ESR_freq, temp_range, ESR_temp, target_freq, target_temp, ESR_target)
    cla(ui_components.freq_ax);
    semilogx(ui_components.freq_ax, freq_range, ESR_freq, 'b-', 'LineWidth', 2);
    hold(ui_components.freq_ax, 'on');
    semilogx(ui_components.freq_ax, target_freq, ESR_target, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    title(ui_components.freq_ax, sprintf('ESR Frequency Characteristic (@%d°C)', target_temp));
    xlabel(ui_components.freq_ax, 'Frequency (Hz)');
    ylabel(ui_components.freq_ax, 'ESR (mΩ)');
    grid(ui_components.freq_ax, 'on');
    legend(ui_components.freq_ax, 'Frequency', 'Working Point', 'Location', 'best');
    cla(ui_components.temp_ax);
    plot(ui_components.temp_ax, temp_range, ESR_temp, 'r-', 'LineWidth', 2);
    hold(ui_components.temp_ax, 'on');
    plot(ui_components.temp_ax, target_temp, ESR_target, 'bo', 'MarkerSize', 8, 'LineWidth', 2);
    title(ui_components.temp_ax, sprintf('ESR Temperature Characteristic (@%dHz)', target_freq));
    xlabel(ui_components.temp_ax, 'Temperature (°C)');
    ylabel(ui_components.temp_ax, 'ESR (mΩ)');
    grid(ui_components.temp_ax, 'on');
    legend(ui_components.temp_ax, 'Temperature', 'Working Point', 'Location', 'best');
end

function export_origin_data_callback(ui_components)
    try
        input_panel = ui_components.L_edit.Parent.Parent.Parent;
        ui_components_updated = getappdata(input_panel, 'ui_components');
        if ~isfield(ui_components_updated, 'last_calculation') || isempty(ui_components_updated.last_calculation)
            errordlg('Please click "Calculate ESR and Contribution" button first', 'No Calculation Result');
            return;
        end
        default_path = '';
        if ~exist(default_path, 'dir')
            default_path = pwd;
        end
        target_folder = uigetdir(default_path, 'Select Folder for Saving Data');
        if target_folder == 0
            ui_components.result_text.Value = 'Export Cancelled';
            return;
        end
        ui_components.result_text.Value = 'Generating Origin Data File...\nUsing Last Calculation Result...';
        drawnow;
        last_calc = ui_components_updated.last_calculation;
        input_params = last_calc.input_params;
        freq_range = last_calc.freq_range;
        temp_range = last_calc.temp_range;
        fprintf('Generating ESR Contribution Analysis Data...\n');
        fprintf('Using last calculation result\n');
        fprintf('Temperature Range: %d°C to %d°C, %d points\n', min(temp_range), max(temp_range), length(temp_range));
        fprintf('Frequency Range: %.0fHz to %.0fHz, %d points\n', min(freq_range), max(freq_range), length(freq_range));
        total_points = length(freq_range) * length(temp_range);
        data = zeros(total_points, 9);
        row_index = 1;
        for i = 1:length(temp_range)
            for j = 1:length(freq_range)
                current_params = input_params;
                current_params.temperature = temp_range(i);
                current_params.frequency = freq_range(j);
                [total_ESR, contributions] = calculate_ESR_with_contributions(current_params);
                data(row_index, 1) = freq_range(j);
                data(row_index, 2) = temp_range(i);
                data(row_index, 3) = total_ESR;
                data(row_index, 4) = contributions.ratio_Al;
                data(row_index, 5) = contributions.ratio_contact;
                data(row_index, 6) = contributions.ratio_electrolyte;
                data(row_index, 7) = contributions.ratio_paper;
                data(row_index, 8) = contributions.ratio_oxide;
                data(row_index, 9) = contributions.ratio_Al_non_perf;
                row_index = row_index + 1;
            end
            progress = i/length(temp_range)*100;
            ui_components.result_text.Value = sprintf('Data Generation... %.0f%%', progress);
            drawnow;
        end
        filename = 'ESR_Contribution_Analysis.csv';
        full_path = fullfile(target_folder, filename);
        fid = fopen(full_path, 'w');
        header = {'Frequency_Hz', 'Temperature_C', 'Total_ESR_mOhm', 'Al_Foil_%', 'Contact_%', 'Electrolyte_%', 'Paper_%', 'Oxide_%', 'NonPerf_Al_%'};
        fprintf(fid, '%s,', header{1:end-1});
        fprintf(fid, '%s\n', header{end});
        for i = 1:size(data, 1)
            fprintf(fid, '%.2f,%.1f,%.3f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f\n', data(i, :));
        end
        fclose(fid);
        result_str = sprintf('Data Export Completed!\n\n');
        result_str = [result_str sprintf('File Location: %s\n', full_path)];
        result_str = [result_str sprintf('Data Dimension: %d rows × %d columns\n', size(data, 1), size(data, 2))];
        result_str = [result_str sprintf('Generated based on last calculation result')];
        ui_components.result_text.Value = result_str;
        if ispc
            try
                winopen(target_folder);
                fprintf('Target folder opened automatically\n');
            catch
                fprintf('Please open folder manually: %s\n', target_folder);
            end
        end
        fprintf('Data export completed! File saved as: %s\n', full_path);
    catch ME
        errordlg(sprintf('Export Error: %s', ME.message), 'Export Error');
        ui_components.result_text.Value = sprintf('Export Error:\n%s', ME.message);
    end
end