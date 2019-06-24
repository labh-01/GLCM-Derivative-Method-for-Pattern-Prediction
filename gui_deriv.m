function varargout = gui_deriv(varargin)
% GUI_DERIV MATLAB code for gui_deriv.fig
%      GUI_DERIV, by itself, creates a new GUI_DERIV or raises the existing
%      singleton*.
%
%      H = GUI_DERIV returns the handle to a new GUI_DERIV or the handle to
%      the existing singleton*.
%
%      GUI_DERIV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DERIV.M with the given input arguments.
%
%      GUI_DERIV('Property','Value',...) creates a new GUI_DERIV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_deriv_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_deriv_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_deriv

% Last Modified by GUIDE v2.5 10-Apr-2018 16:38:42

% Begin initialization code - DO NOT EDIT
clc;
clear image;
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_deriv_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_deriv_OutputFcn, ...
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


% --- Executes just before gui_deriv is made visible.
function gui_deriv_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_deriv (see VARARGIN)

% Choose default command line output for gui_deriv
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_deriv wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_deriv_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectQueryImg.
function selectQueryImg_Callback(hObject, eventdata, handles)
% hObject    handle to selectQueryImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global theImage;
[file,path] = uigetfile('*.jpg');
filename = strcat(path,file);
if exist(filename, 'file')
   theImage = imread(filename);
  axes(handles.image); % Use actual variable names from your program!
  imshow(theImage);
else
  message = sprintf('Image file not found:\n%s', fullFileName);
  
end


% --- Executes on button press in testPattern.
function testPattern_Callback(hObject, eventdata, handles)
% hObject    handle to testPattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global img_cropped;
global theImage;

%n = zeros(length(unique_pattern), 1)
pattern = derivative1(theImage);
% for i=1:10
% r= randi([1,row-138]);
% c= randi([1,col-138]);
% redChannel = theImage(r:(r+138),c:(c+138), 1);
% greenChannel = theImage(r:(r+138),c:(c+138), 2);
% blueChannel = theImage(r:(r+138), c:(c+138), 3);
% img_cropped = cat(3, redChannel, greenChannel, blueChannel);
% patternArr{i} = glcm_derivative1(img_cropped);
% end
% unique_pattern = unique(patternArr);
% n = zeros(length(unique_pattern), 1);
% for iy = 1:length(unique_pattern)
%   n(iy) = length(find(strcmp(unique_pattern{iy}, patternArr)));
% end
% [~, itemp] = max(n);
% pattern = unique_pattern{itemp}
set(handles.pattern,'String',pattern);


