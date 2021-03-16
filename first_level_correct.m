%-----------------------------------------------------------------------
% Job saved on 23-Feb-2021 14:39:59 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

%clear all
%spm_jobman('initcfg');
spm('defaults', 'FMRI');
global defaults;

%BasePath = ('J:/Task_esecutivi/pipeline_executive');
BasePath = ('F:/Task_esecutivi/tem');
%ImagePath = ('F:/Task_esecutivi/conn_proc/conn_project01/data/BIDS');
VolumePath = ('F:/Task_esecutivi/Volume');
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
  flanker_volume = fullfile(VolumePath, DirList(k).name, 'Flanker');
  stroop_fold = fullfile(BasePath, DirList(k).name, subdirname(2).name);
  stroop_volume = fullfile(VolumePath, DirList(k).name, 'Stroop');
  T1w_fold = fullfile(BasePath, DirList(k).name, subdirname(3).name);
  fprintf('Processing folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);
  pathparts = strsplit(thisDir,filesep);
  subname = (pathparts{1,4});
   
  flanker_run_1 = dir(fullfile(flanker_fold, 's8wuaexe*_fMRI_ANT_1_*.nii'));
  smoothselect_1 = strcat(flanker_run_1.name, ',1');
  flanker_run_2 = dir(fullfile(flanker_fold, 's8wuaexe*_fMRI_ANT_2_*.nii'));
  smoothselect_2 = strcat(flanker_run_2.name, ',1');
  flanker_rp_run1 = dir(fullfile(flanker_fold, 'rp*ANT_1_*.txt'));
  flanker_rp_run1_select = strcat(flanker_fold, '\',  flanker_rp_run1.name);
  flanker_rp_run2 = dir(fullfile(flanker_fold, 'rp*ANT_2_*.txt'));
  flanker_rp_run2_select = strcat(flanker_fold, '\',  flanker_rp_run2.name);
  
  
  stroop_run_1 = dir(fullfile(stroop_fold, 's8wuaexe*_fMRI_Stroop_1_*.nii'));
  smoothselect_3 = strcat(stroop_run_1.name, ',1');
  stroop_run_2 = dir(fullfile(stroop_fold, 's8wuaexe*_fMRI_Stroop_2_*.nii'));
  smoothselect_4 = strcat(stroop_run_2.name, ',1');
  stroop_rp_run1 = dir(fullfile(stroop_fold, 'rp*Stroop_1_*.txt'));
  stroop_rp_run1_select = strcat(stroop_fold, '\',  stroop_rp_run1.name);
  stroop_rp_run2 = dir(fullfile(stroop_fold, 'rp*Stroop_2_*.txt'));
  stroop_rp_run2_select = strcat(stroop_fold, '\',  stroop_rp_run2.name);

  matlabbatch{1}.spm.util.exp_frames.files = {(fullfile(flanker_fold, smoothselect_1))};
  matlabbatch{1}.spm.util.exp_frames.frames = Inf;
  matlabbatch{2}.spm.util.exp_frames.files = {(fullfile(flanker_fold, smoothselect_2))};
  matlabbatch{2}.spm.util.exp_frames.frames = Inf;
  matlabbatch{3}.spm.util.exp_frames.files = {(fullfile(stroop_fold, smoothselect_3))};
  matlabbatch{3}.spm.util.exp_frames.frames = Inf;
  matlabbatch{4}.spm.util.exp_frames.files = {(fullfile(stroop_fold, smoothselect_4))};
  matlabbatch{4}.spm.util.exp_frames.frames = Inf;
  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %ANT first level

matlabbatch{5}.spm.stats.fmri_spec.dir = {flanker_volume};
matlabbatch{5}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{5}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{5}.spm.stats.fmri_spec.timing.fmri_t = 35;
matlabbatch{5}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));


%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).name = 'congruent';
flanker_A_cong = dir(fullfile(flanker_fold, '0*Flanker_A_cong.txt'));
flanker_A_cong = load(fullfile(flanker_fold,flanker_A_cong.name));
%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).onset = flanker_A_cong;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).name = 'incongruent';
flanker_A_incong = dir(fullfile(flanker_fold, '0*Flanker_A_incong.txt'));
flanker_A_incong = load(fullfile(flanker_fold,flanker_A_incong.name));
%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).onset = flanker_A_incong;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(3).name = 'neutral';
flanker_A_neutral = dir(fullfile(flanker_fold, '0*Flanker_A_neutral.txt'));
flanker_A_neutral = load(fullfile(flanker_fold,flanker_A_neutral.name));
%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(3).onset = flanker_A_neutral;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{5}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(1).multi_reg = {''};
matlabbatch{5}.spm.stats.fmri_spec.sess(1).multi_reg = {flanker_rp_run1_select};
matlabbatch{5}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));

%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).name = 'congruent';
flanker_B_cong = dir(fullfile(flanker_fold, '0*Flanker_B_cong.txt'));
flanker_B_cong = load(fullfile(flanker_fold,flanker_B_cong.name));
%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).onset = flanker_B_cong;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).name = 'incongruent';
flanker_B_incong = dir(fullfile(flanker_fold, '0*Flanker_B_incong.txt'));
flanker_B_incong = load(fullfile(flanker_fold,flanker_B_incong.name));

matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).onset = flanker_B_incong;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(3).name = 'neutral';
flanker_B_neutral = dir(fullfile(flanker_fold, '0*Flanker_B_neutral.txt'));
flanker_B_neutral  = load(fullfile(flanker_fold,flanker_B_neutral.name));
%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(3).onset = flanker_B_neutral ;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{5}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(2).multi_reg = {''};
matlabbatch{5}.spm.stats.fmri_spec.sess(2).multi_reg = {flanker_rp_run2_select};
matlabbatch{5}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{5}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{5}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{5}.spm.stats.fmri_spec.volt = 1;
matlabbatch{5}.spm.stats.fmri_spec.global = 'None';
matlabbatch{5}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{5}.spm.stats.fmri_spec.mask = {''};
matlabbatch{5}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{6}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{6}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{6}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{7}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{7}.spm.stats.con.consess{1}.tcon.name = 'main_eff_congruent';
matlabbatch{7}.spm.stats.con.consess{1}.tcon.weights = [1 0 0];
matlabbatch{7}.spm.stats.con.consess{1}.tcon.sessrep = 'both';
matlabbatch{7}.spm.stats.con.consess{2}.tcon.name = 'main_eff_incongruent';
matlabbatch{7}.spm.stats.con.consess{2}.tcon.weights = [0 1 0];
matlabbatch{7}.spm.stats.con.consess{2}.tcon.sessrep = 'both';
matlabbatch{7}.spm.stats.con.consess{3}.tcon.name = 'main_eff_neutral';
matlabbatch{7}.spm.stats.con.consess{3}.tcon.weights = [0 0 1];
matlabbatch{7}.spm.stats.con.consess{3}.tcon.sessrep = 'both';
matlabbatch{7}.spm.stats.con.consess{4}.tcon.name = 'coungruent_gt_neutral';
matlabbatch{7}.spm.stats.con.consess{4}.tcon.weights = [1 0 -1];
matlabbatch{7}.spm.stats.con.consess{4}.tcon.sessrep = 'both';
matlabbatch{7}.spm.stats.con.consess{5}.tcon.name = 'congruent_gt_incongruent';
matlabbatch{7}.spm.stats.con.consess{5}.tcon.weights = [1 -1 0];
matlabbatch{7}.spm.stats.con.consess{5}.tcon.sessrep = 'both';
matlabbatch{7}.spm.stats.con.consess{6}.tcon.name = 'incongruent_gt_neutral';
matlabbatch{7}.spm.stats.con.consess{6}.tcon.weights = [0 1 -1];
matlabbatch{7}.spm.stats.con.consess{6}.tcon.sessrep = 'both';
matlabbatch{7}.spm.stats.con.consess{7}.tcon.name = 'incongruent_gt_congruent';
matlabbatch{7}.spm.stats.con.consess{7}.tcon.weights = [-1 1 0];
matlabbatch{7}.spm.stats.con.consess{7}.tcon.sessrep = 'both';
matlabbatch{7}.spm.stats.con.consess{8}.tcon.name = 'cond_gt_baseline';
matlabbatch{7}.spm.stats.con.consess{8}.tcon.weights = [0.5 0.5 -1];
matlabbatch{7}.spm.stats.con.consess{8}.tcon.sessrep = 'both';
matlabbatch{7}.spm.stats.con.delete = 0;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Stroop first level
matlabbatch{8}.spm.stats.fmri_spec.dir = {stroop_volume};
matlabbatch{8}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{8}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{8}.spm.stats.fmri_spec.timing.fmri_t = 35;
matlabbatch{8}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));

%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).name = 'congruent';
stroop_A_cong = dir(fullfile(stroop_fold, '0*stroop_A_cong.txt'));
stroop_A_cong = load(fullfile(stroop_fold,stroop_A_cong.name));
%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).onset = stroop_A_cong;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).name = 'incongruent';
stroop_A_incong = dir(fullfile(stroop_fold, '0*stroop_A_incong.txt'));
stroop_A_incong = load(fullfile(stroop_fold,stroop_A_incong.name));
%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).onset = stroop_A_incong;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).name = 'neutral';
stroop_A_neutral = dir(fullfile(stroop_fold, '0*stroop_A_neutral.txt'));
stroop_A_neutral = load(fullfile(stroop_fold,stroop_A_neutral.name));
%
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).onset = stroop_A_neutral;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{8}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(1).multi_reg = {''};
matlabbatch{8}.spm.stats.fmri_spec.sess(1).multi_reg = {stroop_rp_run1_select};
matlabbatch{8}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));

%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).name = 'congruent';
stroop_B_cong = dir(fullfile(stroop_fold, '0*stroop_B_cong.txt'));
stroop_B_cong = load(fullfile(stroop_fold,stroop_B_cong.name));
%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).onset = stroop_B_cong;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).name = 'incongruent';
stroop_B_incong = dir(fullfile(stroop_fold, '0*stroop_B_incong.txt'));
stroop_B_incong = load(fullfile(stroop_fold,stroop_B_incong.name));
%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).onset = stroop_B_incong;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).name = 'neutral';
stroop_B_neutral = dir(fullfile(stroop_fold, '0*stroop_B_neutral.txt'));
stroop_B_neutral = load(fullfile(stroop_fold,stroop_B_neutral.name));
%
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).onset = stroop_B_neutral;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;
matlabbatch{8}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{8}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{8}.spm.stats.fmri_spec.sess(2).multi_reg = {''};
matlabbatch{8}.spm.stats.fmri_spec.sess(2).multi_reg = {stroop_rp_run2_select};
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
matlabbatch{10}.spm.stats.con.consess{1}.tcon.sessrep = 'both';
matlabbatch{10}.spm.stats.con.consess{2}.tcon.name = 'main_eff_incongruent';
matlabbatch{10}.spm.stats.con.consess{2}.tcon.weights = [0 1 0];
matlabbatch{10}.spm.stats.con.consess{2}.tcon.sessrep = 'both';
matlabbatch{10}.spm.stats.con.consess{3}.tcon.name = 'main_eff_neutral';
matlabbatch{10}.spm.stats.con.consess{3}.tcon.weights = [0 0 1];
matlabbatch{10}.spm.stats.con.consess{3}.tcon.sessrep = 'both';
matlabbatch{10}.spm.stats.con.consess{4}.tcon.name = 'coungruent_gt_neutral';
matlabbatch{10}.spm.stats.con.consess{4}.tcon.weights = [1 0 -1];
matlabbatch{10}.spm.stats.con.consess{4}.tcon.sessrep = 'both';
matlabbatch{10}.spm.stats.con.consess{5}.tcon.name = 'congruent_gt_incongruent';
matlabbatch{10}.spm.stats.con.consess{5}.tcon.weights = [1 -1 0];
matlabbatch{10}.spm.stats.con.consess{5}.tcon.sessrep = 'both';
matlabbatch{10}.spm.stats.con.consess{6}.tcon.name = 'incongruent_gt_neutral';
matlabbatch{10}.spm.stats.con.consess{6}.tcon.weights = [0 1 -1];
matlabbatch{10}.spm.stats.con.consess{6}.tcon.sessrep = 'both';
matlabbatch{10}.spm.stats.con.consess{7}.tcon.name = 'incongruent_gt_congruent';
matlabbatch{10}.spm.stats.con.consess{7}.tcon.weights = [-1 1 0];
matlabbatch{10}.spm.stats.con.consess{7}.tcon.sessrep = 'both';
matlabbatch{10}.spm.stats.con.consess{8}.tcon.name = 'cond_gt_baseline';
matlabbatch{10}.spm.stats.con.consess{8}.tcon.weights = [0.5 0.5 -1];
matlabbatch{10}.spm.stats.con.consess{8}.tcon.sessrep = 'both';
matlabbatch{10}.spm.stats.con.delete = 0;

save (['matlabbatch_correct' subname '.mat'], 'matlabbatch');
    
%%%it's time to do it!
spm_jobman('run',matlabbatch);

fprintf('Finished folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);
end
