function mlint(filename)
  
  fid = fopen(filename);
  ret = about(filename);
  lint = struct();
  lint.line = 0;
  lint.indent = struct();
  lint.indent.is      = 0;
  lint.indent.next    = 0;

  while true

    lineOfCode = fgetl(fid);
    lint.line += 1;
    
    if ~ischar(lineOfCode)
      break
    endif
    
    ## check for code indent
    lint.indent.is = regexp(lineOfCode, '^(\s+).*?', 'tokens');
    if ~isempty(lint.indent.is)
      lint.indent.is = length(cell2mat(lint.indent.is{1}));
    else
      lint.indent.is = 0;
    endif

    if length(lineOfCode) > 0 && ~all(uint8(lineOfCode) == 32)
      [~, currentIndentFactor] = CheckforIndent(strtrim(lineOfCode));
      if (lint.indent.is < (lint.indent.next + currentIndentFactor))
        fprintf("%s:%d - code indent is %d, should be at least %d\n", filename, lint.line, lint.indent.is, lint.indent.next)
      endif
    endif
    lint.indent.next = CheckforIndent(strtrim(lineOfCode)) + lint.indent.is;
    
     
    
  endwhile
  
endfunction



function [next, current] = CheckforIndent(lineOfCode)

  # lineOfCode should be at least 5 characters long
  lineOfCode = [lineOfCode '     '];

  persistent wasLineBreak
  if isempty(wasLineBreak)
    wasLineBreak = false;
  endif

  if (strcmp(lineOfCode(1:2), 'if')) || (strcmp(lineOfCode(1:5), 'while')) || ...
    (strcmp(lineOfCode(1:3), 'for'))
    
    next = 2;
  elseif (strcmp(lineOfCode(1:3), 'end'))
    next = -2;
  else
    next = 0;
  endif
  
  if (strcmp(lineOfCode(1:4), 'else') == 1)
    current = -2;
    next    = 2;
  elseif (strcmp(lineOfCode(1:3), 'end') == 1)
    current = -2;
  else
    current = 0;
  endif
  
  if (length(lineOfCode) > 8)
    if (strcmp(lineOfCode(end-7:end-5), '...'))
      next = 0;
      wasLineBreak = true;
    elseif wasLineBreak
      wasLineBreak = false;
      next = 2;
    endif
  endif

endfunction