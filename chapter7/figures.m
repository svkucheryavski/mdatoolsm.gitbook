close all
clear
clc

figfolder = '.';
figw = 400;
figh = 275;

load('people')

%% model calibration

X = copy(people);
X.removecols('Region');

c = people(:, 'Region');
c.factor(1, {'A', 'B'});

m1 = mdaplsda(X, c, 'A', 3, 'Scale', 'on');

X = copy(people);
X.removecols('Region');

c = people(:, 'Region') == -1;

m2 = mdaplsda(X, c, 'A', 3, 'Scale', 'on');

%% explore results (1)

show([m1.calres.ypred(1:end, 1, 3) m1.calres.cpred(1:end, 1, 3)])

disp(m1.calres.stat)

summary(m1)

nfig = 1;

figure
subplot 221
plotclassification(m1.calres)
subplot 222
plotclassification(m1.calres, 1, 1)
subplot 223
plotclassification(m1.calres, 'Color', 'rg', 'Marker', 'ds')
subplot 224
plotpredictions(m1.calres)
line(xlim(), [0 0], 'Color', 'k')
printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


%% explore results (2)

nfig = 2;

figure
subplot 221
plotsensitivity(m1.calres)
subplot 222
plotspecificity(m1.calres)
subplot 223
plotmisclassified(m1.calres)
subplot 224
plotrmse(m1.calres)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


%% exploring model (1)

m = mdaplsda(X, c, 'A', 3, 'Scale', 'on', 'CV', {'full'}); 

nfig = 3;

figure
subplot 221
plotsensitivity(m)
subplot 222
plotspecificity(m)
subplot 223
plotmisclassified(m)
subplot 224
plotrmse(m)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


%% exploring model (2)

nfig = 4;
figure
plotclassification(m)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

%% exploring model (test set validation)

tind = 1:4:32;

Xc = copy(people);
Xc.removecols('Region');
Xc.removerows(tind);

cc = people(:, 'Region');
cc.removerows(tind);
cc.factor(1, {'A', 'B'});

Xt = people(tind, :);
Xt.removecols('Region');

ct = people(tind, 'Region');
ct.factor(1, {'A', 'B'});

m1 = mdaplsda(Xc, cc, 'A', 2, 'Scale', 'on', 'CV', {'full'}, 'TestSet', {Xt, ct});

cc = people(:, 'Region') == -1;
cc(tind) = [];

ct = people(tind, 'Region') == -1;

m2 = mdaplsda(Xc, cc, 'A', 2, 'Scale', 'on', 'CV', {'full'}, 'TestSet', {Xt, ct});

figure
plotclassification(m1)

figure
plotclassification(m2)

%% predictions

% define values for two "new" persons
p1 = [181 82 -1 42 35 35000 320 100 -1 90 120];
p2 = [179 76 -1 42 43 19000 185 180 -1 85 120];

% create a dataset
p = mdadata([p1; p2], {'P1', 'P2'}, X.colNames);

% make predictions without reference values
res1 = m.predict(p);

% make predictions with reference values
res2 = m.predict(p, [true; false]);

nfig = 5;
% show results
figure
subplot 121
plotclassification(res1, 'Labels', 'names')
subplot 122
plotclassification(res2, 'Labels', 'names')
printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')



