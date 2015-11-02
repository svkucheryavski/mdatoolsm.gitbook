figw = 400;
figh = 275;
figfolder = '.';

%% 

nfig = 1;

figure
load people
scatter(people(:, 1:2), 'Marker', 's', 'MarkerFaceColor', 'c');

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw/2, figh/2], 'png', '-r150')


nfig = 2;

figure
subplot(1, 2, 1)
scatter(people(:, 1:2), 'Labels', 'names');
subplot(1, 2, 2)
scatter(people(:, 1:2), 'Labels', 'numbers');

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')



nfig = 3;

figure
v = people(:, 'Beer').values;
subplot(1, 3, 1)
scatter(people(:, 1:2), 'Colorby', v);
subplot(1, 3, 2)
scatter(people(:, 1:2), 'Colorby', v > 300);
subplot(1, 3, 3)
scatter(people(:, 1:2), 'Colorby', people(:, 'Beer'));

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 3, figh], 'png', '-r150')



nfig = 4;

figure
subplot(1, 2, 1)
scatter(people(:, 1:2), 'Colorby', people(:, 'Beer'), 'Colorbar', 'off');
subplot(1, 2, 2)
scatter(people(:, 1:2), 'Colorby', people(:, 'Beer'), 'Colormap', @gray,...
      'Colorbar', 'on', 'ColorbarTitle', 'Beer consumption (L/year)');

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')
   
%% Density scatter

nfig = 5;

data = mdadata(randn(50000, 2));

figure
densscatter(data);

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw, figh], 'png', '-r150')



nfig = 6;

figure
subplot(1, 3, 1)
densscatter(data);
subplot(1, 3, 2)
densscatter(data, 'NBins', 30);
subplot(1, 3, 3)
densscatter(data, 'Colormap', @spring);

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 3, figh], 'png', '-r150')

%% Line plot

nfig = 7;

load simdata
figure
plot(spectra, 'Color', 'r')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


nfig = 8;

figure
subplot(2, 1, 1)
plot(spectra, 1:151, 'Color', 'b')
xlabel('Wavenumbers')
nm = str2num(cell2mat(spectra.colNames'));
invcm = 10^7 ./ nm;
subplot(2, 1, 2)
plot(spectra, invcm, 'Color', 'r')
xlabel('Wavelength, cm-1')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')



nfig = 9;

figure
subplot(2, 1, 1)
plot(spectra, 'Colorby', conc(:, 1))
subplot(2, 1, 2)
plot(spectra, 'Colorby', conc(:, 1), 'Colorbar', 'on', 'ColorbarTitle', 'Concentration of C1')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh   * 2], 'png', '-r150')

%% Bar plots

expvar = mdadata([45.6 24.1 9.71 5.63 3.1; 43.4 21.1 9.63 4.12 2.2]);
expvar.rowNames = {'Calibration', 'Test'};
expvar.colNames = 1:5;
expvar.dimNames = {'Results', 'Components'};
expvar.name = 'Explained variance, %';

show(expvar)

nfig = 10;

figure
bar(expvar('Test', :), 'FaceColor', 'r')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw, figh], 'png', '-r150')



nfig = 11;

figure
subplot(1, 2, 1)
bar(expvar('Test', :), 'Labels', 'values')
subplot(1, 2, 2)
bar(expvar('Test', :), 'Labels', 'values', 'LabelsSigfig', 2)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')

%% Level and matrix plots

nfig = 12;

figure
levelplot(people(1:5, 1:5))

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw, figh], 'png', '-r150')


nfig = 13;

figure
levelplot(corr(people(1:5, 1:5)), 'Colormap', @jet)
colorbar

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw, figh], 'png', '-r150')


nfig = 14;

figure
matrixplot(people(1:5, 1:5), 'Colormap', @jet)
colorbar

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw, figh], 'png', '-r150')

%% Statistical plots

nfig = 15;

figure
subplot(1, 2, 1)
hist(people(:, 'Height'), 'FaceColor', 'r', 'FaceAlpha', 0.1)
subplot(1, 2, 2)
hist(people(:, 'Height'), 5, 'Density', 'on', 'ShowNormal', 'on', 'Color', 'r')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')



nfig = 16;

d = people(:, {'Height', 'Weight', 'Beer', 'Wine'});
figure
subplot(3, 2, 1)
errorbar(d, 'Color', 'r')
subplot(3, 2, 2)
errorbar(d, 'Alpha', 0.10)
subplot(3, 2, 3)
errorbar(d, 'Type', 'se')
subplot(3, 2, 4)
errorbar(d, 'Type', 'std')
subplot(3, 2, 5)
errorbar(d, 'Type', 'std', 'Alpha', 0.10)
printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 3], 'png', '-r150')



nfig = 17;

d = people(:, {'Height', 'Weight', 'Swim'});
figure
subplot(1, 3, 1)
boxplot(d)
subplot(1, 3, 2)
boxplot(d, 'Whisker', 1, 'Color', 'r', 'EdgeColor', 'k')
subplot(1, 3, 3)
boxplot(d, 'Whisker', 1, 'Labels', 'names')
printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 3, figh], 'png', '-r150')


