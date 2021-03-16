% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {'F:/Task_esecutivi/tem/first_level_correct.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
cat12('expert');
spm_jobman('run', jobs, inputs{:});