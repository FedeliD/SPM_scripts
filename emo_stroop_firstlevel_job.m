%-----------------------------------------------------------------------
% Job saved on 21-Jul-2021 13:23:13 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

spm('defaults', 'FMRI');
global defaults;

BasePath = ('/media/duzzo/Elements/Emo_Stroop/03_first_level');
ProcPath = ('/media/duzzo/Elements/Emo_Stroop/02_Preprocessing');
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
  thisProc = fullfile(ProcPath, DirList(k).name)
  
  %% images
  ita_run_1 = dir(fullfile(thisProc, 'swua*Stroop_IT_1*.nii'));
  nameselect_1 = strcat(ita_run_1.name, ',1');
  ita_run_2 = dir(fullfile(thisProc, 'swua*Stroop_IT_2*.nii'));
  nameselect_2 = strcat(ita_run_2.name, ',1');
  
  eng_run_1 = dir(fullfile(thisProc, 'swua*Stroop_UK_1*.nii'));
  nameselect_3 = strcat(eng_run_1.name, ',1');
  eng_run_2 = dir(fullfile(thisProc, 'swua*Stroop_UK_2*.nii'));
  nameselect_4 = strcat(eng_run_2.name, ',1');
  
  
  %% realignment parameters
  ita_rp_run1 = dir(fullfile(thisProc, 'rp*Stroop_IT_1*.txt'));
  ita_rp_run1_select = strcat(thisProc, '/',  ita_rp_run1.name);
  ita_rp_run2 = dir(fullfile(thisProc, 'rp*Stroop_IT_2*.txt'));
  ita_rp_run2_select = strcat(thisProc, '/',  ita_rp_run2.name);
  eng_rp_run1 = dir(fullfile(thisProc, 'rp*Stroop_UK_1*.txt'));
  eng_rp_run1_select = strcat(thisProc, '/',  eng_rp_run1.name);
  eng_rp_run2 = dir(fullfile(thisProc, 'rp*Stroop_UK_2*.txt'));
  eng_rp_run2_select = strcat(thisProc, '/',  eng_rp_run2.name);

  
  %% onsets
  ita_run_1_emo = dir(fullfile(thisDir, '*Emotional_stroop_ita_1_emo.txt'));
  ita_run_1_emo = load(fullfile(thisDir,ita_run_1_emo.name));
  
  ita_run_1_neu = dir(fullfile(thisDir, '*Emotional_stroop_ita_1_neu.txt'));
  ita_run_1_neu = load(fullfile(thisDir,ita_run_1_neu.name));
   
  ita_run_2_emo = dir(fullfile(thisDir, '*Emotional_stroop_ita_2_emo.txt'));
  ita_run_2_emo = load(fullfile(thisDir,ita_run_2_emo.name));
    
  ita_run_2_neu = dir(fullfile(thisDir, '*Emotional_stroop_ita_2_neu.txt'));
  ita_run_2_neu = load(fullfile(thisDir,ita_run_2_neu.name));
   
  eng_run_1_emo = dir(fullfile(thisDir, '*Emotional_stroop_eng_1_emo.txt'));
  eng_run_1_emo = load(fullfile(thisDir,eng_run_1_emo.name));
  
  eng_run_1_neu = dir(fullfile(thisDir, '*Emotional_stroop_eng_1_neu.txt'));
  eng_run_1_neu = load(fullfile(thisDir,eng_run_1_neu.name));
   
  eng_run_2_emo = dir(fullfile(thisDir, '*Emotional_stroop_eng_2_emo.txt'));
  eng_run_2_emo = load(fullfile(thisDir,eng_run_2_emo.name));
    
  eng_run_2_neu = dir(fullfile(thisDir, '*Emotional_stroop_eng_2_neu.txt'));
  eng_run_2_neu = load(fullfile(thisDir,eng_run_2_neu.name));
    

matlabbatch{1}.spm.util.exp_frames.files = {(fullfile(thisProc, nameselect_1))};
matlabbatch{1}.spm.util.exp_frames.frames = Inf;
matlabbatch{2}.spm.util.exp_frames.files = {(fullfile(thisProc, nameselect_2))};
matlabbatch{2}.spm.util.exp_frames.frames = Inf;
matlabbatch{3}.spm.util.exp_frames.files = {(fullfile(thisProc, nameselect_3))};
matlabbatch{3}.spm.util.exp_frames.frames = Inf;
matlabbatch{4}.spm.util.exp_frames.files = {(fullfile(thisProc, nameselect_4))};
matlabbatch{4}.spm.util.exp_frames.frames = Inf;
matlabbatch{5}.spm.stats.fmri_spec.dir = {thisDir};
matlabbatch{5}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{5}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{5}.spm.stats.fmri_spec.timing.fmri_t = 35;
matlabbatch{5}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).name = 'neu';
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).onset = ita_run_1_neu;
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).name = 'emo';
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).onset = ita_run_1_emo;
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{5}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(1).multi_reg =  {ita_rp_run1_select};
matlabbatch{5}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).name = 'neu';
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).onset = ita_run_2_neu;
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).name = 'emo';
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).onset = ita_run_2_emo;
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{5}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(2).multi_reg = {ita_rp_run2_select};
matlabbatch{5}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{5}.spm.stats.fmri_spec.sess(3).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(1).name = 'neu';
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(1).onset = eng_run_1_neu;
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(1).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(1).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(1).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(2).name = 'emo';
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(2).onset = eng_run_1_emo;
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(2).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(2).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(3).cond(2).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(3).multi = {''};
matlabbatch{5}.spm.stats.fmri_spec.sess(3).regress = struct('name', {}, 'val', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(3).multi_reg = {eng_rp_run1_select};
matlabbatch{5}.spm.stats.fmri_spec.sess(3).hpf = 128;
matlabbatch{5}.spm.stats.fmri_spec.sess(4).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(1).name = 'neu';
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(1).onset = eng_run_2_neu;
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(1).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(1).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(1).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(2).name = 'emo';
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(2).onset = eng_run_2_emo;
%%
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(2).duration = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(2).tmod = 0;
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(4).cond(2).orth = 1;
matlabbatch{5}.spm.stats.fmri_spec.sess(4).multi = {''};
matlabbatch{5}.spm.stats.fmri_spec.sess(4).regress = struct('name', {}, 'val', {});
matlabbatch{5}.spm.stats.fmri_spec.sess(4).multi_reg = {eng_rp_run2_select};
matlabbatch{5}.spm.stats.fmri_spec.sess(4).hpf = 128;
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
matlabbatch{7}.spm.stats.con.consess{1}.tcon.name = 'emo_gt_neu';
matlabbatch{7}.spm.stats.con.consess{1}.tcon.weights = [-1 1];
matlabbatch{7}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{7}.spm.stats.con.consess{2}.tcon.name = 'neu_gt_emo';
matlabbatch{7}.spm.stats.con.consess{2}.tcon.weights = [1 -1];
matlabbatch{7}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{7}.spm.stats.con.consess{3}.tcon.name = 'neu';
matlabbatch{7}.spm.stats.con.consess{3}.tcon.weights = 1;
matlabbatch{7}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
matlabbatch{7}.spm.stats.con.consess{4}.tcon.name = 'emo';
matlabbatch{7}.spm.stats.con.consess{4}.tcon.weights = [0 1];
matlabbatch{7}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{7}.spm.stats.con.consess{5}.tcon.name = 'ita_gt_eng';
matlabbatch{7}.spm.stats.con.consess{5}.tcon.weights = [1 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0];
matlabbatch{7}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
matlabbatch{7}.spm.stats.con.consess{6}.tcon.name = 'eng_gt_ita';
matlabbatch{7}.spm.stats.con.consess{6}.tcon.weights = [-1 -1 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0];
matlabbatch{7}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
matlabbatch{7}.spm.stats.con.consess{7}.tcon.name = 'emo_ita';
matlabbatch{7}.spm.stats.con.consess{7}.tcon.weights = [1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0];
matlabbatch{7}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
matlabbatch{7}.spm.stats.con.consess{8}.tcon.name = 'emo_eng';
matlabbatch{7}.spm.stats.con.consess{8}.tcon.weights = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0];
matlabbatch{7}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
matlabbatch{7}.spm.stats.con.consess{9}.tcon.name = 'neu_ita';
matlabbatch{7}.spm.stats.con.consess{9}.tcon.weights = [0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0];
matlabbatch{7}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
matlabbatch{7}.spm.stats.con.consess{10}.tcon.name = 'neu_eng';
matlabbatch{7}.spm.stats.con.consess{10}.tcon.weights = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0];
matlabbatch{7}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
matlabbatch{7}.spm.stats.con.delete = 0;


save (['matlabbatch' subname '.mat'], 'matlabbatch');
    
%%%it's time to do it!
spm_jobman('run',matlabbatch);

fprintf('Finished folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);
end
