close all
clear
clc

figfolder = '.';
figw = 400;
figh = 275;

%% model calibration (1)

load('people');

% split data into subsets
tind = 4:4:32;

Xc = copy(people);
Xc.removecols('Shoesize')
Xc.removerows(tind);

yc = people(:, 'Shoesize');
yc.removerows(tind);

Xt = people(tind, :);
Xt.removecols('Shoesize')
yt = people(tind, 'Shoesize');

% create a model object and show the object info
m = mdapls(Xc, yc, 5, 'Scale', 'on');
disp(m)

%% results (1)

% show result object
disp(m.calres)

% display decomposition object
disp(m.calres.xdecomp)


nfig = 1;

figure

subplot 121
plotexpvar(m.calres.xdecomp, 'Type', 'bar')
title('Explained variance for X')

subplot 122
plotexpvar(m.calres.ydecomp, 'Type', 'bar')
title('Explained variance for Y')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')

%% results (2)

show(m.calres.ypred)

show([m.calres.yref m.calres.ypred(1:end, 1, [1 3])])

nfig = 2;

figure

% default
subplot 221
plotpredictions(m)

% for the first y-variable
subplot 222
plotpredictions(m, 1)

% for the first y-variable and two components
subplot 223
plotpredictions(m, 1, 2)

% for y-variable 'Showsize' and two components + extra settings
subplot 224
plotpredictions(m, 'Shoesize', 2, 'Marker', 's', 'Color', 'r')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

nfig = 3;

figure
subplot 221
plotxyscores(m.calres, 1, 'Labels', 'names')
subplot 222
plotxyscores(m.calres, 2, 'Labels', 'names')
subplot 223
plotxyscores(m.calres, 3, 'Labels', 'names')
subplot 224
plotxyscores(m.calres, 4, 'Labels', 'names')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

%% results (3)

summary(m.calres)

nfig = 4;

figure
plot(m.calres)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


%% model (1)


m = mdapls(Xc, yc, 3, 'Scale', 'on', 'CV', {'full'}, 'TestSet', {Xt, yt});
summary(m)

nfig = 5;

figure
plot(m)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

%% model (2)

nfig = 6;

figure

% default
subplot 221
plotregcoeffs(m)

% for the first y-variable
subplot 222
plotregcoeffs(m, 1)

% for the first y-variable and two components
subplot 223
plotregcoeffs(m, 1, 2)

% for y-variable 'Showsize' and two components + extra settings
subplot 224
plotregcoeffs(m, 'Shoesize', 2, 'Type', 'line', 'Color', 'r')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

%% model (3)

nfig = 7;

figure
subplot 221
plotxyloadings(m, [1 2], 'Labels', 'names', 'Color', 'br')
subplot 222
plotxloadings(m, [1 2], 'Labels', 'names', 'Color', 'g')
subplot 223
plotxloadings(m, [1 2], 'Type', 'bar')
subplot 224
plotweights(m, [1 2], 'Type', 'bar', 'FaceColor', 'rg')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

