function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 15-Mar-2016 19:10:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function eM_Callback(hObject, eventdata, handles)
% hObject    handle to eM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eM as text
%        str2double(get(hObject,'String')) returns contents of eM as a double


% --- Executes during object creation, after setting all properties.
function eM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
if strcmp(get(handles.eM,'enable'),'on')
    
[F.name F.path]=uigetfile('*.*')
Fn=fopen([F.path F.name])

M=fread(Fn)';
save('M.mat','M')
set(handles.eM,'enable','inactive')
set(handles.eM,'BackgroundColor',[0.9 0.9 0.9])
else
   set(handles.eM,'enable','on') 
   set(handles.eM,'BackgroundColor',[1 1 1])
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

if strcmp(get(handles.eM,'enable'),'on')
    M=get(handles.eM,'String');
    M=unicode2native(M);
else
    load('M.mat');
end

M=dec2bin(M);
M=reshape(M',1,numel(M))
if mod(numel(M),4)==0
M=reshape(M,4,numel(M)/4)'
else
    M=strcat(dec2bin(0,4-mod(numel(M),4)),M)
    M=reshape(M,4,numel(M)/4)'
end
Kin='0110';

K=Kin;
for i=1:numel(M(:,1))
    
    Ks(1)=num2str(xor(  str2double(K(1)) , str2double(K(2))  ));
    Ks(2:4)=K(1:3);
    
    for j=1:4
        S(i,j)=num2str(xor( str2double(Ks(j))   , str2double(M(i,j))  ));
%         S(i,j)=num2str(xor( S   , str2double(M(i,j))  ));
    end
end

D=S;
S=reshape(S',8,numel(S)/8)';

set(handles.eS,'String',native2unicode(bin2dec(S))')



K=Kin;
for i=1:numel(D(:,1))
    
    Ks(1)=num2str(xor(  str2double(K(1)) , str2double(K(2))  ));
    Ks(2:4)=K(1:3);
    
    for j=1:4
        M2(i,j)=num2str(xor( str2double(Ks(j))   , str2double(D(i,j))  ));
%         S(i,j)=num2str(xor( S   , str2double(M(i,j))  ));
    end
end

M2=reshape(M2',8,numel(M2)/8)';

set(handles.eM2,'String',native2unicode(bin2dec(M2))')

function eS_Callback(hObject, eventdata, handles)
% hObject    handle to eS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eS as text
%        str2double(get(hObject,'String')) returns contents of eS as a double


% --- Executes during object creation, after setting all properties.
function eS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eM2_Callback(hObject, eventdata, handles)
% hObject    handle to eM2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eM2 as text
%        str2double(get(hObject,'String')) returns contents of eM2 as a double


% --- Executes during object creation, after setting all properties.
function eM2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eM2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
