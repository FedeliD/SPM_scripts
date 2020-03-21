% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {'/media/duzzo/Toshiba_brain/Syntax_analyses/Old/02-first_level/SYNTAX-OLD-026/first_level_old_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
