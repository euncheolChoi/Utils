% sample mat 파일  로드 : dbSturct 구조 확인 
load('berlin.mat'); 

%% Set imagefile path, utm coordinate file path
img_db_path = './FGI_pr/FGI_pr_sample/similar_ts_image_60_3';
img_db_files = dir(fullfile(img_db_path, '*.png'));

img_query_path = './FGI_pr/FGI_pr_sample/similar_ts_image_100_3';
img_query_files = dir(fullfile(img_query_path, '*.png'));

utm_db_file_name = './FGI_pr/FGI_pr_sample/similar_ts/utm_similar_ts_with_similar_ts_img_with_gt_60_3.csv';
utm_query_file_name = './FGI_pr/FGI_pr_sample/similar_ts/utm_similar_ts_with_similar_ts_img_with_gt_100_3.csv';

%% Get UTM Transformed pose
utm_pose_db = dbStruct{1,2};
% disp(utm_pose_db(1, :));

utm_pose_query = dbStruct{1,4};
% disp(utm_pose_query(1, :));

%% make custom .mat file of Drone dataset

% 1. set image files names to myStruct
myStruct = cell(1, 8);
img_db_arr = char(zeros(length(img_db_files), 40));
img_query_arr = char(zeros(length(img_query_files), 40));

% db files
for i=1:length(img_db_files)
    img_db_arr(i, 1:numel(img_db_files(i).name)) = img_db_files(i).name;   % string size == 40 이런식으로 설정해놔도 넣을 string size와 다르면 에러 발생 -> 문자열 사이즈만큼 다시 할당 후 대입 
end
myStruct{1, 1} = img_db_arr;

% query files
for i=1:length(img_query_files)
    img_query_arr(i, 1:numel(img_query_files(i).name)) = img_query_files(i).name;
end
myStruct{1, 3} = img_query_arr;

% 2. set utm poses to myStruct
% 출력 형식을 지정해 줘야 363814.218174787 값들 정밀도 유지 
format longG;
utm_data_db = readmatrix(utm_db_file_name);
utm_data_query = readmatrix(utm_query_file_name);

myStruct{1, 2} = utm_data_db(:, 2:3);
myStruct{1, 4} = utm_data_query(:, 2:3);

% 3. set other valuse
myStruct{1, 5} = length(img_db_arr);
myStruct{1, 6} = length(img_query_arr);
myStruct{1, 7} = 30;
myStruct{1, 8} = 900;

disp(dbStruct{1, 1})
%% Save myStruct file
save('myStruct.mat', 'myStruct');
