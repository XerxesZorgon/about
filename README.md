in progress ... 

# segfault warning

Currently it can happen that the PCRE1 library that is used by `regexp()` dies in a stack overflow. Octave will segfault then. 
* One workaround is to compile pcre with option `--disable-stack-for-recursion`, but that slows performance. Another workaround is to increase the max stacksize of your system.
* A long term fix will be an improvement of the used regular expressions. 
* A much longer term fix will be to port octave using PCRE2

# mlint example

> testfile.m

    m = rand(100,100);
    [index,auchdas] = find(m < 0.1);
    if isempty(index)
    disp('not found')
    end


    octave:1> mlint('testfile.m')
    testfile.m:2:2 - variable shadows function: index -> /usr/share/octave/4.0.0/m/strings/index.m
    testfile.m:2:8 - variable is assigned but never used: auchdas
    testfile.m:3:12 - variable shadows function: index -> /usr/share/octave/4.0.0/m/strings/index.m
    testfile.m:4 - code indent is 0, should be at least 2


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

