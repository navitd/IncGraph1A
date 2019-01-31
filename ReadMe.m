
%% read asin, score and date from text file
% run ReadTextRT
% input: Electronics_5.txt
% output: ERT: cell with asin, score and date of reviews
% output: countRv: a vector of number of reviews per item


%% build subgroup: only Items with >100 reviews
% run buildItemCell
% input:    ElectronicRT
% output:   EitemCell
% contains  itemCell: col.1: asin, 
%                     col.2: score (sorted chronologically) 
%                     col.3: date 
%                     col.4: avg. score of item
%

%% Find high impact reviews
% run StatOcc6
% input:  EitemCell
% assign within file: w: window width where Impact is checked
% output: histogram graph
%         area_ratio:    percentage of High impact reviews that are not high impact 
%         std of area_ratio
%         NIdip1:        number of high impact incidents depicted
%
% Graph1A: window mean score histogram for window width 20, where 223 reviews are "high
% impact reviews". 20.41% of these are an error. 
%Other parameters are: 
%Nhistbin=30    - number of bins in histogram
%Nitr=1000      - the histogram of the shuffled window is repeated Nitr times
%std_area_ratio=0.006 - standard deviation of area_ratio


% 2637 items with numbre of reviews >100 and score of 4+-1
% 6431 dip reviews, ouly 223 of them are identified as "sticky" - influencing reviews after them
% sticky incidents are a very small number of dip reviews
% mostly people score indipendently. However, sometimes there is an effect of a bad score influencing others after it to give a bad score
