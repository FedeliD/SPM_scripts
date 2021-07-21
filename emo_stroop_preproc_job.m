%-----------------------------------------------------------------------
% Job saved on 20-Jul-2021 16:28:37 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

%clear all
%spm_jobman('initcfg');
spm('defaults', 'FMRI');
global defaults;

BasePath = ('/media/duzzo/Elements/Emo_Stroop/02_Preprocessing');
% Warn user if there is no such folder.
if ~exist(BasePath, 'dir')
  message = sprintf('This folder does not exist:\n%s', BasePath);
  uiwait(errordlg(message));
  return;
end
% Get a list of all files, including folders.
cd (BasePath)
DirList  = dir(BasePath);
% Extract only the folders, not regular files.
DirList  = DirList([DirList.isdir]);  % Folders only
% Get rid of first two folders: dot and dot dot.
DirList = DirList(3:end);
% Warn user if there are no subfolders.
if isempty(DirList)
  message = sprintf('This folder does not contain any subfolders:\n%s', BasePath);
  uiwait(errordlg(message));
  return;
end
% Count the number of subfolders.
numberOfFolders = numel(DirList);
% Loop over all subfolders, processing each one.

%-------------------------------------------------------------------------------
for k = 1: numberOfFolders
 thisDir = fullfile(BasePath, DirList(k).name);
  subdirname = dir(thisDir);
  subdirname = subdirname(3:end);
  fprintf('Processing folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);
  pathparts = strsplit(thisDir,filesep);
  subname = (pathparts{1,7});
  
  T1 = dir(fullfile(thisDir,'*_3D_T1_0.7_ax_*.nii'));
  nameselect_0 = strcat(T1.name, ',1');
  
  ita_run_1 = dir(fullfile(thisDir, '*Stroop_IT_1*.nii'));
  nameselect_1 = strcat(ita_run_1.name, ',1');
  ita_run_2 = dir(fullfile(thisDir, '*Stroop_IT_2*.nii'));
  nameselect_2 = strcat(ita_run_2.name, ',1');
  
  eng_run_1 = dir(fullfile(thisDir, '*Stroop_UK_1*.nii'));
  nameselect_3 = strcat(eng_run_1.name, ',1');
  eng_run_2 = dir(fullfile(thisDir, '*Stroop_UK_2*.nii'));
  nameselect_4 = strcat(eng_run_2.name, ',1');


matlabbatch{1}.spm.util.exp_frames.files = {(fullfile(thisDir, nameselect_1))};
matlabbatch{1}.spm.util.exp_frames.frames = Inf;
matlabbatch{2}.spm.util.exp_frames.files = {(fullfile(thisDir, nameselect_2))};
matlabbatch{2}.spm.util.exp_frames.frames = Inf;
matlabbatch{3}.spm.util.exp_frames.files = {(fullfile(thisDir, nameselect_3))};
matlabbatch{3}.spm.util.exp_frames.frames = Inf;
matlabbatch{4}.spm.util.exp_frames.files = {(fullfile(thisDir, nameselect_4))};
matlabbatch{4}.spm.util.exp_frames.frames = Inf;
matlabbatch{5}.spm.temporal.st.scans{1}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.temporal.st.scans{2}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.temporal.st.scans{3}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.temporal.st.scans{4}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.temporal.st.nslices = 35;
matlabbatch{5}.spm.temporal.st.tr = 2;
matlabbatch{5}.spm.temporal.st.ta = 1.94285714285714;
matlabbatch{5}.spm.temporal.st.so = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34];
matlabbatch{5}.spm.temporal.st.refslice = 1;
matlabbatch{5}.spm.temporal.st.prefix = 'a';
matlabbatch{6}.spm.spatial.realignunwarp.data(1).scans(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{6}.spm.spatial.realignunwarp.data(1).pmscan = '';
matlabbatch{6}.spm.spatial.realignunwarp.data(2).scans(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 2)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{2}, '.','files'));
matlabbatch{6}.spm.spatial.realignunwarp.data(2).pmscan = '';
matlabbatch{6}.spm.spatial.realignunwarp.data(3).scans(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 3)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{3}, '.','files'));
matlabbatch{6}.spm.spatial.realignunwarp.data(3).pmscan = '';
matlabbatch{6}.spm.spatial.realignunwarp.data(4).scans(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 4)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{4}, '.','files'));
matlabbatch{6}.spm.spatial.realignunwarp.data(4).pmscan = '';
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.quality = 0.9;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.sep = 4;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.fwhm = 5;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.rtm = 0;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.einterp = 2;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.ewrap = [0 0 0];
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.weight = '';
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.basfcn = [12 12];
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.regorder = 1;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.lambda = 100000;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.jm = 0;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.fot = [4 5];
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.sot = [];
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.uwfwhm = 4;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.rem = 1;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.noi = 5;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.rinterp = 4;
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.wrap = [0 0 0];
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.mask = 1;
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.prefix = 'u';
matlabbatch{7}.spm.spatial.preproc.channel.vols = {(fullfile(thisDir, nameselect_0))};
matlabbatch{7}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{7}.spm.spatial.preproc.channel.biasfwhm = 60;
matlabbatch{7}.spm.spatial.preproc.channel.write = [0 1];
matlabbatch{7}.spm.spatial.preproc.tissue(1).tpm = {'/mnt/226AE1226AE0F407/Neurosoftware/spm12/tpm/TPM.nii,1'};
matlabbatch{7}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{7}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{7}.spm.spatial.preproc.tissue(1).warped = [0 0];
matlabbatch{7}.spm.spatial.preproc.tissue(2).tpm = {'/mnt/226AE1226AE0F407/Neurosoftware/spm12/tpm/TPM.nii,2'};
matlabbatch{7}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{7}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{7}.spm.spatial.preproc.tissue(2).warped = [0 0];
matlabbatch{7}.spm.spatial.preproc.tissue(3).tpm = {'/mnt/226AE1226AE0F407/Neurosoftware/spm12/tpm/TPM.nii,3'};
matlabbatch{7}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{7}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{7}.spm.spatial.preproc.tissue(3).warped = [0 0];
matlabbatch{7}.spm.spatial.preproc.tissue(4).tpm = {'/mnt/226AE1226AE0F407/Neurosoftware/spm12/tpm/TPM.nii,4'};
matlabbatch{7}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{7}.spm.spatial.preproc.tissue(4).native = [0 0];
matlabbatch{7}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{7}.spm.spatial.preproc.tissue(5).tpm = {'/mnt/226AE1226AE0F407/Neurosoftware/spm12/tpm/TPM.nii,5'};
matlabbatch{7}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{7}.spm.spatial.preproc.tissue(5).native = [0 0];
matlabbatch{7}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{7}.spm.spatial.preproc.tissue(6).tpm = {'/mnt/226AE1226AE0F407/Neurosoftware/spm12/tpm/TPM.nii,6'};
matlabbatch{7}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{7}.spm.spatial.preproc.tissue(6).native = [0 0];
matlabbatch{7}.spm.spatial.preproc.tissue(6).warped = [0 0];
matlabbatch{7}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{7}.spm.spatial.preproc.warp.cleanup = 1;
matlabbatch{7}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{7}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{7}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{7}.spm.spatial.preproc.warp.samp = 3;
matlabbatch{7}.spm.spatial.preproc.warp.write = [0 1];
matlabbatch{7}.spm.spatial.preproc.warp.vox = NaN;
matlabbatch{7}.spm.spatial.preproc.warp.bb = [NaN NaN NaN
                                              NaN NaN NaN];
matlabbatch{8}.cfg_basicio.file_dir.cfg_fileparts.files(1) = cfg_dep('Segment: Bias Corrected (1)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','channel', '()',{1}, '.','biascorr', '()',{':'}));
matlabbatch{9}.spm.util.imcalc.input(1) = cfg_dep('Segment: Bias Corrected (1)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','channel', '()',{1}, '.','biascorr', '()',{':'}));
matlabbatch{9}.spm.util.imcalc.input(2) = cfg_dep('Segment: c1 Images', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{1}, '.','c', '()',{':'}));
matlabbatch{9}.spm.util.imcalc.input(3) = cfg_dep('Segment: c2 Images', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{2}, '.','c', '()',{':'}));
matlabbatch{9}.spm.util.imcalc.input(4) = cfg_dep('Segment: c3 Images', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{3}, '.','c', '()',{':'}));
matlabbatch{9}.spm.util.imcalc.output = 'Brain';
matlabbatch{9}.spm.util.imcalc.outdir(1) = cfg_dep('Get Pathnames: Directories (unique)', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','up'));
matlabbatch{9}.spm.util.imcalc.expression = '(i2 + i3 + i4) .* i1';
matlabbatch{9}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{9}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{9}.spm.util.imcalc.options.mask = 0;
matlabbatch{9}.spm.util.imcalc.options.interp = 1;
matlabbatch{9}.spm.util.imcalc.options.dtype = 4;
matlabbatch{10}.spm.spatial.coreg.estimate.ref(1) = cfg_dep('Image Calculator: ImCalc Computed Image: Brain', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{10}.spm.spatial.coreg.estimate.source(1) = cfg_dep('Realign & Unwarp: Unwarped Mean Image', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','meanuwr'));
matlabbatch{10}.spm.spatial.coreg.estimate.other(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 1)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','uwrfiles'));
matlabbatch{10}.spm.spatial.coreg.estimate.other(2) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 2)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{2}, '.','uwrfiles'));
matlabbatch{10}.spm.spatial.coreg.estimate.other(3) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 3)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{3}, '.','uwrfiles'));
matlabbatch{10}.spm.spatial.coreg.estimate.other(4) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 4)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{4}, '.','uwrfiles'));
matlabbatch{10}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{10}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{10}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{10}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
matlabbatch{11}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('Segment: Forward Deformations', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','fordef', '()',{':'}));
matlabbatch{11}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 1)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','uwrfiles'));
matlabbatch{11}.spm.spatial.normalise.write.subj.resample(2) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 2)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{2}, '.','uwrfiles'));
matlabbatch{11}.spm.spatial.normalise.write.subj.resample(3) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 3)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{3}, '.','uwrfiles'));
matlabbatch{11}.spm.spatial.normalise.write.subj.resample(4) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 4)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{4}, '.','uwrfiles'));
matlabbatch{11}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                           78 76 85];
matlabbatch{11}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{11}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{11}.spm.spatial.normalise.write.woptions.prefix = 'w';
matlabbatch{12}.spm.spatial.smooth.data(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{11}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{12}.spm.spatial.smooth.fwhm = [8 8 8];
matlabbatch{12}.spm.spatial.smooth.dtype = 0;
matlabbatch{12}.spm.spatial.smooth.im = 0;
matlabbatch{12}.spm.spatial.smooth.prefix = 's';
matlabbatch{13}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('Segment: Forward Deformations', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','fordef', '()',{':'}));
matlabbatch{13}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Image Calculator: ImCalc Computed Image: Brain', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{13}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                           78 76 85];
matlabbatch{13}.spm.spatial.normalise.write.woptions.vox = [1 1 1];
matlabbatch{13}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{13}.spm.spatial.normalise.write.woptions.prefix = 'w';

save (['matlabbatch' subname '.mat'], 'matlabbatch');
    
%%%it's time to do it!
spm_jobman('run',matlabbatch);

fprintf('Finished folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);
end
