% Путь к папке
dataPath = 'C:\Users\tanso\Nextcloud\Home-Cloud\Masters\Summer_semester_2025\Neurocognition\intentional-binding\';

% Файлы
file_BA         = fullfile(dataPath, '41baselineAction.csv');
file_BT         = fullfile(dataPath, '41baselineTone.csv');
file_OA_self    = fullfile(dataPath, '41operantAction.csv');   % self-generated
file_OA_other   = fullfile(dataPath, '42operantAction.csv');   % other-generated

% Загрузка данных 
BA = readmatrix(file_BA);
BT = readmatrix(file_BT);
OA_self  = readmatrix(file_OA_self);
OA_other = readmatrix(file_OA_other);

%Извлечение ошибок (errorInMs)
BA_errors = BA(:, end);             % baseline action
BT_errors = BT(:, end);             % baseline tone
OA_self_action_errors  = OA_self(:, 12);
OA_self_tone_errors    = OA_self(:, 17);
OA_other_action_errors = OA_other(:, 12);

%Очистка NaN
BA_errors = BA_errors(~isnan(BA_errors));
BT_errors = BT_errors(~isnan(BT_errors));
OA_self_action_errors  = OA_self_action_errors(~isnan(OA_self_action_errors));
OA_self_tone_errors    = OA_self_tone_errors(~isnan(OA_self_tone_errors));
OA_other_action_errors = OA_other_action_errors(~isnan(OA_other_action_errors));

% Расчёт binding
binding_self_action  = mean(OA_self_action_errors)  - mean(BA_errors);
binding_self_tone    = mean(BT_errors)              - mean(OA_self_tone_errors);
binding_other_action = mean(OA_other_action_errors) - mean(BA_errors);

% Вывод
fprintf('\n=== Intentional Binding: Subject 1 ===\n');
fprintf('Self Action Binding:  %.2f ms\n', binding_self_action);
fprintf('Self Tone Binding:    %.2f ms\n', binding_self_tone);
fprintf('Other Action Binding: %.2f ms\n', binding_other_action);
fprintf('Difference (Self - Other): %.2f ms\n', binding_self_action - binding_other_action);

% Визуализация
figure;

% Данные
bindings = [binding_self_action, binding_other_action, binding_self_tone];
labels = {'Self Action', 'Other Action', 'Self Tone'};

% Построение зелёной диаграммы
b = bar(bindings, 'FaceColor', [0.2 0.6 0.2]);  % зелёный

% Оформление
set(gca, 'XTickLabel', labels, 'FontSize', 12);
ylabel('Binding (ms)', 'FontSize', 12);
title('Intentional Binding — Self vs. Other', 'FontSize', 14);
grid on;

% [h,p] = ttest(self_action_all - other_action_all);
% figure;
% subplot(1,2,1); histogram(OA_self_action_errors); title('Self action errors');
% subplot(1,2,2); histogram(OA_other_action_errors); title('Other action errors');
