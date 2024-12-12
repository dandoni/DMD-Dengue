
function name = str2filename( str )

% Replaces special characters from string for appropriated file name
%
% Usage: name = str2filename( str )
%
% This function replaces by an underscore _
%   any non ascii character
%   any white space
%   the folowing characters: & % $ # ( ) [ ] < > { } \ / | . , : ; ? ! ~ ^ * " ' `
% 
% Also removes leading, trailing or repeted underscore characters
%

  name = str;
  name( ~isascii(name) ) = '_';
  name = regexprep( name, '[&%$#~^,:;!`''´"\s\(\)\[\]\<\>\{\}\\\/\|\.\?\*]', '_' );
  name = regexprep( name, '_+', '_' );
  name = regexprep( name, '^_', '' );
  name = regexprep( name, '_$', '' );

end

