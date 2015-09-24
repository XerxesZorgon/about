## Copyright (C) 2015 Markus Bergholz <markuman@gmail.com>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {@var{list} =} about (@var{file})
## List dependencies of .m files.
##
## Currently only '-toponly' method is implemented
##
## @end deftypefn

function ret = about(file)

  ## get all available functions
  X = completion_matches ("");
  X(:,end+1) = "\n";
  X = X'(:);
  X(X==0) = [];
  ALL = cell2mat(textscan(X','%s'));
  % files in the current directory are also listet, so replace all file extensions
  ALL = unique(strrep(ALL, '.m', '')); 
 
  ## try to open file
  if ischar(file)
    fid = fopen(file);
    str = fread(fid, 'char=>char').';
    fclose(fid);

		# get function name itself
    [~, functionItself, functionItselfExtension] = fileparts(file);

		# list of reserved keywords
    reserved = {'if', 'elseif', 'else', ...
                'try', 'catch', ...
                'switch', 'case', ...
                'function', 'return', ...
                'classdef', 'properties', 'methods', ...
                'for', 'while', 'do', ...
                'end', 'endfunction', 'endwhile', 'end_try_catch', ...
                'endclassdef', 'endif', 'endmethods', 'endfor', ...
                'true', 'false', ...
                functionItself};

    F        = _identifyFunctions(str);
    SHADOWED =  _identifyFunktionsInFunction(str);    


    # iterate over F
    ret = struct();
    ret.functions = {};
    ret.shadowed  = {};
    ret.variables = struct();
    ret.variables.used = _identifyVars(str);
    ret.linesOfCode = _linesOfCode(str);
    cell_ind_f = 1; # function cell index
    cell_ind_s = 1; # shadowed cell index
    for n = 1:columns(F)
    	# check if the possible function is an available function
      ind = find(strcmp(ALL, F{1,n}));
      # check if the possible function is a reserved operation
      block = find(strcmp(reserved, F{1,n}));
            
      if isempty(block)        
        if ~isempty(ind)
        
          % check if a function in the fail is shadowed a build-in function
          s_ind = find(strcmp(SHADOWED, F{1,n}));
          if ~isempty(s_ind)
            ret.shadowed{cell_ind_s, 1} = [F{1,n} ' @ ' functionItself functionItselfExtension ' -> ' which(ALL{ind})];
            cell_ind_s += 1;
          endif
          
          # generate a list of used functions
          ret.functions{cell_ind_f, 1} = [ALL{ind} ' @ ' which(ALL{ind})];
          cell_ind_f += 1;
          
        endif
      endif
    endfor
    
    ret.variables.overloaded = {};
    cell_ind_f = 1;
    for n = 1:columns(ret.variables.used)
      ind = find(strcmp(ALL, ret.variables.used{1,n}));
      if ~isempty(ind)
        ret.variables.overloaded{cell_ind_f, 1} = [ret.variables.used{1,n} ' -> ' which(ALL{ind})]; 
        cell_ind_f += 1;
      endif
    endfor
    
    

  else
    error('file must be a char')
  endif

endfunction

function ret = _linesOfCode(str)

  ret = struct();
  ret.blanklines = columns(regexp(str,'(?m)^\s*\n', 'tokens'));
  ret.total      = columns(regexp(str,'\n', 'split'));
  ret.comments   = columns(cell2mat(regexp(str,'(?m)^\s*%(.*?)', 'tokens')));
  ret.comments  += columns(cell2mat(regexp(str,'(?m)^\s*#(.*?)', 'tokens')));
  ret.code       = ret.total - ret.comments - ret.blanklines;
  
endfunction

function ret = _identifyFunktionsInFunction(str)
  % get all subfunction or classdef methods of the file to check if it shadowed some build-in functions
	ret = regexp(str, 'function \w*\s*=\s*(.*?)\(.*?', 'tokens');
  if ~isempty(ret)
		ret = cell2mat(ret);
  endif
endfunction

function ret = _identifyFunctions(str)

	# 1. remove all comments
	# http://www.mathworks.com/matlabcentral/fileexchange/4645-matlab-comment-stripping-toolbox/content/mlstripcomments/mlstripcommentsstr.m
	# BSD License Author: Peter J. Acklam
	## FIXME
	# block comments are not covered!
	
	# matlab style % based
	mainregex  = '((^|\n)((?:[\]\)}\w.]''+|[^''%])+|''[^''\n]*(''''[^''\n]*)*'')*)[^\n]*';
	str = regexprep(str, mainregex, '$1');
	# octave style # based
	mainregex  = '((^|\n)((?:[\]\)}\w.]''+|[^''#])+|''[^''\n]*(''''[^''\n]*)*'')*)[^\n]*';
	str = regexprep(str, mainregex, '$1');

	# 2. get a unique list of all functions and variales (we don't know if it's a function or a variable).
	# "([abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_]+)"
	ret = unique(cell2mat(regexp(str, ["([" ["a":"z" "A":"Z" "0":"9" "_" "."] "]+)"], 'tokens')));


endfunction


function ret = _identifyVars(str)

  ret = unique(cell2mat(regexp(str,['(?m)^\s*([' ["a":"z" "A":"Z" "0":"9" "_" "."] ']+)\s*=.*?'], 'tokens')));
	

endfunction
