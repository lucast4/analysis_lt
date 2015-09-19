inputtext=all_trans.syl_order_compiled_across_songs

regexp(inputtext,'(?# comment)refgh(\w*)(?:refgh)','match')

% this picks out stuff between pre and post.
pre='refgh'
post=
regexp(inputtext,['(?<=' pre ')\w*?(?=refgh)'],'match')


%% get all things that come before or after ab.

[startind,tokens]=regexp(inputtext,['(?<pre>..)ref(?<post>.)'],'match','names')

tokens.pre
tokens.post

%% get all things that start and end with specific strings
start_string='cd'
end_string='c'

[startind,tokens]=regexp(inputtext,[start_string '\w*?' end_string],'match','names')




%%
inputtext='hawpy '

out=regexp(inputtext, '(?<test>\wawpy\s)','match','tokens','names','split')

%% 
regexp(inputtext,'.')

test='<tr><td><p>text</p></td>'

