%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   MICROSTRIP LINE CALCULATOR

%   Author                   Usman Iqbal
%   Email                    usmaniqbal0001@gmail.com
%   Contact                  +923355251592
%   Last Modified            August 09, 2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Main Coding Starts
function varargout = Microstrip_GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Microstrip_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Microstrip_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function Microstrip_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

%display of the info in the axes box
axes(handles.logo_pic) 
imshow('Info.jpg');

guidata(hObject, handles);


function varargout = Microstrip_GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function edit_dielectric_constant_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_dielectric_constant_Callback(hObject, eventdata, handles)
e_r = str2double(get(handles.edit_dielectric_constant,'String'));
assignin('base','e_r',e_r);


function edit_substrate_thickness_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_substrate_thickness_Callback(hObject, eventdata, handles)
h = str2double(get(handles.edit_substrate_thickness,'String'));
assignin('base','h',h);


function edit_microstrip_width_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_microstrip_width_Callback(hObject, eventdata, handles)
w = str2double(get(handles.edit_microstrip_width,'String'));
assignin('base','w',w);


function edit_frequency_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_frequency_Callback(hObject, eventdata, handles)
f = str2double(get(handles.edit_frequency,'String'));
assignin('base','f',f);


function pushbutton_calculate_Callback(hObject, eventdata, handles)
e_r = str2double(get(handles.edit_dielectric_constant,'String'));
h = (str2double(get(handles.edit_substrate_thickness,'String')))*1e-3;
w = (str2double(get(handles.edit_microstrip_width,'String')))*1e-3;
f = get(handles.edit_frequency,'String');
u0 = 1.25663706e-6; %permeability of free space
e0 = 8.85418782e-12; %permittivity of free space
eta = 3.767303135e2; %wave impedance of free space
c = 299792458; %speed of light

%calculation of effective dielectric constant
e1 = (e_r + 1)/2;
e2 = (e_r - 1)/2;
e3 = 1/sqrt(1 + 12*(h/w));
e_r_eff = e1 + e2*e3;

%calculation of propagation constant
if (isempty(f))
    beta1 = (2*pi/c)*sqrt(e_r_eff);
    beta_str1 = num2str(beta1);
    beta_str = strcat(beta_str1,'f');    
else
    f = (str2double(f))*1e9;
    k_0 = 2*pi*f/c;
    beta = k_0*sqrt(e_r_eff);
    beta_str = num2str(beta);
end


%calculation of characteristic impedance
if w/h >= 1
    z1 = log(w/h + 1.444);
    z2 = w/h + 1.393 + 0.667*z1;
    z3 = sqrt(e_r_eff)*z2;
    Z_0 = eta/z3;
    Z_0_str = num2str(Z_0);
else
    z1 = log(8*h/w + w/(4*h));
    z2 = 60/sqrt(e_r_eff);
    Z_0 = z2*z1;
    Z_0_str = num2str(Z_0);
end

set(handles.edit_propagation_constant,'String',beta_str);
set(handles.edit_characteristic_impedance,'String',Z_0_str);


function edit_propagation_constant_Callback(hObject, eventdata, handles)

function edit_propagation_constant_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_characteristic_impedance_Callback(hObject, eventdata, handles)

function edit_characteristic_impedance_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%activation of button on pressing of 'ENTER'
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
key = get(gcf,'CurrentKey');
if(strcmp(key, 'return'))
    pushbutton_calculate_Callback(hObject, eventdata, handles)
end