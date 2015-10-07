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
## @deftypefn {Function File} mlint (@var{file})
## Static code analysis
##
##
## @end deftypefn


function mlint(filename, varargin)

  # input check
  p               = inputParser();
  p.CaseSensitive = true;
  p.FunctionName  = "mlint"; 
  p.addParamValue ("CodeIndent", true, @isbool);
  p.addParamValue ("ShadowFnc" , true, @isbool);
  p.addParamValue ("UnusedVar" , true, @isbool);
  p.addParamValue ("IndentSize",    2, @isnumeric);
  p.parse (varargin{:});
  
  # list of functions, variables etc comes from about()
  ret     = about(filename);
  fid     = fopen(filename);
  
  if (p.Results.UnusedVar)
    marker  = ftell (fid);
    str     = fread(fid, 'char=>char').';
    # U and UL are used for checking assigned but unused variables later
    U  = strfind (str, ret.variables.used);
    UL = cellfun(@length, U);
    fseek (fid, marker, SEEK_SET);
  endif
  
  # init counts
  lint = struct();
  lint.line = 0;
  lint.indent = struct();
  lint.indent.is      = 0;
  lint.indent.next    = 0;
  lint.indent.size    = p.Results.IndentSize;

  # iterating over every line
  while (true)

    lineOfCode = fgetl(fid);
    lint.line += 1;
    
    if (~ischar(lineOfCode))
      break
    endif
    
    ## check for code indent
    ## ---------------------
    if (p.Results.CodeIndent)
      lint.indent.is = regexp(lineOfCode, '^(\s+).*?', 'tokens');
      if (~isempty(lint.indent.is))
        lint.indent.is = length(cell2mat(lint.indent.is{1}));
      else
        lint.indent.is = 0;
      endif

      if ((length(lineOfCode) > 0) && (~all(uint8(lineOfCode) == 32)))
        [~, currentIndentFactor] = CheckforIndent(strtrim(lineOfCode), lint.indent.size);
        if (lint.indent.is < (lint.indent.next + currentIndentFactor))
          fprintf("%s:%d - code indent is %d, should be at least %d\n", filename, lint.line, lint.indent.is, lint.indent.next)
        endif
      endif
      lint.indent.next = CheckforIndent(strtrim(lineOfCode), lint.indent.size) + lint.indent.is;
    endif
    ## end check for code indent
    ############################

    ## check for shadowed functions
    ## -----------------------------
    if (p.Results.ShadowFnc)
      if (~isempty(ret.variables.overloaded))
        [pos, ind] = CheckVariable(lineOfCode, ret.variables.overloaded);
        if (~isempty(pos))
          fprintf("%s:%d:%d - variable shadows function: %s\n", filename, lint.line, pos, ret.variables.overloaded{ind})
        end
      endif
    endif
    ## end check for shadowed functions
    ####################################
    
    ## check for unused variables
    ## --------------------------
    if (p.Results.UnusedVar)
      if (~isempty(ret.variables.used))
        if (any(UL == 1)) # check only when a variable is only used one time
          pos = cell2mat(strfind(lineOfCode, ret.variables.used(UL == 1)));
          if (~isempty(pos))
            fprintf("%s:%d:%d - variable is assigned but never used: %s\n", filename, lint.line, pos, ret.variables.used{UL == 1})
          endif
        endif
      endif
    endif
    ## end check for unused variables
    ## ------------------------------
     
    
  endwhile
  
  fclose(fid);
  
endfunction

function [pos, ind] = CheckVariable(lineOfCode, overloadedVar)

  funcs = cell2mat(cell2mat(regexp(overloadedVar ,'(\w+) ->', 'tokens')));
  ind   = strfind(lineOfCode , funcs);
  ind   = find(~cellfun (@isempty, ind));
  if isempty(ind)
    pos = ind;
  else
    pos = strfind(lineOfCode, funcs{ind});
  end
  
endfunction

function [next, current] = CheckforIndent(lineOfCode, IndentSize)
  # This function determine the state of Indent for current and for the next line

  # lineOfCode should be at least 5 characters long
  lineOfCode = [lineOfCode '     '];

  persistent wasLineBreak
  if isempty(wasLineBreak)
    wasLineBreak = false;
  endif

  if (strcmp(lineOfCode(1:2), 'if')) || (strcmp(lineOfCode(1:5), 'while')) || ...
    (strcmp(lineOfCode(1:3), 'for'))
    
    next = IndentSize;
  elseif (strcmp(lineOfCode(1:3), 'end'))
    next = IndentSize * (-1);
  else
    next = 0;
  endif
  
  if (strcmp(lineOfCode(1:4), 'else') == 1)
    current = IndentSize * (-1);
    next    = IndentSize;
  elseif (strcmp(lineOfCode(1:3), 'end') == 1)
    current = IndentSize * (-1);
  else
    current = 0;
  endif
  
  if (length(lineOfCode) > 8)
    if (strcmp(lineOfCode(end-7:end-5), '...'))
      next = 0;
      wasLineBreak = true;
    elseif wasLineBreak
      wasLineBreak = false;
      next = IndentSize;
    endif
  endif

endfunction
