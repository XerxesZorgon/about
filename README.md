in progress ... 

# segfault warning

Currently it can happen that the PCRE1 library that is used by `regexp()` dies in a stack overflow. Octave will segfault then. 
* One workaround is to compile pcre with option `--disable-stack-for-recursion`, but that slows performance. Another workaround is to increase the max stacksize of your system.
* A long term fix will be an improvement of the used regular expressions (_it's not perfect yet....identify variables is a huge challenge (for me))
* A much longer term fix will be to port octave using PCRE2

# mlint example

> testfile.m

    m = rand(100,100);
    [index,auchdas] = find(m < 0.1);
    if isempty(index)
    disp('not found')
    end


    >> mlint('testfile.m')
    testfile.m:2:2 - variable shadows function: index -> /usr/share/octave/4.0.0/m/strings/index.m
    testfile.m:2:8 - variable is assigned but never used: auchdas
    testfile.m:3:12 - variable shadows function: index -> /usr/share/octave/4.0.0/m/strings/index.m
    testfile.m:4 - code indent is 0, should be at least 2
    >> mlint('testfile.m', 'CodeIndent', false)
    testfile.m:2:2 - variable shadows function: index -> /usr/share/octave/4.0.0/m/strings/index.m
    testfile.m:2:8 - variable is assigned but never used: auchdas
    testfile.m:3:12 - variable shadows function: index -> /usr/share/octave/4.0.0/m/strings/index.m


# about()

    octave:1> about('mlint.m')
    ans =

      scalar structure containing the fields:

        functions = 
        {
          [1,1] = about @ /home/markus/git/OctaveCodeAnalyzer/depfun/about.m
          [2,1] = all @ libinterp/corefcn/data.cc
          [3,1] = cell2mat @ /usr/share/octave/4.0.0/m/general/cell2mat.m
          [4,1] = cellfun @ libinterp/corefcn/cellfun.cc
          [5,1] = fclose @ libinterp/corefcn/file-io.cc
          [6,1] = fgetl @ libinterp/corefcn/file-io.cc
          [7,1] = find @ libinterp/corefcn/find.cc
          [8,1] = fopen @ libinterp/corefcn/file-io.cc
          [9,1] = fprintf @ libinterp/corefcn/file-io.cc
          [10,1] = ischar @ libinterp/corefcn/strfns.cc
          [11,1] = isempty @ libinterp/corefcn/data.cc
          [12,1] = length @ libinterp/corefcn/data.cc
          [13,1] = regexp @ libinterp/corefcn/regexp.cc
          [14,1] = strcmp @ libinterp/corefcn/strfns.cc
          [15,1] = strfind @ libinterp/corefcn/strfind.cc
          [16,1] = strtrim @ /usr/share/octave/4.0.0/m/strings/strtrim.m
          [17,1] = struct @ libinterp/octave-value/ov-struct.cc
          [18,1] = uint8 @ libinterp/octave-value/ov-uint8.cc
        }
        shadowed = {}(0x0)
        variables =

          scalar structure containing the fields:

            used = 
            {
              [1,1] = current
              [1,2] = fid
              [1,3] = funcs
              [1,4] = ind
              [1,5] = lineOfCode
              [1,6] = lint
              [1,7] = lint.indent
              [1,8] = lint.indent.is
              [1,9] = lint.indent.next
              [1,10] = lint.indent.size
              [1,11] = lint.line
              [1,12] = next
              [1,13] = pos
              [1,14] = ret
              [1,15] = wasLineBreak
              [1,16] =  currentIndentFactor
            }
            overloaded = {}(0x0)

        linesOfCode =

          scalar structure containing the fields:

            blanklines =                   21
            total =                  114
            comments =                   11
            code =                   82


    >> about('../../go-redis/inst/redis.m')
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
          [1,1] = get @ redis.m -> libinterp/corefcn/graphics.cc
          [2,1] = numel @ redis.m -> libinterp/corefcn/data.cc
          [3,1] = ones @ redis.m -> libinterp/corefcn/data.cc
          [4,1] = rand @ redis.m -> libinterp/corefcn/rand.cc
          [5,1] = rename @ redis.m -> libinterp/corefcn/dirfns.cc
          [6,1] = save @ redis.m -> libinterp/corefcn/load-save.cc
          [7,1] = set @ redis.m -> libinterp/corefcn/graphics.cc
          [8,1] = size @ redis.m -> libinterp/corefcn/data.cc
          [9,1] = type @ redis.m -> /usr/share/octave/4.0.0/m/help/type.m
          [10,1] = zeros @ redis.m -> libinterp/corefcn/data.cc
        }
        variables =

          scalar structure containing the fields:

            used =
            {
              [1,1] = dimension
              [1,2] = dimensionVar
              [1,3] = emptyInd
              [1,4] = fid
              [1,5] = linInd
              [1,6] = luastring
              [1,7] = n
              [1,8] = newhost
              [1,9] = newobjectHandle
              [1,10] = newport
              [1,11] = origin_dimension
              [1,12] = origin_linInd
              [1,13] = origin_pairs
              [1,14] = pairs
              [1,15] = ret
              [1,16] = ret1
              [1,17] = ret2
              [1,18] = ret3
              [1,19] = retVar
              [1,20] = self
              [1,21] = self.array_hash
              [1,22] = self.batchsize
              [1,23] = self.count
              [1,24] = self.dbnr
              [1,25] = self.gaussian_hash
              [1,26] = self.hostname
              [1,27] = self.is_cluster
              [1,28] = self.is_octave
              [1,29] = self.objectHandle
              [1,30] = self.passwd
              [1,31] = self.port
              [1,32] = self.precision
              [1,33] = self.swap
              [1,34] = self.verboseCluster
              [1,35] = tmp
              [1,36] = valueVar
              [1,37] = varname
              [1,38] = x
              [1,39] = y
            }
            overloaded = {}(0x0)

        linesOfCode =

          scalar structure containing the fields:

            blanklines =                   95
            total =                  600
            comments =                   52
            code =                  453
