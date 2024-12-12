
function texstr = str2latex( octstr )

% Replaces special characters from string for appropriated LaTeX codes
%
% Usage: texstr = str2latex( octstr )
%
% This function replaces the following characters:
%  &  \& 
%  %  \% 
%  $  \$ 
%  #  \# 
%  _  \_ 
%  {  \{ 
%  }  \}
%  ~  \textasciitilde
%  ^  \textasciicircum
%  \  \textbackslash
%

texstr = octstr;
texstr = strrep( texstr, '\', '\textbackslash'   );
texstr = strrep( texstr, '~', '\textasciitilde'  );
texstr = strrep( texstr, '^', '\textasciicircum' );
texstr = strrep( texstr, '&', '\&'               );
texstr = strrep( texstr, '%', '\%'               );
texstr = strrep( texstr, '$', '\$'               );
texstr = strrep( texstr, '#', '\#'               );
texstr = strrep( texstr, '_', '\_'               );
texstr = strrep( texstr, '{', '\{'               );
texstr = strrep( texstr, '}', '\}'               );

end

