%-----------------------------------------------------------------------
% My first first level script!
%-----------------------------------------------------------------------



%-----------------------------------------------------------------------
% Job saved on 20-Mar-2020 09:10:56 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------



clear all
%spm_jobman('initcfg');
spm('defaults', 'FMRI');
global defaults;

BasePath = ('/media/duzzo/Toshiba_brain/Syntax_analyses/Old/02-first_level');
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
for k = 1 : numberOfFolders
 thisDir = fullfile(BasePath, DirList(k).name);
  subdirname = dir(thisDir);
  subdirname = subdirname(3:end);
  subdesign = fullfile(BasePath, DirList(k).name, subdirname.name);
  fprintf('Processing folder %d of %d: %s\n', ...
    k, numberOfFolders, thisDir);
    pathparts = strsplit(thisDir,filesep);
    subname = (pathparts{1,8});
    NIfTI_run_1 = dir(fullfile(thisDir, '*_fMRI_Syntax_OLD_1.nii'));
    nameselect_1 = strcat(NIfTI_run_1.name, ',1');
    matlabbatch{1}.spm.util.exp_frames.files = {(fullfile(NIfTI_run_1.folder , nameselect_1))};
    matlabbatch{1}.spm.util.exp_frames.frames = Inf;
    NIfTI_run_2 = dir(fullfile(thisDir, '*_fMRI_Syntax_OLD_2.nii'));
    nameselect_2 = strcat(NIfTI_run_2.name, ',1');
    matlabbatch{2}.spm.util.exp_frames.files = {(fullfile(NIfTI_run_2.folder , nameselect_2))};
    matlabbatch{2}.spm.util.exp_frames.frames = Inf;
    matlabbatch{3}.spm.stats.fmri_spec.dir = {thisDir};
    matlabbatch{3}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{3}.spm.stats.fmri_spec.timing.RT = 2.5;
    matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t = 44;
    matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).name = 'filler';
    %%
    fillfile_A = dir(fullfile(thisDir, '0*logA_fill.txt'));
    fillfile_A = load(fullfile(fillfile_A.folder,fillfile_A.name));
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).onset = fillfile_A;
    %%
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).name = 'subj';
    %%
    subjfile_A = dir(fullfile(thisDir, '0*logA_subj.txt'));
    subjfile_A = load(fullfile(subjfile_A.folder,subjfile_A.name));
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).onset = subjfile_A;
    %%
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).name = 'obj';
    %%
    objsfile_A = dir(fullfile(thisDir, '0*logA_objs.txt'));
    objsfile_A = load(fullfile(objsfile_A.folder,objsfile_A.name));
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).onset = [objsfile_A];
    %%
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi = {''};
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi_reg = {''};
    matlabbatch{3}.spm.stats.fmri_spec.sess(1).hpf = 128;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).name = 'filler';
    %%
    fillfile_B = dir(fullfile(thisDir, '0*logB_fill.txt'));
    fillfile_B = load(fullfile(fillfile_B.folder,fillfile_B.name));
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).onset = fillfile_B;
    %%
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).name = 'subj';
    %%
    subjfile_B = dir(fullfile(thisDir, '0*logB_subj.txt'));
    subjfile_B = load(fullfile(subjfile_B.folder,subjfile_B.name));
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).onset = subjfile_B;
    %%
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).name = 'obj';
    %%
    objsfile_B = dir(fullfile(thisDir, '0*logB_objs.txt'));
    objsfile_B = load(fullfile(objsfile_B.folder,objsfile_B.name));
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).onset = objsfile_B;
    %%
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi = {''};
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
    matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi_reg = {''};
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
    matlabbatch{5}.spm.stats.con.consess{1}.tcon.name = 'Filler_Main_Effect';
    matlabbatch{5}.spm.stats.con.consess{1}.tcon.weights = [1 0 0];
    matlabbatch{5}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.consess{2}.tcon.name = 'Subject_Main_Effect';
    matlabbatch{5}.spm.stats.con.consess{2}.tcon.weights = [0 1 0];
    matlabbatch{5}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.consess{3}.tcon.name = 'Object_Main_effect';
    matlabbatch{5}.spm.stats.con.consess{3}.tcon.weights = [0 0 1];
    matlabbatch{5}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.consess{4}.tcon.name = 'Subject>Filler';
    matlabbatch{5}.spm.stats.con.consess{4}.tcon.weights = [-1 1 0];
    matlabbatch{5}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.consess{5}.tcon.name = 'Object>Filler';
    matlabbatch{5}.spm.stats.con.consess{5}.tcon.weights = [-1 0 1];
    matlabbatch{5}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.consess{6}.tcon.name = 'Subject>Object';
    matlabbatch{5}.spm.stats.con.consess{6}.tcon.weights = [0 1 -1];
    matlabbatch{5}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.consess{7}.tcon.name = 'Object>Subject';
    matlabbatch{5}.spm.stats.con.consess{7}.tcon.weights = [0 -1 1];
    matlabbatch{5}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.consess{8}.tcon.name = 'Filler>Subject';
    matlabbatch{5}.spm.stats.con.consess{8}.tcon.weights = [-1 1 0];
    matlabbatch{5}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.consess{9}.tcon.name = 'Filler>Object';
    matlabbatch{5}.spm.stats.con.consess{9}.tcon.weights = [-1 0 1];
    matlabbatch{5}.spm.stats.con.consess{9}.tcon.sessrep = 'repl';
    matlabbatch{5}.spm.stats.con.delete = 0;
    save (['matlabbatch' subname '.mat'], 'matlabbatch');
    
    %%%it's time to do it!
    spm_jobman('run',matlabbatch);
    
end