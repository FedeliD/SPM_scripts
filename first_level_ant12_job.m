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
  
  matlabbatch{1}.spm.util.exp_frames.files = {(fullfile(flanker_fold, smoothselect_1))};
  matlabbatch{1}.spm.util.exp_frames.frames = Inf;
  matlabbatch{2}.spm.util.exp_frames.files = {(fullfile(flanker_fold, smoothselect_2))};
  matlabbatch{2}.spm.util.exp_frames.frames = Inf;

  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %ANT first level

matlabbatch{3}.spm.stats.fmri_spec.dir = {flanker_volume};
matlabbatch{3}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{3}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t = 35;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));


% 1
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).name = 'CC';
flanker_A_CC = dir(fullfile(flanker_fold, '0*Flanker_A_CC.txt'));
flanker_A_CC = load(fullfile(flanker_fold,flanker_A_CC.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).onset = flanker_A_CC;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
% 2
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).name = 'CI';
flanker_A_CI = dir(fullfile(flanker_fold, '0*Flanker_A_CI.txt'));
flanker_A_CI = load(fullfile(flanker_fold,flanker_A_CI.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).onset = flanker_A_CI;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
% 3
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).name = 'CN';
flanker_A_CN = dir(fullfile(flanker_fold, '0*Flanker_A_CN.txt'));
flanker_A_CN = load(fullfile(flanker_fold,flanker_A_CN.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).onset = flanker_A_CN;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
% 4
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(4).name = 'DC';
flanker_A_DC = dir(fullfile(flanker_fold, '0*Flanker_A_DC.txt'));
flanker_A_DC = load(fullfile(flanker_fold,flanker_A_DC.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(4).onset = flanker_A_DC;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(4).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(4).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(4).orth = 1;
% 5
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(5).name = 'DI';
flanker_A_DI = dir(fullfile(flanker_fold, '0*Flanker_A_DI.txt'));
flanker_A_DI = load(fullfile(flanker_fold,flanker_A_DI.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(5).onset = flanker_A_DI;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(5).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(5).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(5).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(5).orth = 1;
%6
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(6).name = 'DN';
flanker_A_DN = dir(fullfile(flanker_fold, '0*Flanker_A_DN.txt'));
flanker_A_DN = load(fullfile(flanker_fold,flanker_A_DN.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(6).onset = flanker_A_DN;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(6).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(6).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(6).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(6).orth = 1;
%7
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(7).name = 'NC';
flanker_A_NC = dir(fullfile(flanker_fold, '0*Flanker_A_NC.txt'));
flanker_A_NC = load(fullfile(flanker_fold,flanker_A_NC.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(7).onset = flanker_A_NC;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(7).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(7).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(7).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(7).orth = 1;
%8
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(8).name = 'NI';
flanker_A_NI = dir(fullfile(flanker_fold, '0*Flanker_A_NI.txt'));
flanker_A_NI = load(fullfile(flanker_fold,flanker_A_NI.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(8).onset = flanker_A_NI;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(8).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(8).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(8).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(8).orth = 1;
%9
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(9).name = 'NN';
flanker_A_NN = dir(fullfile(flanker_fold, '0*Flanker_A_NN.txt'));
flanker_A_NN = load(fullfile(flanker_fold,flanker_A_NN.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(9).onset = flanker_A_NN;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(9).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(9).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(9).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(9).orth = 1;
%10
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(10).name = 'SC';
flanker_A_SC = dir(fullfile(flanker_fold, '0*Flanker_A_SC.txt'));
flanker_A_SC = load(fullfile(flanker_fold,flanker_A_SC.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(10).onset = flanker_A_SC;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(10).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(10).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(10).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(10).orth = 1;
%11
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(11).name = 'SI';
flanker_A_SI = dir(fullfile(flanker_fold, '0*Flanker_A_SI.txt'));
flanker_A_SI = load(fullfile(flanker_fold,flanker_A_SI.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(11).onset = flanker_A_SI;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(11).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(11).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(11).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(11).orth = 1;
%12
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(12).name = 'SN';
flanker_A_SN = dir(fullfile(flanker_fold, '0*Flanker_A_SN.txt'));
flanker_A_SN = load(fullfile(flanker_fold,flanker_A_SN.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(12).onset = flanker_A_SN;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(12).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(12).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(12).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond(12).orth = 1;
%
matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{3}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi_reg = {''};
matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi_reg = {flanker_rp_run1_select};
matlabbatch{3}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
% 1
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).name = 'CC';
flanker_B_CC = dir(fullfile(flanker_fold, '0*Flanker_B_CC.txt'));
flanker_B_CC = load(fullfile(flanker_fold,flanker_B_CC.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).onset = flanker_B_CC;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;
% 2
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).name = 'CI';
flanker_B_CI = dir(fullfile(flanker_fold, '0*Flanker_B_CI.txt'));
flanker_B_CI = load(fullfile(flanker_fold,flanker_B_CI.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).onset = flanker_B_CI;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;
% 3
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).name = 'CN';
flanker_B_CN = dir(fullfile(flanker_fold, '0*Flanker_B_CN.txt'));
flanker_B_CN = load(fullfile(flanker_fold,flanker_B_CN.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).onset = flanker_B_CN;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;
% 4
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(4).name = 'DC';
flanker_B_DC = dir(fullfile(flanker_fold, '0*Flanker_B_DC.txt'));
flanker_B_DC = load(fullfile(flanker_fold,flanker_B_DC.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(4).onset = flanker_B_DC;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(4).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(4).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(4).orth = 1;
% 5
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(5).name = 'DI';
flanker_B_DI = dir(fullfile(flanker_fold, '0*Flanker_B_DI.txt'));
flanker_B_DI = load(fullfile(flanker_fold,flanker_B_DI.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(5).onset = flanker_B_DI;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(5).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(5).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(5).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(5).orth = 1;
%6
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(6).name = 'DN';
flanker_B_DN = dir(fullfile(flanker_fold, '0*Flanker_B_DN.txt'));
flanker_B_DN = load(fullfile(flanker_fold,flanker_B_DN.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(6).onset = flanker_B_DN;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(6).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(6).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(6).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(6).orth = 1;
%7
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(7).name = 'NC';
flanker_B_NC = dir(fullfile(flanker_fold, '0*Flanker_B_NC.txt'));
flanker_B_NC = load(fullfile(flanker_fold,flanker_B_NC.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(7).onset = flanker_B_NC;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(7).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(7).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(7).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(7).orth = 1;
%8
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(8).name = 'NI';
flanker_B_NI = dir(fullfile(flanker_fold, '0*Flanker_B_NI.txt'));
flanker_B_NI = load(fullfile(flanker_fold,flanker_B_NI.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(8).onset = flanker_B_NI;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(8).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(8).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(8).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(8).orth = 1;
%9
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(9).name = 'NN';
flanker_B_NN = dir(fullfile(flanker_fold, '0*Flanker_B_NN.txt'));
flanker_B_NN = load(fullfile(flanker_fold,flanker_B_NN.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(9).onset = flanker_B_NN;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(9).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(9).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(9).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(9).orth = 1;
%10
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(10).name = 'SC';
flanker_B_SC = dir(fullfile(flanker_fold, '0*Flanker_B_SC.txt'));
flanker_B_SC = load(fullfile(flanker_fold,flanker_B_SC.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(10).onset = flanker_B_SC;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(10).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(10).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(10).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(10).orth = 1;
%11
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(11).name = 'SI';
flanker_B_SI = dir(fullfile(flanker_fold, '0*Flanker_B_SI.txt'));
flanker_B_SI = load(fullfile(flanker_fold,flanker_B_SI.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(11).onset = flanker_B_SI;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(11).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(11).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(11).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(11).orth = 1;
%12
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(12).name = 'SN';
flanker_B_SN = dir(fullfile(flanker_fold, '0*Flanker_B_SN.txt'));
flanker_B_SN = load(fullfile(flanker_fold,flanker_B_SN.name));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(12).onset = flanker_B_SN;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(12).duration = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(12).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(12).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond(12).orth = 1;
%
matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{3}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi_reg = {''};
matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi_reg = {flanker_rp_run2_select};
matlabbatch{3}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{3}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{3}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{3}.spm.stats.fmri_spec.volt = 1;
matlabbatch{3}.spm.stats.fmri_spec.global = 'None';
matlabbatch{3}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{3}.spm.stats.fmri_spec.mask = {''};
matlabbatch{3}.spm.stats.fmri_spec.cvi = 'AR(1)';
%%
matlabbatch{4}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{4}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{4}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{5}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{5}.spm.stats.con.consess{1}.tcon.name = 'alerting';
matlabbatch{5}.spm.stats.con.consess{1}.tcon.weights = [0 0 0 -1 -1 -1 1 1 1 0 0 0];
matlabbatch{5}.spm.stats.con.consess{1}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{2}.tcon.name = 'orienting';
matlabbatch{5}.spm.stats.con.consess{2}.tcon.weights = [1 1 1 0 0 0 0 0 0 -1 -1 -1];
matlabbatch{5}.spm.stats.con.consess{2}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{3}.tcon.name = 'main_eff_congruent';
matlabbatch{5}.spm.stats.con.consess{3}.tcon.weights = [1 0 0 1 0 0 1 0 0 1 0 0];
matlabbatch{5}.spm.stats.con.consess{3}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{4}.tcon.name = 'main_eff_incongruent';
matlabbatch{5}.spm.stats.con.consess{4}.tcon.weights = [0 1 0 0 1 0 0 1 0 0 1 0];
matlabbatch{5}.spm.stats.con.consess{4}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{5}.tcon.name = 'main_eff_neutral';
matlabbatch{5}.spm.stats.con.consess{5}.tcon.weights = [0 0 1 0 0 1 0 0 1 0 0 1];
matlabbatch{5}.spm.stats.con.consess{5}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{6}.tcon.name = 'coungruent_gt_neutral';
matlabbatch{5}.spm.stats.con.consess{6}.tcon.weights = [1 0 -1 1 0 -1 1 0 -1 1 0 -1];
matlabbatch{5}.spm.stats.con.consess{6}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{7}.tcon.name = 'congruent_gt_incongruent';
matlabbatch{5}.spm.stats.con.consess{7}.tcon.weights = [1 -1 0 1 -1 0 1 -1 0 1 -1 0];
matlabbatch{5}.spm.stats.con.consess{7}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{8}.tcon.name = 'incongruent_gt_neutral';
matlabbatch{5}.spm.stats.con.consess{8}.tcon.weights = [0 1 -1 0 1 -1 0 1 -1 0 1 -1];
matlabbatch{5}.spm.stats.con.consess{8}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{9}.tcon.name = 'incongruent_gt_congruent';
matlabbatch{5}.spm.stats.con.consess{9}.tcon.weights = [-1 1 0 -1 1 0 -1 1 0 -1 1 0];
matlabbatch{5}.spm.stats.con.consess{9}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.consess{10}.tcon.name = 'cond_gt_baseline';
matlabbatch{5}.spm.stats.con.consess{10}.tcon.weights = [0.5 0.5 -1 0.5 0.5 -1 0.5 0.5 -1 0.5 0.5 -1];
matlabbatch{5}.spm.stats.con.consess{10}.tcon.sessrep = 'both';
matlabbatch{5}.spm.stats.con.delete = 0;


save (['matlabbatch_ANT12' subname '.mat'], 'matlabbatch');
    
%%%it's time to do it!
spm_jobman('run',matlabbatch);

fprintf('Finished folder %d of %d: %s\n', ...
  k, numberOfFolders, thisDir);
end
