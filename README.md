# depfun
depfun for octave

It can happen that the pcre library that is used by `regexp` dies in a stack overflow. Octave will segfault then. 
One workaround is to compile pcre with option `--disable-stack-for-recursion`, but that slows performance. Another workaround is to increase the max stacksize of your system.
A long term fix will be an improvement of the used regular expressions. 

## example

    >> depfun('../go-redis/inst/redis.m')
    ans =

      scalar structure containing the fields:

        functions =
        {
          [1,1] = NaN @ libinterp/corefcn/data.cc
          [2,1] = OCTAVE_VERSION @ libinterp/corefcn/defaults.cc
          [3,1] = and @ libinterp/corefcn/data.cc
          [4,1] = any @ libinterp/corefcn/data.cc
          [5,1] = assert @ /usr/share/octave/4.0.0/m/testfun/assert.m
          [6,1] = builtin @ libinterp/parse-tree/oct-parse.cc
          [7,1] = cell @ libinterp/octave-value/ov-cell.cc
          [8,1] = cell2mat @ /usr/share/octave/4.0.0/m/general/cell2mat.m
          [9,1] = cellfun @ libinterp/corefcn/cellfun.cc
          [10,1] = char @ libinterp/corefcn/strfns.cc
          [11,1] = delete @ /usr/share/octave/4.0.0/m/miscellaneous/delete.m
          [12,1] = disp @ libinterp/corefcn/pr-output.cc
          [13,1] = error @ libinterp/corefcn/error.cc
          [14,1] = exist @ libinterp/corefcn/variables.cc
          [15,1] = fclose @ libinterp/corefcn/file-io.cc
          [16,1] = file @ variable
          [17,1] = fopen @ libinterp/corefcn/file-io.cc
          [18,1] = fread @ libinterp/corefcn/file-io.cc
          [19,1] = get @ libinterp/corefcn/graphics.cc
          [20,1] = index @ /usr/share/octave/4.0.0/m/strings/index.m
          [21,1] = input @ libinterp/corefcn/input.cc
          [22,1] = inputname @ /usr/share/octave/4.0.0/m/miscellaneous/inputname.m
          [23,1] = iscell @ libinterp/octave-value/ov-cell.cc
          [24,1] = ischar @ libinterp/corefcn/strfns.cc
          [25,1] = isempty @ libinterp/corefcn/data.cc
          [26,1] = isnan @ libinterp/corefcn/mappers.cc
          [27,1] = isnumeric @ libinterp/corefcn/data.cc
          [28,1] = isspace @ libinterp/corefcn/mappers.cc
          [29,1] = load @ libinterp/corefcn/load-save.cc
          [30,1] = max @ libinterp/corefcn/max.cc
          [31,1] = meshgrid @ /usr/share/octave/4.0.0/m/plot/util/meshgrid.m
          [32,1] = min @ libinterp/corefcn/max.cc
          [33,1] = nargin @ libinterp/octave-value/ov-usr-fcn.cc
          [34,1] = num2str @ /usr/share/octave/4.0.0/m/general/num2str.m
          [35,1] = numel @ libinterp/corefcn/data.cc
          [36,1] = ones @ libinterp/corefcn/data.cc
          [37,1] = or @ libinterp/corefcn/data.cc
          [38,1] = prod @ libinterp/corefcn/data.cc
          [39,1] = quit @ libinterp/corefcn/toplev.cc
          [40,1] = rand @ libinterp/corefcn/rand.cc
          [41,1] = regexp @ libinterp/corefcn/regexp.cc
          [42,1] = rename @ libinterp/corefcn/dirfns.cc
          [43,1] = reshape @ libinterp/corefcn/data.cc
          [44,1] = save @ libinterp/corefcn/load-save.cc
          [45,1] = set @ libinterp/corefcn/graphics.cc
          [46,1] = size @ libinterp/corefcn/data.cc
          [47,1] = source @ libinterp/parse-tree/oct-parse.cc
          [48,1] = sprintf @ libinterp/corefcn/file-io.cc
          [49,1] = str2double @ libinterp/corefcn/str2double.cc
          [50,1] = strcmp @ libinterp/corefcn/strfns.cc
          [51,1] = strfind @ libinterp/corefcn/strfind.cc
          [52,1] = sub2ind @ libinterp/corefcn/sub2ind.cc
          [53,1] = type @ /usr/share/octave/4.0.0/m/help/type.m
          [54,1] = varargin @
          [55,1] = zeros @ libinterp/corefcn/data.cc
        }
        shadowed =
        {
          [1,1] = get @ redis.m
          [2,1] = numel @ redis.m
          [3,1] = ones @ redis.m
          [4,1] = rand @ redis.m
          [5,1] = rename @ redis.m
          [6,1] = save @ redis.m
          [7,1] = set @ redis.m
          [8,1] = size @ redis.m
          [9,1] = type @ redis.m
          [10,1] = zeros @ redis.m
        }
        
        
        >> depfun('depfun.m')
        ans =

          scalar structure containing the fields:

            functions =
            {
              [1,1] = cell2mat @ /usr/share/octave/4.0.0/m/general/cell2mat.m
              [2,1] = char @ libinterp/corefcn/strfns.cc
              [3,1] = columns @ libinterp/corefcn/data.cc
              [4,1] = completion_matches @ libinterp/corefcn/input.cc
              [5,1] = error @ libinterp/corefcn/error.cc
              [6,1] = fclose @ libinterp/corefcn/file-io.cc
              [7,1] = file @ variable
              [8,1] = fileparts @ /usr/share/octave/4.0.0/m/miscellaneous/fileparts.m
              [9,1] = find @ libinterp/corefcn/find.cc
              [10,1] = fopen @ libinterp/corefcn/file-io.cc
              [11,1] = fread @ libinterp/corefcn/file-io.cc
              [12,1] = functions @ libinterp/octave-value/ov-fcn-handle.cc
              [13,1] = ischar @ libinterp/corefcn/strfns.cc
              [14,1] = isempty @ libinterp/corefcn/data.cc
              [15,1] = regexp @ libinterp/corefcn/regexp.cc
              [16,1] = regexprep @ libinterp/corefcn/regexp.cc
              [17,1] = strcmp @ libinterp/corefcn/strfns.cc
              [18,1] = strrep @ libinterp/corefcn/strfind.cc
              [19,1] = struct @ libinterp/octave-value/ov-struct.cc
              [20,1] = textscan @ /usr/share/octave/4.0.0/m/io/textscan.m
              [21,1] = unique @ /usr/share/octave/4.0.0/m/set/unique.m
              [22,1] = which @ /usr/share/octave/4.0.0/m/help/which.m
            }
            shadowed = {}(0x0)
