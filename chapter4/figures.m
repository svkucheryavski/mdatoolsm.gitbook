close all
clear
clc

figfolder = '.';
figw = 400;
figh = 275;

%% objects and results

load('people');

dcal = copy(people);
dcal.removerows(1:4:32);
dtest = people(1:4:32, :);


m = mdapca(dcal, 5, 'Scale', 'on');

disp(m)

show(m.loadings(1:5, :))

disp(m.calres)
show(m.calres.variance)

%% predictions

res = m.predict(dtest);
disp(res)

res.info = 'New predictions';
disp(res)

%% validation

mt = mdapca(dcal, 5, 'Scale', 'on', 'TestSet', dtest);
disp(mt)

mcv = mdapca(dcal, 7, 'Scale', 'on', 'CV', {'rand', 10});
disp(mcv)

show(mcv.cvres.variance)

mcvt = mdapca(dcal, 7, 'Scale', 'on', 'CV', {'rand', 10}, 'TestSet', dtest);
disp(mcvt)

%% exploring the results

summary(m.calres)

nfig = 1;

figure
plot(m.calres)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


nfig = 2;

figure
plot(m.calres, [1 3], 'Labels', 'off')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


nfig = 3;

figure
subplot 211
plotscores(m.calres, 1:3, 'Type', 'line')
subplot 212
plotscores(m.calres, 2, 'Type', 'bar')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


nfig = 4;

figure
subplot 221
plotscores(m.calres, [1 2], 'Labels', 'names', 'Marker', 's', 'Color', 'r')
subplot 222
plotresiduals(m.calres, 2, 'Marker', '^', 'MarkerSize', 10)
subplot 223
plotexpvar(m.calres, 'Type', 'bar', 'FaceColor', 'g', 'Labels', 'values')
subplot 224
plotcumexpvar(m.calres, 'Type', 'line', 'Marker', 'o', 'MarkerSize', 10)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


%% exploring the models

summary(mt)

nfig = 5;

figure
plot(mt)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')



nfig = 6;

figure
subplot 321
plotloadings(m)
subplot 322
plotloadings(m, [1 3], 'Color', 'r', 'Marker', 's', 'Labels', 'names')
subplot (3, 2, 3:4)
plotloadings(m, 1:2, 'Type', 'line')
subplot (3, 2, 5:6)
plotloadings(m, 1:3, 'Type', 'bar', 'FaceColor', 'rgb')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 3], 'png', '-r150')



nfig = 7;

figure
subplot 221
plotexpvar(mcvt)
subplot 222
plotexpvar(mt, 'Type', 'bar', 'FaceColor', 'rg', 'Labels', 'values')
subplot 223
plotcumexpvar(mcvt)
subplot 224
plotcumexpvar(mt, 'Type', 'bar', 'FaceColor', 'rg', 'Labels', 'values')
printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


nfig = 8;

figure
subplot 221
plotscores(mcvt)
subplot 222
plotscores(mt, [1 2], 'Marker', {'s', 'd', 'o'}, 'Color', 'rgb')
subplot 223
plotresiduals(mcvt)
subplot 224
plotresiduals(mt, 2, 'Marker', {'s', 'd', 'o'}, 'Color', 'rgb')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

%% preprocessing

load('people');

p = prep();
p.add('scale');

m = mdapca(people, 5, 'Prep', p);

nfig = 9;

figure
plot(m)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')



v = [180 85 -1 44 39 32000 300 120 -1 95 -1 120];
p = mdadata(v, {'New person'}, people.colNames);

show(p)



res = m.predict(p);

nfig = 10;

figure

subplot 121
plotscores(m.calres)
hold on
plotscores(res, 'Color', 'r', 'Labels', 'names')
hold off

subplot 122
plotresiduals(m.calres)
hold on
plotresiduals(res, 'Color', 'r', 'Labels', 'names')
hold off
printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 1], 'png', '-r150')


