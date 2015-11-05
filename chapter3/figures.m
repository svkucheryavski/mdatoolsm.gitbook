close all
clear
clc

figfolder = '.';
figw = 400;
figh = 275;

%% autoscaling
load('people')

data = people(:, {'Height', 'Wine'});
% create a preprocessing object only for centering
p = prep();
p.add('center');

% show information about the object
show(p);


pdata1 = copy(data);
p.apply(pdata1);



nfig = 1;

lim = 200;
figure

subplot 121
scatter(data)
title('Original data')
grid on
axis([-lim lim -lim lim])
line([0 0], [-lim lim], 'Color', 'k')
line([-lim lim], [0 0], 'Color', 'k')

subplot 122
scatter(pdata1)
title('After centering')
grid on
axis([-lim lim -lim lim])
line([0 0], [-lim lim], 'Color', 'k')
line([-lim lim], [0 0], 'Color', 'k')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')



p = prep();
p.add('center');
p.add('scale');

show(p);


pdata2 = copy(data);
p.apply(pdata2);

nfig = 2;
figure 

subplot 121
scatter(pdata1)
title('After centering')
grid on
axis([-100 100 -100 100])
line([0 0], [-100 100], 'Color', 'k')
line([-100 100], [0 0], 'Color', 'k')

subplot 122
scatter(pdata2)
title('After autoscaling')
grid on
axis([-2 2 -2 2])
line([0 0], [-2 2], 'Color', 'k')
line([-2 2], [0 0], 'Color', 'k')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh], 'png', '-r150')


p = prep();
p.add('center', median(data));

p = prep();
p.add('center');
p.add('scale');

show(p);

p.remove(1);

show(p);


%% parameters of preprocessing

load('people')

m = people(people(:, 'Sex') == -1, 1:5);
f = people(people(:, 'Sex') ==  1, 1:5);

p = prep();
p.add('center');

fp = copy(f);
p.apply(fp);

show(mean(f))
show(mean(fp))

mp = copy(m);
p.apply(mp);

show(mean(m))
show(mean(mp))

p2 = copy(p);
mp = copy(m);
p2.apply(mp)

show(mean(m))
show(mean(mp))

%% baseline correction

load('simdata')

p = prep();
p.add('snv')
pspectra = copy(spectra);
p.apply(pspectra)

nfig = 3;

figure


subplot 211
plot(spectra)
title('Original spectra')

subplot 212
plot(pspectra)
title('After SNV correction')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')


p = prep();
p.add('msc')
pspectra = copy(spectra);
p.apply(pspectra)

nfig = 4;

figure

subplot 211
plot(spectra)
title('Original spectra')

subplot 212
plot(pspectra)
title('After MSC transformation')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

%% ALS

npdf = @(x, m, s)(1/sqrt(2 * pi * s^2) * exp(-(x - m).^2/(2 * s^2)));

x = 1:3000;
y = -((x - 1500) / 100).^2 + 200;
y = y + npdf(x, 150, 10) * 10000;
y = y + npdf(x, 550, 20) * 10000;
y = y + npdf(x, 1550, 30) * 10000;
y = y + npdf(x, 2000, 20) * 10000;
y = mdadata(y);

p1 = prep(); p1.add('alsbasecorr', 100000, 0.1);
p2 = prep(); p2.add('alsbasecorr', 100000, 0.01);
p3 = prep(); p3.add('alsbasecorr', 1000000, 0.01);

py1 = copy(y);
p1.apply(py1);
py2 = copy(y);
p2.apply(py2);
py3 = copy(y);
p3.apply(py3);

nfig = 5;

figure
subplot 221
plot(y, x)
ylim([-100 500])
title('Original data')

subplot 222
plot(py1, x)
ylim([-100 500])
title('s = 10^5, p = 0.1')

subplot 223
plot(py2, x)
ylim([-100 500])
title('s = 10^5, p = 0.01')

subplot 224
plot(py3, x)
ylim([-100 500])
title('s = 10^6, p = 0.01')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')

%% Savgol


load('simdata')

% add random noise to the spectra
nspectra = spectra + 0.025 * randn(size(spectra));

% create two objects for preprocessing
p1 = prep();
p1.add('savgol', 0, 15, 1);

p2 = prep();
p2.add('savgol', 1, 15, 1);

% apply the preprocessing
sspectra = copy(nspectra);
p1.apply(sspectra);

dspectra = copy(nspectra);
p2.apply(dspectra);

% show results
nfig = 6;

figure

subplot 221
plot(spectra)
title('Original')
subplot 222
plot(nspectra)
title('With nose added')
subplot 223
plot(sspectra)
title('After smoothing')
subplot 224
plot(dspectra)
title('Smoothing and 1st derivative')

printplot(gcf, sprintf('%s/fig%d.png', figfolder, nfig), [figw * 2, figh * 2], 'png', '-r150')
