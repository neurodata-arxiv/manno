function manno_getImage(server, token, queryFile, fileOut, useSemaphore)
% MANNO function to get OCP image data and format it to be
% compatible with ITK-Snap.
%
% **Inputs**
%
%	server: [string]
%		- OCP server name hosting the image data of interest
%
%	token: [string]
%		- OCP token name hosting the image data of interest
%
%	queryFile: [string]
%		- path and filename for queryFile.  Should be a MAT file containing one OCPQuery variable, named 'query'
%
%	fileOut: [string]
%		- path and filename for NIFTI image file to use in ITK Snap for annotating
%
%	useSemaphore: [number][default=0]
%		- Throttles reading/writing client-side for large batch jobs.  Not needed in single cutout mode
%
% **Outputs**
%
%	No explicit outputs.  Output file is saved to disk rather than
%	output as a variable to allow for downstream integration with LONI.
%
% **Notes**
%
%	Currently only uint8 image data is supported.  Multichannel data may
%	produce unexpected results.


if useSemaphore
    oo = OCP('semaphore');
else
    oo = OCP();
end

%load query
load(queryFile)

oo.setServerLocation(server);
oo.setImageToken(token);
oo.setDefaultResolution(query.resolution);

im = oo.query(query);
im = permute(rot90(im.data,2),[2,1,3]);
nii = make_nii(im);
save_nii(nii, fileOut);