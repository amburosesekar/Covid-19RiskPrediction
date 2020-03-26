function varargout = RiskPredictionTool(varargin)
% RISKPREDICTIONTOOL MATLAB code for RiskPredictionTool.fig
%      RISKPREDICTIONTOOL, by itself, creates a new RISKPREDICTIONTOOL or raises the existing
%      singleton*.
%
%      H = RISKPREDICTIONTOOL returns the handle to a new RISKPREDICTIONTOOL or the handle to
%      the existing singleton*.
%
%      RISKPREDICTIONTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RISKPREDICTIONTOOL.M with the given input arguments.
%
%      RISKPREDICTIONTOOL('Property','Value',...) creates a new RISKPREDICTIONTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RiskPredictionTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RiskPredictionTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RiskPredictionTool

% Last Modified by GUIDE v2.5 26-Mar-2020 23:32:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RiskPredictionTool_OpeningFcn, ...
                   'gui_OutputFcn',  @RiskPredictionTool_OutputFcn, ...
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


% --- Executes just before RiskPredictionTool is made visible.
function RiskPredictionTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RiskPredictionTool (see VARARGIN)

% Choose default command line output for RiskPredictionTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RiskPredictionTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RiskPredictionTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num txt raw Class Preproc inputArr out1

temp1 =(get(handles.edit1,'String'));
as=strsplit(temp1,':');
inputArr=str2double(as{1}):str2double(as{2});
out1 =str2double(get(handles.edit2,'String'));



[file,path]=uigetfile('*','Select Training XL File');
[num,txt,raw] = xlsread(strcat(path,file))
% [num,txt,raw] = xlsread('DataModel.xls');
%Id=num(:,1);% No Need first column
%% Extract All Data to Features
for ik=1:size(num,2)
     if(sum(isnan(num(:,ik)))>5) % Text Data
        %%
        txtT=zeros(1,numel(txt(2:end,ik)));
        [A,ia1,ic1]=unique(txt(2:end,ik));
        ab=1;
        for ip=1:numel(ia1)
            if(strcmp(A{ip},''))
                txtT(ic1==ip)=NaN;   
            else
                txtT(ic1==ip)=ab;
                ab=ab+1;
            end
        end       
        %%
       Sp{ik}= txtT';
    else                       % NonText Data
       Sp{ik}=num(:,ik);
    end
end
Preproc=cell2mat(Sp);
figure,
plot(Preproc(:,inputArr))
legend(txt{1,inputArr})
xlabel('Sample')
ylabel('Amplitude')
%% Assign Class
outputInd=out1;
[A,ia1,ic1]=unique(upper(txt(2:end,outputInd)));
Class=zeros(1,numel(txt(2:end,outputInd)));
ab=1;
for ik=1:numel(ia1)     
       Class(ic1==ik)=ab;
       ab=ab+1;     
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Class minS maxS
global XaN Preproc inputArr out1

xa=Preproc(:,inputArr); %imp
XaN=xa;
for ik=1:size(xa,2)
   minS(ik)= min(xa(:,ik));
   maxS(ik)= max(xa(:,ik));  
   
   if(maxS(ik)==minS(ik))
        XaN(:,ik)=xa(:,ik)./maxS(ik);    
   else
        XaN(:,ik)=(xa(:,ik)-min(xa(:,ik)))./(max(xa(:,ik))-min(xa(:,ik)));
   end
end
xb=[XaN];
TrainingSet=xb;
TestSet=xb;
GroupTrain=Class;

% %% Training Result   
% P1=TrainingSet;
% vec2 = full(ind2vec(Class));
% T=vec2; 
% net = patternnet(5);
% net.trainParam.epochs =1050;
% net = train(net,(P1)',(T));
% view(net)
% y = net(P1');
% perf = perform(net,T,y);
% classes = vec2ind(y)
% label=classes'
% Mdl=net;




%%
 %Mdl = fitcknn(TrainingSet, GroupTrain,'NumNeighbors',10);
 Mdl = fitcecoc(TrainingSet, GroupTrain, 'Learners',templateSVM('Standardize',true));
 [label,score] = predict(Mdl, TestSet);
 ind=find(Class~=label');
 misAccF=numel(ind)/numel(label)
 AccF=1-misAccF



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Class label ind2
global XaN Preproc len out1 min1 max1 Mdl
xb=[XaN];
%%
Max_iteration=str2double(get(handles.edit6,'String'));
Pop_size=str2double(get(handles.edit7,'String'));

min1=str2double(get(handles.edit4,'String'));
max1=str2double(get(handles.edit5,'String'));
Function_name='F1';
Animation=0;
[cg_curvePSO,Best_sol]=psoEx(Max_iteration,Pop_size,Function_name);%ProposedPSO2(Max_iteration,Function_name,Animation);%
Best_pos=Best_sol.Position;
%% Feature Selection
x=Best_pos;
len=round(x(end));

[val2,ind2]=sort(x(1:end-1));
x1=xb(:,ind2(1:len));
TrainingSet=x1;%(x1-min(x1,1))./(max(x1,1)-min(x1,1));
TestSet=x1;%(x1-min(x1,1))./(max(x1,1)-min(x1,1));
GroupTrain=Class;
Mdl = fitcecoc(TrainingSet, GroupTrain, 'Learners',templateSVM('Standardize',true));
[label,score] = predict(Mdl, TestSet);
ind=find(Class~=label');
misAcc=numel(ind)/numel(label)
Acc=1-misAcc



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Class label num txt raw ind2
global XaN Preproc len out1 Mdl minS maxS
XaN;
Preproc;
num;
txt;
raw;
ind2;
len;
Mdl; minS; maxS;

fprintf('Selected Features -->\n')
txt(1,ind2(1:len))


[Ap,ia1,ic1]=unique(upper(txt(2:end,out1)));
ind=find(Class~=label');
misAccFt=numel(ind)/numel(label)
AccFpsotrain=1-misAccFt
fprintf('Actual Class ||  Predicted Class\n')
[Class ;label']


fprintf('Actual Class ||  Predicted Class \n')
for iv=1:numel(Class)
 fprintf('%15s--%15s\n',Ap{Class(iv)}, Ap{label(iv)})   
end


yt=Class';
T=label';
figure,
plotconfusion(full(ind2vec(yt')),full(ind2vec(T)))
title('TestResult')
EVAL = Evaluate(T,yt')
% cpNeuralNet = classperf(T,yt')
figure,
plotroc(full(ind2vec(T)),full(ind2vec(yt')))


answer = questdlg('Would you like to update Training Dataset?', ...
	'Menu', ...
	'Yes','No','No thank you');
% Handle response
switch answer
    case 'Yes'
        save('TrainingData.mat','Class','label','XaN', 'Preproc','num','txt','raw','ind2','Mdl','len','minS','maxS');        
    case 'No'
        disp([answer ' coming right up.'])
        
    case 'No thank you'
        disp([answer ' coming right up.'])
end







% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Preproc2 num2 txt2 raw2 XaNt Mdl2 num txt len out1
load('TrainingData.mat')
Mdl2=Mdl;
num;
txt;
len;
temp1 =(get(handles.edit1,'String'));
as=strsplit(temp1,':');
inputArr=str2double(as{1}):str2double(as{2});
out1 =str2double(get(handles.edit2,'String'));
[file,path]=uigetfile('*','Select Testing XL File');
%[num,txt,raw] = xlsread(strcat(path,file))
[num2,txt2,raw2] = xlsread(strcat(path,file));
%Id=num(:,1);% No Need first column
%% Extract All Data to Features

for ik=1:size(num2,2)
     if(sum(isnan(num2(:,ik)))>=1) % Text Data
        %%
        txtT2=zeros(1,numel(txt2(2:end,ik)));
        [A,ia1,ic1]=unique(txt2(2:end,ik));
        [Ap,ia2,ic2]=unique(txt(2:end,ik));
        
        ab=1;
        for ip=1:numel(ia1)
            if(strcmp(Ap{ip},''))
                txtT2(ic1==ip)=NaN;   
            else
                val=find(strcmp(A{ip},Ap)==1);
                txtT2(ic1==ip)=val;
                ab=ab+1;
            end
        end       
        %%
       Sp2{ik}= txtT2';
    else                       % NonText Data
       Sp2{ik}=num2(:,ik);
     end
       
end
Preproc2=cell2mat(Sp2);
figure,
plot(Preproc2(:,inputArr))
legend(txt2{1,inputArr})
xlabel('Sample')
ylabel('Amplitude')
xat=Preproc2(:,inputArr); %imp
XaNt=xat;
for ik=1:size(xat,2)
   if(maxS(ik)==minS(ik))
   XaNt(:,ik)=xat(:,ik)./maxS(ik);    
   else
   XaNt(:,ik)=(xat(:,ik)-minS(ik))./(maxS(ik)-minS(ik));
   end
end






% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Preproc2 num2 txt2 raw2 XaNt Mdl2 ind2 num txt len out1

%% Predict Result
[Ap,ia2,ic2]=unique(upper(txt(2:end,out1)));
TestSet=XaNt(:,ind2(1:len));
%GroupTrain=Classp1;
%Mdl = fitcecoc(TrainingSet, GroupTrain, 'Learners',templateSVM('Standardize',true));
[label2,score] = predict(Mdl2, TestSet);
fprintf('Predicted Class-->%s\n',Ap{label2})
label2

%% Result Performance Analysis
try
global Class2
outputInd=out1;
[A,ia1,ic1]=unique(upper(txt2(2:end,outputInd)));
Class2=zeros(1,numel(txt2(2:end,outputInd)));
for ik=1:numel(ia1)     
        val=find(strcmp(A{ik},Ap)==1);
       Class2(ic1==ik)=val;
end
fprintf('Actual Class ||  Predicted Class\n')
[Class2 ;label2']


fprintf('Actual Class ||  Predicted Class \n')
for iv=1:numel(Class2)
 fprintf('%15s--%15s\n',Ap{Class2(iv)}, Ap{label2(iv)})   
end



yt1=Class2';
Tt1=label2';
figure,
plotconfusion(full(ind2vec(yt1')),full(ind2vec(Tt1)))
title('TestResult')
EVAL_Testing = Evaluate(Tt1,yt1')
figure,
plotroc(full(ind2vec(Tt1)),full(ind2vec(yt1')))
catch
    msgbox('No Validate Data for Testing!!!');
end



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Preproc2 num2 txt2 raw2 XaNt Mdl2 ind2 num txt len out1
Id =str2double(get(handles.edit3,'String'));
[Ap,ia2,ic2]=unique(upper(txt(2:end,out1)));
TestSet=XaNt(Id,ind2(1:len));
[label2,score] = predict(Mdl2, TestSet);
fprintf('Predicted Class-->%s\n',Ap{label2})
set(handles.text7, 'String',Ap{label2});
drawnow; % Needed only if this is in a fast loop.



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
