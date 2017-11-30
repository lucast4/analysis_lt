%% xaa
strtype = 'xaa'; % a is fixed, x variable, across contexts
[CLASSES, prms] = lt_neural_v2_CTXT_Extract(SummaryStruct, strtype);

% &&&&&&&&&&&&& 2) EXTRACT REGEXP STRUCT 
prms.alignWhichSyl = 2; % which syl (in order) to align to
prms.alignOnset = 1; % if 1, then onset, if 0, then offset
prms.motifpredur = 0.15;
prms.motifpostdur = 0.1;
prms.preAndPostDurRelSameTimept = 1; % 1, then pre and post both aligned at same time. if 0, then post is aligned to motif ofset.
CLASSES = lt_neural_v2_CTXT_GetBrnchDat(CLASSES, SummaryStruct, prms);

% &&&&&&&&&&&&&& OPTIONAL - COLLECT POSITIVE CONTROL DATA
CLASSES = lt_neural_v2_CTXT_GetBrnchPosControl(CLASSES, SummaryStruct, prms, strtype);

% &&&&&&&&&&&&&&
TimeWindowDur = 0.025;
TimeWindowSlide = 0.005;
FRbinsize = 0.005;
savenotes = 'pu69wh78RALMAN';

prms.ClassSlide.GetNegControl = 1; % 1 = yes. (i.e. shuffle dat-context link).
prms.ClassSlide.GetPosControl =1;

CVmethod = 'Kfold';
plotstat = 'F1';

saveON =1;
LinTimeWarp = 1;
regionstowarp = [3 4];
ALLBRANCH = lt_neural_v2_CTXT_ClassSliding(CLASSES, SummaryStruct, prms, ...
    TimeWindowDur, TimeWindowSlide, FRbinsize, savenotes, CVmethod, plotstat, ...
    saveON, LinTimeWarp, regionstowarp);


%% xaaa
clear CLASSES

strtype = 'xaaa'; % a is fixed, x variable, across contexts
[CLASSES, prms] = lt_neural_v2_CTXT_Extract(SummaryStruct, strtype);

% &&&&&&&&&&&&& 2) EXTRACT REGEXP STRUCT 
prms.alignWhichSyl = 3; % which syl (in order) to align to
prms.alignOnset = 1; % if 1, then onset, if 0, then offset
prms.motifpredur = 0.25;
prms.motifpostdur = 0.15;
prms.preAndPostDurRelSameTimept = 1; % 1, then pre and post both aligned at same time. if 0, then post is aligned to motif ofset.
CLASSES = lt_neural_v2_CTXT_GetBrnchDat(CLASSES, SummaryStruct, prms);

% &&&&&&&&&&&&&& OPTIONAL - COLLECT POSITIVE CONTROL DATA
CLASSES = lt_neural_v2_CTXT_GetBrnchPosControl(CLASSES, SummaryStruct, prms, strtype);

% &&&&&&&&&&&&&&
TimeWindowDur = 0.025;
TimeWindowSlide = 0.005;
FRbinsize = 0.005;
savenotes = 'pu69wh78RALMAN';

prms.ClassSlide.GetNegControl = 1; % 1 = yes. (i.e. shuffle dat-context link).
prms.ClassSlide.GetPosControl =1;

CVmethod = 'Kfold';
plotstat = 'F1';

saveON =1;
LinTimeWarp = 1;
regionstowarp = [5 6];
ALLBRANCH = lt_neural_v2_CTXT_ClassSliding(CLASSES, SummaryStruct, prms, ...
    TimeWindowDur, TimeWindowSlide, FRbinsize, savenotes, CVmethod, plotstat, ...
    saveON, LinTimeWarp, regionstowarp);
