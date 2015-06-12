function run_manno_example()
% Mananno Example 
% manno starter to demonstrate protocol functionality.  All required inputs
% are hardcoded for this demo.  Paths are hardcoded for Linux/Mac.
% 
% The result of this run can be viewed in a webbrowser using the following
% URL: http://braingraph1dev.cs.jhu.edu/ocp/overlay/0.7/temp2/xy/1/5472,5972/8712,9212/1031/

% **Author**
%
% W. Gray Roncal

xstart = 5472;
xstop = xstart + 512;
ystart = 8712;
ystop = ystart + 512;
zstart = 1020;
zstop = zstart + 16;

resolution = 1;

query = OCPQuery;
query.setType(eOCPQueryType.imageDense);
query.setCutoutArgs([xstart, xstop],[ystart,ystop],[zstart,zstop],resolution);

%% Servers and tokens - alter appropriately
server = 'openconnecto.me';
token = 'kasthuri11cc';

serverUp = 'braingraph1dev.cs.jhu.edu';
tokenUp = 'temp2';

%% Run manno
manno_getImage(server,token,'../data/queryFileTest','../data/testitk.nii',0)
% Manual annotation step happens here
manno_putAnno(serverUp,tokenUp,'../data/queryFileTest','../data/exampleAnno.nii.gz','RAMONOrganelle', 1,0)