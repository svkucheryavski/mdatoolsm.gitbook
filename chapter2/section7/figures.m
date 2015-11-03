figw = 400;
figh = 275;
figfolder = '.';

%% statistical group plots

n = 1000;
v1 = [randn(n, 1); randn(n, 1) + 2];
v2 = [rand(n, 1); rand(n, 1) + 0.3];
v3 = [ones(n, 1); zeros(n, 1)];

data = mdadata([v1 v2 v3]);
data.factor(3);

nfig = 1;

figure
subplot 121
hist(data(:, 1), data(:, 3), 'ShowNormal', 'on');
subplot 122
hist(data(:, 1), data(:, 3), 15, 'ShowNormal', 'on', 'FaceAlpha', 0.3);

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')



nfig = 2;

figure
subplot 121
hist(data, data(:, 3), 25, 'ShowNormal', 'on', 'FaceColor', 'rb');

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


load people

people.factor('Sex', {'Male', 'Female'});
people.factor('Region', {'A', 'B'});



nfig = 3;

figure
subplot 121
errorbar(people(:, 'Height'), people(:, {'Sex', 'Region'}), 'Type', 'std', 'Alpha', 0.1);
subplot 122
errorbar(people(:, 'Height'), people(:, {'Sex', 'Region'}), 'Alpha', 0.1);

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


nfig = 4;

figure
subplot 121
boxplot(people(:, 'Height'), people(:, {'Sex', 'Region'}), 'Labels', 'names');
subplot 122
boxplot(people(:, 'Height'), people(:, {'Sex'}), 'Whisker', 1);

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


nfig = 5;

figure
subplot 121
qqplot(people(:, 'Height'), people(:, {'Sex', 'Region'}), 'Labels', 'names');
subplot 122
qqplot(people(:, 'Height'), people(:, {'Sex'}));

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


nfig = 6;

% set up a data with explained variance for PCA model
expvarcal = [0.54 0.25 0.13 0.09];
expvarcv = [0.49 0.19 0.15 0.12];
data = mdadata([expvarcal; expvarcv]);
data.rowNames = {'Cal', 'CV'};
data.colNames = {'PC1', 'PC2', 'PC3', 'PC4'};
data.dimNames = {'Results', 'Components'};
data.name = 'Explained variance';

% show group bar plot
figure
subplot 121
gbar(data);

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')



nfig = 7;

figure
subplot 121
gbar(data, 'FaceColor', 'yc', 'EdgeColor', 'rb', 'Labels', 'names');

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')



nfig = 8;

figure
subplot 121
gplot(data, 'Marker', '.')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


nfig = 9;

data = people(:, {'Height', 'Weight', 'Wine', 'Beer'});
groups = people(:, {'Sex', 'Region'});
groups.factor('Sex', {'Male', 'Female'});
groups.factor('Region', {'A', 'B'});

figure
subplot 121
gplot(data, groups)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


nfig = 10;

figure
subplot 121
gplot(data, groups, 'LineStyle', {'-', '--', ':', '-.'}, 'LineWidth', 2)

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


nfig = 11;

figure
subplot 121
gscatter(data(:, {'Wine', 'Beer'}), groups);

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


nfig = 12;

figure
subplot 121
gscatter(data, groups, 'Marker', 'ssoo', 'MarkerFaceColor', 'rbrb', 'Labels', 'names')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')
