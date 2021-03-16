%-----------------------------------------------------------------------
% Job created by Gianpaolo & Davide
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
% 15/03/2021
%-----------------------------------------------------------------------
%%
spm('defaults', 'FMRI');
global defaults;

BasePath = ('F:/Task_esecutivi/tem');

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
for k = 12: numberOfFolders
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
  
  surf_fold = dir(T1w_fold);
  surf_fold = surf_fold(end).name;
  surf_fold = fullfile(T1w_fold, surf_fold);
  surface = dir(fullfile(surf_fold, 'lh.central*.gii'));
  surface_select = (fullfile(surf_fold, surface.name));
  flanker_run_1 = dir(fullfile(flanker_fold, 'ua*_fMRI_ANT_1_*.nii'));
  nameselect_1 = strcat(flanker_run_1.name, ',1');
  flanker_run_2 = dir(fullfile(flanker_fold, 'ua*_fMRI_ANT_2_*.nii'));
  nameselect_2 = strcat(flanker_run_2.name, ',1');
  flanker_rp_run1 = dir(fullfile(flanker_fold, 'rp*ANT_1_*.txt'));
  flanker_rp_run1_select = strcat(flanker_fold, '\',  flanker_rp_run1.name);
  flanker_rp_run2 = dir(fullfile(flanker_fold, 'rp*ANT_2_*.txt'));
  flanker_rp_run2_select = strcat(flanker_fold, '\',  flanker_rp_run2.name);
  

  
  matlabbatch{1}.spm.util.exp_frames.files = {(fullfile(flanker_fold, nameselect_1))};
  matlabbatch{1}.spm.util.exp_frames.frames = Inf;
  matlabbatch{2}.spm.util.exp_frames.files = {(fullfile(flanker_fold, nameselect_2))};
  matlabbatch{2}.spm.util.exp_frames.frames = Inf;
  

  
matlabbatch{3}.spm.stats.fmri_spec.dir = {flanker_fold};
matlabbatch{3}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{3}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t = 35;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).name = 'congruent';
%%
flanker_A_cong = dir(fullfile(flanker_fold, '0*Flanker_A_cong.txt'));
flanker_A_cong = load(fullfile(flanker_fold,flanker_A_cong.name));

matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).onset = flanker_A_cong;
%%
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).name = 'incongruent';
%%
flanker_A_incong = dir(fullfile(flanker_fold, '0*Flanker_A_incong.txt'));
flanker_A_incong = load(fullfile(flanker_fold,flanker_A_incong.name));

matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).onset = flanker_A_incong;
%%
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).name = 'neutral';
%%

flanker_A_neutral = dir(fullfile(flanker_fold, '0*Flanker_A_neutral.txt'));
flanker_A_neutral = load(fullfile(flanker_fold,flanker_A_neutral.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).onset = flanker_A_neutral;
%%
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{3}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi_reg = {flanker_rp_run1_select};
matlabbatch{3}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).name = 'congruent';
%%

flanker_B_cong = dir(fullfile(flanker_fold, '0*Flanker_B_cong.txt'));
flanker_B_cong = load(fullfile(flanker_fold,flanker_B_cong.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).onset = flanker_B_cong;
%%
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).name = 'incongruent';
%%

flanker_B_incong = dir(fullfile(flanker_fold, '0*Flanker_B_incong.txt'));
flanker_B_incong = load(fullfile(flanker_fold,flanker_B_incong.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).onset = flanker_B_incong;
%%
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).name = 'neutral';
%%

flanker_B_neutral = dir(fullfile(flanker_fold, '0*Flanker_B_neutral.txt'));
flanker_B_neutral  = load(fullfile(flanker_fold,flanker_B_neutral.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).onset = flanker_B_neutral;
%%
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{3}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi_reg = {flanker_rp_run2_select};
matlabbatch{3}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{3}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{3}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{3}.spm.stats.fmri_spec.volt = 1;
matlabbatch{3}.spm.stats.fmri_spec.global = 'None';
matlabbatch{3}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{3}.spm.stats.fmri_spec.mask = {''};
matlabbatch{3}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{4}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{4}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{4}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{5}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{5}.spm.stats.con.consess{1}.tcon.name = 'main_eff_congruent';
matlabbatch{5}.spm.stats.con.consess{1}.tcon.weights = [1 0 0];
matlabbatch{5}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{5}.spm.stats.con.consess{2}.tcon.name = 'main_eff_incongruent';
matlabbatch{5}.spm.stats.con.consess{2}.tcon.weights = [0 1 0];
matlabbatch{5}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{5}.spm.stats.con.consess{3}.tcon.name = 'main_eff_neutral';
matlabbatch{5}.spm.stats.con.consess{3}.tcon.weights = [0 0 1];
matlabbatch{5}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
matlabbatch{5}.spm.stats.con.consess{4}.tcon.name = 'coungruent_gt_neutral';
matlabbatch{5}.spm.stats.con.consess{4}.tcon.weights = [1 0 -1];
matlabbatch{5}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{5}.spm.stats.con.consess{5}.tcon.name = 'congruent_gt_incongruent';
matlabbatch{5}.spm.stats.con.consess{5}.tcon.weights = [1 -1 0];
matlabbatch{5}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
matlabbatch{5}.spm.stats.con.consess{6}.tcon.name = 'incongruent_gt_neutral';
matlabbatch{5}.spm.stats.con.consess{6}.tcon.weights = [0 1 -1];
matlabbatch{5}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
matlabbatch{5}.spm.stats.con.consess{7}.tcon.name = 'incongruent_gt_congruent';
matlabbatch{5}.spm.stats.con.consess{7}.tcon.weights = [-1 1 0];
matlabbatch{5}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
matlabbatch{5}.spm.stats.con.consess{8}.tcon.name = 'cond_gt_baseline';
matlabbatch{5}.spm.stats.con.consess{8}.tcon.weights = [0.5 0.5 -1];
matlabbatch{5}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
matlabbatch{5}.spm.stats.con.delete = 1;
matlabbatch{6}.spm.tools.cat.stools.vol2surf.data_vol(1) = cfg_dep('Contrast Manager: All Con Images', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','con'));
matlabbatch{6}.spm.tools.cat.stools.vol2surf.data_mesh_lh = {surface_select};
matlabbatch{6}.spm.tools.cat.stools.vol2surf.sample = {'maxabs'};
matlabbatch{6}.spm.tools.cat.stools.vol2surf.interp = {'linear'};
matlabbatch{6}.spm.tools.cat.stools.vol2surf.datafieldname = 'Flanker_con_surf';
matlabbatch{6}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.class = 'GM';
matlabbatch{6}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.startpoint = -0.5;
matlabbatch{6}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.steps = 7;
matlabbatch{6}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.endpoint = 0.5;
matlabbatch{7}.spm.tools.cat.stools.vol2surf.data_vol(1) = cfg_dep('Contrast Manager: All Stats Images', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spm'));
matlabbatch{7}.spm.tools.cat.stools.vol2surf.data_mesh_lh = {surface_select};
matlabbatch{7}.spm.tools.cat.stools.vol2surf.sample = {'maxabs'};
matlabbatch{7}.spm.tools.cat.stools.vol2surf.interp = {'linear'};
matlabbatch{7}.spm.tools.cat.stools.vol2surf.datafieldname = 'Flanker_stats_surf';
matlabbatch{7}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.class = 'GM';
matlabbatch{7}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.startpoint = -0.5;
matlabbatch{7}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.steps = 7;
matlabbatch{7}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.endpoint = 0.5;
matlabbatch{8}.spm.tools.cat.stools.surfresamp.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{8}.spm.tools.cat.stools.surfresamp.merge_hemi = 1;
matlabbatch{8}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{8}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{8}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{8}.spm.tools.cat.stools.surfresamp.nproc = 4;
matlabbatch{9}.spm.tools.cat.stools.surfresamp.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{9}.spm.tools.cat.stools.surfresamp.merge_hemi = 1;
matlabbatch{9}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{9}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{9}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{9}.spm.tools.cat.stools.surfresamp.nproc = 4;
matlabbatch{10}.spm.tools.cat.stools.surfresamp.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{10}.spm.tools.cat.stools.surfresamp.merge_hemi = 0;
matlabbatch{10}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{10}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{10}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{10}.spm.tools.cat.stools.surfresamp.nproc = 4;
matlabbatch{11}.spm.tools.cat.stools.surfresamp.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{11}.spm.tools.cat.stools.surfresamp.merge_hemi = 0;
matlabbatch{11}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{11}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{11}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{11}.spm.tools.cat.stools.surfresamp.nproc = 4;
% Stroop


  stroop_run_1 = dir(fullfile(stroop_fold, 'ua*_fMRI_Stroop_1_*.nii'));
  nameselect_3 = strcat(stroop_run_1.name, ',1');
  stroop_run_2 = dir(fullfile(stroop_fold, 'ua*_fMRI_Stroop_2_*.nii'));
  nameselect_4 = strcat(stroop_run_2.name, ',1');
 
  stroop_rp_run1 = dir(fullfile(stroop_fold, 'rp*Stroop_1_*.txt'));
  stroop_rp_run1_select = strcat(stroop_fold, '\',  stroop_rp_run1.name);
  stroop_rp_run2 = dir(fullfile(stroop_fold, 'rp*Stroop_2_*.txt'));
  stroop_rp_run2_select = strcat(stroop_fold, '\',  stroop_rp_run2.name); 

matlabbatch{12}.spm.util.exp_frames.files = {(fullfile(stroop_fold, nameselect_3))};
matlabbatch{12}.spm.util.exp_frames.frames = Inf;
matlabbatch{13}.spm.util.exp_frames.files = {(fullfile(stroop_fold, nameselect_4))};
matlabbatch{13}.spm.util.exp_frames.frames = Inf;
matlabbatch{14}.spm.stats.fmri_spec.dir = {stroop_fold};
matlabbatch{14}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{14}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{14}.spm.stats.fmri_spec.timing.fmri_t = 35;
matlabbatch{14}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{12}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(1).name = 'congruent';
%%

stroop_A_cong = dir(fullfile(stroop_fold, '0*stroop_A_cong.txt'));
stroop_A_cong = load(fullfile(stroop_fold,stroop_A_cong.name));

matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(1).onset = stroop_A_cong;
%%
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(2).name = 'incongruent';
%%
stroop_A_incong = dir(fullfile(stroop_fold, '0*stroop_A_incong.txt'));
stroop_A_incong = load(fullfile(stroop_fold,stroop_A_incong.name));

matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(2).onset = stroop_A_incong;
%%
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(3).name = 'neutral';
%%
stroop_A_neutral = dir(fullfile(stroop_fold, '0*stroop_A_neutral.txt'));
stroop_A_neutral = load(fullfile(stroop_fold,stroop_A_neutral.name));
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(3).onset = stroop_A_neutral;
%%
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{14}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(1).multi_reg = {stroop_rp_run1_select};
matlabbatch{14}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{13}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(1).name = 'congruent';
%%
stroop_B_cong = dir(fullfile(stroop_fold, '0*stroop_B_cong.txt'));
stroop_B_cong = load(fullfile(stroop_fold,stroop_B_cong.name));
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(1).onset = stroop_B_cong;
%%
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(2).name = 'incongruent';
%%
stroop_B_incong = dir(fullfile(stroop_fold, '0*stroop_B_incong.txt'));
stroop_B_incong = load(fullfile(stroop_fold,stroop_B_incong.name));
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(2).onset = stroop_B_incong;
%%
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(3).name = 'neutral';
%%
stroop_B_neutral = dir(fullfile(stroop_fold, '0*stroop_B_neutral.txt'));
stroop_B_neutral = load(fullfile(stroop_fold,stroop_B_neutral.name));
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(3).onset = stroop_B_neutral;
%%
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{14}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(2).multi_reg = {stroop_rp_run2_select};
matlabbatch{14}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{14}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{14}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{14}.spm.stats.fmri_spec.volt = 1;
matlabbatch{14}.spm.stats.fmri_spec.global = 'None';
matlabbatch{14}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{14}.spm.stats.fmri_spec.mask = {''};
matlabbatch{14}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{15}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{14}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{15}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{15}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{16}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{15}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{16}.spm.stats.con.consess{1}.tcon.name = 'main_eff_congruent';
matlabbatch{16}.spm.stats.con.consess{1}.tcon.weights = [1 0 0];
matlabbatch{16}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{16}.spm.stats.con.consess{2}.tcon.name = 'main_eff_incongruent';
matlabbatch{16}.spm.stats.con.consess{2}.tcon.weights = [0 1 0];
matlabbatch{16}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{16}.spm.stats.con.consess{3}.tcon.name = 'main_eff_neutral';
matlabbatch{16}.spm.stats.con.consess{3}.tcon.weights = [0 0 1];
matlabbatch{16}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
matlabbatch{16}.spm.stats.con.consess{4}.tcon.name = 'coungruent_gt_neutral';
matlabbatch{16}.spm.stats.con.consess{4}.tcon.weights = [1 0 -1];
matlabbatch{16}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{16}.spm.stats.con.consess{5}.tcon.name = 'congruent_gt_incongruent';
matlabbatch{16}.spm.stats.con.consess{5}.tcon.weights = [1 -1 0];
matlabbatch{16}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
matlabbatch{16}.spm.stats.con.consess{6}.tcon.name = 'incongruent_gt_neutral';
matlabbatch{16}.spm.stats.con.consess{6}.tcon.weights = [0 1 -1];
matlabbatch{16}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
matlabbatch{16}.spm.stats.con.consess{7}.tcon.name = 'incongruent_gt_congruent';
matlabbatch{16}.spm.stats.con.consess{7}.tcon.weights = [-1 1 0];
matlabbatch{16}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
matlabbatch{16}.spm.stats.con.consess{8}.tcon.name = 'cond_gt_baseline';
matlabbatch{16}.spm.stats.con.consess{8}.tcon.weights = [0.5 0.5 -1];
matlabbatch{16}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
matlabbatch{16}.spm.stats.con.delete = 1;
matlabbatch{17}.spm.tools.cat.stools.vol2surf.data_vol(1) = cfg_dep('Contrast Manager: All Con Images', substruct('.','val', '{}',{16}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','con'));
matlabbatch{17}.spm.tools.cat.stools.vol2surf.data_mesh_lh = {surface_select};
matlabbatch{17}.spm.tools.cat.stools.vol2surf.sample = {'maxabs'};
matlabbatch{17}.spm.tools.cat.stools.vol2surf.interp = {'linear'};
matlabbatch{17}.spm.tools.cat.stools.vol2surf.datafieldname = 'Stroop_con_surf';
matlabbatch{17}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.class = 'GM';
matlabbatch{17}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.startpoint = -0.5;
matlabbatch{17}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.steps = 7;
matlabbatch{17}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.endpoint = 0.5;
matlabbatch{18}.spm.tools.cat.stools.vol2surf.data_vol(1) = cfg_dep('Contrast Manager: All Stats Images', substruct('.','val', '{}',{16}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spm'));
matlabbatch{18}.spm.tools.cat.stools.vol2surf.data_mesh_lh = {surface_select};
matlabbatch{18}.spm.tools.cat.stools.vol2surf.sample = {'maxabs'};
matlabbatch{18}.spm.tools.cat.stools.vol2surf.interp = {'linear'};
matlabbatch{18}.spm.tools.cat.stools.vol2surf.datafieldname = 'Stroop_stats_surf';
matlabbatch{18}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.class = 'GM';
matlabbatch{18}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.startpoint = -0.5;
matlabbatch{18}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.steps = 7;
matlabbatch{18}.spm.tools.cat.stools.vol2surf.mapping.rel_mapping.endpoint = 0.5;
matlabbatch{19}.spm.tools.cat.stools.surfresamp.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{19}.spm.tools.cat.stools.surfresamp.merge_hemi = 1;
matlabbatch{19}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{19}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{19}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{19}.spm.tools.cat.stools.surfresamp.nproc = 4;
matlabbatch{20}.spm.tools.cat.stools.surfresamp.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{18}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{20}.spm.tools.cat.stools.surfresamp.merge_hemi = 1;
matlabbatch{20}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{20}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{20}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{20}.spm.tools.cat.stools.surfresamp.nproc = 4;
matlabbatch{21}.spm.tools.cat.stools.surfresamp.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{21}.spm.tools.cat.stools.surfresamp.merge_hemi = 0;
matlabbatch{21}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{21}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{21}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{21}.spm.tools.cat.stools.surfresamp.nproc = 4;
matlabbatch{22}.spm.tools.cat.stools.surfresamp.data_surf(1) = cfg_dep('Map Volume (Native Space) to Individual Surface: Left mapped values', substruct('.','val', '{}',{18}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','lh'));
matlabbatch{22}.spm.tools.cat.stools.surfresamp.merge_hemi = 0;
matlabbatch{22}.spm.tools.cat.stools.surfresamp.mesh32k = 1;
matlabbatch{22}.spm.tools.cat.stools.surfresamp.fwhm_surf = 3;
matlabbatch{22}.spm.tools.cat.stools.surfresamp.lazy = 0;
matlabbatch{22}.spm.tools.cat.stools.surfresamp.nproc = 4;

save (['surface_correct' subname '.mat'], 'matlabbatch');
    
%%%it's time to do it!
spm_jobman('run',matlabbatch);

fprintf('Finished folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);

end