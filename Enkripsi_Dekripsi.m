function varargout = Enkripsi_Dekripsi(varargin)
% ENKRIPSI_DEKRIPSI MATLAB code for Enkripsi_Dekripsi.fig
%      ENKRIPSI_DEKRIPSI, by itself, creates a new ENKRIPSI_DEKRIPSI or raises the existing
%      singleton*.
%
%      H = ENKRIPSI_DEKRIPSI returns the handle to a new ENKRIPSI_DEKRIPSI or the handle to
%      the existing singleton*.
%
%      ENKRIPSI_DEKRIPSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENKRIPSI_DEKRIPSI.M with the given input arguments.
%
%      ENKRIPSI_DEKRIPSI('Property','Value',...) creates a new ENKRIPSI_DEKRIPSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Enkripsi_Dekripsi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Enkripsi_Dekripsi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Enkripsi_Dekripsi

% Last Modified by GUIDE v2.5 20-Feb-2021 09:49:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Enkripsi_Dekripsi_OpeningFcn, ...
                   'gui_OutputFcn',  @Enkripsi_Dekripsi_OutputFcn, ...
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


% --- Executes just before Enkripsi_Dekripsi is made visible.
function Enkripsi_Dekripsi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Enkripsi_Dekripsi (see VARARGIN)

% Choose default command line output for Enkripsi_Dekripsi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axs2 = axes('unit','normalized','position',[0 0 1 1]);
bg2 = imread('icon_bg\dashboard.jpg');
imagesc(bg2);
set(axs2,'handlevisibility','off','visible','off');

% UIWAIT makes Enkripsi_Dekripsi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Enkripsi_Dekripsi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_img.
function btn_img_Callback(hObject, eventdata, handles)
% hObject    handle to btn_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
[c,d]=uigetfile('*.jpg;*.bmp;*.tif;*.png', 'Pick a image');
     v=strcat(d,c);
     a=imread(v);
     axes(handles.axes_img);
     imshow(a);


% --- Executes on button press in btn_enkripsi.
function btn_enkripsi_Callback(hObject, eventdata, handles)
% hObject    handle to btn_enkripsi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
global d;
global n;
%p = 23, q = 67;
p = 13;
q = 31;
%menghitung nilai n
n=p*q;

%menghitung Phi 
Phi=(p-1)*(q-1);

%Calculate the value of e 
%1<e<phi and gcd(e,phi)=1
%x=2;e=1;
%while x > 1
%    e=e+1;
 %   x=gcd(Phi,e);
%end

%menghitung nilai e, nilai e harus koprima thd phi
for e=2:Phi
    if gcd(e,Phi)==1
        break
    end
end

%menghitung nilai d
i=1;
r=1;
while r > 0
    k=(Phi*i)+1;
    r=rem(k,e);
    disp(['Value of i is : ' num2str(i)]);
    i=i+1;
end
d=k/e;


disp(['The value of (n) is:    ' num2str(n)]);
disp(['The public key (e) is:  ' num2str(e)]);
disp(['The value of tautient is: ' num2str(Phi)]);
disp(['The private key (d)is:  ' num2str(d)]);



%Input Image
global input;
input = double(a);


inputsize = size(input);
global cipher;
cipher = ones(inputsize);

%Function to Encrypt
for u=1:numel(input)
    cipher(u) = exponentmod(input(u),e,n);    
end

global output;
output = ones(inputsize);

axes(handles.axes_cipher);
imshow(uint8(cipher));
%global enc_img;
%enc_img = uint8(cipher);
%imwrite(enc_img,'enc.jpg','jpg');




% --- Executes on button press in btn_loadimg.
function btn_loadimg_Callback(hObject, eventdata, handles)
% hObject    handle to btn_loadimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cipher;
axes(handles.axes_load);
imshow(uint8(cipher));



% --- Executes on button press in btn_dekripsi.
function btn_dekripsi_Callback(hObject, eventdata, handles)
% hObject    handle to btn_dekripsi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cipher;
global output;
global input;
global d;
global n;
global a;
for u=1:numel(cipher)
    output(u) = exponentmod(cipher(u),d,n);
end
axes(handles.axes_plainimg);
imshow(uint8(output));
%dec_img = uint8(output);
%imwrite(dec_img,'dec.jpg','jpg');

%psnr and mse
A=cipher;
ref=output;
[MSE,PSNR]=msepsnr(A,ref);
set(handles.edPSNR,'string',PSNR);
set(handles.edMSE,'string',MSE);

%Function to entropy plainimage
[ ENTROPI ] = func_entropy(input);
set(handles.edEntropi1,'string',ENTROPI);
disp(['The value of entropy(plain-image) is:  ' num2str(ENTROPI)]);
%Function to entropy chiperimage
[ ENTROPI ] = func_entropy(A);
set(handles.edEntropi2,'string',ENTROPI);
disp(['The value of entropy(chiper-image) is:  ' num2str(ENTROPI)]);

%ber
x = a;
y = output;
[ hasil] = func_ber(x,y);
set(handles.edBER,'string',hasil);


% --- Executes on button press in btn_reset.
function btn_reset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edMSE,'String','');
set(handles.edBER,'String','');
set(handles.edPSNR,'String','');
set(handles.edEntropi1,'String','');
set(handles.edEntropi2,'String','');
axes(handles.axes_load); cla;
axes(handles.axes_img); cla;
axes(handles.axes_plainimg); cla;
axes(handles.axes_cipher); cla;



% --- Executes on button press in btn_tutup.
function btn_tutup_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tutup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edMSE_Callback(hObject, eventdata, handles)
% hObject    handle to edMSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edMSE as text
%        str2double(get(hObject,'String')) returns contents of edMSE as a double


% --- Executes during object creation, after setting all properties.
function edMSE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edMSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edPSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edPSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edPSNR as text
%        str2double(get(hObject,'String')) returns contents of edPSNR as a double


% --- Executes during object creation, after setting all properties.
function edPSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edPSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edEntropi1_Callback(hObject, eventdata, handles)
% hObject    handle to edEntropi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edEntropi1 as text
%        str2double(get(hObject,'String')) returns contents of edEntropi1 as a double


% --- Executes during object creation, after setting all properties.
function edEntropi1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edEntropi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edEntropi2_Callback(hObject, eventdata, handles)
% hObject    handle to edEntropi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edEntropi2 as text
%        str2double(get(hObject,'String')) returns contents of edEntropi2 as a double


% --- Executes during object creation, after setting all properties.
function edEntropi2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edEntropi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edEntropi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edEntropi1 as text
%        str2double(get(hObject,'String')) returns contents of edEntropi1 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edEntropi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edEntropi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edEntropi2 as text
%        str2double(get(hObject,'String')) returns contents of edEntropi2 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edEntropi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edBER_Callback(hObject, eventdata, handles)
% hObject    handle to edBER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edBER as text
%        str2double(get(hObject,'String')) returns contents of edBER as a double


% --- Executes during object creation, after setting all properties.
function edBER_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edBER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_save.
function btn_save_Callback(hObject, eventdata, handles)
% hObject    handle to btn_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global enc_img;
global cipher;

enc_img = uint8(cipher);
[filename, foldername] = uiputfile('*.jpg','Where do you want the file saved?');
complete_name = fullfile(foldername, filename);
imwrite(enc_img, complete_name);
