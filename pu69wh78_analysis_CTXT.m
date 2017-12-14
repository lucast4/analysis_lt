%% xaa
%% EXTRACT 
clear all; close all;
BirdsToKeep = {'pu69wh78'}; % {birdname , neuronstokeep} if neuronstokeep = [], then gets all;
BrainArea = {};
% ExptToKeep = {'RAlearn1', 'RALMANlearn1', 'LMANsearch'};
ExptToKeep = {};
RecordingDepth = [];
LearningOnly = 0;
BatchesDesired = {};
ChannelsDesired = [];
% BirdsToKeep = {}; % {birdname , neuronstokeep} if neuronstokeep = [], then gets all;
% BrainArea = {'X'};
% ExptToKeep = {};
% RecordingDepth = [];
% LearningOnly = 1;
% BatchesDesired = {};
% ChannelsDesired = [];
[NeuronDatabase, SummaryStruct] = lt_neural_v2_ConvertSummary2Database(BirdsToKeep, ...
    BrainArea, ExptToKeep, RecordingDepth, LearningOnly, BatchesDesired, ChannelsDesired);

% ==============
strtype = 'aax'; % a is fixed, x variable, across contexts
[CLASSES, prms] = lt_neural_v2_CTXT_Extract(SummaryStruct, strtype);

% &&&&&&&&&&&&& 2) EXTRACT REGEXP STRUCT 
prms.alignWhichSyl = 2; % which syl (in order) to align to
prms.alignOnset = 1; % if 1, then onset, if 0, then offset
prms.motifpredur = 0.15;
prms.motifpostdur = 0.2;
prms.preAndPostDurRelSameTimept = 1; % 1, then pre and post both aligned at same time. if 0, then post is aligned to motif ofset.
CLASSES = lt_neural_v2_CTXT_GetBrnchDat(CLASSES, SummaryStruct, prms);

% &&&&&&&&&&&&&& OPTIONAL - COLLECT POSITIVE CONTROL DATA
CLASSES = lt_neural_v2_CTXT_GetBrnchPosControl(CLASSES, SummaryStruct, prms, strtype);

% &&&&&&&&&&&&&&
TimeWindowDur = 0.025;
TimeWindowSlide = 0.005;
FRbinsize = 0.005;
savenotes = 'pu69wh78RALMANLTW';

prms.ClassSlide.GetNegControl = 1; % 1 = yes. (i.e. shuffle dat-context link).
prms.ClassSlide.GetPosControl =1;

CVmethod = 'Kfold';
plotstat = 'F1';

saveON =1;
LinTimeWarp = 1;
regionstowarp = [1 2 3];
ALLBRANCH = lt_neural_v2_CTXT_ClassSliding(CLASSES, SummaryStruct, prms, ...
    TimeWindowDur, TimeWindowSlide, FRbinsize, savenotes, CVmethod, plotstat, ...
    saveON, LinTimeWarp, regionstowarp);


%% xaaa
%% EXTRACT 
clear all; close all;
BirdsToKeep = {'pu69wh78'}; % {birdname , neuronstokeep} if neuronstokeep = [], then gets all;
BrainArea = {};
% ExptToKeep = {'RAlearn1', 'RALMANlearn1', 'LMANsearch'};
ExptToKeep = {};
RecordingDepth = [];
LearningOnly = 0;
BatchesDesired = {};
ChannelsDesired = [];
% BirdsToKeep = {}; % {birdname , neuronstokeep} if neuronstokeep = [], then gets all;
% BrainArea = {'X'};
% ExptToKeep = {};
% RecordingDepth = [];
% LearningOnly = 1;
% BatchesDesired = {};
% ChannelsDesired = [];
[NeuronDatabase, SummaryStruct] = lt_neural_v2_ConvertSummary2Database(BirdsToKeep, ...
    BrainArea, ExptToKeep, RecordingDepth, LearningOnly, BatchesDesired, ChannelsDesired);

% ==============
strtype = 'xaaa'; % a is fixed, x variable, across contexts
[CLASSES, prms] = lt_neural_v2_CTXT_Extract(SummaryStruct, strtype);

% &&&&&&&&&&&&& 2) EXTRACT REGEXP STRUCT 
prms.alignWhichSyl = 3; % which syl (in order) to align to
prms.alignOnset = 1; % if 1, then onset, if 0, then offset
prms.motifpredur = 0.3;
prms.motifpostdur = 0.15;
prms.preAndPostDurRelSameTimept = 1; % 1, then pre and post both aligned at same time. if 0, then post is aligned to motif ofset.
CLASSES = lt_neural_v2_CTXT_GetBrnchDat(CLASSES, SummaryStruct, prms);

% &&&&&&&&&&&&&& OPTIONAL - COLLECT POSITIVE CONTROL DATA
CLASSES = lt_neural_v2_CTXT_GetBrnchPosControl(CLASSES, SummaryStruct, prms, strtype);

% &&&&&&&&&&&&&&
TimeWindowDur = 0.025;
TimeWindowSlide = 0.005;
FRbinsize = 0.005;
savenotes = 'pu69wh78RALMANLTW';

prms.ClassSlide.GetNegControl = 1; % 1 = yes. (i.e. shuffle dat-context link).
prms.ClassSlide.GetPosControl =1;

CVmethod = 'Kfold';
plotstat = 'F1';

saveON =1;
LinTimeWarp = 1;
regionstowarp = [3 4 5 6];
ALLBRANCH = lt_neural_v2_CTXT_ClassSliding(CLASSES, SummaryStruct, prms, ...
    TimeWindowDur, TimeWindowSlide, FRbinsize, savenotes, CVmethod, plotstat, ...
    saveON, LinTimeWarp, regionstowarp);
