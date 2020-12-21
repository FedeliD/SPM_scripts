%-----------------------------------------------------------------------
% Job created by Gianpaolo & Davide
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
% 22/09/2020
%-----------------------------------------------------------------------
%%

%clear all
%spm_jobman('initcfg');
spm('defaults', 'FMRI');
global defaults;

BasePath = ('S:\christmas_analyses\pipeline_executive');
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
  flanker_fold = fullfile(BasePath, DirList(k).name, subdirname(1).name);
  stroop_fold = fullfile(BasePath, DirList(k).name, subdirname(2).name);
  T1w_fold = fullfile(BasePath, DirList(k).name, subdirname(3).name);
  fprintf('Processing folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);
  pathparts = strsplit(thisDir,filesep);
  subname = (pathparts{1,4});
  
  T1 = dir(fullfile(T1w_fold, '*_3D_T1_0.7_ax_*.nii'));
  nameselect_0 = strcat(T1.name, ',1');
  flanker_run_1 = dir(fullfile(flanker_fold, '*_fMRI_ANT_1_*.nii'));
  nameselect_1 = strcat(flanker_run_1.name, ',1');
  matlabbatch{1}.spm.util.exp_frames.files = {(fullfile(flanker_fold, nameselect_1))};
  matlabbatch{1}.spm.util.exp_frames.frames = Inf;
  flanker_run_2 = dir(fullfile(flanker_fold, '*_fMRI_ANT_2_*.nii'));
  nameselect_2 = strcat(flanker_run_2.name, ',1');
  matlabbatch{2}.spm.util.exp_frames.files = {(fullfile(flanker_fold, nameselect_2))};
  matlabbatch{2}.spm.util.exp_frames.frames = Inf;

%%
matlabbatch{3}.spm.temporal.st.scans{1}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.temporal.st.scans{2}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.temporal.st.nslices = 35;
matlabbatch{3}.spm.temporal.st.tr = 2;
matlabbatch{3}.spm.temporal.st.ta = 1.94285714285714;
matlabbatch{3}.spm.temporal.st.so = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34];
matlabbatch{3}.spm.temporal.st.refslice = 1;
matlabbatch{3}.spm.temporal.st.prefix = 'a';
matlabbatch{4}.spm.spatial.realignunwarp.data(1).scans(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{4}.spm.spatial.realignunwarp.data(1).pmscan = '';
matlabbatch{4}.spm.spatial.realignunwarp.data(2).scans(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 2)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{2}, '.','files'));
matlabbatch{4}.spm.spatial.realignunwarp.data(2).pmscan = '';
matlabbatch{4}.spm.spatial.realignunwarp.eoptions.quality = 0.9;
matlabbatch{4}.spm.spatial.realignunwarp.eoptions.sep = 4;
matlabbatch{4}.spm.spatial.realignunwarp.eoptions.fwhm = 5;
matlabbatch{4}.spm.spatial.realignunwarp.eoptions.rtm = 0;
matlabbatch{4}.spm.spatial.realignunwarp.eoptions.einterp = 2;
matlabbatch{4}.spm.spatial.realignunwarp.eoptions.ewrap = [0 0 0];
matlabbatch{4}.spm.spatial.realignunwarp.eoptions.weight = '';
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.basfcn = [12 12];
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.regorder = 1;
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.lambda = 100000;
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.jm = 0;
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.fot = [4 5];
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.sot = [];
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.uwfwhm = 4;
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.rem = 1;
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.noi = 5;
matlabbatch{4}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';
matlabbatch{4}.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];
matlabbatch{4}.spm.spatial.realignunwarp.uwroptions.rinterp = 4;
matlabbatch{4}.spm.spatial.realignunwarp.uwroptions.wrap = [0 0 0];
matlabbatch{4}.spm.spatial.realignunwarp.uwroptions.mask = 1;
matlabbatch{4}.spm.spatial.realignunwarp.uwroptions.prefix = 'u';
matlabbatch{5}.spm.tools.cat.estwrite.data = {(fullfile(T1w_fold, nameselect_0))};
matlabbatch{5}.spm.tools.cat.estwrite.data_wmh = {''};
matlabbatch{5}.spm.tools.cat.estwrite.nproc = 2;
matlabbatch{5}.spm.tools.cat.estwrite.useprior = '';
matlabbatch{5}.spm.tools.cat.estwrite.opts.tpm = {'P:\SPM12\tpm\TPM.nii'};
matlabbatch{5}.spm.tools.cat.estwrite.opts.affreg = 'mni';
matlabbatch{5}.spm.tools.cat.estwrite.opts.biasstr = 0.5;
matlabbatch{5}.spm.tools.cat.estwrite.opts.accstr = 0.5;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.APP = 1070;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.NCstr = -Inf;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.spm_kamap = 0;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.LASstr = 0.5;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.gcutstr = 2;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.cleanupstr = 0.5;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.BVCstr = 0.5;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.WMHC = 1;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.SLC = 0;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.mrf = 1;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.segmentation.restypes.optimal = [1 0.1];
matlabbatch{5}.spm.tools.cat.estwrite.extopts.registration.shooting.shootingtpm = {'P:\SPM12\toolbox\cat12\templates_volumes\Template_0_IXI555_MNI152_GS.nii'};
matlabbatch{5}.spm.tools.cat.estwrite.extopts.registration.shooting.regstr = 0.5;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.vox = 1.5;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.pbtres = 0.5;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.pbtmethod = 'pbt2x';
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.pbtlas = 0;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.collcorr = 0;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.reduce_mesh = 1;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.vdist = 1.33333333333333;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.scale_cortex = 0.7;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.add_parahipp = 0.1;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.surface.close_parahipp = 0;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.admin.experimental = 0;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.admin.new_release = 0;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.admin.lazy = 0;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.admin.ignoreErrors = 1;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.admin.verb = 2;
matlabbatch{5}.spm.tools.cat.estwrite.extopts.admin.print = 2;
matlabbatch{5}.spm.tools.cat.estwrite.output.surface = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.surf_measures = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.neuromorphometrics = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.lpba40 = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.cobra = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.hammers = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.ibsr = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.aal3 = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.mori = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.anatomy = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.julichbrain = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.Schaefer2018_100Parcels_17Networks_order = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.Schaefer2018_200Parcels_17Networks_order = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.Schaefer2018_400Parcels_17Networks_order = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.Schaefer2018_600Parcels_17Networks_order = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ROImenu.atlases.ownatlas = {''};
matlabbatch{5}.spm.tools.cat.estwrite.output.GM.native = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.GM.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.GM.mod = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.GM.dartel = 2;
matlabbatch{5}.spm.tools.cat.estwrite.output.WM.native = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.WM.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.WM.mod = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.WM.dartel = 2;
matlabbatch{5}.spm.tools.cat.estwrite.output.CSF.native = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.CSF.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.CSF.mod = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.CSF.dartel = 2;
matlabbatch{5}.spm.tools.cat.estwrite.output.ct.native = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ct.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.ct.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.pp.native = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.pp.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.pp.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.WMH.native = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.WMH.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.WMH.mod = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.WMH.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.SL.native = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.SL.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.SL.mod = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.SL.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.TPMC.native = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.TPMC.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.TPMC.mod = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.TPMC.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.atlas.native = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.atlas.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.atlas.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.label.native = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.label.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.label.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.labelnative = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.bias.native = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.bias.warped = 1;
matlabbatch{5}.spm.tools.cat.estwrite.output.bias.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.las.native = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.las.warped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.las.dartel = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.jacobianwarped = 0;
matlabbatch{5}.spm.tools.cat.estwrite.output.warps = [1 1];
matlabbatch{5}.spm.tools.cat.estwrite.output.rmat = 0;
matlabbatch{6}.spm.util.imcalc.input(1) = cfg_dep('CAT12: Segmentation (current release): Native Bias Corr. Image', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','biascorr', '()',{':'}));
matlabbatch{6}.spm.util.imcalc.input(2) = cfg_dep('CAT12: Segmentation (current release): p1 Image', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{1}, '.','p', '()',{':'}));
matlabbatch{6}.spm.util.imcalc.input(3) = cfg_dep('CAT12: Segmentation (current release): p2 Image', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{2}, '.','p', '()',{':'}));
matlabbatch{6}.spm.util.imcalc.input(4) = cfg_dep('CAT12: Segmentation (current release): p3 Image', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{3}, '.','p', '()',{':'}));
matlabbatch{6}.spm.util.imcalc.output = 'Brain';
matlabbatch{6}.spm.util.imcalc.outdir = {T1w_fold};
matlabbatch{6}.spm.util.imcalc.expression = '(i2 + i3 + i4) .* i1';
matlabbatch{6}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{6}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{6}.spm.util.imcalc.options.mask = 0;
matlabbatch{6}.spm.util.imcalc.options.interp = 1;
matlabbatch{6}.spm.util.imcalc.options.dtype = 4;
matlabbatch{7}.spm.spatial.coreg.estimate.ref(1) = cfg_dep('Image Calculator: ImCalc Computed Image: Brain', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{7}.spm.spatial.coreg.estimate.source(1) = cfg_dep('Realign & Unwarp: Unwarped Mean Image', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','meanuwr'));
matlabbatch{7}.spm.spatial.coreg.estimate.other(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 1)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','uwrfiles'));
matlabbatch{7}.spm.spatial.coreg.estimate.other(2) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 2)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{2}, '.','uwrfiles'));
matlabbatch{7}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{7}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{7}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{7}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
matlabbatch{8}.spm.stats.fmri_spec.dir = {flanker_fold};
matlabbatch{8}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{8}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{8}.spm.stats.fmri_spec.timing.fmri_t = 35;
matlabbatch{8}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 1)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','uwrfiles'));
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).name = 'congruent';
%%

flanker_A_cong = dir(fullfile(flanker_fold, '0*flanker_A_cong.txt'));
flanker_A_cong = load(fullfile(flanker_fold,flanker_A_cong.name));
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).onset = flanker_A_cong;

%%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).name = 'incongruent';
%%

flanker_A_incong = dir(fullfile(flanker_fold, '0*flanker_A_incong.txt'));
flanker_A_incong = load(fullfile(flanker_fold,flanker_A_incong.name));
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).onset = flanker_A_incong;

%%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).name = 'neutral';
%%

flanker_A_neutral = dir(fullfile(flanker_fold, '0*flanker_A_neutral.txt'));
flanker_A_neutral = load(fullfile(flanker_fold,flanker_A_neutral.name));
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).onset = flanker_A_neutral;

%%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{8}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(1).multi_reg = {''};
matlabbatch{8}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 2)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{2}, '.','uwrfiles'));
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).name = 'congruent';
%%


flanker_B_cong = dir(fullfile(flanker_fold, '0*flanker_B_cong.txt'));
flanker_B_cong = load(fullfile(flanker_fold,flanker_B_cong.name));
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).onset = flanker_B_cong;

%%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).name = 'incongruent';
%%
flanker_B_incong = dir(fullfile(flanker_fold, '0*flanker_B_incong.txt'));
flanker_B_incong = load(fullfile(flanker_fold,flanker_B_incong.name));
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).onset = flanker_B_incong;

%%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).name = 'neutral';
%%
flanker_B_neutral = dir(fullfile(flanker_fold, '0*flanker_B_neutral.txt'));
flanker_B_neutral  = load(fullfile(flanker_fold,flanker_B_neutral.name));
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).onset = flanker_B_neutral ;

%%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{8}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(2).multi_reg = {''};
matlabbatch{8}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{8}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{8}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{8}.spm.stats.fmri_spec.volt = 1;
matlabbatch{8}.spm.stats.fmri_spec.global = 'None';
matlabbatch{8}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{8}.spm.stats.fmri_spec.mask = {''};
matlabbatch{8}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{9}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{9}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{9}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{10}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{10}.spm.stats.con.consess{1}.tcon.name = 'main_eff_congruent';
matlabbatch{10}.spm.stats.con.consess{1}.tcon.weights = [1 0 0];
matlabbatch{10}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{10}.spm.stats.con.consess{2}.tcon.name = 'main_eff_incongruent';
matlabbatch{10}.spm.stats.con.consess{2}.tcon.weights = [0 1 0];
matlabbatch{10}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{10}.spm.stats.con.consess{3}.tcon.name = 'main_eff_neutral';
matlabbatch{10}.spm.stats.con.consess{3}.tcon.weights = [0 0 1];
matlabbatch{10}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
matlabbatch{10}.spm.stats.con.consess{4}.tcon.name = 'coungruent_gt_neutral';
matlabbatch{10}.spm.stats.con.consess{4}.tcon.weights = [1 0 -1];
matlabbatch{10}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{10}.spm.stats.con.consess{5}.tcon.name = 'congruent_gt_incongruent';
matlabbatch{10}.spm.stats.con.consess{5}.tcon.weights = [1 -1 0];
matlabbatch{10}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
matlabbatch{10}.spm.stats.con.consess{6}.tcon.name = 'incongruent_gt_neutral';
matlabbatch{10}.spm.stats.con.consess{6}.tcon.weights = [0 1 -1];
matlabbatch{10}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
matlabbatch{10}.spm.stats.con.consess{7}.tcon.name = 'incongruent_gt_congruent';
matlabbatch{10}.spm.stats.con.consess{7}.tcon.weights = [-1 1 0];
matlabbatch{10}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
matlabbatch{10}.spm.stats.con.consess{8}.tcon.name = 'cond_gt_baseline';
matlabbatch{10}.spm.stats.con.consess{8}.tcon.weights = [0.5 0.5 -1];
matlabbatch{10}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
matlabbatch{10}.spm.stats.con.delete = 0;
matlabbatch{11}.spm.tools.cat.stools.vol2surf.data_vol(1) = cfg_dep('Contrast Manager: All Con Images', substruct('.','val', '{}',{10}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','con'));
matlabbatch{11}.spm.tools.cat.stools.vol2surf.data_mesh_lh(1) = cfg_dep('CAT12: Segmentation: Left Central Surface', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','lhcentral', '()',{':'}));
matlabbatch{11}.spm.tools.cat.stools.vol2surf.sample = {'maxabs'};
matlabbatch{11}.spm.tools.cat.stools.vol2surf.interp = {'linear'};
matlabbatch{11}.spm.tools.cat.stools.vol2surf.datafieldname = 'Flanker';
matlabbatch{11}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.class = 'GM';
matlabbatch{11}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.startpoint = -0.5;
matlabbatch{11}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.steps = 7;
matlabbatch{11}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.endpoint = 0.5;
matlabbatch{12}.spm.tools.cat.stools.surfresamp.sample{1}.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{11}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{12}.spm.tools.cat.stools.surfresamp.merge_hemi = 1;
matlabbatch{12}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{12}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{12}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{12}.spm.tools.cat.stools.surfresamp.nproc = 4;
matlabbatch{13}.spm.tools.cat.stools.surfresamp.sample{1}.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{11}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{13}.spm.tools.cat.stools.surfresamp.merge_hemi = 0;
matlabbatch{13}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{13}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{13}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{13}.spm.tools.cat.stools.surfresamp.nproc = 4;
%%

stroop_run_1 = dir(fullfile(stroop_fold, '*_fMRI_Stroop_1_*.nii'));
  nameselect_3 = strcat(stroop_run_1.name, ',1');
  matlabbatch{14}.spm.util.exp_frames.files = {(fullfile(stroop_fold, nameselect_3))};
  matlabbatch{14}.spm.util.exp_frames.frames = Inf;
  stroop_run_2 = dir(fullfile(stroop_fold, '*_fMRI_Stroop_2_*.nii'));
  nameselect_4 = strcat(stroop_run_2.name, ',1');
  matlabbatch{15}.spm.util.exp_frames.files = {(fullfile(stroop_fold, nameselect_4))};
  matlabbatch{15}.spm.util.exp_frames.frames = Inf;

matlabbatch{16}.spm.temporal.st.scans{1}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{14}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{16}.spm.temporal.st.scans{2}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{15}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));

%%
matlabbatch{16}.spm.temporal.st.nslices = 35;
matlabbatch{16}.spm.temporal.st.tr = 2;
matlabbatch{16}.spm.temporal.st.ta = 1.94285714285714;
matlabbatch{16}.spm.temporal.st.so = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34];
matlabbatch{16}.spm.temporal.st.refslice = 1;
matlabbatch{16}.spm.temporal.st.prefix = 'a';
matlabbatch{17}.spm.spatial.realignunwarp.data(1).scans(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{16}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{17}.spm.spatial.realignunwarp.data(1).pmscan = '';
matlabbatch{17}.spm.spatial.realignunwarp.data(2).scans(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 2)', substruct('.','val', '{}',{16}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{2}, '.','files'));
matlabbatch{17}.spm.spatial.realignunwarp.data(2).pmscan = '';
matlabbatch{17}.spm.spatial.realignunwarp.eoptions.quality = 0.9;
matlabbatch{17}.spm.spatial.realignunwarp.eoptions.sep = 4;
matlabbatch{17}.spm.spatial.realignunwarp.eoptions.fwhm = 5;
matlabbatch{17}.spm.spatial.realignunwarp.eoptions.rtm = 0;
matlabbatch{17}.spm.spatial.realignunwarp.eoptions.einterp = 2;
matlabbatch{17}.spm.spatial.realignunwarp.eoptions.ewrap = [0 0 0];
matlabbatch{17}.spm.spatial.realignunwarp.eoptions.weight = '';
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.basfcn = [12 12];
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.regorder = 1;
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.lambda = 100000;
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.jm = 0;
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.fot = [4 5];
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.sot = [];
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.uwfwhm = 4;
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.rem = 1;
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.noi = 5;
matlabbatch{17}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';
matlabbatch{17}.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];
matlabbatch{17}.spm.spatial.realignunwarp.uwroptions.rinterp = 4;
matlabbatch{17}.spm.spatial.realignunwarp.uwroptions.wrap = [0 0 0];
matlabbatch{17}.spm.spatial.realignunwarp.uwroptions.mask = 1;
matlabbatch{17}.spm.spatial.realignunwarp.uwroptions.prefix = 'u';
matlabbatch{18}.spm.spatial.coreg.estimate.ref(1) = cfg_dep('Image Calculator: ImCalc Computed Image: Brain', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{18}.spm.spatial.coreg.estimate.source(1) = cfg_dep('Realign & Unwarp: Unwarped Mean Image', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','meanuwr'));
matlabbatch{18}.spm.spatial.coreg.estimate.other(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 1)', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','uwrfiles'));
matlabbatch{18}.spm.spatial.coreg.estimate.other(2) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 2)', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{2}, '.','uwrfiles'));
matlabbatch{18}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{18}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{18}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{18}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
matlabbatch{19}.spm.stats.fmri_spec.dir = {stroop_fold};
matlabbatch{19}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{19}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{19}.spm.stats.fmri_spec.timing.fmri_t = 35;
matlabbatch{19}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 1)', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','uwrfiles'));
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(1).name = 'congruent';
%%
stroop_A_cong = dir(fullfile(stroop_fold, '0*stroop_A_cong.txt'));
stroop_A_cong = load(fullfile(stroop_fold,stroop_A_cong.name));
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(1).onset = stroop_A_cong;


%%
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(2).name = 'incongruent';
%%
stroop_A_incong = dir(fullfile(stroop_fold, '0*stroop_A_incong.txt'));
stroop_A_incong = load(fullfile(stroop_fold,stroop_A_incong.name));
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(2).onset = stroop_A_incong;


%%
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(3).name = 'neutral';
%%
stroop_A_neutral = dir(fullfile(stroop_fold, '0*stroop_A_neutral.txt'));
stroop_A_neutral = load(fullfile(stroop_fold,stroop_A_neutral.name));
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(3).onset = stroop_A_neutral;

%%
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
matlabbatch{19}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{19}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(1).multi_reg = {''};
matlabbatch{19}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 2)', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{2}, '.','uwrfiles'));
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(1).name = 'congruent';
%%
stroop_B_cong = dir(fullfile(stroop_fold, '0*stroop_B_cong.txt'));
stroop_B_cong = load(fullfile(stroop_fold,stroop_B_cong.name));
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(1).onset = stroop_B_cong;

%%
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(2).name = 'incongruent';
%%
stroop_B_incong = dir(fullfile(stroop_fold, '0*stroop_B_incong.txt'));
stroop_B_incong = load(fullfile(stroop_fold,stroop_B_incong.name));
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(2).onset = stroop_B_incong;

%%
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(3).name = 'neutral';
%%
stroop_B_neutral = dir(fullfile(stroop_fold, '0*stroop_B_neutral.txt'));
stroop_B_neutral = load(fullfile(stroop_fold,stroop_B_neutral.name));
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(3).onset = stroop_B_neutral;

%%
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;
matlabbatch{19}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{19}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(2).multi_reg = {''};
matlabbatch{19}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{19}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{19}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{19}.spm.stats.fmri_spec.volt = 1;
matlabbatch{19}.spm.stats.fmri_spec.global = 'None';
matlabbatch{19}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{19}.spm.stats.fmri_spec.mask = {''};
matlabbatch{19}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{20}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{19}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{20}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{20}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{21}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{20}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{21}.spm.stats.con.consess{1}.tcon.name = 'main_eff_congruent';
matlabbatch{21}.spm.stats.con.consess{1}.tcon.weights = [1 0 0];
matlabbatch{21}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{21}.spm.stats.con.consess{2}.tcon.name = 'main_eff_incongruent';
matlabbatch{21}.spm.stats.con.consess{2}.tcon.weights = [0 1 0];
matlabbatch{21}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{21}.spm.stats.con.consess{3}.tcon.name = 'main_eff_neutral';
matlabbatch{21}.spm.stats.con.consess{3}.tcon.weights = [0 0 1];
matlabbatch{21}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
matlabbatch{21}.spm.stats.con.consess{4}.tcon.name = 'coungruent_gt_neutral';
matlabbatch{21}.spm.stats.con.consess{4}.tcon.weights = [1 0 -1];
matlabbatch{21}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{21}.spm.stats.con.consess{5}.tcon.name = 'congruent_gt_incongruent';
matlabbatch{21}.spm.stats.con.consess{5}.tcon.weights = [1 -1 0];
matlabbatch{21}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
matlabbatch{21}.spm.stats.con.consess{6}.tcon.name = 'incongruent_gt_neutral';
matlabbatch{21}.spm.stats.con.consess{6}.tcon.weights = [0 1 -1];
matlabbatch{21}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
matlabbatch{21}.spm.stats.con.consess{7}.tcon.name = 'incongruent_gt_congruent';
matlabbatch{21}.spm.stats.con.consess{7}.tcon.weights = [-1 1 0];
matlabbatch{21}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
matlabbatch{21}.spm.stats.con.consess{8}.tcon.name = 'cond_gt_baseline';
matlabbatch{21}.spm.stats.con.consess{8}.tcon.weights = [0.5 0.5 -1];
matlabbatch{21}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
matlabbatch{21}.spm.stats.con.delete = 0;
matlabbatch{22}.spm.tools.cat.stools.vol2surf.data_vol(1) = cfg_dep('Contrast Manager: All Con Images', substruct('.','val', '{}',{21}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','con'));
matlabbatch{22}.spm.tools.cat.stools.vol2surf.data_mesh_lh(1) = cfg_dep('CAT12: Segmentation (current release): Left Central Surface', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','lhcentral', '()',{':'}));
matlabbatch{22}.spm.tools.cat.stools.vol2surf.sample = {'maxabs'};
matlabbatch{22}.spm.tools.cat.stools.vol2surf.interp = {'linear'};
matlabbatch{22}.spm.tools.cat.stools.vol2surf.datafieldname = 'Stroop';
matlabbatch{22}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.class = 'GM';
matlabbatch{22}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.startpoint = -0.5;
matlabbatch{22}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.steps = 7;
matlabbatch{22}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.endpoint = 0.5;
matlabbatch{23}.spm.tools.cat.stools.surfresamp.sample{1}.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{22}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{23}.spm.tools.cat.stools.surfresamp.merge_hemi = 1;
matlabbatch{23}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{23}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{23}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{23}.spm.tools.cat.stools.surfresamp.nproc = 4;
matlabbatch{24}.spm.tools.cat.stools.surfresamp.sample{1}.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{22}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{24}.spm.tools.cat.stools.surfresamp.merge_hemi = 0;
matlabbatch{24}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{24}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{24}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{24}.spm.tools.cat.stools.surfresamp.nproc = 4;

save (['matlabbatch' subname '.mat'], 'matlabbatch');
    
%%%it's time to do it!
spm_jobman('run',matlabbatch);

fprintf('Finished folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);
end
