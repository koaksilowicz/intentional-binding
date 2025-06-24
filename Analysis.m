% === Путь к папке ===
dataPath = 'C:\Users\tanso\Nextcloud\Home-Cloud\Masters\Summer_semester_2025\Neurocognition\intentional-binding\'; 

% === Файлы ===
file_BA = fullfile(dataPath, '1baselineAction.csv');
file_BT = fullfile(dataPath, '11baselineTone.csv');
file_OA_self = fullfile(dataPath, '11operantAction.csv');
file_OA_other = fullfile(dataPath, '12operantAction.csv');

% === Загрузка данных ===
BA = csvread(file_BA)
BT = csvread(file_BT)
OA = csvread(file_OA_self);         % operant action

% === Извлечение ошибок (errorInMs) ===
BA_errors = BA(:, end);         % последняя колонка — errorInMs
BT_errors = BT(:, end);         % baseline tone — тоже последняя

OA_errors_action = OA(:, 12);   % action error
OA_errors_tone   = OA(:, 17);   % tone error

% === Очистка NaN
BA_errors = BA_errors(~isnan(BA_errors));
BT_errors = BT_errors(~isnan(BT_errors));
OA_errors_action = OA_errors_action(~isnan(OA_errors_action));
OA_errors_tone = OA_errors_tone(~isnan(OA_errors_tone));

% === Расчёт binding-эффектов
action_binding = mean(OA_errors_action) - mean(BA_errors);
tone_binding = mean(BT_errors) - mean(OA_errors_tone);

% === Вывод
fprintf('\nIntentional Binding — Subject 1:\n');
fprintf('Action binding: %.2f ms\n', action_binding);
fprintf('Tone binding:   %.2f ms\n', tone_binding);

% === Визуализация
figure;
bar([action_binding, tone_binding]);
set(gca, 'XTickLabel', {'Action Binding', 'Tone Binding'});
ylabel('Binding (ms)');
title('Intentional Binding — Subject 1');
grid on;
