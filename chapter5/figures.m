close all
clear
clc

figfolder = '.';
figw = 400;
figh = 275;


%% model calibration (1)

load('people');

% split data to subsets

tind = 4:4:32;

Xc = people(:, {'Height', 'Income', 'Age', 'Beer', 'IQ'});
Xc.removerows(tind);
yc = people(:, 'Shoesize');
yc.removerows(tind);

Xt = people(tind, {'Height', 'Income', 'Age', 'Beer', 'IQ'});
yt = people(tind, 'Shoesize');

m = mdamlr(Xc, yc);

%% model calibration (2)

px = prep();
px.add('scale');

py = prep();
py.add('scale');

m = mdamlr(Xc, yc, 'Prep', {px, py});

%% exploring MLR results (1)

disp(m.calres)
disp(m.calres.ypred)
show([m.calres.yref m.calres.ypred])

disp(m.calres.stat)

summary(m.calres)

nfig = 1;

figure
subplot 121
plotpredictions(m.calres)
subplot 122
plotyresiduals(m.calres)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')

%% exploring MLR results (2)

nfig = 2;

figure
subplot 121
plotpredictions(m.calres, 'Marker', 's', 'Colorby', m.calres.yref)
subplot 122
plotyresiduals(m.calres, 'Color', 'c', 'Labels', 'names')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')

%% validation (1)

mcv = mdamlr(Xc, yc, 'Scale', 'on', 'CV', {'rand', 8, 4});
disp(mcv)
summary(mcv.cvres)

%% validation (2)

mt = mdamlr(Xc, yc, 'Scale', 'on', 'TestSet', {Xt, yt});
disp(mt)

mcvt = mdamlr(Xc, yc, 'Scale', 'on', 'CV', {'rand', 8, 4}, 'TestSet', {Xt, yt});
disp(mcvt)

%% exploring MLR model (1)

summary(mcvt)

nfig = 3;

figure
subplot 121
plotpredictions(mcvt)
subplot 122
plotyresiduals(mcvt)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')


%% exploring MLR model (2)

nfig = 4;

figure
subplot 121
plotpredictions(mcvt, 'Color', 'rgb')
subplot 122
plotyresiduals(mcvt, 'Marker', {'s', 'd', 'o'}, 'MarkerSize', [5 7 9])

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')

%% regcoeffs (1)

clc
show(m.regcoeffs.values)
disp(m.regcoeffs.pvalues)
disp(mcv.regcoeffs.pvalues)
show(mcv.regcoeffs.pvalues)
summary(mcv.regcoeffs)


m1 = mdamlr(Xc, yc, 'Scale', 'on', 'CV', {'full'}, 'Alpha', 0.01);
m2 = mdamlr(Xc, yc, 'Scale', 'on', 'CV', {'full'}, 'Alpha', 0.1);

nfig = 5;

figure
subplot 221
plotregcoeffs(m1)
subplot 222
plotregcoeffs(m2)
subplot 223
plotregcoeffs(m1, 'Type', 'line')
subplot 224
plotregcoeffs(m2, 'Type', 'line')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

%% regcoeffs (2)

nfig = 6;

figure
subplot 121
plotregcoeffs(m1, 'CI', 'off')
subplot 122
plotregcoeffs(m1, 'Type', 'line', 'CI', 'off')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')

%% predictions

res = mcv.predict(Xt);
show(res.ypred)

summary(res)

nfig = 7;

figure
subplot 121
plotpredictions(res)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')


res = mcv.predict(Xt, yt);
summary(res)
