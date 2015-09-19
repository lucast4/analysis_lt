batchname = 'batch';
% batchname = input('What is the name of the batch file?  ', 's');

%makes a batch file
db_write_batch(batchname)

cleandirAuto('batch',800,4,5)
