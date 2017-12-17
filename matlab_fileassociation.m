disp('Rebuild Matlab R2015a file associations on Windows.')

cwd=pwd;

cd([matlabroot '/mcr/toolbox/matlab/winfun/private']);

fileassoc('add',{'.m','.mat','.fig','.p','.mdl',['.' mexext]});

cd(cwd);

disp('Changed Windows file associations. FIG, M, MAT, MDL, MEX, and P files are now associated with MATLAB.')