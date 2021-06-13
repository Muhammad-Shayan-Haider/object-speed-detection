function varargout = speed_detection(varargin)
% SPEED_DETECTION MATLAB code for speed_detection.fig
%      SPEED_DETECTION, by itself, creates a new SPEED_DETECTION or raises the existing
%      singleton*.
%
%      H = SPEED_DETECTION returns the handle to a new SPEED_DETECTION or the handle to
%      the existing singleton*.
%
%      SPEED_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEED_DETECTION.M with the given input arguments.
%
%      SPEED_DETECTION('Property','Value',...) creates a new SPEED_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before speed_detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to speed_detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help speed_detection

% Last Modified by GUIDE v2.5 30-Dec-2020 20:08:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speed_detection_OpeningFcn, ...
                   'gui_OutputFcn',  @speed_detection_OutputFcn, ...
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


% --- Executes just before speed_detection is made visible.
function speed_detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to speed_detection (see VARARGIN)

% Choose default command line output for speed_detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes speed_detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = speed_detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_video.
function load_video_Callback(hObject, eventdata, handles)
% hObject    handle to load_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % reference: https://www.mathworks.com/matlabcentral/answers/304393-how-can-i-play-video-in-matlab-gui-after-browsing-the-video
    [chosenfile, chosenpath] = uigetfile('*.mp4', 'Select a video');
    if ~ischar(chosenfile)
        return;   %user canceled dialog
    end
    global filename;
    filename = fullfile(chosenpath, chosenfile);
    
    set(handles.video_path, 'String', filename);
    if ~exist(filename, 'file')
        warndlg('Video is not present!');
        return;
    end
    
    try
        obj = VideoReader(filename);
    catch        
        return;
    end
        
    while hasFrame(obj)
        vidFrame = readFrame(obj);        
        image(vidFrame, 'Parent', handles.axes1);
        set(handles.axes1, 'Visible', 'off');
        pause(1/obj.FrameRate);
    end
    [frames, length, speed] = video_reader(filename);
    axes(handles.axes2);
    imshow((frames{length - 2}));
    axes(handles.axes3);
    imshow((frames{length - 1}));


% --- Executes on button press in play_video.
function play_video_Callback(hObject, eventdata, handles)
% hObject    handle to play_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global filename;
    try
        obj = VideoReader(filename);
    catch        
        return;
    end
        
    while hasFrame(obj)
        vidFrame = readFrame(obj);        
        image(vidFrame, 'Parent', handles.axes1);
        set(handles.axes1, 'Visible', 'off');
        pause(1/obj.FrameRate);
    end    
    [frames, length, speed] = video_reader(filename);
    speed = num2str(speed * 0.02);
    str = [speed ' cm / sec'];
    set(handles.speed, 'String', str);
    axes(handles.axes2);
    imshow((frames{length - 2}));
    axes(handles.axes3);
    imshow((frames{length - 1}));
