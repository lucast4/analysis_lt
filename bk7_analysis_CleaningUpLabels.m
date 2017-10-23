% 1 - /bluejay4/lucas/birds/bk7/NEURAL/080916_NeuralAudio_/Chan14amp-BatchChan14good_v4
% 2 - /bluejay4/lucas/birds/bk7/NEURAL/080916_NeuralAudio_/Chan14amp-BatchChan14Late
% 19 - /bluejay4/lucas/birds/bk7/NEURAL/080916_NeuralAudio_/Chan9amp-Batch1010to1547

% 3 - /bluejay4/lucas/birds/bk7/NEURAL/081616_neuralAudio/Chan18amp-BatchMidDayChan18SU
% 4 - /bluejay4/lucas/birds/bk7/NEURAL/081616_neuralAudio/Chan18amp-BatchMidDayChan18SU

% 5 - /bluejay4/lucas/birds/bk7/NEURAL/081916_neuralaudio/Chan18amp-BatchChan18Early


% 7 - /bluejay4/lucas/birds/bk7/NEURAL/100616_LearnLMAN1/Chan10amp-BatchChan10oppdirlearn

% 8 - /bluejay4/lucas/birds/bk7/NEURAL/101716_LearnLMAN2/Chan10amp-Batch1302to1427
% 9 - /bluejay4/lucas/birds/bk7/NEURAL/101716_LearnLMAN2/Chan14amp-Batch1302to1427
% 10 - /bluejay4/lucas/birds/bk7/NEURAL/101716_LearnLMAN2/Chan23amp-Batch1302to1427
% 13 - /bluejay4/lucas/birds/bk7/NEURAL/101716_LearnLMAN2/Chan23amp-Batch1302to1322SU

% 11 - /bluejay4/lucas/birds/bk7/NEURAL/100516_LearnLMAN1/Chan23amp-Batch1259to1642SkipOne
% 12 - /bluejay4/lucas/birds/bk7/NEURAL/100516_LearnLMAN1/Chan18amp-Batch1259to1757SkipSome
% 6 - /bluejay4/lucas/birds/bk7/NEURAL/100516_LearnLMAN1/Chan10amp-Batch1860_DurLearn


% 14 - /bluejay4/lucas/birds/bk7/NEURAL/080516_Neural_Audio/Chan23amp-Batch1153to1202
% 15 - /bluejay4/lucas/birds/bk7/NEURAL/080516_Neural_Audio/Chan19amp-Batch1153to1202
% 16 - /bluejay4/lucas/birds/bk7/NEURAL/080516_Neural_Audio/Chan14amp-Batch1153to1202

% 17 - /bluejay4/lucas/birds/bk7/NEURAL/080616_Neural_Audio/Chan9amp-Batch1041to1311
% 18 - /bluejay4/lucas/birds/bk7/NEURAL/080616_Neural_Audio/Chan14amp-Batch1041to1311


% 20 - /bluejay4/lucas/birds/bk7/NEURAL/081916_neuralaudio/Chan18amp-Batch1026to1034
% 21 - /bluejay4/lucas/birds/bk7/NEURAL/081916_neuralaudio/Chan18amp-Batch1143to1605
% 26 - /bluejay4/lucas/birds/bk7/NEURAL/081916_neuralaudio/Chan14amp-Batch1026to1044

% 22 - /bluejay4/lucas/birds/bk7/NEURAL/082216_neuralaudio/Chan23amp-Batch1117to1125
% 23 - /bluejay4/lucas/birds/bk7/NEURAL/082216_neuralaudio/Chan23amp-Batch1135to1216
% 24 - /bluejay4/lucas/birds/bk7/NEURAL/082216_neuralaudio/Chan23amp-Batch1247to1316
% 25 - /bluejay4/lucas/birds/bk7/NEURAL/082216_neuralaudio/Chan10amp-Batch1632to1709


%% ======================= TO CHECK ACCURACY - isolates all syls labeled and saves to .wav - open and check by eye.
clear all; close all;

% 1) b, h
syl.targ = 'c';
batch = 'BatchChan14good_v4';


% 2) n --> c
% syl.targ = 'n';

% 3) 

[fnames, sylnum]=lt_jc_chcklbl(batch, syl.targ, 0.025,0.025,'','','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl.targ,'','');

%% ============ 3) Replace hand-checekd mislabeld syls 
lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)

