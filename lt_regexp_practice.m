% returns all the N-grams in inputtext
%
% takes:
%      inputtext: a long string
%      N: N-gram (1 for unigrams)
% output:
%      a cell array of N-grams
inputtext=all_trans.syl_order_compiled_across_songs
N=8;
clear terms
for n=2:N;
terms{n} = regexp(inputtext,['\w{2,' num2str(n) '}'],'match')
end

% remove smaller sized n-grams that are always part of a larger n-gram;
% start from small, and for each n-gram check whether there are multiple
% (n+1)-grams containing it.  If so keep it.  If not throw it out (e.g. ab
% is really abcd...)

%% or mopre simply take out the most common of all n-grams for each n. should be obvious.
for n=2:N
    for i=1:size(terms{n},2); % number of n-grams
        regexp(terms{n}(1)      
    
    
    end
end

  nString = numel(terms);
  
  index = repmat((0:(nString-N))',1,N)+repmat(1:N,(nString-N+1),1);
  subStrings = (terms(index));
  
  for i=2:N
      subStrings(:,1) = strcat(subStrings(:,1),repmat({' '}, numel(subStrings(:,1)),1),subStrings(:,i));
  end
  output = subStrings(:,1);
  

