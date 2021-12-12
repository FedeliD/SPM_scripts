%-----------------------------------------------------------------------
% Job saved on 23-Apr-2021 15:24:14 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% developer: Davide "Duzzo" Fedeli - fedeli.davide@hsr.it
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

%Istruzioni: cambia i percorsi in base a dove sono salvati i files nella
%tua cartella. Lancia "visual_batch.m" per eseguire questo comando e
%ottenere una serie di batch già pronti per ogni soggetto

%Consiglio di lanciare questo script all'interno della cartella
% path/to/this/folder/.../01_preprocessing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear all

%spm_jobman('initcfg');
spm('defaults', 'FMRI');
global defaults;

BasePath = ('/media/duzzo/Elements/Grasping/01_preprocessing');
% Warn user if there is no such folder.
first_fold = ('/media/duzzo/Elements/Grasping/02_first_level/');


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
  
  first_subj = fullfile(first_fold, DirList(k).name); %Switch_fold 

  fprintf('Processing subject %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);

  pathparts = strsplit(thisDir,filesep);
  subname = (pathparts{1,7});
  
  grasp_run_1 = dir(fullfile(thisDir, '*_fMRI_GRASP_IT_1*.nii')); 
  nameselect_1 = strcat(grasp_run_1.name, ',1');
  grasp_run_2 = dir(fullfile(thisDir, '*_fMRI_GRASP_IT_2*.nii')); 
  nameselect_2 = strcat(grasp_run_2.name, ',1');
  

  matlabbatch{1}.spm.util.exp_frames.files = {
                                            (fullfile(thisDir, nameselect_1))
                                            (fullfile(thisDir, nameselect_2))
                                            };
matlabbatch{1}.spm.util.exp_frames.frames = Inf;
matlabbatch{2}.spm.stats.fmri_spec.dir = {first_subj};
matlabbatch{2}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{2}.spm.stats.fmri_spec.timing.RT = 2.5;
matlabbatch{2}.spm.stats.fmri_spec.timing.fmri_t = 44;
matlabbatch{2}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{2}.spm.stats.fmri_spec.sess.scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(1).name = 'visual_graspable';
%%
visual_grasp_A = dir(fullfile(thisDir, '*grasping_ListA_fmri_vis_grasp.txt'));
visual_grasp_Ar = textread(fullfile(thisDir,visual_grasp_A.name));
visual_grasp_B = dir(fullfile(thisDir, '*grasping_ListB_fmri_vis_grasp.txt'));
visual_grasp_Br = textread(fullfile(thisDir,visual_grasp_B.name));
visual_grasp_Br = visual_grasp_Br + (258 .* 2.5);
visual_grasp = [visual_grasp_Ar;visual_grasp_Br];


matlabbatch{2}.spm.stats.fmri_spec.sess.cond(1).onset = visual_grasp;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(1).duration = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(1).orth = 1;


visual_nongrasp_A = dir(fullfile(thisDir, '*grasping_ListA_fmri_vis_nongrasp.txt'));
visual_nongrasp_Ar = textread(fullfile(thisDir,visual_nongrasp_A.name));
visual_nongrasp_B = dir(fullfile(thisDir, '*grasping_ListB_fmri_vis_nongrasp.txt'));
visual_nongrasp_Br = textread(fullfile(thisDir,visual_nongrasp_B.name));
visual_nongrasp_Br = visual_nongrasp_Br + (258 .* 2.5);
visual_nongrasp = [visual_nongrasp_Ar;visual_nongrasp_Br];


matlabbatch{2}.spm.stats.fmri_spec.sess.cond(2).name = 'visual_nongraspable';
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(2).onset = visual_nongrasp;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(2).duration = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(2).orth = 1;

visual_control_A = dir(fullfile(thisDir, '*grasping_ListA_fmri_vis_control.txt'));
visual_control_Ar = textread(fullfile(thisDir,visual_control_A.name));
visual_control_B = dir(fullfile(thisDir, '*grasping_ListB_fmri_vis_control.txt'));
visual_control_Br = textread(fullfile(thisDir,visual_control_B.name));
visual_control_Br = visual_control_Br + (258 .* 2.5);
visual_control = [visual_control_Ar;visual_control_Br];

matlabbatch{2}.spm.stats.fmri_spec.sess.cond(3).name = 'visual_control';
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(3).onset = visual_control;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(3).duration = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(3).tmod = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(3).orth = 1;


verbal_grasp_A = dir(fullfile(thisDir, '*grasping_ListA_fmri_ver_grasp.txt'));
verbal_grasp_Ar = textread(fullfile(thisDir,verbal_grasp_A.name));
verbal_grasp_B = dir(fullfile(thisDir, '*grasping_ListB_fmri_ver_grasp.txt'));
verbal_grasp_Br = textread(fullfile(thisDir,verbal_grasp_B.name));
verbal_grasp_Br = verbal_grasp_Br + (258 .* 2.5);
verbal_grasp = [verbal_grasp_Ar;verbal_grasp_Br];

matlabbatch{2}.spm.stats.fmri_spec.sess.cond(4).name = 'verbal_graspable';
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(4).onset = verbal_grasp;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(4).duration = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(4).tmod = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(4).orth = 1;

verbal_nongrasp_A = dir(fullfile(thisDir, '*grasping_ListA_fmri_ver_nongrasp.txt'));
verbal_nongrasp_Ar = textread(fullfile(thisDir,verbal_nongrasp_A.name));
verbal_nongrasp_B = dir(fullfile(thisDir, '*grasping_ListB_fmri_ver_nongrasp.txt'));
verbal_nongrasp_Br = textread(fullfile(thisDir,verbal_nongrasp_B.name));
verbal_nongrasp_Br = verbal_nongrasp_Br + (258 .* 2.5);
verbal_nongrasp = [verbal_nongrasp_Ar;verbal_nongrasp_Br];

matlabbatch{2}.spm.stats.fmri_spec.sess.cond(5).name = 'verbal_nongraspable';
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(5).onset = verbal_nongrasp;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(5).duration = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(5).tmod = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(5).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(5).orth = 1;

verbal_control_A = dir(fullfile(thisDir, '*grasping_ListA_fmri_ver_control.txt'));
verbal_control_Ar = textread(fullfile(thisDir,verbal_control_A.name));
verbal_control_B = dir(fullfile(thisDir, '*grasping_ListB_fmri_ver_control.txt'));
verbal_control_Br = textread(fullfile(thisDir,verbal_control_B.name));
verbal_control_Br = verbal_control_Br + (258 .* 2.5);
verbal_control = [verbal_control_Ar;verbal_control_Br];


matlabbatch{2}.spm.stats.fmri_spec.sess.cond(6).name = 'verbal_control';
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(6).onset = verbal_control;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(6).duration = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(6).tmod = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(6).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.cond(6).orth = 1;

matlabbatch{2}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{2}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.multi_reg = {''};
matlabbatch{2}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{2}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{2}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{2}.spm.stats.fmri_spec.volt = 1;
matlabbatch{2}.spm.stats.fmri_spec.global = 'None';
matlabbatch{2}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{2}.spm.stats.fmri_spec.mask = {''};
matlabbatch{2}.spm.stats.fmri_spec.cvi = 'AR(1)';


matlabbatch{3}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{3}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{4}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{4}.spm.stats.con.consess{1}.tcon.name = 'main_eff_g-vis';
matlabbatch{4}.spm.stats.con.consess{1}.tcon.weights = [1 0 0 0 0 0];
matlabbatch{4}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{2}.tcon.name = 'main_eff_ng-vis';
matlabbatch{4}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 0 0 0];
matlabbatch{4}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{3}.tcon.name = 'main_eff_c-vis';
matlabbatch{4}.spm.stats.con.consess{3}.tcon.weights = [0 0 1 0 0 0];
matlabbatch{4}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{4}.tcon.name = 'G_Vis>Ng_Vis';
matlabbatch{4}.spm.stats.con.consess{4}.tcon.weights = [1 -1 0 0 0 0];
matlabbatch{4}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{5}.tcon.name = 'G_Vis>C_Vis';
matlabbatch{4}.spm.stats.con.consess{5}.tcon.weights = [1 0 -1 0 0 0];
matlabbatch{4}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{6}.tcon.name = 'Ng_Vis>C_Vis';
matlabbatch{4}.spm.stats.con.consess{6}.tcon.weights = [0 1 -1 0 0 0];
matlabbatch{4}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{7}.tcon.name = 'G_Ng_Vis>C_Vis';
matlabbatch{4}.spm.stats.con.consess{7}.tcon.weights = [0.5 0.5 -1 0 0 0];
matlabbatch{4}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{8}.tcon.name = 'G_Vis>Ng_C_Vis';
matlabbatch{4}.spm.stats.con.consess{8}.tcon.weights = [1 -0.5 -0.5 0 0 0];
matlabbatch{4}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{9}.tcon.name = 'main_eff_g-ver';
matlabbatch{4}.spm.stats.con.consess{9}.tcon.weights = [0 0 0 1 0 0];
matlabbatch{4}.spm.stats.con.consess{9}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{10}.tcon.name = 'main_eff_ng-ver';
matlabbatch{4}.spm.stats.con.consess{10}.tcon.weights = [0 0 0 0 1 0];
matlabbatch{4}.spm.stats.con.consess{10}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{11}.tcon.name = 'main_eff_c-ver';
matlabbatch{4}.spm.stats.con.consess{11}.tcon.weights = [0 0 0 0 0 1];
matlabbatch{4}.spm.stats.con.consess{11}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{12}.tcon.name = 'G_Ver>Ng_Ver';
matlabbatch{4}.spm.stats.con.consess{12}.tcon.weights = [0 0 0 1 -1 0];
matlabbatch{4}.spm.stats.con.consess{12}.tcon.sessrep = 'none';
matlabbatch{4}.spm.stats.con.consess{13}.tcon.name = 'G_Ver>C_Ver';
matlabbatch{4}.spm.stats.con.consess{13}.tcon.weights = [0 0 0 1 0 -1];
matlabbatch{4}.spm.stats.con.consess{13}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{14}.tcon.name = 'Ng_Ver>C_Ver';
matlabbatch{4}.spm.stats.con.consess{14}.tcon.weights = [0 0 0 0 1 -1];
matlabbatch{4}.spm.stats.con.consess{14}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{15}.tcon.name = 'G_Ng_Ver>C_Ver';
matlabbatch{4}.spm.stats.con.consess{15}.tcon.weights = [0 0 0 0.5 0.5 -1];
matlabbatch{4}.spm.stats.con.consess{15}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{16}.tcon.name = 'G_Ver>Ng_C_Ver';
matlabbatch{4}.spm.stats.con.consess{16}.tcon.weights = [0 0 0 1 -0.5 -0.5];
matlabbatch{4}.spm.stats.con.consess{16}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{17}.tcon.name = 'main_eff_g';
matlabbatch{4}.spm.stats.con.consess{17}.tcon.weights = [1 0 0 1 0 0];
matlabbatch{4}.spm.stats.con.consess{17}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{18}.tcon.name = 'main_eff_ng';
matlabbatch{4}.spm.stats.con.consess{18}.tcon.weights = [0 1 0 0 1 0];
matlabbatch{4}.spm.stats.con.consess{18}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{19}.tcon.name = 'main_eff_c';
matlabbatch{4}.spm.stats.con.consess{19}.tcon.weights = [0 0 1 0 0 1];
matlabbatch{4}.spm.stats.con.consess{19}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{20}.tcon.name = 'G_V>Ng';
matlabbatch{4}.spm.stats.con.consess{20}.tcon.weights = [1 -1 0 1 -1 0];
matlabbatch{4}.spm.stats.con.consess{20}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{21}.tcon.name = 'G>C';
matlabbatch{4}.spm.stats.con.consess{21}.tcon.weights = [1 0 -1 1 0 -1];
matlabbatch{4}.spm.stats.con.consess{21}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{22}.tcon.name = 'Ng>C';
matlabbatch{4}.spm.stats.con.consess{22}.tcon.weights = [0 1 -1 0 1 -1];
matlabbatch{4}.spm.stats.con.consess{22}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{23}.tcon.name = 'G_Ng>C';
matlabbatch{4}.spm.stats.con.consess{23}.tcon.weights = [0.5 0.5 -1 0.5 0.5 -1];
matlabbatch{4}.spm.stats.con.consess{23}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{24}.tcon.name = 'G>Ng_C';
matlabbatch{4}.spm.stats.con.consess{24}.tcon.weights = [1 -0.5 -0.5 1 -0.5 -0.5];
matlabbatch{4}.spm.stats.con.consess{24}.tcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.consess{25}.fcon.name = 'eye';
matlabbatch{4}.spm.stats.con.consess{25}.fcon.weights = [1 0 0 0 0 0
                                                         0 1 0 0 0 0
                                                         0 0 1 0 0 0
                                                         0 0 0 1 0 0
                                                         0 0 0 0 1 0
                                                         0 0 0 0 0 1];
matlabbatch{4}.spm.stats.con.consess{25}.fcon.sessrep = 'repl';
matlabbatch{4}.spm.stats.con.delete = 0;

%%

save (['matlabbatch' subname '.mat'], 'matlabbatch');
    
%%%it's time to do it!
spm_jobman('run',matlabbatch);

fprintf('Finished folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);




 end
